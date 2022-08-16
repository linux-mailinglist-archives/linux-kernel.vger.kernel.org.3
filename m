Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC0595802
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiHPKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiHPKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:20:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3974116ECD;
        Tue, 16 Aug 2022 01:24:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s11so7593785qtx.6;
        Tue, 16 Aug 2022 01:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=URNWhoG6Jht3PNpZTFjRMq9C2xuK/GPJGs5c4/qP8Qo=;
        b=WMTSsJZCsuR2GWexgektS/N4A4uFwS5j+U4U9bXLj9a3L47qI380JV+vKz4DRgUo7m
         JQ0ZPw6GRXuu40crI4HPnyfuU8Mwuj1qNeEIP4TcZGai2JWBghl1MLZHSVb55P06F6bx
         B1nlcqlENsza+hf4Ohd1X2ICgnXG9gNZC7PGiYkFdA7ZFjkUfcc87MSd36YKblkLzxGa
         2BnwA9oruaCFleVvpGTBbHY4dKpfAmqqekOjjv8m9YDssWVu8bRB/z5KMz8EGrrjZ7Sy
         Eu4fOB4U87dlJ/FQykdL1H5XL0UdE1RlRY7jmsZJ10A3yVUtG2esLd0xOaEnLq9ua0pr
         3xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=URNWhoG6Jht3PNpZTFjRMq9C2xuK/GPJGs5c4/qP8Qo=;
        b=e4x9YMl4hoo1y89HM5Ci5Jp5LKPTYqOmkNWgQFQGsjBx+NmR/0QUz+lTTckOgi277Y
         sAPdfcHZjQVHg9hewQQXtcxUg8RTEZ0j0pQeKcviFFrL/+4ut/xbVyRtEUekQNnY2qEI
         VzS4MtsQsQGYk0G0/k7AvC2pWn/Z/BDD8tERXZkBi74SqtUBkVnPc7OXkocfF1JTGqZo
         ogb/nuvWjIZ5Jk8m2li+OOEKJtoKZSdhxg4OpDOjm35js34vAhrN/VQ0qsx1jRJaErS6
         ezntuXFXJbWCkWpKmsnSXfai1RWb1MqbM3wOpdvOwxAKC90BGy1fhg0KFjiqZN132yPx
         N4tw==
X-Gm-Message-State: ACgBeo3Zxe0nTE8F6Trk56qb222CQX/jl1QENzmY1g7Hj5bNS+aTtykf
        p2fkJqHSkNCgnflRw6RnvDqcOgJL2AFJiZ3AUyk=
X-Google-Smtp-Source: AA6agR5pnQGi7oingWiXnnixDq3edlax9wsTNuhcRBi9pIKjuflZ8obEieyrcjYpsw/u/5tbgjY0kZ/rOVvlBmyXAN8=
X-Received: by 2002:a05:622a:14cf:b0:343:5b6:68ca with SMTP id
 u15-20020a05622a14cf00b0034305b668camr16705479qtx.195.1660638245828; Tue, 16
 Aug 2022 01:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org> <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
 <Yvp1Qkuh7xfeb/B2@sirena.org.uk> <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
In-Reply-To: <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Aug 2022 11:23:29 +0300
Message-ID: <CAHp75VcAS2Km_aWOV-XhMe9JkLER-1DYbJbkM9pa-i9yhHqsFQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-hwmon@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 11:20 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Aug 15, 2022 at 05:33:06PM +0100, Mark Brown wrote:

...

> However, should a devm_clk_get_enable() or similar function be
> implemented, we'll run into trouble.

And in 5.19 we have devm_clk_get_enable(), are we already in trouble?

-- 
With Best Regards,
Andy Shevchenko
