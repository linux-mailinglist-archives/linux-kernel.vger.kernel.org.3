Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3908593709
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiHOSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242460AbiHOSmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:42:46 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22E2A711
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:26:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AF634447DB;
        Mon, 15 Aug 2022 18:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1660587986; bh=0eJkDGE3GNvcOcrqqV1kb6hUfibmFduCDUfne/ShuDE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=BjSm8hWsvn6dwegv+PhyexA77iCJc24QCH4ZHb2ClHrPArSlQvtJMBynZVWR45RZn
         MeXfh9FHXVZ8XIGFag9GsiyJP0PcNQOfAMoCcpCJ1p/cGnuqb4yVUgT2rGbmIqEEHm
         eDm6hIINQcP/5S5wZJVJkvevNtQPuCw4Koag86Fby/I5cj3LwHt31B5S6v2ERdE5ZH
         CMLXRcU0sNqN3JDTl9EtkbnH6PEmV6vhYUhijMwZ1ZUkoTlDGrrOU0h6jKNZoYHrBm
         4J9mtzx20fg24jT7K/evAqE2DDrYGLc8Hki+NreyuurtCkXg3Igu4SolOG8mrr0bnr
         XkKhp07nTMNIQ==
Message-ID: <8ccfdd2d-ef77-4586-e50c-985e1d13726a@marcan.st>
Date:   Tue, 16 Aug 2022 03:26:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: Debugging a TTY race condition on M1 (memory ordering dragons)
In-Reply-To: <YvqKtJn5eBsDJXBI@boqun-archlinux>
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

On 16/08/2022 03.04, Boqun Feng wrote:
> On Tue, Aug 16, 2022 at 01:01:17AM +0900, Hector Martin wrote:
> Hmm.. but doesn't your (and Will's) finding actually show why
> queue_work() only guarantee ordering if queuing succeeds? In other
> words, if you want extra ordering, use smp_mb() before queue_work()
> like:
> 
> 	smp_mb();	// pairs with smp_mb() in set_work_pool_and_clear_pending()
> 	queue_work();	// if queue_work() return false, it means the work
> 			// is pending, and someone will eventually clear
> 		      	// the pending bit, with the smp_mb() above it's
> 			// guaranteed that work function will see the
> 			// memory accesses above.
> 
> Of course, I shall defer this to workqueue folks. Just saying that it
> may not be broken. We have a few similar guarantees, for example,
> wake_up_process() only provides ordering if it really wakes up a
> process.

Technically yes, but that doesn't actually make a lot of sense, and in
fact the comments inside the workqueue code imply that it does actually
provide order even in the failure case (and there are other barriers to
try to make that happen, just not enough). Note that the ordering
documentation was added post-facto, and I don't think the person who
wrote it necessarily considered whether it *actually* provides
guarantees in the failure case, and whether it should.

wake_up_process() is different because it doesn't actually guarantee
anything if the process is already awake. However, under this
definition, queue_work() guarantees that *some* work execution will
observe every preceding write before queue_work(), regardless of the
current state, and that is a very useful property. That is something
that wake_up_process() semantics can't do.

Without this guarantee, basically every queue_work() user that's using
some kind of producer/consumer pattern would need the explicit barrier.
I imagine that pattern is very common.

- Hector
