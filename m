Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E084490701
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbiAQLSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiAQLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:18:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D8C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:35 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m4so63981555edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hXtz38xI39sb/l7IV7cpsFMcqJ4/30G12fzT7qLAPw=;
        b=VnZMWJJPppDz6zU/SauFyWdqQcazAIoL+9JIIIQlg9xNZMHRMtj3b1d13VjYmluaPr
         MeKxtTx24Z7UAJMbv+v3H6jkONGZCVgf+ff89Sm2dRE5thDY1r6FcKKDEIj7vRl5VUkG
         5H6rBG2mRe/hdhcpJ++jKMY22GAgauMiQXwUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7hXtz38xI39sb/l7IV7cpsFMcqJ4/30G12fzT7qLAPw=;
        b=47TyfZ111rW7sXiz7s7cl1orxekD69huw2aVQFjC1HvyvkMe8TJ5eCwujubZ/y4ULG
         FaQ8Q4SfVcbAWC01pgujp3WscbUToqjd4PeL6dBS6O+d/5Kvwx4RWCNeHWFhfufiKot2
         tlppyi71EKi9n9qvx5e7Tjs/hQbzxAnIEtCQGxWXXJ27qC9xeoitFmPD2h+S9UXxQAFx
         K112NsXQI8Yh+dQLavjm1dVVHVVvu9R4ezFAsXzxKfFK8K9WZRb30ObU1jeMmGp3jI1/
         Lrj+QxhLgq4V8t4JVL43kPLMrXa20DUWVenrqiNIa6Y4o+h/ULmzLvXO0fRDRwjTCMCN
         Mdwg==
X-Gm-Message-State: AOAM533KvXSkT+QX3aqv9iPQb3cGsW0nN05En1G7R3l9DLHXoqv49zgW
        IFwRhoiIYlZJGU/j5AViA4C+BR+fLbegx/a4
X-Google-Smtp-Source: ABdhPJy9p4muRxfjQF96SruKy8vlk8bAz/98oyel7N3eUnloHeqIJB3RVUTA9t5CPd6kk9zHFHU0RQ==
X-Received: by 2002:a17:906:4a4d:: with SMTP id a13mr10764683ejv.223.1642418313594;
        Mon, 17 Jan 2022 03:18:33 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id f11sm5142713edv.67.2022.01.17.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:18:33 -0800 (PST)
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
Subject: [RFC PATCH v2 0/5] Fix and improve gpmi nand on mx28
Date:   Mon, 17 Jan 2022 12:18:24 +0100
Message-Id: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
 - Reparent by device tree instead of code (drivers/clk/mxs/clk-imx28.c).
   Suggested by Stephen Boyd.
- Improve the commit description.
- give examples of frequencies on my setup.
- Add the patch to the series.
- Fix commit description.
- Add an example to the commit description to better understand the
  problem solved by the patch.
- Split the patch.
- Improve the commit message.
- Move the patch to the end of the series.

Dario Binacchi (5):
  ARM: dts: imx28: reparent gpmi clock to ref_gpmi
  mtd: rawnand: gpmi: fix controller timings setting
  mtd: rawnand: gpmi: use a table to get EDO mode setup
  mtd: rawnand: gpmi: validate controller clock rate
  mtd: rawnand: gpmi: support fast edo timings for mx28

 arch/arm/boot/dts/imx28.dtsi               |  2 +
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 70 ++++++++++++++++------
 2 files changed, 55 insertions(+), 17 deletions(-)

-- 
2.32.0

