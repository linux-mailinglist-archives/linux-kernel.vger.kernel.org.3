Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4E59412A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiHOVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343757AbiHOVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:05:47 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F69951433
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:15:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2C02044E47;
        Mon, 15 Aug 2022 19:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1660590905; bh=qqaaeEPVyM0kn+wlB73W5v9RUTLjhjxD0bTjXPsKLTc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MUGsMWhyajDA1ZUk/xpNWAPGXiNsuhJLSZapOYcsH8J65ov5p7MXVNW4wWtYnxRtq
         dF5k63BfNZ3QJJ3hKvPQcN6DLqwjESodNVQdMRoyMFbPczGR/oHQYymELOsKWdb6dd
         buRfqWuFmD+eFUOm7pNTtSRdlPTCUNZHgIRSjGdGY28o8ecf8XIDfu8WamkyxMmS1z
         TBXtvIEsLFWccPsje9gCHmQtsSySV7zMaxc10Q30M2JU0RSr095MkdYAOldPm2nTXD
         dYeKdZco8iKuDsmloBu5sPV86KO5dhMguOgZBsY01uvFyagSoLrguVfhBOrew40a+w
         LWparOodqyBuw==
Message-ID: <f3f84fc1-50be-0a9b-0538-6ea26dd93b16@marcan.st>
Date:   Tue, 16 Aug 2022 04:15:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Debugging a TTY race condition on M1 (memory ordering dragons)
Content-Language: es-ES
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Asahi Linux <asahi@lists.linux.dev>,
        Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
 <20220815134711.GA10374@willie-the-truck>
 <63cd54a8-3c48-d1b9-406a-c521bd02ee4a@marcan.st>
 <YvqKtJn5eBsDJXBI@boqun-archlinux>
 <8ccfdd2d-ef77-4586-e50c-985e1d13726a@marcan.st>
 <YvqXbApYbGGEqQl+@boqun-archlinux>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <YvqXbApYbGGEqQl+@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 03.58, Boqun Feng wrote:
> I agree this is handy, but an unconditional full barrier may be costy to
> some users, and probably unnecessary if the users periodically queue
> the work. In that case, some successful enqueue will eventually make all
> memory accesses observable. Also if workqueue users use their own
> locking in work function, then the barrier is also unnecessary.
> 
> The document part of course needs some help to clear things up. But I'm
> not sure "strengthen"ing the ordering guarantee of queue_work() is a
> good idea. Maybe a dedicated API, like:
> 
> // More work is needed for the @work, it has the same semantics as
> // queue_work() if the @work is not pending. If the @work is pending,
> // this ensures the work function observes all memory access before
> // this.
> void queue_more_work(struct work_struct *work)
> {
> 	smp_mb();
> 	queue_work(work);
> }
> 
> Regards,
> Boqun

FWIW, I didn't actually use a full barrier in my patch. I just replaced
the test_and_set_bit() with the underlying atomic op, sans early exit path.

Personally though, I think it makes more sense to have the default
function provide the guarantees, and if someone *really* needs the
performance gain from eliding the implicit barrier, they could use an
alternate API for that (after they show useful gains). This stuff is too
subtle to expect every caller to wrap their head around memory ordering,
and having queue_work() always provide order with prior stores *feels*
intuitive.

But let's see what the workqueue folks say :)

- Hector
