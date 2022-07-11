Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574556D850
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiGKIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiGKIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:38:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626221837
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:38:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v14so6019095wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o8pB0WCFFerRUHBjDvUy3qhRaoM3S8BY8gjio25xw3I=;
        b=rmoZZEeYDmDhNmztEBdG5OBsjuefUSqGUluPr7G4LlMrGyneaBKfc3zaAripcWP4LM
         i6IQdHu0MI3gPsI0u6r6G8VblscY5gC2P/tX/xIHVvFebStGqA5YMrmrVewgleKNMqiR
         tBTfvnrzx1Hm24Iv4y3XugvBVkRot1DBcS2ePGhwKe7HZmbOdeXpIOlDNymiSBXzGo0s
         kcr+cNYSzOhzWgB4MGNevdjy3k8ZaRg11/5nO422Y9zyBXWFhNmRnjDrXpZZUaHNvHkC
         R1MfTiZJq11Uer0c6kR2mre3u343nUEkTkmLIXPY6iF63M3RYFlsRfV0crZs0O1SSuDM
         1alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o8pB0WCFFerRUHBjDvUy3qhRaoM3S8BY8gjio25xw3I=;
        b=HYx/AynDW8dBYwx4zc80kWMUyIqWHYuiwrmTkOg+EWKBITFWyLDHE07njbX+SzSNA6
         t5H+Pqbrijh8UUiJnpnAwvhR9AmKfyZmvoPwQ7QprJFtGZKh/+l1QgAdaoTScFpTq7Wd
         IQDbhvuGObUiVGY76zp4CdyYEwB1RLAJYb/d8kZ09hQ1TzUVavjgH4kd5wj53ngZTi+7
         SiQ5QzPfWpUXGcBbAvy/9mVu357sT+nfwq5wqd2ZtEAthM58D+ztkHnY1Vo9YioZtMBC
         P7lZ+UrsxSxnP+999VBasb4peUGqDcL6WAC8DJHgVDos6X+9/xHvq+2zLOLpYvSPK6YC
         0v3g==
X-Gm-Message-State: AJIora/Knqrz6fWttzEp/0MS2LT2jewS4WnOfrvk9uUzgEu773tJ9E9A
        tgOY+/3/0YSCfwhChSs2EqfHR2YSU3T2Fw==
X-Google-Smtp-Source: AGRyM1uRQwe3P0Crn3A+6fjmmX8oqa98UuwFRdclzV4Tuf1SBY0SIHU4yfCTKS3LMr2VG0aEt2jzwQ==
X-Received: by 2002:a05:6000:617:b0:21d:9873:bbf4 with SMTP id bn23-20020a056000061700b0021d9873bbf4mr10189561wrb.389.1657528679669;
        Mon, 11 Jul 2022 01:37:59 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003973ea7e725sm12793308wmq.0.2022.07.11.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:37:59 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:37:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 09/11] mfd: intel_soc_pmic_bxtwc: Use sysfs_emit()
 instead of sprintf()
Message-ID: <YsvhZbqgekY9lHTe@google.com>
References: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
 <20220628221747.33956-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628221747.33956-9-andriy.shevchenko@linux.intel.com>
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

> sysfs_emit() is preferred over sprintf() when formatting the value to be
> returned to user space in show() functions, because it knows about sysfs
> buffer specifics and has sanity checks.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: added tag (Lee)
> 
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
