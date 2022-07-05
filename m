Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7456648E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiGEHzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGEHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:55:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337213D73
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:55:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so850477edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Dd+03ltwb0A3OCeiLRuPRch6yR6Hqx8MxtfMOc1/kN4=;
        b=AC4el096uzd63l5aciUqinEEpLgrlQWcC38O1EV98cJQ+ByiExghvMKJ5nL3kIlWkL
         YKM1Ob0cdII8rY/1W0Hm2TclvjJTpEyoX/IlUYIJs1a9hWdUn4928i22OObOwAOs6gdT
         4a/mYN0TvFarKgGV0Dc1njO3U2NRo+Gvd7MMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Dd+03ltwb0A3OCeiLRuPRch6yR6Hqx8MxtfMOc1/kN4=;
        b=Vlms5oPwdw6pIjBdUirIjNBC82pnbgpAOTgXw+0kRLJFnP3mgjpPAIVnAxG0ceqoMN
         4qkuLu5+PS2+XyPlWKAUZfkByTtK6qr03hREhewIJnnsMmjDZgyKaKWFPW7vf10fot6e
         xBkpXI9T4ksHIgjdFUsBLyqsSOI5wHimq7tN7PGe8w81xDyYhBkWle7mxQz8+w6T832+
         3svvJlq7xqSGmht6ngJLHTEdaFWts8RLcpQDsfJSx7vrnLSsdpLR2AD8kAQJk1HhRlEP
         DFuvG4fW5rNa8qtNmv+cMtsPLDJ5YFW9qXrSorpJ8oTwWcsgKgDtrCpl185J8ywjP+7R
         hPqA==
X-Gm-Message-State: AJIora+e9EQOmIq3XyEnOAy1t6ke/RNDKGyR0y+P1AB0C+S/QEnJmm12
        QStAD6ZFmIN+07I0d/bHSD+8RkO0dzoQ6g==
X-Google-Smtp-Source: AGRyM1vZKXamGSOdwS9rEBAHE6ehIF1mBvlnL7rtFuNKTsGNH8m5LvWDVWe9ZGbwOaYm136qfE84Og==
X-Received: by 2002:a05:6402:4507:b0:43a:5b42:2be5 with SMTP id ez7-20020a056402450700b0043a5b422be5mr11728385edb.392.1657007703459;
        Tue, 05 Jul 2022 00:55:03 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id w2-20020a50fa82000000b0043a64eee322sm3421430edr.28.2022.07.05.00.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:55:02 -0700 (PDT)
Date:   Tue, 5 Jul 2022 09:55:00 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: equalizer cfg in max98088 driver
Message-ID: <20220705075500.GA1987744@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, All,
Just a question. Can you explain me the proper way to configure eq1 and
eq2 of max98089 using sound/soc/codecs/max98088.c driver?
Could be a valid solution fetching eq1, eq2 bands params from dts?

Let me know.
Thanks in advance
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
