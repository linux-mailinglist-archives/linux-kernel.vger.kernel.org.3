Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B79C58CBE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243882AbiHHQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiHHQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:12:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269F1DA0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:12:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j1so11476330wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ya/SMAg77tvhGnHbDbWPVximQKTdWODPlRy9qV2sJug=;
        b=HjUZiEK5K80b9d27RiC/rufBCwpzqLcJeYfdZtMcXZvKFLJM5lM4a/gDyL1VvfD4EQ
         MSvtXE1MmkrjBIAZZcMQ5nSVgfPXmjFI8p6wCTkEKFBiXP93OOHHOIbV9BWBCYpnNptx
         JJLYMurmwbh3GBhivLSMf8e9vuKETD8Jxw2pOAPhdFCMT+M0pduHRVKAUOlKJIO7NK2T
         Uehrm7zfnorFW7G3Alq13THBhLYp4Ykms3lb+cJOKhZRnacpVI4n0wSsO+cQ+8PMyQOw
         Gm+V0u7lvMxQ5E/KrolhrfkwuPGOEzp6v7A4Z5znUXTYRSsFEvvO9UqW/RIMAgKE3tvm
         YoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ya/SMAg77tvhGnHbDbWPVximQKTdWODPlRy9qV2sJug=;
        b=3tUikj6N8sxTa115oixFMTchxXI9UTvKrE/4Iz+aGXmBpwRCwagVY2gUwNPwXIpvDb
         F5u1CGoUHNTvYBpIFqVkA8/szzd8xVoDRAAcCptuLf9B0Eq+xipshnJwrIQnXm7mknDb
         v7UQoQVqZBxQik3Zpdl7s9iJ3EiG7EKJFaNstIINajhemIgCALSVMvEZe8LJ2fV1RR1K
         SHrLCgCt1HohT9CyHirJ/SJ1KY7ha3ft3Wbhs53hzoSMiKmGjYBcVQLsdanCoTAf8CuR
         EkEwhyyyYZVLhmXvNRz00gGpMtTm8qJRnopli88mtmE1etKKb1YUb+wuHa/jM/LN+dAE
         mzZA==
X-Gm-Message-State: ACgBeo3vpNyM3j6BNhkOkeIFp/Odc5yQ1KmNc2MzI9QHtPV62SVEVIdM
        KGVCW740TaMOcRB7MyCe+Ov/VA==
X-Google-Smtp-Source: AA6agR6UIKAJu82I9hQGna9QCM3KgB8jHA0wTpovyn3M9si95DdRgVkmffZfqxBN6Nbdfl7L48MxcQ==
X-Received: by 2002:a05:6000:1447:b0:222:9616:2fc8 with SMTP id v7-20020a056000144700b0022296162fc8mr6122876wrx.445.1659975160718;
        Mon, 08 Aug 2022 09:12:40 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6441000000b0021eb309c97dsm11564572wrw.25.2022.08.08.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:12:40 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:12:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 05/10] mfd: intel_soc_pmic_crc: Convert to use
 i2c_get/set_clientdata()
Message-ID: <YvE19pScyKu965RQ@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-5-andriy.shevchenko@linux.intel.com>
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

> We have the specific helpers for I2C device to set and get its driver data.
> Convert driver to use them instead of open coded variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/intel_soc_pmic_crc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
