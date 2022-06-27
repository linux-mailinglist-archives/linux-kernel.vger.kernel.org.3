Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FE55DB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiF0NG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiF0NGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:06:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A8B7E2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:05:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n185so5363671wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vld0Dj8OJXpJAa2OC4isE1RAEnqMNrm09Lv3PYNRhdQ=;
        b=mMvnUpzSa7sNcUPxu6mKGWyI04Ew1jQUpTZ5mNn8668H2e69u2Kc17hotk89W6oI05
         u4y8uVUeFut8BkD+NDD/ApC5Nmqo5w9ldB3N/3BWnMe9CkiHdxGv+dIAnHhLyaXdd+JP
         PU//7cO/5ld8xy/JPSI6th9y/yR2yZd8M5dOu2R3HqwwxQYFcZP3cny+PUSq99O5mQVx
         0NT9RT41FQzA0tFbTfPP7XVU0YUWiBpl7DPSLNmWgbRCTB6t0tWbAxQZGKA4y40qg+Q+
         VDAPUI+yHjdazPMZhYz45mEJpbJ0cPIH3FJoovzXVQvX35ZLS4FI7IWuk3t0QNF3JOhP
         2wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vld0Dj8OJXpJAa2OC4isE1RAEnqMNrm09Lv3PYNRhdQ=;
        b=Q/BtyTBGgrHlEiaIE2uPWTwv4/jOApBebis7uil3EZ9sK0fTidxcHN5JbYK96ep3sd
         U66CQlZaaymjw4pgE44DMYKEAn7dYKhe2bJRuikk2d1XtO8Ve6+O143kKxfK5qDLLN1G
         ZlVCeoI8xktXvFGYA6WfDwirVqnogNh4L1eOaDuMVWjWNmS04E4JbrD8A8Nwot2sbyIc
         6jarKGzSsNpF3wvyPfbZb4P7LAottON9ZhwCLWupvb9CKgRp/B8h9IdQtBFdFYVNDP+S
         HUd6lc0CIuCje9prn+W7pIh1WeMKyaFQ5dxrt23m1Gwm8OUAWyJXvSJ9I7CuKs4xMDx4
         Y/vQ==
X-Gm-Message-State: AJIora/4ByHhPRapeg0UBSGn9VS66sksxTqVuc87M8J3d6jD5Mi4kdg3
        EB7YmwuKBMDLlNHhRD0ss11u3g==
X-Google-Smtp-Source: AGRyM1vQw9qGrFXsatehd68Cn0xUv/eFbBm512aRillDYy5UciLCYRvXsOt5Se9JSDcacWAtFtvdkQ==
X-Received: by 2002:a7b:c8c4:0:b0:3a0:374c:a3b4 with SMTP id f4-20020a7bc8c4000000b003a0374ca3b4mr20349614wml.112.1656335131689;
        Mon, 27 Jun 2022 06:05:31 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0021bae66362esm6685194wrb.58.2022.06.27.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:05:31 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:05:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 2/2] mfd: intel_soc_pmic_chtwc: Switch from
 __maybe_unused to pm_sleep_ptr() etc
Message-ID: <YrmrGXMLG2DEi5y2@google.com>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
 <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
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

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less heavier for builds
> than the use of __maybe_unused attributes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
