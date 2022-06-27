Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85D55C4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiF0Nq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiF0Nq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:46:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612005FE6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:46:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k129so4060405wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LGnjZjMgNQjjpT6vk/yU6tWzkORqa0MTnCOvzva+faY=;
        b=XS5NG7d9dhRv3vfxHj+NNSuqz724i7KVRnYtrArOwbFU4ye6nmTf7wFDnK5Pr4F6w2
         TD/x3vhC1x11KbeSWVkDvuNjYlOF8hffkJW+ekq2av3v0rJmMKfCQduLgXYM2wTYA0a0
         BXSCMRPhuHXYQK9IjhYLTOlII/dY+6tAqJxwLy/QGj7OrelMwJq66W1AnRZlL3RdVFU7
         qpGCJRYDv1/gPgmSlAgOKSP9HKHyZjGXzPXbhhI3jkDyBVEUsAx9yAx6/y0vYhRFnJ6h
         6MD7YEO9iLSsYPGBzpIlP7mNqJYfrjphmYmNIlM0JLy4EdqabdtTUW7DRNAFtynNaThP
         /zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LGnjZjMgNQjjpT6vk/yU6tWzkORqa0MTnCOvzva+faY=;
        b=vHoD3L4UFDb0ZqriLx4xBKvJZ/0udQlmh8XGFOLFFST3gEl35uDYbl68zNDhf8SKoQ
         sOKOidr5fR0HdTmTqSDiCOdp0PhVrKAFPEkaSQ+Y7VxK6dledZrtUIvqgOy40ejgWx32
         j5Vq1eFJ0vyr0CeUR1uBUt/6BHubENQ7K2DkctyJA9FK95OISV4fG89S+EULFZNqHWpP
         GOJM39fPqJAVZqKpxmb/mS6YnwR6atcOwup74X9Nmdsl6/RUjfrqzbh55BXhFSPrSA4X
         iACwLAGWczzCGiP/dyOFwiNC/0ZJUD0FZz4X0DVnkbD6p23kv8KCLrJQxZc9LG0cwnxQ
         /UKw==
X-Gm-Message-State: AJIora/DyxJKZDK07IXKoDdTPT+Wvp7HKkMwEepoEokt5b+NITQ5QD4k
        GedGLLFLnomKbQNcJiImG7CBEY35rgszGA==
X-Google-Smtp-Source: AGRyM1u78796Z4LX2iHZSPEgvOHod7hz5vFvKKcOt2cEsXGqXyuV1i4kybJSIjWJFmLQo4lfZDpx4g==
X-Received: by 2002:a7b:c8d2:0:b0:3a0:2fd0:177 with SMTP id f18-20020a7bc8d2000000b003a02fd00177mr20174364wml.23.1656337583949;
        Mon, 27 Jun 2022 06:46:23 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm10360253wru.21.2022.06.27.06.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:46:23 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:46:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 9/9] mfd: intel_soc_pmic_crc: Update the copyright year
Message-ID: <Yrm0rXd2ok8bJkTm@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-9-andriy.shevchenko@linux.intel.com>
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

> Update the copyright year to be 2012-2014, 2022.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
> index bb3cc1a808f0..0e5aae7ae9ad 100644
> --- a/drivers/mfd/intel_soc_pmic_crc.c
> +++ b/drivers/mfd/intel_soc_pmic_crc.c
> @@ -2,7 +2,7 @@
>  /*
>   * Device access for Crystal Cove PMIC
>   *
> - * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
> + * Copyright (C) 2012-2014, 2022 Intel Corporation. All rights reserved.

Same question as before.

What happens between these dates?

>   * Author: Yang, Bin <bin.yang@intel.com>
>   * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
