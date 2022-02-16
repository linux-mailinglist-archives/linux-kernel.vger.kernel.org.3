Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB54B85EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiBPKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiBPKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:33:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8BB2B1644
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:33:45 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 687F81EC054C;
        Wed, 16 Feb 2022 11:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645007619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4O6P6Bd8YAaCuifrnqVgvcR1H2vua8DbkApbjkory2g=;
        b=qLG0G+lrqyKebvs/LDjbNEU+/iV9y0rTf2MGK5IOEcztD5O0OjmQQU3qsMXGIjn2+wT6IU
        IpfQwlkSzyGahTOqu/XVxhlUkTxHiquE0q1ARXrOz9QC/toVIpA2yjHFyfQW5GsB7wSU4h
        jKu784k/Mew+rHQeOPYXXflze03mGJU=
Date:   Wed, 16 Feb 2022 11:33:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v4] x86/cpu: clear SME feature flag when not in use
Message-ID: <YgzTCtlMq9+4IsZ4@zn.tnic>
References: <20220216034446.2430634-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216034446.2430634-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:44:46PM -0600, Mario Limonciello wrote:
> @@ -607,6 +609,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>  		if (IS_ENABLED(CONFIG_X86_32))
>  			goto clear_all;
>  
> +		if (!sme_me_mask)
> +			setup_clear_cpu_cap(X86_FEATURE_SME);

Why not "goto clear_all;" ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
