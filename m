Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4159AEDE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbiHTPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:33:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F4BD82
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:33:13 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98e0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98e0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 697471EC026E;
        Sat, 20 Aug 2022 17:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661009587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G3IJhwDiyGx/Q6TP7rSZkT6XzxALCoB5GDPvScV6Xxc=;
        b=gnc57b2xfK1sYH0TxE+ABfVo3ri5AT8BQuM099vt8JnFzerGLM6AWfQPHk/wLJEj10aShN
        mtnRK0uATfH+rKvJSNXCRfNQi+ODG+hoY9sHIIddwlLeK53CVJKd2TpZNt6bvVcMfugLBb
        KkOZkz5X+G15C4BYkIVFy6EcbyZCAiY=
Date:   Sat, 20 Aug 2022 17:33:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Russ Dill <russ.dill@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86/boot: Fail gracefully if SMP MP-table early_memremap
 fails
Message-ID: <YwD+rZ/7zDPCmlRI@zn.tnic>
References: <20220819224400.2667654-1-Russ.Dill@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220819224400.2667654-1-Russ.Dill@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:44:00PM -0700, Russ Dill wrote:
> At least one older motherboard (Micronics W6-LI Pentium Pro) has been
> observed to fill in the physptr but not actually populate the mpc when
> only one CPU is present. In this specific case, this leads to the size
> field being zero which causes early_memremap to fail. This then
> causes a NULL pointer exception in smp_read_mpc.
> 
> Add a simple return check. Returning -1 here will cause the MP-table to
> be ignored and the system to boot in nosmp mode.
> 
> Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/kernel/mpparse.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> index fed721f90116..ca2af4f42cb8 100644
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -438,6 +438,10 @@ static int __init check_physptr(struct mpf_intel *mpf, unsigned int early)
>  
>  	size = get_mpc_size(mpf->physptr);

If the size is 0, why aren't you checking size and returning early here
instead of the early_memremap() result which gets called with size=0?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
