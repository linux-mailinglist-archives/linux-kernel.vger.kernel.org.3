Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC60055D127
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiF0Npv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiF0Npt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:45:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B45FE6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:45:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e28so7981593wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9FdyKVqxca7JjMXT8AI+UPWtuLm5yrwvxgWDtl5sUco=;
        b=McDeXl9WgPit2868FtACoq5aGzLsbGWPqIpLp1GNzIx3/DBU8r4BZkbO9Upt75LrSB
         NvNIgCcLABS3nVXmB6TkvcCq1zZiQKXFQpYrOWTugCaNY/mWZ2glRjKmKKj+eys1qZRr
         vdX//Ley6RVUR3JeyfsIAKoZjCycZqgSVpGjN64++1EjpqdsPUVUltMCU0km3VYzFZkq
         GcyAh/zcvdyRDFBYcBHDug31ABf39v4TDafXnassjvSy7x4kHakYek5xOZBZJvbfHN/N
         dXdfpf84Ne5EZD4obF9Ah8wwoA1y9GxSIPMr6YSqdM7JGqEobK3ZOWy4X84wMQ5ThBLI
         PgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9FdyKVqxca7JjMXT8AI+UPWtuLm5yrwvxgWDtl5sUco=;
        b=PKL5gt56owcwLwu6m8NRTpZxksADACjpVQ+Id+pdQc3FkiRzCBOxxWhPw8DgHjHZ/Y
         bb+FD5ndYYeSQ4CvUMKbojt4dFrCBEq9nWLDgMS7j8wUhRY4lM23678rfjdrYoju+jOS
         Al2KqA874RV7M4qBDyGqOgsl1PkZpXZ+AR1I0T6vkmsFllCbztlFWwfUZr8DpBV6/5yF
         xD1/Z3ce5c5/0lb1u6F/A1T0hmlTZdP5qjrV/CSTHPjv+WPBMKA5rmIf0+TcnuT9bm4e
         gl7YQeN1uBVaT7e/almqy/d5c8xrLRQnE33vV3T7W1V/lAjTLzipJkxJ+M0lMDdn4blu
         0EmQ==
X-Gm-Message-State: AJIora+nnrqcubyU04fLAvCgyKsgyNUxGPZNpTjMAUnOsEsjFxDP1/Zy
        5+VaKp7zsM5+EBT13WMFcVx7Yg==
X-Google-Smtp-Source: AGRyM1vl+MtLumtxCqKdMXnHzbNbEBPayhz1xyDXnuOB/INTROe+20T3wT1BsuZ9naWtGpZ5QbfdpA==
X-Received: by 2002:a05:6000:12c3:b0:21a:3795:70ac with SMTP id l3-20020a05600012c300b0021a379570acmr12575805wrx.175.1656337547419;
        Mon, 27 Jun 2022 06:45:47 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c248100b0039c5ab7167dsm17393339wms.48.2022.06.27.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:45:47 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:45:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 8/9] mfd: intel_soc_pmic_crc: Replace intel_soc_pmic
 with crystal_cove
Message-ID: <Yrm0iT4ht8DVdLli@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-8-andriy.shevchenko@linux.intel.com>
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

> To reflect the point that this driver is only for one type of the PMICs,
> replace intel_soc_pmic with crystal_cove (avoid using crc for possible
> namespace collisions with CRC library APIs).
> 
> Note, also rename the driver name since we don't expect any user
> that enumerates by it, only ACPI known so far.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 42 ++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
