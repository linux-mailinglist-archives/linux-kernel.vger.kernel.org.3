Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586049C2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiAZEuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiAZEuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:50:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E48C06161C;
        Tue, 25 Jan 2022 20:50:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h21so6016730wrb.8;
        Tue, 25 Jan 2022 20:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=ZnFERg4538qEnnFDm3nu3v0KamXDEvSagtuMNAkM2ec=;
        b=qzRXO/gyUPn6B8dOERb/z9Y2l1TuydXikcK0/je5mLsxfq7ZFu8syLt8nbh04TjPxP
         dFGw9oIHNDND0snYVrh2+T0HuQ1YH508eLbxae339V703WQO2MDftLW4Hm2mHZaxZo3D
         k9VDBUMow7gaZwOcoITKmoJs4KFW1FXOlolKpH63E9htJig4tUhaLuFQgeC1R6+jw5on
         agpJJP4Az3OrTs6+4UCcnfWnbtf4i/9GZLZFFZrZ5zj6b7mADaP7ftrjPocQzYE3BFXK
         J0vB+HNU9TlXgdO+Eb+OnREx0KfLLYAIAOTLfdKHJHFvjr14/km/y6x1r1BwVrAataFk
         rggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZnFERg4538qEnnFDm3nu3v0KamXDEvSagtuMNAkM2ec=;
        b=vENz418FqScEpw1aR51XI+t/VKdO/021bjrOWCqrqI5a6pMcQZOrr2bBugji0UnMDt
         icsS7gZHH3zZVfwCrcqwAG1mom65zIUxC3pJMjpuD6HyTMjzjlLtU37CrOAIv5WWmAz/
         LyWQgCUAB3JemDwGtF+ZdKg7PtgGjapuHecCE1Lll+rsz0VFLb7CCRoAwIYUxwOlcS4X
         7nQbwxNndLIn6heSZe+o2U7lqUyNdAuU3ze2oL1N8TQupLeuMVrKetv+6kKSvYd4KCrA
         U+5D0rOJXehG7xa62YSTNaoI3Lw4xzdhJH6+zkMFCDRIrL0udnDeHJB67dvYn3oJY16q
         BCwg==
X-Gm-Message-State: AOAM531PKNibDofBxcFqmDZl4owoeqaPw0NB6Km0CyoJXTSIbpGF+X+l
        8PmG1adx/4Yo368buVdU+5c=
X-Google-Smtp-Source: ABdhPJxMQ+Owhslgsg6YV8JFt0RhWAyKkZIa7OOaBUy/CVMbb3/CMJS3NJ/mczCB9JDwi2x+UMB0bQ==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr20829820wrn.298.1643172598738;
        Tue, 25 Jan 2022 20:49:58 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n15sm2171342wmr.26.2022.01.25.20.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:49:58 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] arm64: dts: meson: add ATF BL32 reserved-memory regions
Date:   Wed, 26 Jan 2022 04:49:51 +0000
Message-Id: <20220126044954.19069-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series supersedes [0] which fixed a long-running kernel panic issue
seen with Beelink G12B devices booted from Amlogic vendor firmware. The
same issue exists with a wider set of devices from GXBB to SM1, although
it is not often seen due to my kernel fork including 'catch-all' patches
for some time (the meson-gx patch was suggested by Matheusz in 2019) and
many distros actively supporting Amlogic hardware consuming some or all
of my regular patchset.

I've also included a cleanup to the SEI510/SEI610 board files. If that's
not desirable feel free to ignore that patch. I also dropped the fixes
tagging as I'm not sure what original commits could be targetted. If you
think fixes are good please provide some guidance and I'll be happy to
send a revised series.

[0] https://patchwork.kernel.org/project/linux-amlogic/list/?series=607446

Christian Hewitt (3):
  arm64: dts: meson-gx: add ATF BL32 reserved-memory region
  arm64: dts: meson-g12: add ATF BL32 reserved-memory region
  arm64: dts: meson-g12: drop BL32 region from SEI510/SEI610

 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 8 --------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts  | 8 --------
 4 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.17.1

