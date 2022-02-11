Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7974B2038
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiBKIbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:31:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiBKIbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:31:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D8EE53
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:31:17 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5DE71EC0295;
        Fri, 11 Feb 2022 09:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644568271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rjXh0IESiNrCgHWWK3fXBhQhopmWuYvROCtH7A5MAew=;
        b=aMZzTn+4JloR8bsANVGwOo9dG/03X9E7D+1AJO2OihgkwXrwAcxzF17WYInU9oqdgQD9Qm
        CVDmZvj9su9JGq1qP2iGu+uzgMd1cPvFwEzmFzkQFmf2Wa9cZ+g4Kqk9jg/olEoGgq7ZAz
        q+vI3+iHNlBqv1eiNvCwHQ/QAvPnMw0=
Date:   Fri, 11 Feb 2022 09:31:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/cpu: clear SME/SEV/SEV_ES features when not in
 use
Message-ID: <YgYe1V0ViPYoB0az@zn.tnic>
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <20220211053652.64655-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211053652.64655-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:36:52PM -0600, Mario Limonciello wrote:
> Currently SME/SEV/SEV_ES features are reflective of whether the CPU
> supports the features but not whether they have been activated by the
> kernel.
> 
> Change this around to clear the features if the kernel is not using
> them so userspace can determine if they are available and in use
> from `/proc/cpuinfo`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 4edb6f0f628c..4a7d4801fa0b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -611,12 +611,20 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>  		if (!(msr & MSR_K7_HWCR_SMMLOCK))
>  			goto clear_sev;
>  
> +		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			goto clear_all;
> +		if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +			goto clear_sev;
> +		if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +			goto clear_sev_es;

The cc_platform stuff is to be used in generic code - I think you can
safely read MSR_AMD64_SEV here and look at the bits, just like the rest
of this code does.

Also, why is this a separate patch? I.e., one single patch should be
just fine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
