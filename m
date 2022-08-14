Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0075925F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiHNS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNS23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:28:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7417E0D;
        Sun, 14 Aug 2022 11:28:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b16so7181049edd.4;
        Sun, 14 Aug 2022 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TDq4TxM/Ckg6Qko1e2UClQr3wI8LPMR2dsNUHG49cJs=;
        b=Gfh2U705sN4INdM10kgqOB4ZriC46K8BvgYY/hul2G0RqTRa1rzw8IW0ZG7twbx1+s
         GYwA/2/W79dqfny+Lk97hALHWqzhk9VQLFMEyGf6PG+oVh4EO2e6+6G/EuA6Tzv9Il2D
         agzLdWCEBllZZzfp/SRTEH8PTZ2SydRz+wGg1kqh50cUeSlS9XNdn2WfTJnOua498pMY
         Mc9S7c3Lpyz5An5vfAS4JtZeSiLJ/UUzYLp+qwd3EuqhT85JWLr/qa1rgqBwUoiU2zmC
         GlPL0MHgNe5loKj+sqh8B9sfiX/9amAOjmcQbuVasxA05mEmR2q6edS9qBN2KGWBy0Vc
         A6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TDq4TxM/Ckg6Qko1e2UClQr3wI8LPMR2dsNUHG49cJs=;
        b=zji3jh+zUTiypnrIB664dd2bBvg6Wzbfwkc0HltJMx9TGIpkKQo6sbVFc8eapnQj89
         EWNclo0dTkzdVrYHeizLxHst/LUVvyzo7+tB7/lNzy+4uxfD0LaJ4RjK7XKfpOP+72AT
         /j+3TFTst1WYwTpBEUUgu40EQ00d6byHAKSBUlMCirgV/XihA8hbhs8/f9MMwpy5y2Lf
         6BY4iehtYKv3jCSLYNBvNatInrICdAIEWEPKaLBNJQueFRyLl6nBuGXdomSnWlc/Md07
         cIH9+U9WG1mSLJ5jvRADzDU1lL5+vKDJT+m84h8mB4P119vsJqOEge462yUqc0EOLZwY
         80fA==
X-Gm-Message-State: ACgBeo0EnnBG+s2gQTN0CpebUwyONrAOIG+MMQDHo3ou19flsUKX1G+8
        zpx0myelMeBZCnRwAv0nThU=
X-Google-Smtp-Source: AA6agR6hgf1Q+tCnYs80QZTSFEm/fFieWNnYZD/LRsYaFKc5cbadXjo60qzsFGnKncHuwdKH0z+AUQ==
X-Received: by 2002:aa7:c30c:0:b0:440:a189:541d with SMTP id l12-20020aa7c30c000000b00440a189541dmr11562979edq.64.1660501707004;
        Sun, 14 Aug 2022 11:28:27 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906300100b006fee98045cdsm3283836ejz.10.2022.08.14.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:28:26 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/9] soc: sunxi: sram: Fix debugfs info for A64 SRAM C
Date:   Sun, 14 Aug 2022 20:28:25 +0200
Message-ID: <3503978.R56niFO833@jernej-laptop>
In-Reply-To: <20220801030509.21966-6-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-6-samuel@sholland.org>
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

Dne ponedeljek, 01. avgust 2022 ob 05:05:05 CEST je Samuel Holland napisal(a):
> The labels were backward with respect to the register values. The SRAM
> is mapped to the CPU when the register value is 1.
> 
> Fixes: 5e4fb6429761 ("drivers: soc: sunxi: add support for A64 and its SRAM
> C") 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


