Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DD490C59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiAQQSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbiAQQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:18:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C8DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 15so34546408edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4y5Hl3U1xXQXZw23h6/DO7pv/6iLmoZwNHNPhFYyIt8=;
        b=H7Kyile8bVbUB1uHXBaUIRyKZ8c7SBGxw1S9Bq1l7v1qCdkBs3OkvwHPBHe1d9tFni
         P7ZpCPGCpTFPJ3FugYLnQ0uNeH/2X9/xwte20CTIYlILxxuw1ZGakLiHVMgBvDaW/MDa
         hLACj+lIfyO/bcvaSxpTA2shvjDfo1byUl4m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4y5Hl3U1xXQXZw23h6/DO7pv/6iLmoZwNHNPhFYyIt8=;
        b=u64Mwtg50M67J+dUYMOsP8WZWUMzA+2Vr6JQotTi86dVpv1QgmYU5dZcN13mDXl7U/
         FQctac9wnrvyjUTIXjbtRImlomaQfq3fhiDWUiB5XE7u/paDBFbswIF+kLyQj8f3q07G
         A7m2LppjQ08nsbbmMR4VSReIK9I0Mz6BJCU9eUCpvgp/MI+gl6rhIBIbNCHDQg3ThgIN
         f6pD/q0/5HMNpM6JAPAoCkcWB/FGuu/ooynkh1x6T2o6may18kObB7JXP4/E8zqVGRmH
         CAubyBLATuF5FYWbw/zPkC1r0LH/1afyHTFg/O2XjZGaz5bbEp5ZbH34bjzrBtYdl+0c
         Yasw==
X-Gm-Message-State: AOAM530zndnvC6y0w5vMaZkLeRaXxKgPkZEhzyrm8SLO1godjblO4hc3
        yH/fG6/bRNxP5POqP6hSdARFsjMgsaMVJmXo
X-Google-Smtp-Source: ABdhPJzoKLf0i17Ak3VzqNyVv9Vm8qt47iUJmDiS73Di84vuVY4d6AuUwx7pgXcp35lk5Ixyzj/Ljw==
X-Received: by 2002:a17:906:1145:: with SMTP id i5mr16996384eja.317.1642436290556;
        Mon, 17 Jan 2022 08:18:10 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id s4sm4147652ejm.146.2022.01.17.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 08:18:10 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v3 0/4] Fix and improve gpmi nand on mx28
Date:   Mon, 17 Jan 2022 17:17:51 +0100
Message-Id: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from [1], the series fixes the timings setting of the gpmi
controller for the mx28 architecture, also adding support for fast
edo mode timings. The whole series has been heavily tested with the
mtd kernel test modules, and with repeated write cycles on nand.

[1] https://lore.kernel.org/r/20210702065350.209646-5-ebiggers@kernel.org

Changes in v3:
- Remove the "mtd: rawnand: gpmi: use a table to get EDO mode setup" patch.
- Simplify the validation logic (suggested by Sascha Hauer <sha@pengutronix.de>).

Changes in v2:
- Reparent by device tree instead of code (drivers/clk/mxs/clk-imx28.c).
  Suggested by Stephen Boyd.
- Improve the commit description.
- give examples of frequencies on my setup.
- Fix commit description.
- Add an example to the commit description to better understand the
  problem solved by the patch.
- Split the patch.
- Improve the commit message.
- Move the patch to the end of the series.

Dario Binacchi (4):
  ARM: dts: imx28: reparent gpmi clock to ref_gpmi
  mtd: rawnand: gpmi: fix controller timings setting
  mtd: rawnand: gpmi: validate controller clock rate
  mtd: rawnand: gpmi: support fast edo timings for mx28

 arch/arm/boot/dts/imx28.dtsi               |  2 ++
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 27 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.32.0

