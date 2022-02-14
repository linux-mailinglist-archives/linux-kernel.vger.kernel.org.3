Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E064B5449
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355678AbiBNPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:12:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355669AbiBNPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:12:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC18C71
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:12:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso7422008wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ri75SenAJq39WjG18uKN/hPJVEWkQcUwIKXpcT+q7Fc=;
        b=OEZHe1qlP3GAq+JVJLpyE4GoOeC0Y+H8A4mxPqQa+WMd0F8KzzaquSALHtkRIwoMmX
         15ZAXsh0Xv2EisfG/vSzRuYwahD4JaqU3/iHwlnLucs2b2iNpUr6FuQ+uwUXdXIWoD7s
         ns7FBkc0m3ITWqHS7pe3Ml1kwhHPXOC310/D7aWHMfIO3QcsVOV9F6/8GIp5nN0bM9YZ
         OcqbS5PVa8PUYfqVM+gFHCAvem3dCxUElgbkf940da/KFzEZ1WPqTfP2kZ/pn10IoZoM
         kgWHrVOEd9Q5UEvCM2mILZO4lV6F7ttOsWN7s+dj/uKGTbebX7Fa2jGGsUi+3DOPDAb+
         bVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ri75SenAJq39WjG18uKN/hPJVEWkQcUwIKXpcT+q7Fc=;
        b=cknGXQ/DDvCqxf1PBGx1U+am6sea3OeMgKQJCH0ckWjZL6ZUZDhRAwb/b/U7Z2VF4z
         eSo3j/D8Df2gvh4qGHrrChpKsMJRMqTmoNOdUkqWuM0rWRvXGoxQXzVl0GBTToLOetGc
         pYeiV53CEQpVNvZNxiX6X2UxSCiKei49IqbCUC9m0wrqNTqOcssi7PuRD2FhDAAwAey6
         /748YS/Bcg3jfzWntpcwMm6PdR+LzSqGbWysWrIcsm+uj3IXb+DxO+GYe68VlM2bbWUV
         p5nk3YbT7FxOrj1M1mZgls/X2JylSB7YYY0c27yUbZeyy1Chv4yfoxaOtcDRoiQSm2WQ
         cpmQ==
X-Gm-Message-State: AOAM53269ByKdLkM+cdBgSkjou4i0YUvvwrYdqk5ks6CMB/4i7hQG65F
        2aNPdLW9kX9ESKB7gePF1kj/9w==
X-Google-Smtp-Source: ABdhPJym8F+sdd5169UuY6UoCZSGZxjw1fgYsIOHh2MjisghANK0U+Holxca8I7ozPRvIo9QIY16TQ==
X-Received: by 2002:a05:600c:1547:: with SMTP id f7mr5192575wmg.96.1644851555975;
        Mon, 14 Feb 2022 07:12:35 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f9sm10041370wry.27.2022.02.14.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:12:35 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:12:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: stmfx: Improve error message triggered by
 regulator fault in .remove()
Message-ID: <YgpxYfYH8BzBdq/y@google.com>
References: <20220214150710.312269-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214150710.312269-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Uwe Kleine-König wrote:

> Returning a non-zero value in an i2c remove callback results in the i2c
> core emitting a very generic error message ("remove failed (-ESOMETHING),
> will be ignored") and as the message indicates not further error handling
> is done.
> 
> Instead emit a more specific error message and then return zero in
> .remove().
> 
> The long-term goal is to make the i2c remove prototype return void, making
> all implementations return 0 is preparatory work for this change.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1:
> 
>  - put declaration of ret and assignment in two lines.
>    (requested by Lee Jones)
> 
>  drivers/mfd/stmfx.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
