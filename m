Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2049527B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376983AbiATQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiATQh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:37:59 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:37:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m1so23847337lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h/m/F2NnRHmw+s3i6KtA12JmjEsgCsTpng2++DmHCL8=;
        b=y5eOxJkbWcKuaqZVdz1DUjNmNcraimHw+Pro9FAjfVRZvzZVigHZAMfQepfSot/3cI
         bBB91Zhc/W0YLBueoaaYsW0JjOQfX3w/wGeV3NSYRKnHas5ZaguVtN3p3BI/qB7C1Hpa
         8uEfJ0WvETzxZdIvQWUlU1GRjgd97VCMX2EO+Us7r4JPsFyY3npFgPXNfr2myNLzV/2g
         HqJu/Wq2fqsOBAm9OQqDYSjnofAondLtUk0CyRg6UOAbUDiSONu03gXQhwn/nAd5RYSz
         2PookWxbJAsZM8hotIfw/bY9NXfwB5Wkp4S3pv5/7DL55sO9be5gKah8nnATxwTYEPLG
         anwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h/m/F2NnRHmw+s3i6KtA12JmjEsgCsTpng2++DmHCL8=;
        b=ZdmQqTeeyUWfGnFBiXA97kZL1e8Ksk6msUnSmWBinoKGU5LFEfZ/3nT4/fOdVMMhPs
         SF+frDc/HZTQyIlJrAVymEP7QqmUWIYfsuo1vo2nh5iJFty8njFRk8TKK5VtTUqqmFXu
         J8Yn1zof4VGohc0sUgp190+oEa9PorWJurRFhTXFc1JvqFuvZz4DmGqUH9aEDYLZnUB3
         VDhSbc+ZcY7TpGNVmgEeukjP1J0rqAnjnBszOvU9urslU61xBd4z4LCxWmVwkJ2587w+
         gjAfHFppF5zJOU5I0dBwdwbSHRwsnUxkhRd2CC08lT43aMTf2xPf6Z86QwvZQLGmwfbl
         TaTw==
X-Gm-Message-State: AOAM533MqkuDtPVAlBx7l2AQTPwmIjOJ/yZhwoCjO9IQXMq+39usJTio
        0geXAhBnMIS69UQiDY8PDUVJ3Q==
X-Google-Smtp-Source: ABdhPJw9iGkrATKaBESRT/TiPdqro/IDReFNHIhcDEIp0QL20iCiddQOerAnmxQJUtZTy11MFnSICQ==
X-Received: by 2002:a19:ac03:: with SMTP id g3mr729009lfc.422.1642696677075;
        Thu, 20 Jan 2022 08:37:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w16sm409638lfk.89.2022.01.20.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:37:56 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3F380103725; Thu, 20 Jan 2022 19:38:26 +0300 (+03)
Date:   Thu, 20 Jan 2022 19:38:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/boot: Allow to hook up alternative port I/O
 helpers
Message-ID: <20220120163826.bits6ffbnbal4yse@box.shutemov.name>
References: <Yehz3eqq670WRVJE@zn.tnic>
 <20220120021545.7786-1-kirill.shutemov@linux.intel.com>
 <20220120021545.7786-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120021545.7786-2-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 05:15:43AM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/boot/io.h b/arch/x86/boot/io.h
> new file mode 100644
> index 000000000000..640daa3925fb
> --- /dev/null
> +++ b/arch/x86/boot/io.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BOOT_IO_H
> +#define BOOT_IO_H
> +
> +#include <asm/shared/io.h>
> +
> +struct port_io_ops {
> +	unsigned char (*inb)(int port);
> +	unsigned short (*inw)(int port);
> +	unsigned int (*inl)(int port);
> +	void (*outb)(unsigned char v, int port);
> +	void (*outw)(unsigned short v, int port);
> +	void (*outl)(unsigned int v, int port);
> +};
> +
> +extern struct port_io_ops pio_ops;
> +
> +static inline void init_io_ops(void)
> +{
> +	pio_ops = (struct port_io_ops){
> +		.inb = inb,
> +		.inw = inw,
> +		.inl = inl,
> +		.outb = outb,
> +		.outw = outw,
> +		.outl = outl,
> +	};
> +}
> +
> +#endif

It works fine on x86-64, but breaks on i386:

ld: Unexpected run-time relocations (.rel) detected!

I'll change it to

	pio_ops.inb = inb;
	pio_ops.inw = inw;
	pio_ops.inl = inl;
	pio_ops.outb = outb;
	pio_ops.outw = outw;
	pio_ops.outl = outl;

It works, but I hate that I don't really have control here. I have no clue
why compiler generate different code after the change. It is very fragile.

Do we really have no way to say compiler to avoid relactions here?

-- 
 Kirill A. Shutemov
