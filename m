Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8324850D547
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiDXV1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiDXV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:27:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52AF32B2;
        Sun, 24 Apr 2022 14:24:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y3so5784971ejo.12;
        Sun, 24 Apr 2022 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+T3blva0+11RoqIrydPcJ4eFJjGut1/Jrt7tVg7N+0=;
        b=ieIaUBdjjumm1tt9nZ7RwmVYSKUOyskQiT/Zo2MH/BHJXDWBFHWOw4Ex9uBep3qLOn
         /4NkzjFLiRfd8VX+0TBI08caL8KESKFhzrop6LRekviFDBbIDXovKmyKzNxqHsdhWlG8
         6LWozquA93d8zv9wcjJD8XrVMEBLz6qSZTnDOdtpqPCwSIUQdTZ8DZ/wJW2crfOcfR/5
         cyf2nDxpN2/JxFu1/nL5B/+mz3io18LWNeyuhF2WlGpRjMTnua9RejpdiI+V6RVSvDSj
         EgjS7XgDJmR5mXe64H38kq87ccwR6VMKGocKJIbEdc1ppUs3J9Na23jEHIcZcHXGvYUM
         TnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+T3blva0+11RoqIrydPcJ4eFJjGut1/Jrt7tVg7N+0=;
        b=zUmg1T7w9fwZSUh8OpQmBgTTadO0mCaHlVcfRyG+38+lC7MeZO2fVnk7V4KldVEa87
         ALeXfHB4L0r7InygDRhPKOy2PYrMAuYjr7BPWppW0xIqzf1Ymsg1PMn5Wkd+eY9KD82U
         PYlXhIxaaSHgDqz4h6yKc1HivpSaz2K34GptKUecv+XMv12w0wkLCya6RxgbF8m9jviK
         YqPfVckukuDQDvJplqIRj/gCB7rE78Op/RPnObGmkymsTSJVDkO8kf+uu3izkSejfXa8
         9VpG5TdU5jd0nMSmJfeEgZVI2ccuP9RYA99mE/JMiyECC2P9ciGmUz7rBsm9cW3gcSrC
         ZJGg==
X-Gm-Message-State: AOAM531vpqCTS0lFCeDIj2KjUIesSUFRowf4G/v/ovIGEHH5dvCe6+u1
        lcwyZqhOuN9IWIbtMHA8/B4=
X-Google-Smtp-Source: ABdhPJyzpIDmLRKrpcal2QQTXhVK62etz5I70moUWqToVxvT7R471LddteKcEYb4KZGQw+rF8f6bsA==
X-Received: by 2002:a17:907:7f8d:b0:6da:b3d6:a427 with SMTP id qk13-20020a1709077f8d00b006dab3d6a427mr13075143ejc.509.1650835458308;
        Sun, 24 Apr 2022 14:24:18 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id b8-20020a056402084800b004207931a9cbsm3865243edz.36.2022.04.24.14.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:24:17 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: sun6i-rtc: Mark rtc-32k as critical
Date:   Sun, 24 Apr 2022 23:24:16 +0200
Message-ID: <1891070.PYKUYFuaPT@kista>
In-Reply-To: <20220411050100.40964-1-samuel@sholland.org>
References: <20220411050100.40964-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 11. april 2022 ob 07:00:59 CEST je Samuel Holland napisal(a):
> Because some newer hardware variants have multiple possible parents for
> the RTC's timekeeping clock, this driver models it as a "rtc-32k" clock.
> However, it does not add any consumer for this clock. This causes the
> common clock framework to disable it, preventing RTC time access.
> 
> Since the RTC's timekeeping clock should always be enabled, regardless
> of which drivers are loaded, let's mark this clock as critical instead
> of adding a consumer in the RTC driver.
> 
> Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied to sunxi/fixes-for-5.18, thanks!

Best regards,
Jernej


