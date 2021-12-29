Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54A5481370
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhL2NRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhL2NRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:17:36 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:17:35 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t26so44391651wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HXbJLG2x7ddZZHbyv1lbghWYh3dFLZJ8HVvdGE8R5MA=;
        b=GcpwhzpbZH1+v3cc90gFjzSoDhBDsNFAaAIgleZKOsvlQDEOmEzaklrlxc0AdrzMpl
         SAAx6+VsRNdOsf85Mrbe4LybAsX17qkNsMpXEAgIIDwW2oJFrDjWb82Ihah3FvT3TtGI
         eBAJjofIOfVlgrth3+pxNJfiADFI/l0dhVa51EevipwkDb2sjcASWWiw3RrF6w9CUaL0
         /fOg//1Da5szApGpb8NB1WGzQzA8bjg3wzjCN1hsWCE4DJ7iTji3N9iBDCXIkpvJx8qv
         51hZC+XGLPw/fVDICQom6+FHs84tR+POg5n37H6PEYBWndlYzxL9naWT1hhMyy1WwztV
         o3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HXbJLG2x7ddZZHbyv1lbghWYh3dFLZJ8HVvdGE8R5MA=;
        b=fajF3zO2bCM4H0ZM53K5w3RwPRsoQXv2zy/x0MfRiczDRNFXhFYOrtkapnWUAh7qcZ
         AQoeq7o8MwN2F9wE9hE3oSKV/qHW1Diig9n4z02tZ7KdGJnXn01RLJ7CQBVktY/Vy9g1
         b7yXRaxMBJO+VGBI7LQIMH+7FWHUbIRKyvq4mUQ39XvQ4EtFrxB+Bcz1LNGQRI6jnpRt
         yGQiQfQbQg/EGjQ45ostfF/GElH3TFkXSO/Ik4+yUrc97urFjb3Ymhhv8jwNOzvxBXNe
         +sOnaKMZzWKcYnAn8gL1Nb84BTTJjXaI8IEyGkcjYYEMjxqeTbwqiWl4PZ27gbulSmEX
         cmhw==
X-Gm-Message-State: AOAM530DPbZhL1SyHeVYh1vA5M8HU4uro0TXmM9wp3Cj96/BBuhE5oUQ
        mVDF7guY9ZPEmZDRFMdjnWZ2iA==
X-Google-Smtp-Source: ABdhPJwwgKaFs99EjE5PBIwI5fB975NLyxXqXJS/p0hLKhEeYdmZAR2OiPzEMV6kUH6h+XQuRoqqAA==
X-Received: by 2002:a05:6000:2a9:: with SMTP id l9mr20850932wry.71.1640783854080;
        Wed, 29 Dec 2021 05:17:34 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id p62sm20953846wmp.10.2021.12.29.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 05:17:33 -0800 (PST)
Date:   Wed, 29 Dec 2021 13:17:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dan Scally <djrscally@gmail.com>,
        Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix I2C4 not being available on the
 Microsoft Surface Go & Go 2
Message-ID: <Ycxf6/UulLysJ8HA@google.com>
References: <20211203115108.89661-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211203115108.89661-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021, Hans de Goede wrote:

> Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
> _SB.PCI0.GEXP ACPI Device node describing an I2C attached PCA953x
> GPIO expander.
> 
> This seems to be something which is copy and pasted from the DSDT
> from some reference design since this ACPI Device is present even on
> models where no such GPIO expander is used at all, such as on the
> Microsoft Surface Go & Go 2.
> 
> This ACPI Device is a problem because it contains a SystemMemory
> OperationRegion which covers the MMIO for the I2C4 I2C controller. This
> causes the MFD cell for the I2C4 controller to not be instantiated due
> to a resource conflict, requiring the use of acpi_enforce_resources=lax
> to work around this.
> 
> I have done an extensive analysis of all the ACPI tables on the
> Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
> not used by any code in the ACPI tables, neither are any of them
> directly called by any Linux kernel code. This is unsurprising since
> running i2cdetect on the I2C4 bus shows that there is no GPIO
> expander chip present on these devices at all.
> 
> This commit adds a PCI subsystem vendor:device table listing PCI devices
> where it is known to be safe to ignore resource conflicts with ACPI
> declared SystemMemory regions.
> 
> This makes the I2C4 bus work out of the box on the Microsoft Surface
> Go & Go 2, which is necessary for the cameras on these devices to work.
> 
> Cc: Dan Scally <djrscally@gmail.com>
> Cc: Kate Hsuan <hpa@redhat.com>
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Use PCI_VENDOR_ID_INTEL instead of 0x8086
> - Small tweaks to commit message
> - Added Laurent's and Andy's Reviewed-by
> ---
>  drivers/mfd/intel-lpss-pci.c | 12 ++++++++++++
>  drivers/mfd/intel-lpss.c     |  1 +
>  drivers/mfd/intel-lpss.h     |  1 +
>  3 files changed, 14 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
