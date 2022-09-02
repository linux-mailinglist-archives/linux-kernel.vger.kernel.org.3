Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAE5AB599
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiIBPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbiIBPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:47:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45DAE68F0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:36:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k22so2655746ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=hYq4cv4cNUo/9VVzRmU4eVk/nrbDfe3lb0f5HSAbg0c=;
        b=fXAJ+/P3fhtMN1q8A3rt66vZdRafbtT3fcpkG6YbzOLJGXgMenZOZnNNgfXKlGyB5r
         /neSeMRbtxKr4RaUWpB2ly4PnRRPe3twwNXT5Zp04HSiIrWrtbPfxQPl4d/DCSv7Jw6P
         v6OpRAIcUKGWzfQf/L+mK3HkoWkVWdXaqxmdGC+Oz21BBA6qkJR+PgSYOi4lpfJwFBEk
         c4m+9c6wiXw6W0fyG49lUa9QfrMJ+Lu2JQOHxBNqW5Upsci/xG1gPacMteCbU+aw8w2R
         Wa40oIUi6Z2lVi0NDIyqyuz6OUkgO1Yegq0OH/PklUbwM23JcCeCErq8rCn2j2KUs7+z
         AwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=hYq4cv4cNUo/9VVzRmU4eVk/nrbDfe3lb0f5HSAbg0c=;
        b=eesbZW0WPsmHQKwDXabEbz8eyiIxy0dZCpb8jjuYUdo4PQ9N3DoGXHt9O5D2mPb1du
         zdHvVUJbjPvT8zp31wbl9HwdNLisEPK300qePjf1lY1yF6sHMimay5yuyoN3fwwt0PLW
         JM1UFX6b8XKoOgXPcZOefcdOIXpVrsY+N5SqpsHWIhHs6a8yvT9oubo1oZVTu54N372S
         h1NSO6BZuQwqiR+UdmOaleAYqm/MW5af5YbIyYKRbWyH35AsXJeyaUQEq28TI0lIEuYu
         rm8F9liFE+FUyhD7QckQWmwCwbjrssDTSL560TtvL6v441knBJBD4tRK4wRtpceEm+HU
         kOOw==
X-Gm-Message-State: ACgBeo1UzuNWF7YQijVGRUwU7o6Vpb7bcaNJnAlo1BF8ZS+YabiXsjSt
        lzW1ezJjL4umbyIHOrDIyk9uba+7RHpv/kR9qBxw9g==
X-Google-Smtp-Source: AA6agR5BgJy2rk6wsD1gHEWSl466MvJsMQgEJ7ryOhxaVIAxSSxBf5O7ox+glstyi65Tkgtdj9RtOlUAM7wEftZQWJQ=
X-Received: by 2002:a05:651c:1953:b0:268:983a:c6de with SMTP id
 bs19-20020a05651c195300b00268983ac6demr3626799ljb.218.1662133017439; Fri, 02
 Sep 2022 08:36:57 -0700 (PDT)
MIME-Version: 1.0
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 2 Sep 2022 17:36:19 +0200
Message-ID: <CAGuA+oo5HvBo6aVvpXmk+ZEgvAM_zBHW2JZLD376+s7uHpdJuA@mail.gmail.com>
Subject: Thermal Framework, Thermal Driver, Thermal Aggregation
To:     rafael@kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

I'm currently waiting for reviews of the LVTS Driver v9 series that I
recently submitted
"https://patchwork.kernel.org/project/linux-mediatek/cover/20220817080757.352021-1-bchihi@baylibre.com/",
then I will send the v10 with additional mt8195 specific code.
The upcoming v10 of the LVTS series will support Daniel's new Thermal
Framework implementation
"https://patchwork.kernel.org/project/linux-pm/cover/20220804224349.1926752-1-daniel.lezcano@linexp.org/",
plus new changes that may be requested from reviews of the v9.

After that, I will submit another series about Thermal Aggregation.
Basically, I need to create an additional thermal_zone with all
sensors registered to it, this will allow us to return MAX, AVG, or
MIN temperature based on all sensor values within this new
thermal_zone (could we call it Virtual?).
A series for the same purpose are sent by Alexandre Bailon
"https://patchwork.kernel.org/project/linux-pm/cover/20220218084604.1669091-1-abailon@baylibre.com/",
the implementation is done in "thermal_of.c" (I'm continuing on
Alexander's work). According to comments, other platforms not based on
Device Tree should benefit from this feature. So, according to Daniel
Lezcano, it should be implemented in "thermal_core.c" instead.

So, I would like to discuss it with you, and ask for recommendations
and help on how to implement this feature, because it is not easy for
me alone to figure out how to do it.
Should we update the thermal zone to support aggregation? or add a way
to register a thermal zone that aggregates other thermal zones?
what about applying some configuration to a multiple sensor thermal
zone? does it override the trip already defined in mono sensor thermal
zones?
And many other questions that should be asked to implement this new feature...
In my honest opinion, we should clarify together how it must be done.

Thank you in advance.

Best regards,
Balsam CHIHI
