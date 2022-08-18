Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D052A598597
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbiHROSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHROSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:18:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516FB4DB3B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:18:41 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A42F91EC0575;
        Thu, 18 Aug 2022 16:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660832315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gJ69YO/yMYg9+PoKFN0S+hG+LcapgaGO9wDIhQnh21s=;
        b=EVQW7N+CO7PTLXRuoBtQFpm/qy/KwebJJCE2caXxD8qy3vvO3Xr1Jree8hgBh7svUMQU8f
        jAJqhn8KS7oQY9M/ZwkcyyglnpGAfwnzT/hkpkbDaIKJQvSiEBVBEua+8bU1kPZcigUFyq
        ZxBtOqsNnMIWdbXFr6Mx0J94TSkH/P4=
Date:   Thu, 18 Aug 2022 16:18:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <Yv5KNyX992ddvVtD@zn.tnic>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:44:15PM -0700, Kuppuswamy Sathyanarayanan wrote:

...

> Operations like getting TDREPORT or Quote generation involves sending
> a blob of data as input and getting another blob of data as output. It
> was considered to use a sysfs interface for this, but it doesn't fit
> well into the standard sysfs model for configuring values. It would be
> possible to do read/write on files, but it would need multiple file
> descriptors, which would be somewhat messy. IOCTLs seems to be the best
> fitting and simplest model for this use case. This is similar to AMD
> SEV platform, which also uses IOCTL interface to support attestation.

So the gist of this whole commit message - with the TD<->TDX
nomenclature fixed - needs to go to Documentation/x86/tdx.rst.

> diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
> new file mode 100644
> index 000000000000..46a2f3612753
> --- /dev/null
> +++ b/arch/x86/coco/tdx/attest.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * attest.c - TDX attestation feature support.

s/feature //

> + *
> + * Implements attestation related IOCTL handlers.
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <asm/tdx.h>
> +
> +#include "tdx.h"
> +
> +/* TDREPORT module call leaf ID */
> +#define TDX_GET_REPORT			4

All TDX leaf definitions go to arch/x86/include/asm/shared/tdx.h, for
example.

Not spread around the tree. There are some in arch/x86/coco/tdx/tdx.c
too.

In a pre-patch: please pick a fitting header, move them there and keep
them all there.

> +long tdx_get_report(void __user *argp)
> +{
> +	u8 *reportdata = NULL, *tdreport = NULL;
> +	struct tdx_report_req req;
> +	long ret;
> +
> +	/* Copy request struct from the user buffer */

Useless comment.

> +	if (copy_from_user(&req, argp, sizeof(req)))
> +		return -EFAULT;
> +
> +	/*
> +	 * Per TDX Module 1.0 specification, section titled
> +	 * "TDG.MR.REPORT", REPORTDATA and TDREPORT length
> +	 * is fixed as TDX_REPORTDATA_LEN and TDX_REPORT_LEN.
> +	 */
> +	if (req.rpd_len != TDX_REPORTDATA_LEN || req.tdr_len != TDX_REPORT_LEN)
> +		return -EINVAL;
> +
> +	/* Allocate kernel buffers for REPORTDATA and TDREPORT */
> +	reportdata = kzalloc(req.rpd_len, GFP_KERNEL);
> +	if (!reportdata) {
> +		ret = -ENOMEM;
> +		goto report_failed;
> +	}
> +
> +	tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
> +	if (!tdreport) {
> +		ret = -ENOMEM;
> +		goto report_failed;
> +	}
> +
> +
> +	/* Copy REPORTDATA from user to kernel buffer */

Useless comment.

> +	if (copy_from_user(reportdata, (void *)req.reportdata, req.rpd_len)) {

You're trusting a user pointer without any checks?

I guess there's not a lot you can check besides the length with you do.
If there are sanity checks you can do, though, do them here.

> +		ret = -EFAULT;
> +		goto report_failed;
> +	}
> +
> +	/*
> +	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
> +	 *
> +	 * Get the TDREPORT using REPORTDATA as input. Refer to
> +	 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
> +	 * Specification for detailed information.
> +	 */
> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> +				virt_to_phys(reportdata), req.subtype,

That subtype you're not checking either.

Where's the paranoia?!

> +				0, NULL);
> +	if (ret) {
> +		ret = -EIO;
> +		goto report_failed;
> +	}
> +
> +	/* Copy TDREPORT data back to the user buffer */

Another useless comment.

> +	if (copy_to_user((void *)req.tdreport, tdreport, req.tdr_len))
> +		ret = -EFAULT;
> +
> +report_failed:
> +	kfree(reportdata);
> +	kfree(tdreport);
> +	return ret;
> +}
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 928dcf7a20d9..205f98f42da8 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -5,6 +5,9 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
>  
>  #include <linux/cpufeature.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -12,6 +15,8 @@
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
>  
> +#include "tdx.h"
> +
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
>  #define TDX_GET_VEINFO			3
> @@ -34,6 +39,10 @@
>  #define VE_GET_PORT_NUM(e)	((e) >> 16)
>  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>  
> +#define DRIVER_NAME	"tdx-guest"

Just "tdx". When you add another driver, then you can disambiguate.

> +static struct miscdevice tdx_misc_dev;
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -775,3 +784,49 @@ void __init tdx_early_init(void)
>  
>  	pr_info("Guest detected\n");
>  }
> +
> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	long ret = -EINVAL;
> +
> +	switch (cmd) {
> +	case TDX_CMD_GET_REPORT:
> +		ret = tdx_get_report(argp);
> +		break;
> +	default:
> +		pr_debug("cmd %d not supported\n", cmd);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations tdx_guest_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= tdx_guest_ioctl,
> +	.llseek		= no_llseek,
> +};
> +
> +static int __init tdx_guest_init(void)
> +{
> +	int ret;
> +
> +	/* Make sure we are in a valid TDX platform */

More useless comments.

When you type comments, pls stop and think whether it even makes sense
to add them or the code you're commenting is actually clear from the
function naming and the given parameters and the position in the
function..., from all of it, that it is pretty clear what happens.

> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EIO;
> +
> +	tdx_misc_dev.name = DRIVER_NAME;
> +	tdx_misc_dev.minor = MISC_DYNAMIC_MINOR;
> +	tdx_misc_dev.fops = &tdx_guest_fops;
> +
> +	ret = misc_register(&tdx_misc_dev);
> +	if (ret) {
> +		pr_err("misc device registration failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +device_initcall(tdx_guest_init)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
