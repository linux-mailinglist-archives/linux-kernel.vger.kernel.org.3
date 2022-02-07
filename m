Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720644AB4D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiBGGgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiBGGat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:30:49 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD072C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:30:47 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c194so11272228pfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 22:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLX5yScMxlQJ0sOssQwN5Kzrzlw7vwEez/KPc90XX1c=;
        b=mZGtqaYZUVCLH900LgcbwP8iVBRBagHqD2CsiTQ3hHkie78V59FfMQGeXnUnGetJvI
         DcB9FvVD9uzjdIYzDItXH+R1ixXa96wYWEIko9b1jHCIPaHmmQ2Z7B44q59+ZLK8TRwx
         10/0F8jPtCKl3fxbuBofFcQnArPFnhU8VEEvvf86n5NJEVzo/4UCcxvTgCm+/3G3b6P5
         KdmRpg8tq3/+ftH0CmD6hkZXgXbzcAkgdP7+jwie3u7YoIh00JFiEle504RX1Sj6Fmbu
         TcpOU10k5dUOIkDEJGkUyP0gHZNxn09YtyT5ZJgq/+pBL9MRTz48Q+vKM83t0KkxLxZD
         G/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLX5yScMxlQJ0sOssQwN5Kzrzlw7vwEez/KPc90XX1c=;
        b=17NoXPFk7NFdepDCt2/qvrLNri6OUlO8DwekmKt6gPuyMNQDfYGyKWSa3WOlMjd98p
         nc41Jpz1bzshcmhRsxbAKPFTL/1RUVeOKViGI8qBpar1inLQrzQCQwyPvU7R6Q1XQ702
         E2Oj1cx4hly3A7fdl0c8qFPXIP8I1jxh8s5Mc2IiWidvTo0+f7uuoJyvkzLAT7Qf6+x6
         u0L/3Vio6HRrWrfLKb80onja2m2f2CC7hkRa8P1FNFwlErwsG1o93PnKCuCprnA4ZSoG
         LkixGv5Lc90+zXKonhD2dgrgM4CHocsBaOVj1yzE/GRhId2bBKO8GI33CWFaOFPT2wf1
         xQ7A==
X-Gm-Message-State: AOAM530RP+HtNqCgbF6YLWq9Y8ZVmEiCmKLH/Ypa3zGyWCncl9WfBsjq
        Dz3wh1QB8TVo0KtdqT90j/nqNg==
X-Google-Smtp-Source: ABdhPJzLXi5WEZyX6LDirKnfSvr2IIhEFCVIHrTUFoTtuYM6ocZtuM8KhHrWJ6491MLFe71KsCULsw==
X-Received: by 2002:a05:6a00:1789:: with SMTP id s9mr14302978pfg.71.1644215447332;
        Sun, 06 Feb 2022 22:30:47 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i10sm5266634pjd.2.2022.02.06.22.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 22:30:46 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 0/3] Determine the number of DMA channels by 'dma-channels' property
Date:   Mon,  7 Feb 2022 14:30:37 +0800
Message-Id: <cover.1644215230.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PDMA driver currently assumes there are four channels by default, it
might cause the error if there is actually less than four channels.
Change that by getting number of channel dynamically from device tree.
For backwards-compatible, it uses the default value (i.e. 4) when there
is no 'dma-channels' information in dts.

This patch set contains the dts and dt-bindings change.

Changed in v5:
 - Rebase on tag v5.17-rc3
 - Fix typo in dt-bindings and commit message
 - Add PDMA versioning scheme for compatible

Changed in v4:
 - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>

Changed in v3:
 - Fix allocating wrong size
 - Return error if 'dma-channels' is larger than maximum

Changed in v2:
 - Rebase on tag v5.16
 - Use 4 as default value of dma-channels

Zong Li (3):
  dt-bindings: Add dma-channels property and modify compatible
  riscv: dts: Add dma-channels property and modify compatible
  dmaengine: sf-pdma: Get number of channel by device tree

 .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++++--
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  3 ++-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  3 ++-
 drivers/dma/sf-pdma/sf-pdma.c                 | 21 ++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
 5 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.31.1

