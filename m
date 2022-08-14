Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE76591F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiHNKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHNKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:11:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4332018E;
        Sun, 14 Aug 2022 03:11:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kb8so9062576ejc.4;
        Sun, 14 Aug 2022 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bHUqv/0GJPBCxHv+0WA5YwKaB/OSuW/QMKq7Vb1Yd3Y=;
        b=H9Q7SUQm+w/IZFinc+9IuGZRvyrc241jl2NXMTsWWzK4Yj/bMca3jtmqXimH+PoLbj
         2tVsPtc0OBB1cWpTsK/ypRcAlVZ/oc5Fm3ZVDm0k5kgXDzpSN4W+WaHryNCwo66pJDLz
         xUwI5u56/PgqhkW+91DeXvq9Zxbq1ayvGKJtLUXMSisVyhtIDqI6axlu4upiXKieu5Hq
         JIcX3ZxxJuBcGLV7J8a5YSjhoLUQta4nKDZyf/30VbQq53CXMGRd3EMi1AAvOpnPeCBQ
         6Kg49DtGHFitHX0fGzHErFmG16oJUsyiji2F2PO4jzO/Ab9e+C+UvcMpCMHfrz3fMvAQ
         QA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bHUqv/0GJPBCxHv+0WA5YwKaB/OSuW/QMKq7Vb1Yd3Y=;
        b=XmYAAX1YsGjpl8GVYfe95UPc7LZOJnDopwIAlS5dJsdo3+6agU2K6AmJbsrDXR3QQX
         XMtkMfMyQd0qlWBUmwFg0VdiWy//C/6vDRayarduAlJIe6kOHn1PPn7h1XOij9AYV5OA
         AQOBb4Ra7oeXHjIPjg+4uUykSGKV6vv7w7xH6MCpKaUDiNRNZMPzIssAYA+RLXI75UqZ
         R0OAmeRx7sui9M96DhbaLenDxAIKyaQ/X+YAsG+9kPEgW1Q6nQj954tOW89QTdtNqDO5
         tmhqVqH0CLgNrPZI4WlHWtr2aUj/amOF2BF92qTWr/OqoWB8wag9wdtls6yc2X+XWavF
         TqQQ==
X-Gm-Message-State: ACgBeo2q9IOzqHFiIFxxEKvR97cQ5tbIc2ckuZupcoYq61RV5CSug2Hh
        1aK0T2HduAbHDDqWP+8Sh78=
X-Google-Smtp-Source: AA6agR59O0rxTrcXuFbtEwWNQAihsOjIR0aJFZi3EF6pxH9m8ayr/toLSzZmLt9jpvao2bukmLllwA==
X-Received: by 2002:a17:907:969f:b0:730:b649:ff90 with SMTP id hd31-20020a170907969f00b00730b649ff90mr7496486ejc.337.1660471889310;
        Sun, 14 Aug 2022 03:11:29 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7d641000000b004417eeff836sm4538337edr.53.2022.08.14.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:11:28 -0700 (PDT)
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v5 28/33] iio/drivers/sun4i_gpadc: Switch to new of thermal API
Date:   Sun, 14 Aug 2022 12:11:26 +0200
Message-ID: <8976333.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20220804224349.1926752-29-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org> <20220804224349.1926752-29-daniel.lezcano@linexp.org>
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

Dne petek, 05. avgust 2022 ob 00:43:44 CEST je Daniel Lezcano napisal(a):
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


