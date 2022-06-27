Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B749555DF84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiF0JIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiF0JIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:08:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8AB38A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:08:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so6701967wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EK8ZKVC4vXKP44XZRmB3DEh4s34C/LuW//SP9lrTtxA=;
        b=Iu4BSJ9vx3AG/xKmrAnhxS01VXfFI+mCtc2w9a/Anxo873GlqOV+sdZJZPwJY++P4R
         W7/zvP8P1ZjxxHvfQcTU5XmUoLrb/iVDgD5Y+qSyubQBge+FVD5ViCObPyag13+Qbpsz
         cDluqrCRzhfcSxi2LXGxZSTAYsgvNC5MhjJk57+DaHZfQGub9sHARFvAu4WqA73uC6mX
         571KUvYqg3Zzcg4JvW/3ZkzOp1bdJr5tgzz/SMcxccDYl+oxqDmtuTecSqU6t3mSJ36+
         2Ty8nb1/AW/ir3bw95wPXIOwFN1jWgyXwfkEDjWo+zvFLe8wDNd55FgRG6//DVisY5cb
         588g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EK8ZKVC4vXKP44XZRmB3DEh4s34C/LuW//SP9lrTtxA=;
        b=RsEiWri4zCceLJTvszGQYgKqtVtYcl0/K+/E/28UFAF2Y1yZGgql53Nvrh/ch8wTQ6
         6Gpyf7D+YS4Y4k7tZ/ILXOLGy9zACeAzEJxiLuc4njd8zB6+KrHiwoENOhbIrxauG6K6
         VhrBPkoHVAia4JF6I1FNYP/QiWkdBK0INorvsHYkdw7z1/8Gd6gCDoOROsC8KSJI3Z6g
         kaTY912+6NMxb6q/0hnwniNiECNGYuuku5vrjExygPDQeA6K0UfwVYDXpTgwBPXPoBeH
         UJm85IbHZH42qnFhwrGOpekLXxVLwKwwYwl/ywPwIfuiHX+MaHUQPvhkCw5PKX0PGRDq
         7nnQ==
X-Gm-Message-State: AJIora8rwin+TTjc0IMPe7j1SaKGrInARFZYm9y2noJKARM325QuwBbC
        N1ydxyM9QPw/6M5ich0sWKLZKn+7ZxCeKg==
X-Google-Smtp-Source: AGRyM1vV3ajVvpW2wTwwVIQWDTGvJ7BUl6Ue39v8aMt4h8x3HEjB5qy8tiHZ3PHYiEV2E5UndzlWBA==
X-Received: by 2002:a05:6000:15c6:b0:21b:ccda:fc69 with SMTP id y6-20020a05600015c600b0021bccdafc69mr5018850wry.411.1656320898449;
        Mon, 27 Jun 2022 02:08:18 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t11-20020adff60b000000b0021b962f4256sm9677219wrp.80.2022.06.27.02.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:08:17 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:08:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 03/11] mfd: intel_soc_pmic_bxtwc: Convert to use
 platform_get/set_drvdata()
Message-ID: <YrlzgJq6FA+BvtOZ@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-3-andriy.shevchenko@linux.intel.com>
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

> We have the specific helpers for platform device to set and get
> its driver data. Convert driver to use them instead of open coded
> variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
