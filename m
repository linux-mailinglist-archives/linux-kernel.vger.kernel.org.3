Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED814465D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355699AbhLBErW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355612AbhLBErJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:47:09 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA28C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:43:47 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id j9so23866668qvm.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 20:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAKjMwA1aOUY1Tr9hpTK/UCH7nKBs/RRTFxbIpF5PZ8=;
        b=FEHBJYie3CB2KZDjtYA3j/5uUAaVJOTvu7E0/04x8K/WbjXIz/FDvHxGH2P3Ii2WxZ
         v9Bs2/O0UREiwt0E2/VbWWigcO4hc10pre016PBcn+QXodwd73bX9T4TsVRq40uktow7
         4Aw1+K+7+zxeCfqkLc2jEVpy8PhnsM8iwNMMpZpxzJzxbml6XFbuSujWKggOjl2plgz8
         gzwrQGj5Hrj0zVelxCsCf2ekA4Tl8kovCtkODGi64jRLEId4dpDvY2E4lP81S8hrgwn9
         CFcQa+5KRv01eplGasqx3rnWeVFTliibqQWdHz2z21/8+H7YLIPgWfIKQJmaLQaano+f
         myxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAKjMwA1aOUY1Tr9hpTK/UCH7nKBs/RRTFxbIpF5PZ8=;
        b=lPo25kkaFcmGc7an+s8zM3rKD3rUCecxzxogl2J5Ziw2PqvTmN1MaS17jrgV8khpr0
         mRLILNp9yMFWh7ZSR263JUnyspW4USurFTMW989XrGtLyg0ODaZGkhU6ynuWGPnVXzYa
         R590QmGRVfmergJfHZDHAYZQIbNGW9lebOLpyCJH3pa2LkYLT8vnbO6FrSHkK0AL99fh
         RHjq+ely+IYLM/GnUIaPPsQ1BZBtGxEFkWEbNNZsFrh3Al3aOTdR1vwblf1RtO1dHaSV
         AKHokYOSv+w6jcvro2y2uqgvA7/2bx2KtLdPMqyhDkEWL8LncEJX0RHLbbXZDDFs+oT+
         TFbA==
X-Gm-Message-State: AOAM530lkPzZagU5rshKGmpBPzYPH+uwhGe/9+GNp4/OE8FlSmOg9biR
        nPluG9T9bN6FmoUkAMwYeRPEeWc0fimJPLxqpho=
X-Google-Smtp-Source: ABdhPJwqzMntbplVSOVYF1L5aEN0hoBAP+fURw/kkntkN8VE+L+LNIWKJ0OpdMkuH2+qeUkygkY1uxmFJTLtRSCv9V4=
X-Received: by 2002:ad4:5673:: with SMTP id bm19mr10480450qvb.105.1638420226317;
 Wed, 01 Dec 2021 20:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20211117023751.24190-1-feng.tang@intel.com> <20211117023751.24190-2-feng.tang@intel.com>
In-Reply-To: <20211117023751.24190-2-feng.tang@intel.com>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Wed, 1 Dec 2021 23:47:39 -0500
Message-ID: <CAJRGBZznZOxqfOE471jUUTupPeZ-zW31sRo+0p5o0SeFKSqF9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified platforms
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paulmck@kernel.org,
        rui.zhang@intel.com, andi.kleen@intel.com,
        Len Brown <len.brown@intel.com>, tim.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:18 PM Feng Tang <feng.tang@intel.com> wrote:
>
> There are cases that tsc clocksources are wrongly judged as unstable by
> clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> there is hardly a general reliable way to check the validity of a
> watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
>
> "I'm inclined to lift that requirement when the CPU has:
>
>     1) X86_FEATURE_CONSTANT_TSC
>     2) X86_FEATURE_NONSTOP_TSC
>     3) X86_FEATURE_NONSTOP_TSC_S3
>     4) X86_FEATURE_TSC_ADJUST
>     5) At max. 4 sockets
>
>  After two decades of horrors we're finally at a point where TSC seems
>  to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
>  was really key as we can now detect even small modifications reliably
>  and the important point is that we can cure them as well (not pretty
>  but better than all other options)."
>
> As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several generations
> of Atom processor, and is always coupled with X86_FEATURE_CONSTANT_TSC
> and X86_FEATURE_NONSTOP_TSC, skip checking it, and also be more defensive
> to use maxim of 2 sockets.
>
> The check is done inside tsc_init() before registering 'tsc-early' and
> 'tsc' clocksources, as there were cases that both of them had been
> wrongly judged as unreliable.
>
> For more background of tsc/watchdog, there is a good summary in [2]
>
> [1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
> [2]. https://lore.kernel.org/lkml/87a6pimt1f.ffs@nanos.tec.linutronix.de/
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Change log:
>
>   v3:
>     * rebased against 5.16-rc1
>     * refine commit log
>
>   v2:
>     * Directly skip watchdog check without messing flag
>       'tsc_clocksource_reliable' (Thomas)
>
>  arch/x86/kernel/tsc.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

retry:

Reviewed-by: Luming Yu <luming.yu@intel.com>
