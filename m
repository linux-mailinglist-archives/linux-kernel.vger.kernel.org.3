Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36755C774
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiF0J2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiF0J2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:28:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3346267
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:28:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r20so12163540wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wdn/wXJynYJg0BH5v/3hmpbzb2vbfk9ThFwzeSLBf4k=;
        b=iDj/rR3D2GwXp7u4Pz+ilZDGMW7OwRwK8Rs5ylOvueeOaPoVI4FjlTTtRMWvRaIXwz
         9BS5KYhJ6EZX3Lxi8298/yaoZjcI+g0fqsG4rzGqkQwap4rkSsDLOd5c1jfadYSaHIeF
         v0TrjDvTFYKx4en39gb+4MDu+QbULNKdzZxi5tosQH8lojp0PEmQGjClDKye6KUuCOJM
         vG0+APhfvmysZN3nlhROUl9qVLkX6/mbnUsT0ER6vdYM2nVbL4n8G6VV5aHakt/0i+bF
         r7NwXW340r4pip3L0K/ilg5wtn4uOw9z+Zr3o+qYYql9kh8cGBWkW9moM6yyI99Zr5CI
         9MOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wdn/wXJynYJg0BH5v/3hmpbzb2vbfk9ThFwzeSLBf4k=;
        b=e5MQoBILxpHA9e2PiHhfKDxkGQN5dQXOPEWCQpkB/KKBQOhj74WY3xgQJQgG8TL/8r
         0PseP4x9BORLE8yLMJi5pIXBaIdtmsIPb4SqfKDmvqQFZlaNhChRUVOY3SUcC2gxEOGx
         YXkRkFcgn7n4qFuZsgki/NGXO2n1XIV+X2Gma/DK4WQVZHGuJR7LcHOzpOdPWihsFim/
         7lOJA/t3kE1Ac5/nacmwduSUWgxF6+gLrGJNcBJ8Hl4VRTUAOUGt3/styw+lY0oSqiWj
         7vUmeenwYI3AaOHJB6O3qTnesx+o/tthF9GbymOWYpewYKM76iy05UISrk7Gt3iVR8sr
         AmSQ==
X-Gm-Message-State: AJIora8Wx+Vh/AYqx9BJyaf3yXc51jxRN1CC9Thb+IlIQ7rkCh2U/5hT
        a+0kzc8YsV8DBOET+pZWJlQTAJSAcWDQqw==
X-Google-Smtp-Source: AGRyM1tPtMCxYARUKw+gLnhzbPfxu4xmoU6vTava8RI9SZMKoC0zwIYX7wy+yalKQPbG/e1hPE0fyg==
X-Received: by 2002:adf:f704:0:b0:21b:85ad:2a49 with SMTP id r4-20020adff704000000b0021b85ad2a49mr11366512wrp.455.1656322081361;
        Mon, 27 Jun 2022 02:28:01 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id az33-20020a05600c602100b003a03b4cb7cfsm12055245wmb.38.2022.06.27.02.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:28:01 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:27:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 06/11] mfd: intel_soc_pmic_bxtwc: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Message-ID: <Yrl4H49k/JcPEuLQ@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-6-andriy.shevchenko@linux.intel.com>
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
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
