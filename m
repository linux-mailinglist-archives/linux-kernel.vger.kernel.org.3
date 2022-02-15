Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0504B6D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiBONXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:23:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiBONXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:23:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F3106628
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:22:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v12so32144235wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OhoR4XATjA7zKN/RXHZHTsGzRsSVf9+O2oXzvEdltm4=;
        b=b37OwHeSwfGsU9K1T22xDFIAhKSKSenRPOPbaBz5dZ/gVxQWzkw8Y3f1IAXCFdvB5m
         +rSWAbEkBChDH+rt2BOUIkYYjYF1LSICd9lKhJIBHYcdADSvzXh1Gtm+OqkvSP1NqtEC
         G2mE+1Epjaafm5Q66Hno5vMzoyv3AhZXIFAoMK3NVIV+pK5/ssYk2jOK7jIou3xRnGdd
         kpGaGU3vcaN+DqVvayYZvOe6PnvMl98owWy9NR0ZvCmpYpJWiq0wys4JDCviEwdDf5Rj
         24EK3QIdRsEIulb0NtGI8z6Buh2SHfkNgIrxKGAISAyEDWGTW05NanSb53nDjsTn42Gi
         MiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OhoR4XATjA7zKN/RXHZHTsGzRsSVf9+O2oXzvEdltm4=;
        b=e8fAGBv+s54mUvEhGai7s9Nmtft4+2U7a4iDkL6tG1ta3HzIHAI8FguGTxzbz9H60S
         HqRGEUaIfu0o3ddW6wckvvFDbsDl/7R2TabIk0E2V97WRr5PJ9NeDXuXhcHN3nJF68z+
         V6ZyzHs0ZkVNFgK+u6pkRUTj1o4gdzcGtAfR6Pns+i8MYTUf2WqSHXqtc2gVloMvM/lS
         Bo7IYWBxvebzxZaQF64qoDffOUUb2YEeThtbmLc5xfueTcW4tQlgf4CfYDneCR11SpJc
         Vr0DOYVUR8m2q/JoOT3QEddrGo8ixt8axLvF4xT9gwz3jMi72toJIal95xzPSt5N1pdf
         VFLg==
X-Gm-Message-State: AOAM533/fMWIvFX9T14gco1ul9bMiKJPa4SNdJudEibwqqMm46YlSuS/
        FbVAU4tVnbGcIbwZ6RO00wcOzLbVXcSTwQ==
X-Google-Smtp-Source: ABdhPJwcKJSqTBvxL+OpSByXJmDucyG0ZiWYSfuT5Cbu9ZCkArRBYTg7i2nkZMigKRRU51tW62ISkg==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr3147271wrs.574.1644931369364;
        Tue, 15 Feb 2022 05:22:49 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m31sm16135529wms.34.2022.02.15.05.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 05:22:48 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:22:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] mfd: sta2x11: use GFP_KERNEL
Message-ID: <YgupJrUGnOh1vxr5@google.com>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-10-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220210204223.104181-10-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022, Julia Lawall wrote:

> Pci_driver probe functions aren't called with locks held and
> thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/mfd/sta2x11-mfd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
