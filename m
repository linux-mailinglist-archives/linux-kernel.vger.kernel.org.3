Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDB5AD83F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiIERQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiIERQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:16:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47851430;
        Mon,  5 Sep 2022 10:16:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bz13so8743708wrb.2;
        Mon, 05 Sep 2022 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6jua7XnB+S6QXNBg/xY2SX2MwZ+5JccffQnTKsOaqDk=;
        b=kgxn/iA5M9NOE/FH/QgrgFrxAlMWYsOVL1vev7aZqaKj6cSVe5RQu6Ww9/m9lFCwCB
         2/A6a3MiFL0manWBuKAT8ClQIPJLDfkHBpFiTk287Fn8TzFFF6FNvR072trcXHX+zgKu
         RyU+XqriqsXa48+mrZcgbsgthA1+F1Szi1KR6ugjKpyh6qLZi9wtieC3w+AUZz8HP9M5
         0kXlUxhdIq7kWBWo8duWoPoSBZ/pmp7gtQbhmFp12lb2UWVSr1om04J9Z42dWiDAyi1w
         9trYU69D2oS0BcjCjIm4yRP1QWaMN+NCZ0Xmwj68pdOQzFbnIP7bNa54oEz1MF3Zcmjd
         p4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6jua7XnB+S6QXNBg/xY2SX2MwZ+5JccffQnTKsOaqDk=;
        b=5QGW6O405KS4fhSLV0eTXd+9vn69g8oYpZI3KHYl5UUQgmnK1U9Xp5owk4PAoImETj
         7xszPs7pDfBmMZ1THFZDwxnOAUBaRbcWH7w2fMrsVN5zjT6e3gVvggGo88D48bit1Ckg
         pq5ND/ChGpb4no8fYvrI80WzPNsDdn1SWaY7uWyKu2Gx563UyYaP9bGyWXyEOwGlYCzv
         C6H0Y8Zl1L00MHQ6vhWwf1BLtfNvBL3iHTJEU+WCSf0j84V9FZqHJX5R3+YuYAkt2UW7
         quKoHUYGIGkwCovWqA0uksbq051ehpzeAn/62I+YQ7XHJ+18EXrRdYSPrA63pGY5Aj4x
         Z4yw==
X-Gm-Message-State: ACgBeo2H4rwbSN+OXxpjtdeRnw6bnw7t+mblsicSL2VSqSjP8YTe9YIi
        81Z8FujCaV3/pFYtLuFQjoA=
X-Google-Smtp-Source: AA6agR5ygwYGBm+rLrHkshGbCtPvib5qsaV24F9hXwanS5vZYK/GZL3sk0pdeyAzqgdef3O42Uiq5w==
X-Received: by 2002:a5d:684e:0:b0:228:74d5:54e8 with SMTP id o14-20020a5d684e000000b0022874d554e8mr3860063wrw.101.1662398165821;
        Mon, 05 Sep 2022 10:16:05 -0700 (PDT)
Received: from Clement-Blade14.home (2a01cb000c0d3d00995730c36491d21b.ipv6.abo.wanadoo.fr. [2a01:cb00:c0d:3d00:9957:30c3:6491:d21b])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003a5ad7f6de2sm11437072wmj.15.2022.09.05.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 10:16:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/5] Allwinner H6 GPU devfreq
Date:   Mon,  5 Sep 2022 19:15:56 +0200
Message-Id: <20220905171601.79284-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a refresh of previous patches sent to enable GPU Devfreq on H6
Beelink GS1 but that wasn't stable at that time[0].

With the recent fix on GPU PLL from Roman Stratiienko I have retested
and everything seems stable and works as expected[1].

Regards,
Clement

0: https://lore.kernel.org/lkml/CAJiuCce58Gaxf_Qg2cnMwvOgUqYU__eKb3MDX1Fe_+47htg2bA@mail.gmail.com/
1: https://lore.kernel.org/linux-arm-kernel/2562485.k3LOHGUjKi@kista/T/

Changes since v2:
 - Fixes device-tree warnings
 - Add panfrost fix to enable regulator
 - Remove always-on regulator from device-tree
 - Update cooling map from vendor kernel

Clément Péron (5):
  arm64: defconfig: Enable devfreq cooling device
  arm64: dts: allwinner: h6: Add cooling map for GPU
  arm64: dts: allwinner: h6: Add GPU OPP table
  drm/panfrost: devfreq: set opp to the recommended one to configure and
    enable regulator
  arm64: dts: allwinner: beelink-gs1: Enable GPU OPP

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  1 +
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 87 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 51 ++++++++++-
 arch/arm64/configs/defconfig                  |  1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  8 ++
 5 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

-- 
2.34.1

