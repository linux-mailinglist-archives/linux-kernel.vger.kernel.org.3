Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15159B59E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHURbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHURbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:31:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13117A90;
        Sun, 21 Aug 2022 10:31:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a4so10675553wrq.1;
        Sun, 21 Aug 2022 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=pNG4G+DwLDhFmuP5MPNfWqVOnSu+/xUGuRdk4UBjqw0=;
        b=UXcBNDkenBGwNMu/3GWsBnvB7gtkcR/JxOeG/pRsiyqsfKTPjhxvyRDOfPu3UmfOEP
         Y7YiYC/2akv7mHHWzp6iMmL7UgceEiPP05sME56JiOaIzBKBGTSoVnuetmQTQNpYRLiD
         uw7vq/8CHuZ/xGf/gOmZjIiTqqjXi+WekAjGGS76WcogkQZP2YgABg1uyt3wHEAQmT2z
         feA/zBYL/PKLhDcuOV8JuVE5fhZ/b1A5+r9Gtpp82JebWyg9s0V9uAFeqDk81+uvgbFT
         GAHUcueGKP5WZD4Plx7kN0q3zvD5Jy+K6/2jOiAAlM/RDJ35etsYJEYWPymK4X0fGEJe
         mELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pNG4G+DwLDhFmuP5MPNfWqVOnSu+/xUGuRdk4UBjqw0=;
        b=H9LeU1i+fLrpAHYq95gAdRA0lVuMN8/bchWRG/ZvFa0OlfKAPlBmL9NpIQ2PS7fVh3
         l3HGKGZgcnsFhy/ZY7qTcSO+pX8cdNOpHDXd/t9SDF5AJsB7DzAFegfEwtPtTbavFKtV
         q3lY/B2fPupgAxFAMq/5Qvon176ekaX0o2refZaLxNWH5hcYyAXYPlBBxAsdoEzlHyIC
         4zA4Fsnc4NWwQZ9kC+TPTQffKcv6RvFra/i9upQ6YdxLoLuCk4LoxwcgVAiB3ScrdgKv
         w1b2cgn5C8jPAm9KJqWJIscgecuU/dRSMZFc67H/Cs3OOybJBEIAeFymBSOXbHyNZJWm
         Fr6Q==
X-Gm-Message-State: ACgBeo10WiPrb5Xp7KPem8MF6cKKwTxJ9nqcCQJv+a3htFNL9/MK2QHk
        7ZLN66X6NBtvGFL9Jw1QUUk=
X-Google-Smtp-Source: AA6agR6UjJd0cmOJ8JSdIgLww1DMnwTrCTIBW5LX94OLcDxq9nQQOzIHDtayKFKeiYBrrs8OYg6CzA==
X-Received: by 2002:a05:6000:1f0a:b0:225:3bbd:c5e6 with SMTP id bv10-20020a0560001f0a00b002253bbdc5e6mr5703120wrb.126.1661103064463;
        Sun, 21 Aug 2022 10:31:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:a77:3d70:9d84:ec8d:98d9:c29a])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b00224f7c1328dsm9387205wrr.67.2022.08.21.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:31:03 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/4] Allwinner H6 GPU devfreq
Date:   Sun, 21 Aug 2022 19:30:47 +0200
Message-Id: <20220821173051.155038-1-peron.clem@gmail.com>
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
and everything seems stable and works as expected.

Regards,
Clement

0: https://lore.kernel.org/lkml/CAJiuCce58Gaxf_Qg2cnMwvOgUqYU__eKb3MDX1Fe_+47htg2bA@mail.gmail.com/
1: https://lore.kernel.org/linux-arm-kernel/2562485.k3LOHGUjKi@kista/T/

Changes since v1:
 - proper sign-off with my personal email
 - sent serie to SoC Maintainer w/ cover letter

Clément Péron (4):
  arm64: defconfig: Enable devfreq cooling device
  arm64: dts: allwinner: h6: Add cooling map for GPU
  arm64: dts: allwinner: h6: Add GPU OPP table
  arm64: dts: allwinner: beelink-gs1: Enable GPU OPP

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 88 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 22 +++++
 arch/arm64/configs/defconfig                  |  1 +
 4 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

-- 
2.34.1

