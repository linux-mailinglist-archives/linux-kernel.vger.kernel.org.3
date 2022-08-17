Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE84597708
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiHQTlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241660AbiHQTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:40:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69738A4B3A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:40:35 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C36101EC0230;
        Wed, 17 Aug 2022 21:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660765229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=44GACs/e0WleSjvrDsLYa/d5aVKDfRJalm17EdZtIGw=;
        b=b/QFgs/QzwtnLR2Oj1km1LH2suhnkYt09N2b/jgWEHTjmpaU8vZL3EEaa51cbdbev4Nybi
        7sFZWtVmAgxSp4Do+dTJkjF93aSkow6BpXcX+y1tid9bfeHoYLKlq4ajIc/PXWwRTv7/Cf
        cAZBEZslpeOmqwtJfHUxeMpYTRgG4+Q=
Date:   Wed, 17 Aug 2022 21:40:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, mikelley@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, tim.c.chen@linux.intel.com,
        will@kernel.org, song.bao.hua@hisilicon.com,
        suravee.suthikulpanit@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: Don't use cpu_llc_shared_map for
 !CONFIG_SMP
Message-ID: <Yv1ELaWHbRfvdt/p@zn.tnic>
References: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:15:15AM -0700, Saurabh Sengar wrote:
> cpu_llc_shared_map is always declared and defined, but populated in
> arch/x86/kernel/smpboot.c which only builds for CONFIG_SMP=y. For
> UniProcessor builds this mask is never populated and hence invalid.
> Current code doesn't handle the case of AMD UniProcessor correctly,

What is "AMD UniProcessor"?

> which results "shared_cpu_map" and "shared_cpu_list" files missing from
> sysfs entries for l3 cache. This patch fixes this issue.

What issue exactly?

What is the real life use case for this?

> This code used to work because of a another bug in 'cpumask_next',
> where in the CONFIG_SMP=n case the cpumask_next() ignores empty mask
> that results as if CPU 0 was set. This bug in 'cpumask_next' was fixed by
> following commit, which exposes the cpu_llc_shared_map bug.
> 
> b81dce77ced ("cpumask: Fix invalid uniprocessor mask assumption")
> 
> Fixes: 2b83809a5e ("x86/cpu/amd: Derive L3 shared_cpu_map from cpu_llc_shared_mask")

Add

---
[core]
        abbrev = 12

[alias]
        one = show -s --pretty='format:%h (\"%s\")'
---

to your git .config so that when you do

$ git one <commit id>

you can get the proper formatting and abbreviated sha1 for commits.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
