Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58384557D21
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiFWNf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiFWNf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:35:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9E175AA;
        Thu, 23 Jun 2022 06:35:26 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:35:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655991325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIfS0wAgMAPHur5F2be+uJqVhpZpyJ5Kv6RCfMNIA5Y=;
        b=RLnb/2S7c5GR0UcxJAp3h60TVmoTk1srsw7+OQ7Mbsh7YSgcTJKZ49HwFYSpl8pR/aLahp
        Q1Uln3TsxKnRj+cJcXe28JLZz95eZSL2gbaE7rDqlbQVFYfn4ZkIIikRp5GT4EJcy+05tD
        ki63ivVZCVzv9zJjl1RPG7v1WBofxzwDLkagvo4Z1SF2qFhVC5N38U+8AG7phV5uGStbed
        BYenYgFimrJOHwQn4tsQUNq1CaWXfgo4CkgjMLWyQIcVICALLtko+d2vOpm/5pAM9SlNlV
        VvX09gHdPhqO8SXq2bBaGSaFnY1qg1NHJcZ2YWbxjkx3F+HImzf2LqeuvwY4sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655991325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIfS0wAgMAPHur5F2be+uJqVhpZpyJ5Kv6RCfMNIA5Y=;
        b=hO4ECR8hE6DwZxhwnYOBCV7FqgzraeYR171ibypr2FWi0oQeO1sXGHQUDzPXY+cEpF27wc
        UmYzi4JcHBqhXnCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <YrRsGzXTpms+FOeI@linutronix.de>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrQzB7sPD8BNxSFq@linutronix.de>
 <xhsmhy1xn622a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhy1xn622a.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-23 12:39:57 [+0100], Valentin Schneider wrote:
> > RT-wise it would be needed for each release.
> 
> So git tells me the Fixes: commit dates from v4.2; from [1] and [2] I get
> that both current longterm stable and stable-rt trees go as far back as
> v4.9, so I'm guessing if that gets picked up for the stable trees then it
> should make its way into the stable -rt trees?

correct, if it goes -stable. Just pointing it out. But the
mutex_unlock() looks like it might also be relevant for non-RT kernels.

Sebastian
