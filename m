Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00C509A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386437AbiDUIKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbiDUIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:10:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7AF1DA7D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:07:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so5465112wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m9wV+vIEZDL8KhprPYlhYVDn81Dgoq0DcYhAGk+490w=;
        b=du9gEsiIZYwYSSHgVxteh57cU7mTdEFHlkGr4b/devaFuNqJoLUFrAIV5PI+p0E7fw
         YLIsoSZ/jA79uXIHoD90HEkNd4wRqdbKvWHVM2sTyS6hbKW8Sad4piUCdXEn2vp56n6R
         eGb6hicXJeuUa53OFmXryJu5xVwHcxuD8Oj/RSstVnmE28BD3NMaXJnHBkkc3U4a4sgd
         WZKPviGs74pFKHwUkB8YtvknwXwiEKZU2FNztg18c+5PhkDwZ4M0yOdSI6iexi+Zg5lT
         OYbC4qA5rogT1Hz1sMNvovkIjT2ypBw0xQ+QvrKS9b37yWEsKROeUlfskIECps37+VFf
         KaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m9wV+vIEZDL8KhprPYlhYVDn81Dgoq0DcYhAGk+490w=;
        b=6eBoDSLe8HL09fXvM5yX36icZzAB+u7OHQH+yn1jJwsF/nqVdhtmKLY4xTzqXX6JGy
         WSvR6j5AtRZ2XKxht4s0ZPD1oC6wX9R3aWrcIufCflbKJCUvXhFaMcj/iUKEjxXWMvV/
         d7cm671nxr03GpBw+ffMu7uyOKbB3JiPTHWwyrklndHAVNaIDZ147d+0hqkkgbh/qy+f
         9MD5HsNBgi4RuIr/90Xdf0DxY0x7eIYRJVac2MlOOICYMrj/ZXmAPUmpaEWcI7Fo4xV0
         5kxbnGJHKGe/SQKSowAeO8PS+RrDAO/XK9S6DlFXDGpBl1gDbXLIxV5bAM1EDsvzpryc
         snDA==
X-Gm-Message-State: AOAM533I9oAHc4ZHhq7UR8BnARmlB22BzsUy8T+U0EFfKNauxCGmusrf
        ZVMxdhNCYhLSsxLvKtieuA8Cwg==
X-Google-Smtp-Source: ABdhPJxyBztgLVIeedlBtMENS04Io2p1DpkMBDuu8qD87zZoXq4uHdG79UYVvBKbGBM6/Dyz/WHiNw==
X-Received: by 2002:a05:6000:100c:b0:207:a2aa:8d15 with SMTP id a12-20020a056000100c00b00207a2aa8d15mr18159747wrx.394.1650528474628;
        Thu, 21 Apr 2022 01:07:54 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b0038ffac6f752sm1404892wma.45.2022.04.21.01.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 01:07:53 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:07:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair23@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v20 1/4] mfd: silergy,sy7636a: Add config option
Message-ID: <YmEQ1/Gs15gUxYdh@google.com>
References: <20220330094126.30252-1-alistair@alistair23.me>
 <20220330094126.30252-2-alistair@alistair23.me>
 <45acc349-8fea-f755-065c-c561949c45af@roeck-us.net>
 <CAKmqyKOqjperoku_uOy4sCa6LmCUtfB7SCvhLEKxLtcwDkzRyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOqjperoku_uOy4sCa6LmCUtfB7SCvhLEKxLtcwDkzRyA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022, Alistair Francis wrote:

> On Thu, Mar 31, 2022 at 6:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/30/22 02:41, Alistair Francis wrote:
> > > Add a specific MFD_SY7636A config option.
> > >
> > > As part of this change we can use MFD_SY7636A as a dependency for all
> > > SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
> > > it no longer needs to be selectable.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Any chance of getting this in for 5.18? It would be nice to have the
> configs all sorted before the release

Can't do anything without Mark's Ack.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
