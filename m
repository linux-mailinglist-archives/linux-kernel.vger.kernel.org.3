Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEE52E8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344866AbiETJ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiETJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:27:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2D87204
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:27:05 -0700 (PDT)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 173CA1EC0258;
        Fri, 20 May 2022 11:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653038820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4q4B8B6JOY6jxn99S0iabm4qIhRYOLZ2S6fDGT0xc58=;
        b=CHhsgH5o3QZU5x8WA5Vm69Uiz4Zzi2Q/w8I1mdaqxQVCy98cyXm3LnSwTa/On2NVcV4IdN
        ubSxLchELki5hjuBvMDCy4cvxgnfiu3v6q/wWuna7AvD5xA86T+/oH2VnOFB1D/+NMmPJm
        dCMDNlt2aCjyasbV9hyEBu52YO2AoCA=
Date:   Fri, 20 May 2022 11:26:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH] x86/vmware: use unsigned integer for shifting
Message-ID: <Yode3m6iia9ZBHsl@zn.tnic>
References: <20220520072857.592746-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520072857.592746-1-sshedi@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:58:57PM +0530, Shreenidhi Shedi wrote:
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..b28f789d3c56 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -476,7 +476,7 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> +	return (eax & (1U << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>  	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;

Or you can use the BIT() macro and simplify this expression even more:

       return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
               (eax & BIT(VMWARE_CMD_LEGACY_X2APIC));


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
