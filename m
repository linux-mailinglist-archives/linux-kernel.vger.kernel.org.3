Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4445D48EB14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbiANNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:49:14 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33705 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiANNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:49:13 -0500
Received: by mail-oi1-f182.google.com with SMTP id x193so12282017oix.0;
        Fri, 14 Jan 2022 05:49:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+AfKsQIJxC792VJgj63R3rMU3bH/e+JiSQPxpb/PgA=;
        b=CThA8zH1Yu5NzfG7RPNjwSJYIECd/s9/lQVUAeR3pqmoLwAVUQBw6lsCrwXqUmpwV/
         YK45SMt64Gs2jlkA6aP0MO5e9XgUy0CXcFX/wBAEG3580q/9in1YPwOrPrf6A/n3G0vS
         6ltTkUD4h8S3s2Mtc05NTwP48p4/9tnFObsSAufkEWry9fuA9hpw2V2ydfczSOdfa7gV
         Tco4Q95ly2w80Gw3tXQcyHd9jSYiABksTajvXbADgGSff9HAGPVZKdPjw0KT4rzBCkm6
         IxKHn0AEFa4zgE2GI9FxV7uelqeux5SU+riGBNLwkegmYosPQf0hUhNY/siKOxeV+tiw
         fTPg==
X-Gm-Message-State: AOAM530eqpz7YoHqfgxC7aH2w+zudcOVNgH3FqBR1T6GqTjDbeRiIvWF
        K9KzjMlSedjZhvvAQ1Rm1+Kf9SpbMQ==
X-Google-Smtp-Source: ABdhPJxmmpHFexPzfp142xVob3UE2xRtzttqlu0uvjFB2qTPN7Q740l/qG4ZqqAAkRskJZeKthLPSQ==
X-Received: by 2002:a05:6808:124d:: with SMTP id o13mr7412554oiv.91.1642168150973;
        Fri, 14 Jan 2022 05:49:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n189sm1812573oif.33.2022.01.14.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 05:49:10 -0800 (PST)
Received: (nullmailer pid 1783269 invoked by uid 1000);
        Fri, 14 Jan 2022 13:49:09 -0000
Date:   Fri, 14 Jan 2022 07:49:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] um: Add devicetree support
Message-ID: <YeF/Vbxo6fAt0WLp@robh.at.kernel.org>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <20211208151123.29313-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208151123.29313-3-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:11:23PM +0100, Vincent Whitchurch wrote:
> Add a dtb=<filename> option to boot UML with a devicetree blob.  This
> can be used for testing driver code using UML.

Neat!

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/um/Kconfig          |  1 +
>  arch/um/kernel/Makefile  |  1 +
>  arch/um/kernel/dtb.c     | 41 ++++++++++++++++++++++++++++++++++++++++
>  arch/um/kernel/um_arch.c |  3 +++
>  arch/um/kernel/um_arch.h |  6 ++++++
>  5 files changed, 52 insertions(+)
>  create mode 100644 arch/um/kernel/dtb.c
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index c18b45f75d41..1cf7ef3a2b81 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -18,6 +18,7 @@ config UML
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DEBUG_BUGVERBOSE
>  	select NO_DMA if !UML_DMA_EMULATION
> +	select OF_EARLY_FLATTREE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_CPU_DEVICES
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 92692bfef7ae..ebd0cca3ff26 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -22,6 +22,7 @@ obj-y += load_file.o
>  
>  obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
>  obj-$(CONFIG_GPROF)	+= gprof_syms.o
> +obj-$(CONFIG_OF) += dtb.o
>  obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
>  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
> new file mode 100644
> index 000000000000..ca69d72025f3
> --- /dev/null
> +++ b/arch/um/kernel/dtb.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/init.h>
> +#include <linux/of_fdt.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <init.h>
> +
> +#include "um_arch.h"
> +
> +static char *dtb __initdata;
> +
> +void uml_dtb_init(void)
> +{
> +	long long size;
> +	void *area;
> +
> +	area = uml_load_file(dtb, &size);
> +	if (!area)
> +		return;
> +
> +	if (!early_init_dt_scan(area)) {
> +		pr_err("invalid DTB %s\n", dtb);
> +		memblock_free(area, size);
> +		return;
> +	}
> +
> +	unflatten_device_tree();
> +	early_init_fdt_scan_reserved_mem();

These should be reversed. early_init_fdt_scan_reserved_mem() works on 
the flat tree. Reserved memory needs to be reserved before 
unflatten_device_tree() starts allocating memory. Though I imagine that 
doesn't really matter for UML.

Also, does the dtb end up in permanently allocated memory (i.e. not 
init)? It needs to be if not.

Rob
