Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE685432A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbiFHOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbiFHOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:34:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E93D670D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:34:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p10so28625548wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smuYMl0mhH56tDeHdXWNQOJZvruGPXatNdGHlD7YYTs=;
        b=lh/wsibIUywoWWz5yLN1RVAdkgCCFrBp+/s6WpZdSKwBaZHa3wcoks5skuKZz30cfP
         nSZWTrzWnqLrVP1W2Wk7qG5pXrVup+/0Wwy1s6utotmkgIgACXZfPb+9Y79qoUfX+oJ9
         ExKOMgNgf/jN6HJ6ywgE+i/QHy5irCgS3+L230B7vEM9DAXccGChvXIK5jIi7Z+x71Cc
         b0iNAVnZ9lvEzXnIlIjF1NlS2vyBb2eyTgxDgDrBW9qowNQ0Zwq9SSLVLFmfM2NmFXQo
         UOvufvy+J2IzDSJrbR/BjQxjf1cfYIk5QRwc+J6D2AYq1DnctbL2XqJq/7cEZA+q/GF6
         73QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smuYMl0mhH56tDeHdXWNQOJZvruGPXatNdGHlD7YYTs=;
        b=3uaXcEH9s2i2Wl0Vigw+CyppEOF6c2iXA/uJ/3ucpohO3SqocZE6HS+pF2nVphU+JI
         JEE6r4zPXq5FCf8XB2RoI8KfA/keud26vdQuEVDxeaCQus0OR9syp5vlVVsBDGdN/GOV
         U1E0SScIM6toYMubKdA0jX75aSPTNrs80RGeN89qDhijBPP0qSjD8xMmMja/Lpv6DxEI
         35V3RjiWhAhM62XUg9ndmEmnkP9zU/5YdZkRSmcYwIHT6t5qYhXLpDhIVOTATYu9t5Ih
         xddptFjzqmJb6p+RPA7sWBV4bj5q2PJ50Jv5SFsz2Srw8EChhHmQeLKUBG/8trdoJfXc
         TY6Q==
X-Gm-Message-State: AOAM533TOklDZaLkB1+okb/5eLcG7fmpKA2GfDx2aZQWOC6uSLdObIv+
        t5OyFqp/v1k6wXOhr79pv+K9Ew==
X-Google-Smtp-Source: ABdhPJzA4yH9/T+sa0NpsuRjmT5XXk943o+/qsHi0qHrpaB16l7/vjdk7u5BWNDdUZEneCaB74mdag==
X-Received: by 2002:adf:f390:0:b0:218:4de4:510c with SMTP id m16-20020adff390000000b002184de4510cmr10350628wro.475.1654698855460;
        Wed, 08 Jun 2022 07:34:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bp3-20020a5d5a83000000b0020cff559b1dsm21061219wrb.47.2022.06.08.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:34:14 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:34:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] backlight: ipaq_micro: Use backlight helper
Message-ID: <20220608143412.rbhk4ne7jwubzz6g@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-4-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:24PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
