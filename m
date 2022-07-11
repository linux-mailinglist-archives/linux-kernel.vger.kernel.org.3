Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA2F56D78F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGKIPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiGKIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:15:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B495A1DA73
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:15:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so5961062wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6DWq1wMF9fY90AzBasovu62zTzhHtDKOLQCRNv0ZlKo=;
        b=b0YBrpH+jAFbo9NMcnOyJkponKHXE1UAlDOhxKgGfWY9dtxjGM1Z1vlfXDW9wdPiQQ
         5HFDrWzqRl0Vkqa/gVrVCyn/rwWg6pBi/DGOSVDsbRWCXESyc9iOtqh/G4iWD9RfoIRC
         ba2/r0t655DXphFYP6VbJAf/uGlJ8VxJgPzL0KCJ49cmvFmxIj5KoRCnB8aIPqS2824J
         7p1ENR6vakoUl81JKE81TC/tq0iQy5U4XpcWYMma+xeslIPKIpizcvHcwuu1bMxLIlT1
         9smjkXX28ZvdvYxcBJuwvy5JR9LxujjSfSukxXkW/yZsxbKqJ/QZn5uzB+/d0r7vV/+0
         a7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6DWq1wMF9fY90AzBasovu62zTzhHtDKOLQCRNv0ZlKo=;
        b=xf0ScUGFKx/18XaKvKdmmcaz7p4DBb7FNrKCz8bDrxFW1Pj/OtfuW8vcjkCSdwDw/q
         CH364M4/oh50E/elisPzsIP3aNN+dRAH2xe+IW8UJjcXF4GoRXnm63ZqC3raO41ayWna
         ouYruzSKqmA04YBbLpWMAUuGR/k4nbZ244QcheYVzVUvmIzkVyHOCVQdvK19ddly+DwD
         17GWTfc/Ukffbp3WNdwDFbDLxosg2QO60HzzZ4PMEjj4g+RzYWagLtE/pA/Tr+PRC+4j
         Z1yvXTyVE3Up317g6LGmATW0Rf4xbFo4u21SXmXupFh40Zo9p3PDgkH0YiK2lJ6Tf86w
         Ph9Q==
X-Gm-Message-State: AJIora/oWWkBMr6OPAQUp5k0alAvGhkyYgBjEtW0jiDiF8gknaUDc1c1
        9Ml1jF2myi0h0lIktL+qYx5GyVapznvGlA==
X-Google-Smtp-Source: AGRyM1u4cExAFLILTw1IcqnT14nWcrV8iR0sCp/R3lJU6ktzDppmN5og0YxCTwwaGjbi/2S43aZXRw==
X-Received: by 2002:a5d:64c7:0:b0:21d:a743:394 with SMTP id f7-20020a5d64c7000000b0021da7430394mr2905094wri.628.1657527341239;
        Mon, 11 Jul 2022 01:15:41 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600c354f00b0039ee51fda45sm6209835wmq.2.2022.07.11.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:15:40 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:15:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error
 codes in show()/store()
Message-ID: <YsvcK3ihQXbr1m/l@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
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

> kstrtox() along with regmap API can return different error codes based on
> circumstances.
> 
> Don't shadow them when returning to the caller.
> 
> While at it, remove rather confusing message from addr_store().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: dropped a confusing message as well (Lee)
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
