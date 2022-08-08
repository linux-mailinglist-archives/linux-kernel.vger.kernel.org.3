Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7DA58CBE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiHHQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiHHQKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:10:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E0D81
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:10:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h186-20020a1c21c3000000b003a5360f218fso753163wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=p1YH5n40SEE/etNSWqSsoqBjsQgCRMOB5bj39jCUx08=;
        b=ktbNScHrzb23fN63eS/CPz/yswpYD18tFUJ1HLFw+7FW4j76rWkGOKPjH71f6lJks8
         RmB8fC8tUXmwDctAbz/ju7t3e4rUvj0/4Fi1b1gZzJgQ7FAbwQ3hqPVeVEuvVlBKdVpK
         R2z2eAnnejRIE2arOEVk2VxEm7E0H2bON+kYTueKrxrus+utx0wrwMNIT0l1bPVfX4Gx
         gNlgdtS3RaHphva/afGLMgGur0I2O6xhHKIRIG8Az1xWICRz+fMRlV0J7yAaQ5zUOUfo
         A9CMLPgKvA3D+qOhtPf0wW1eirXP/CQgIpBKUgGO/3ED18e0WdMldHlbIHYU9VjaJt9i
         9NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=p1YH5n40SEE/etNSWqSsoqBjsQgCRMOB5bj39jCUx08=;
        b=pgS4qRtBueBtRgFFkgMUQx/QXfpGMLTK08iQ/ny36SKgHELKzKuK5pLM/UsR+ZogTp
         bjyx/eAhAXZvfOHk9r3X5ZeAlX0oHf7NKkSFzYhs8Qnp+MVcZ5WXWyyv705USnACcZ1l
         7zjY8DXoHJa6Hf00KhkaJbrGTTHgjFbCLi94n8jxAIBGfY2ZFHItsneRPaG0Iaq7/zDr
         yTDrY+zV//n5ijUhWzJevL192r3f+f3aEF6YT/sMFb15CBJtTFqEY1ACq8cudELAePha
         /9TqwL8wXY7oNGk6rrLltXK9VpxCtA4tV1DAyiWue3s3jJgSDbIcKfIMaynLgTUMHrNg
         Mn7A==
X-Gm-Message-State: ACgBeo0IGlIKuN2sYQ9ScUg5CJcd1mzD9YTk7WWxMaOTRKoVQdMmFXnL
        yqt8R/H7ksRlQbRcFT9rTxwF/Q==
X-Google-Smtp-Source: AA6agR6HP25WhYd9eFWj1UVQWM/PYlEUeiB2/Jn/1BDnlK8FA4uPuNTq5CeLTasT7fpcTkUap0be3A==
X-Received: by 2002:a05:600c:58e:b0:3a5:2c3:5e17 with SMTP id o14-20020a05600c058e00b003a502c35e17mr16033206wmd.200.1659975049494;
        Mon, 08 Aug 2022 09:10:49 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002217540b222sm9197883wrq.58.2022.08.08.09.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:10:48 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:10:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 03/10] mfd: intel_soc_pmic: Move non-Intel Makefile
 entries to their own group
Message-ID: <YvE1h+MXHwsYoBQ2@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-3-andriy.shevchenko@linux.intel.com>
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

> It looks like a random position for couple of Makefile entries that are
> disrupting Intel PMIC group. Move them to their own group.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
