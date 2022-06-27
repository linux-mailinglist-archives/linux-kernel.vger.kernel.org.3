Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785955C329
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiF0J25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiF0J2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:28:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC918A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:28:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so4469078wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4PL1++HQNkiis5N4Auy4/gVnvZshPRAjuREpHrbteZY=;
        b=HU8kfowq/gFoJeZPPDf/C+CFlnjDxg4EdFT3qTEjsyZWi7uWoVvNwecWOdY/8y18Yf
         GACfk5elcX/Ze/s8CIleFDP4JEdhiHb7dz3jB9/WSoy01pSArjLuUznRNzB9x2CZ+3mW
         1a7YZ2QGEu8MjYud9/5HEcPy89oDW8kZMgvky2WBVi1DQ9z87h6E5azq6CpuvW4yzL6O
         APoUg94oMM2+wm/s6ZK2pUqZGKdjaVPVYDHSykITKQngNR6R3gkQnuo/O54oAxW8mYdq
         bYpwEPKLDnjx/OPl0P6jv7jJMMYBrDY4fPhl1B94o3OVQ5AMXmZV7sB5OKD3hejj4iyN
         o81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4PL1++HQNkiis5N4Auy4/gVnvZshPRAjuREpHrbteZY=;
        b=sYiM/jk4H8ym3ylTTwfvus96sCM4q356CucSl31C3hz+Ktng7Dd3zExmW2PJThzPwk
         OIeJTvaenDF7WaSKxswjPWx3HdFn6mlkiDV1QIQf5VY4PW3uv4thH/w8OOKknw5o8Kdx
         2xWqBDTEKbQTurYcq6HzSyc5vWM4otryjHnqrxmv/+rRo890ABaTkB+vrFGPt1c1tW4Q
         Ku6wjV8MRiuxSXR/gQru4itrxy9WcotjNSlDyds9zY2y33i6OFHD7psw/58K3sJ8Uzf9
         R5H98ddRL2kpNWlijfG1hvvTOAR+6wO8Izh1STtDO7orChVjj83q9ZuVNn3HDzxtn9Lz
         K2kQ==
X-Gm-Message-State: AJIora9fsKLzX4YFM81P/eF1GTYBf1GA2a8Hi+j9E1CuhNnryjZiY1VN
        u9Xa60yImJwFU7THdtFLqFmaKBrgSQaWkA==
X-Google-Smtp-Source: AGRyM1s3ZVCoid7K22D7QutquK+WCuJmVq4VCfVWwRMLpY2A9nERsTx8pAu5oCSp69bB3sL2Xidgvw==
X-Received: by 2002:a05:600c:3d16:b0:39e:f07b:77a5 with SMTP id bh22-20020a05600c3d1600b0039ef07b77a5mr18462761wmb.140.1656322128365;
        Mon, 27 Jun 2022 02:28:48 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c284a00b0039c41686421sm15989745wmb.17.2022.06.27.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:28:47 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:28:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 07/11] mfd: intel_soc_pmic_bxtwc: Drop redundant
 ACPI_PTR()
Message-ID: <Yrl4TklxdYyYjSKM@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-7-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> The driver depends on ACPI (via MFD_INTEL_PMC_BXT), ACPI_PTR() resolution
> is always the same. Otherwise a compiler may produce a warning.
> 
> That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
> none should be used in a driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
