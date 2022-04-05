Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023104F486F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383273AbiDEVjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444564AbiDEPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168F73077
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:05:53 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 196ED1EC04D6;
        Tue,  5 Apr 2022 16:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649167548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ABkgJ7WZFU27xa+T6ghR5OktxwYJzWigVN97vtpvhqU=;
        b=QGvnVdS+Rakt7j93ycaMpKSdeoZxsBAHpOHJJqCChN7wRLawTlCq2gVLBvyFvbu/roQEko
        JupxNxuGnSWL/xPOfK2J774LQyyQPvcf6YsYrjdKAiPfyO1vWaWHuZkw1Er3brGa117u11
        8js4ySSQOPHOjY4+0Y3y8i2mCWIY8zA=
Date:   Tue, 5 Apr 2022 16:05:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Message-ID: <YkxMtx9zdk+nH33r@zn.tnic>
References: <20220405130021.557880-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405130021.557880-1-wyes.karny@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:30:21PM +0530, Wyes Karny wrote:
> From: Lewis Caroll <lewis.carroll@amd.com>
> 
> Currently in the absence of the cpuidle driver (eg: when global
> C-States are disabled in the BIOS or when cpuidle is driver is not
> compiled in),

When does that ever happen?

Sounds like a very very niche situation to me...

> Here we enable MWAIT instruction as the default idle call for AMD
> Zen processors which support MWAIT. We retain the existing behaviour
> for older processors which depend on HALT.

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

>  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
>  {
> -	if (c->x86_vendor != X86_VENDOR_INTEL)
> +	if (!early_mwait_supported(c))

Isn't it enough to simply do here:

	if (cpu_has(c, X86_FEATURE_ZEN))
		return 1;

        if (c->x86_vendor != X86_VENDOR_INTEL)
                return 0;

	...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
