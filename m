Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B16591F75
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiHNKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiHNKMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:12:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBC12018E;
        Sun, 14 Aug 2022 03:12:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so6351105edd.3;
        Sun, 14 Aug 2022 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1+mb69L+xqrAYBz+n/l0oT22rgwEo4zT/GChnKSihHg=;
        b=bhJnAPvl8dAmRl0/3Nc6acyExiSTqYLEqrbPRQJbd5QYDO21pR0LDR3ky1ftzHZU/j
         COElbRmt8asxFYHsS1lvDLqeT1DoCUGP1Ll0odlXXVnECaaWe2XH8edFWAnEIcgGFrvw
         vhb0H7Xf0hlfikfI1GpbP2ZahLXvXjJOMirQPpIT+KRZdJHk/HDrO3oBi5Z29hqG6unP
         rS0PTQ6bXhtJdpeakpaJ5+Bu7wBdfbyrTXKjped8VIFZQSkl/xATXHBmFmpdnZYHuFvF
         kwI3kXbcKYOcno4HAzsRyUguNoUMbXu7py6of5o1vIe51U8SKQTgpLlL8AzKqwalQuiL
         rLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1+mb69L+xqrAYBz+n/l0oT22rgwEo4zT/GChnKSihHg=;
        b=NlE/iGfmaKkySDItrrxLHG7pwL+wasFoYCf5+8812erk37+hePuybp4xowP1Fo3UQF
         4w1WtjYgu8RaWUkW35hcALVO5qXH6xzHFv9N0w+hH82ebfcWUkd5YwKVRbZZKYOwCy6R
         XeCJ9FGC1mwegPJNtYFYsV1P/9xJ4Tw81JBLxTsCz/BZ87vifUIEdrYtjeyUKRnv+Z86
         +7sTpYe36jQzhQql7uA4jUg1t1pxbZVwwW2+iosvyFKmNXF9m7Y2hFDy90wwcRxFTr1d
         OALJV/RErCBzzfQlLqjeElwf0ccRDkbo+4tdwHKLl9OZ0tqq1jviG9CQ+XcpBr5SOIme
         hzDQ==
X-Gm-Message-State: ACgBeo3ASSjLo5l07YT5val1MTEy0a+285qPY6DfjVw6rntK1x6xp3xl
        trPZpkC+pJ89FbEtdkgtZqw=
X-Google-Smtp-Source: AA6agR7X9N4O3WfDrYIk/VM94aaKm2o58k/Qya8E5B+4G+3yoIYZJ5fowQBFGeaSXfh59aq7b/6b1g==
X-Received: by 2002:a05:6402:540f:b0:440:d9a4:aebf with SMTP id ev15-20020a056402540f00b00440d9a4aebfmr10251453edb.196.1660471943579;
        Sun, 14 Aug 2022 03:12:23 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id b10-20020a0564021f0a00b0043df40e4cfdsm4488524edb.35.2022.08.14.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:12:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v5 29/33] Input: sun4i-ts - switch to new of thermal API
Date:   Sun, 14 Aug 2022 12:12:21 +0200
Message-ID: <5746387.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20220804224349.1926752-30-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org> <20220804224349.1926752-30-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 05. avgust 2022 ob 00:43:45 CEST je Daniel Lezcano napisal(a):
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


