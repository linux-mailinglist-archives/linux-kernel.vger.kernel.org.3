Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC859F3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiHXHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiHXHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:08:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4A9322E;
        Wed, 24 Aug 2022 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661324916; x=1692860916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E7dBTFLuHmlRMo3zzffCQ2u+pMWgaHQ/XvLs2QO7rXE=;
  b=q3DQ1OqpooGfks1ibWc3Y7jTWeD0RqGw01ilLm6qr5OVau5wik/jrYA6
   H2P1yc9BqNtz/fjzPQzM5oVlOfhTcaB6YGlgZ1RwuXEmHiS0zbw9Ps2bx
   rEerUxD4WTKFPUyfhEycbZOafr/ZDGt8K7LTMD/+AzvHkUQzGvs0ZylXt
   JFzb79Y2cKVsju/4MSE29eVBfYZX/YkVn5fPSyxjWuz0SXwRQHw7LRJKh
   AdfV/hrLvWh2IOO7j119CBlJkRyZN1ZjY1uDqMjzYpXBWUDobLL+s5quU
   yJqDULfjWlpDaoIzWdhk97SqIh4iFvFPy4sx6TYpOU9ujTQO3u6c/406d
   w==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="170677304"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 00:08:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 00:08:34 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 00:08:33 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 0/3] MPFS mailbox fixes
Date:   Wed, 24 Aug 2022 08:08:08 +0100
Message-ID: <20220824070810.52219-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I spotted a couple of bugs in my mailbox driver while developing some
new features. None of the features these bugs relate to were in use so
they've gone unnoticed until now. The binding screwup is unfortunate
and I don't really know how I misread the register map so badly.

Thanks,
Conor.

Changes since v1:
- add the extra fixes tag & Krzysztof's R-b for patch 1

Conor Dooley (3):
  dt-bindings: mailbox: fix the mpfs' reg property
  mailbox: mpfs: fix handling of the reg property
  mailbox: mpfs: account for mbox offsets while sending

 .../mailbox/microchip,mpfs-mailbox.yaml       | 15 ++++++++---
 drivers/mailbox/mailbox-mpfs.c                | 25 +++++++++++--------
 2 files changed, 25 insertions(+), 15 deletions(-)


base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.36.1

