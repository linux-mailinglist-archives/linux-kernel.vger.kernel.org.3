Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1049F58B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbiA1Iow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbiA1Iov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:44:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2095C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:44:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f17so9513032wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cIaNBMx7IdzP699KauIlrjluaHc1E9JkACiB9Gtq4Bs=;
        b=SX64XqQ5G6XVFLW17qHA87jx8sD/QYtO4xKej5z7I1qSar/bk0izQfqFV/DjTJJVql
         fOjl1nkz+snrIHhGJASANG/o7jvjEzDt/gtC1T8nW7dGCu/zkfwtcKaXcZ/KdGyeP13h
         M9eqilQZSBsEDBondyuqY1jlNO/EgJeerJiTRqtUeVR2mLasbQTh3nFsoTyrbZpLxnS9
         H1Lb7b4KECUAli/OQ8emLj52Hh39zOckXNWsCKnZNvLp/2RpqaYQsVKP9BAk99gdqJss
         L+3uJej78NvVNgKo3clZzaZD05ii8e37XK6wTf8o3Mb5BqZbI63C5K34Eij6RgTXOkfQ
         jHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cIaNBMx7IdzP699KauIlrjluaHc1E9JkACiB9Gtq4Bs=;
        b=qmc51159IfH8A57gK368MVJ1lS8lQhqLRURKG3OLlhcDPaeVmSxb4QQpL1X8upN6Yf
         +GQzAtQFr9xQk5KAuKcUpJ3yAOxahcMBt4EvpS3GzLHDIXU/eOHsQSCqRw+FfSZWLJnP
         5ebA2E3KGKa7R9ACkRZRWEf68mwWA63WAbJ2Z1+LOvN30HHsQdQRYhNq58IxVWoBN2sL
         Sc+bTOMlgtwXL7Y/8XGBKshTebTsuRXYf3Cbaj1e7RwbBUF+UJxD0S1EgFDssW/gVfHk
         ssDwDTTtAWvSsx4Ai+ibTIRh/Kgnl/a/ACPLZdZ7Dwh9cm7ii/o0EYqabJd2019JPEvU
         xx7g==
X-Gm-Message-State: AOAM530p0xD2sXdqyR2WeXQRor31FpQTMly5ANkqmVx6v7oiV0YvyQHo
        th7Fb7CdNW8OlMXJA+2uUvjp9A==
X-Google-Smtp-Source: ABdhPJzeYlGcAbO3qbM1+9qlvsWjeZd75PDVx1TVHtmLMx0EUtDp4Ri2asMbfOlDC9ori9jdCVbxSg==
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr411721wrd.51.1643359489380;
        Fri, 28 Jan 2022 00:44:49 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id 5sm5031758wrb.113.2022.01.28.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 00:44:49 -0800 (PST)
Date:   Fri, 28 Jan 2022 08:44:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] mfd: simple-mfd-i2c: add compatible string for
 LS1028A-QDS FPGA
Message-ID: <YfOs/wkylwMgsepj@google.com>
References: <20220127172105.4085950-1-vladimir.oltean@nxp.com>
 <20220127172105.4085950-2-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220127172105.4085950-2-vladimir.oltean@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022, Vladimir Oltean wrote:

> As Michael mentions in the description of commit 3abee4579484 ("mfd: Add
> simple regmap based I2C driver"), "If a device wants to use this as its
> MFD core driver, it has to add an individual compatible string."
> 
> The QIXIS FPGA on the LS1028A-QDS boards has a similar purpose to the
> Kontron SL28 CPLD: it deals with board power-on reset timing, muxing,
> etc.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
