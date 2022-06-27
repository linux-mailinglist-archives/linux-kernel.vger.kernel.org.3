Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3755D205
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiF0Jar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiF0Jap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:30:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE518A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:30:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso1678593wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yrjSb0Ckr6OyB8OTvoc1bSQEObi6R4PR8vq3UsAz654=;
        b=e0GvQoe6562R15lcwVHIqfpjpax8YEefnMUjbGIGMspx0m6qzJaxqH9ZhV+93PxIhE
         xsSrFdnoSbO2YyUtqDKnvM4q1Kwn+JkGBKcRINUYbsHxzvmFDoceFM5bqoIvG9CqBjcA
         9gzXRobka+NuhIFUECY+WDOTMgkSdj1WhXVzq6CYfQe1VUa73CHnP0bukebiGY+yQJ5O
         T3L7rVb0QLwQ/yz+29mWOEbj1VPu79VcBA5rx+7a1Sc9r/BNhYgURyY1ddS3w8BiPE1W
         4G9ZOQnINzMuPCVzT6YiEBWZ0RhtWK8MIyMeFbtFBgMMwCNe6zb8Xr3DFon3E1dzDIa3
         b9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yrjSb0Ckr6OyB8OTvoc1bSQEObi6R4PR8vq3UsAz654=;
        b=pYttlPOEiCUDwPOmENYyTYoQNkZuF97T964wDGiSmGjZ8d6H9uIWwZbWkiXUvP2x1c
         nIf3Gp/VDrkaszKUxYt5ZsvmDmNtk6bYIzXKGsywXYWpCOwo9hEfjOV+cA32n3JoLcyp
         rJFgmgYID3/KIBkrlLzkoUJ5pHwh0coZMM20OjoYnKIYgUr9kN71U41IA6B7X+BWBu4P
         uFsrpSAhS4CDRTLejZ4zkJR/tic3p3SzsQDxp/aoIlvdmTPziOc7aoCKNJYpCfQGQ6iT
         6VGNPqqeXvT1QSK4dg3yDsnEzRyMnBHq1XUCF5ecCt9mQEQDSFOW3Or0iPHB8Ny69VIL
         lC3g==
X-Gm-Message-State: AJIora9k9Q3ar5kbyW3+oKljmhUshro6s3fqpwS1/ODbXDEfokIFtvei
        L9axinvVoVKf+JcJht0UjgUNIL30aXk/cw==
X-Google-Smtp-Source: AGRyM1u7f8zpjsNsmCKfFBXkK22cYXVPQp05GB/B+aAp9Djsj7JwipP5zH3KC1oEF14VHpJkF1cS0Q==
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id c2-20020a05600c0a4200b0039c90868a34mr19101536wmq.169.1656322241922;
        Mon, 27 Jun 2022 02:30:41 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b003a03ae64f57sm12616410wms.8.2022.06.27.02.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:30:41 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:30:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 09/11] mfd: intel_soc_pmic_bxtwc: Use sysfs_emit()
 instead of sprintf()
Message-ID: <Yrl4v2cTXa/U3A8Q@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-9-andriy.shevchenko@linux.intel.com>
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

> sysfs_emit() is preferred over sprintf() when formatting the value to be
> returned to user space in show() functions, because it knows about sysfs
> buffer specifics and has sanity checks.
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
