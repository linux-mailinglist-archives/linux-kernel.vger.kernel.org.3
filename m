Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08652EB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348743AbiETLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348700AbiETLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:52:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21656286FE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:52:12 -0700 (PDT)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 574D71EC0432;
        Fri, 20 May 2022 13:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653047527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UBx25AJVNBXwj5NkoGiu7FzpWAyO7lQh9NzqQwd3+KY=;
        b=hlg4xpGj5ir+DAwkdOit9i47xkD0eD832zyfp5Bqcbc65pO+fSAD4TR+ozvBBFilfXWqNg
        prhaUpQsxQMZUJa0smCpYQ1blvcii5b+KZtbuBu4AhzCPSBJn8kpcFkW3GmW6J9n2rBQ4a
        GW3RDinr3LPum9Ozz1lYbI7tEuAzbsg=
Date:   Fri, 20 May 2022 13:52:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     srivatsa@csail.mit.edu, amakhalov@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v1] x86/vmware: use unsigned integer for shifting
Message-ID: <YoeA4pf5OWxfjE0J@zn.tnic>
References: <20220520114712.595583-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520114712.595583-1-sshedi@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:17:12PM +0530, Shreenidhi Shedi wrote:
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.
> 
> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>

This is not how this is done - you need to set your author email
properly in git so that it adds your From: ... @vmware.com> instead of
having two SOBs.

> ---
>  arch/x86/kernel/cpu/vmware.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..7f44ea073436 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpu.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
> +#include <linux/bits.h>
>  #include <asm/div64.h>
>  #include <asm/x86_init.h>
>  #include <asm/hypervisor.h>
> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return (eax & BIT(VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> +	       (eax & BIT(VMWARE_CMD_LEGACY_X2APIC)) != 0;
						    ^^^^^^^^

You did hurry too much with sending a new version.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
