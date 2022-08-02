Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6F588048
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiHBQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiHBQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:30:53 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764E12AFB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659457757; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Djhgp8iXUCsOnH9BSyQXz7FMb/CCtRzW70p2rAlremDefOEUPhcd/lYHd1VRKZeM3YRLOGNNeSKuekz/r9J/Cn49yzNpUMEQk/U7HZ0F0dU6qL7jlpWZjfkeguXXmjpQVrk1nA5k/YeazDLsBEZWRk3lLjVla5iWdRN+d0OlXcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659457757; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tIaoKZqeKwVm3YXlgfzkmmqa+keWxZ5MypfokfBzu1Q=; 
        b=AOGAeRcesujq661zWHJWre5A0KEV7ftyIYUHwYhdkcRYgQoTz9AQSSgrxHs1NK9LGIbrboePn5bSh0gR8XBKh6erYOYNUqne/4m0siUOyp+1bs6fuW0+fY4votXtTHTN4gDECXJjXx3b9ZFHqxsyn3XwIq95LbbN7L3HGe9ZlzY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659457757;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=tIaoKZqeKwVm3YXlgfzkmmqa+keWxZ5MypfokfBzu1Q=;
        b=oEJBR4ucJWNOr8jLGXAYjnRdA3ARGIT+6lE5L1REVDeYjJryM5Mj3+UeC4HtJ+nz
        4FEmI2NUKoT5AtsnyZJn4ho0wiCZs8S6B37xp/HmIEanfBVL8r0P40viL3GNKW0cONb
        /IlFqk+1C4+5t5EqcQkD4v2y1gzj2W7WIFrkVA4I=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659457745264923.42593622627; Tue, 2 Aug 2022 21:59:05 +0530 (IST)
Date:   Tue, 02 Aug 2022 21:59:05 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Ingo Molnar" <mingo@kernel.org>
Cc:     "x86" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <1825f63b142.8968bde3116633.1242410031840350968@siddh.me>
In-Reply-To: <YukFgFTaq4Aw+uht@gmail.com>
References: <20220731160913.632092-1-code@siddh.me> <YukFgFTaq4Aw+uht@gmail.com>
Subject: Re: [PATCH] x86/numa: Use cpumask_available instead of hardcoded
 NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2022 16:37:44 +0530  Ingo Molnar <mingo@kernel.org> wrote:
> Your fix makes sense I suppose, but I'm wondering how testing didn't 
> trigger this warning.
> 
> Off-stack isn't a rare config option:
> 
>   kepler:~/tip> make allmodconfig
>   #
>   # No change to .config
>   #
>   kepler:~/tip> grep CPUMASK_OFFSTACK .config
>   CONFIG_CPUMASK_OFFSTACK=y
>   kepler:~/tip> 
> 
> What am I missing?

Maybe this triggers on certain config options set, or maybe due to new
gcc version? (I'm using gcc-12, I also likely saw while on gcc-11.)
It nevertheless is a helpful warning.

I just now tried `make defconfig` (default configuration based on
'x86_64_defconfig') and compiling with `make -j13 all`, and gcc doesn't
give any warning. (CONFIG_CPUMASK_OFFSTACK isn't even listed in the
.config file produced, grep fails.)

The config on which I can reproduce the warning can be found here:
https://gist.github.com/siddhpant/0197ea2b9873e8719d5d7ef991e2cd89
(It has 8969 lines, thus uploaded as a gist.)

This is a modification of a config found on syzkaller, which I was using
to compile and test some bug. I had noticed the gcc warning earlier while
on similar detours and usually ignored it, but now I finally took a look.

I tested compiling with it 5 times (`make clean` and `make -j13 all`),
and gcc gave the warning in all attempts. I also tried `make -j1 all`,
which also had gcc spitting out the warning, so it cannot be any race.

> > Fixes: c032ef60d1aa ("cpumask: convert node_to_cpumask_map[] to cpumask_var_t")
> > Fixes: de2d9445f162 ("x86: Unify node_to_cpumask_map handling between 32 and 64bit")
> 
> These are ancient commits from 2009 & 2011.

Yes, that's where blaming the file leads me to.

Thanks,
Siddh
