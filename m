Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118458CBEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiHHQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbiHHQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:13:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED392700
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:13:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q30so11407182wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ZryEEyjSCWEbCU3Q+FUhQy+AbSQLPWxQZGpckBFvSEo=;
        b=vN4bcGGLlSPlkunAjwIrl3thBrrII9OESQ8QQFxQbeUjGxBgRoVHsMDExSNMHrYE+6
         tx2PFWI6VT/4iRJCUZ/ZJ9AWS1hKhsw6ptYcspqDL6sub27j+oelJWrBWyRdYkpJzF/m
         sZ5XcE82bLP4HMrafKOHrxElMWCNXbJtMVx2gStCkvgJZCsy/qI+BrJz1VKOm7HFRABp
         enspCtOVS3Ktamd60YxFk36GBB2Q/iUVyeIp9iObmD8NhORRf21zUSpn/LUjYjytCps/
         VUcXC6M+FHclLtEfkaRUiJgBfFrMFiF4nQE+ZyWwY1kGqIhRypFRK9F1D9hS4FZY5W3L
         MqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZryEEyjSCWEbCU3Q+FUhQy+AbSQLPWxQZGpckBFvSEo=;
        b=TvyZYGWdyCY/TwkI2/dun4PnyXzwkv4xBQJYOLxlum10YKbNx0yfGwCK7XO3Q2eaZj
         tGT4YDvz0/HOP9AUcSC1e1rJ2Mmb4YPJDrKvNrwEFcn4PLkFnT+s11i+02WHUByScJJW
         rjN+JShoxL9zyW6xFM+vsBxfDUYbKlxomJJ8XsG130ExmuqZ6BEDDi9xXCsXfX7Z8QOt
         DvhXCNxOfMrcxvClMp5YC6geMdkg/RlAn/Klv/VAowZPtbT0Up583Z8YTBi68TNyLVxC
         QHXjpTM2jjLCAYSibhNbAYKNkgpimfM/dXIf/vbv3cXJP2a7bldqzI9X9lrObaIfiprF
         OcnA==
X-Gm-Message-State: ACgBeo1JKG9CZ0usWNmsXRMlxZCdtLHSlFaqj0uHnjNe2c84jc352/KF
        pVsR+Y3aRjZtd+9gwk/LMoX3Ag==
X-Google-Smtp-Source: AA6agR7Mfrb7gIJ0VaClks5ixg4h11z9QgX3ywX1T7uIyneGCWDMEnuGohBa7375GOZC0EUHLvP2Wg==
X-Received: by 2002:a05:6000:42:b0:21f:dc5:5ce0 with SMTP id k2-20020a056000004200b0021f0dc55ce0mr12440737wrx.12.1659975185361;
        Mon, 08 Aug 2022 09:13:05 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q10-20020adff94a000000b0021d80f53324sm11604168wrr.7.2022.08.08.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:13:04 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:13:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 06/10] mfd: intel_soc_pmic_crc: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Message-ID: <YvE2DyKOHtthMAVN@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-6-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022, Andy Shevchenko wrote:

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/intel_soc_pmic_crc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
