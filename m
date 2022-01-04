Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB904843ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiADO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiADO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:56:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD7C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:56:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t26so76695812wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8y3fxQ7Ixt8X6KzlM4QoJHjlMDWhk5dk98sHG3phE8=;
        b=LnBgmJrGWXQSJznhBJE7nxnjt6hdhnRrlVkEdW/QZH+gDm/GnpetPv7QTsZX8pf/8b
         cHfgr6n/Wm3EK3AJEjCNoYm6HmQbgcMMsVwHWjur2NzP5TnDVKc2nnp1oInjOu2+q6hd
         1gnY07zR7Wb+Ufe59UmTXEEynlolGPNxTLcRerhKv0W4vtk6RVv1OuIE42MQltOi/1BF
         Tshs6HHsmUsS+m5MDHlegZhacwkdZ+NYq+AC1j4gY8MdxfREkQHPUaSReq1LBuo010Ws
         GICNQ97F95sXfLa4gRtAnbevuAblhYx3UcEeHdABqenh4BRMujIZl+5kNTbbwnwzThn3
         WD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8y3fxQ7Ixt8X6KzlM4QoJHjlMDWhk5dk98sHG3phE8=;
        b=KsJHYKU6E5p07drIv/WKUVSX/zm3fwSR1qLZ4o9AZ0Sdk/lztlBEEmugMwEfIX6658
         kxL5GD+TdBh/kuBXdcUosjJKxx9mgNjXw9qt2Z/hxW1VRAx+UfrKRfDQwLnnLC7GcCOX
         XjkFNPs/lVppPWzEYLh3bhaSsmljkg6W5Qz07pE8Qz2qqXvRKGTXbfVzHYEEwp9vG3qx
         jyr3BuxBXCQd4ARocTcXbbMoha0/yR8dB3ZjcYoW2b8IghBljy4xhtVAtVioTDhVr2Ks
         r51Dlyunz6Tk0nl5mevl5aVXJizuMNdI3kbPxn99X8/X2npoQJ+YO78ZrLiS+2CI0zff
         KzIQ==
X-Gm-Message-State: AOAM533rbUZqkrN1WXBYUdij8LanuFcekY0jXD0+oo+T+3orATl5MPks
        g7X4G1cFKp9Lul+cE/dKRbEa7gctuas3eg==
X-Google-Smtp-Source: ABdhPJzGZKFOs4DEcC/6CKGwfstjaCLEUD0B2urzy0Wb63F4ZVqkq++d9906q+a/ZlR7wvNjeeMIIA==
X-Received: by 2002:a5d:5889:: with SMTP id n9mr42818211wrf.476.1641308211178;
        Tue, 04 Jan 2022 06:56:51 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id k10sm19309859wrz.113.2022.01.04.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:56:50 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-oxnas@groups.io,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] ARM: ox810se: Add Ethernet support
Date:   Tue,  4 Jan 2022 15:56:43 +0100
Message-Id: <20220104145646.135877-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Synopsys DWMAC controller found in the
OX820SE SoC, by using almost the same glue code as the OX820.

Patch 1 & 2 are for net branch, patch 3 will be queued to arm-soc.

Changes since v1:
- correctly update value read from register
- add proper tag on patch 3 for arm-soc tree

Neil Armstrong (3):
  dt-bindings: net: oxnas-dwmac: Add bindings for OX810SE
  net: stmmac: dwmac-oxnas: Add support for OX810SE
  ARM: dts: ox810se: Add Ethernet support

 .../devicetree/bindings/net/oxnas-dwmac.txt   |   3 +
 arch/arm/boot/dts/ox810se-wd-mbwe.dts         |   4 +
 arch/arm/boot/dts/ox810se.dtsi                |  18 +++
 .../net/ethernet/stmicro/stmmac/dwmac-oxnas.c | 115 +++++++++++++-----
 4 files changed, 111 insertions(+), 29 deletions(-)

-- 
2.25.1

