Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA756D84F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGKIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiGKIhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:37:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1001211A12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:37:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l68so2609345wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kK9P2ba1h7/W8SvYR4UHHtRck6nEjGS/jF+Eq3Ktf2o=;
        b=t/oHDVAvKA/Y/cIxqnL98Tm4hqtxotiwuworY8WzD4JTxD0E72OBga3eLyzaFMHlbt
         8BatTT+z4vFHbWaTBki2H09DsITn+UJK+fToH3+jfb8Oz3jbAdpMTsw7fJk2Yszu15V+
         66ra/S1yeGTrjk5YWzfpD1izZ3MSY1Rn+sPRvjM2D3oHKkFp0TyGkHlmuzYATKUCjBS3
         kfIPKmTnTDeoFufPPm0Yi3rMepx2WhsQA6BZPjm8bA1gZ56B7KVmrZann1rCF5B7uZi+
         uVh8S+egBei6IyxOD1OcGJbBpPvRTG7NwOKaoFt2/EomT7JSlRo2cnYBXB5E09eyDzPt
         G/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kK9P2ba1h7/W8SvYR4UHHtRck6nEjGS/jF+Eq3Ktf2o=;
        b=mr7qL/FDVsDSJq9Ku5vWUbCeNsXsEh9Ne4r2p4DARw5ao3dp8JF9Tjsj6jA/jNSGo1
         rN/Ou+GLrH8M2MpxRn0yX7pMcgN0PvWWCQZcQGP7hhCqfCxv6Y5I/E1ByWdEjTqIPCeX
         HqjyaHUXv+TF38Fhzg+S7Fgb8VpUMCleG3Hhphw3D4nnJR54fYH1J62nL+Vy6si1xeBp
         6PAM/P5VS7uOXdGDDuEcxXCjwqzc176biOPD4bQ8fgQcQXotYrZHm0XbZ67qCvkKmKlU
         vMmUS2quiFvf3Nkh8rrnye05a7NgjfeMmdVUF8wo5/pNZNrOGUgewZ2ARjmnkx4Kszoi
         ftWQ==
X-Gm-Message-State: AJIora9R0h3xFD6vcTNaEnlPpswqLBteirhyg8cfaUXMQyHLaUHl0JBv
        xZH4r8j4pFYR7rwmbR/O73u83g==
X-Google-Smtp-Source: AGRyM1tvLiWuXOlS/cT3Kfo+ISSxIUxAA0QtPQ9FVGHdW6nOgaVvCSX4QrvVDdZqOYfNlp6Ep7hDpA==
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id d14-20020a05600c3ace00b003a04ea45f77mr14569199wms.57.1657528660637;
        Mon, 11 Jul 2022 01:37:40 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id ay19-20020a5d6f13000000b0021dabdc381fsm565665wrb.22.2022.07.11.01.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:37:40 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:37:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 08/11] mfd: intel_soc_pmic_bxtwc: Use bits.h macros
 for all masks
Message-ID: <YsvhUosAs735ZK3z@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> Currently we are using BIT(), but GENMASK(). Make use of the latter one
> as well (far less error-prone, far more concise).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
