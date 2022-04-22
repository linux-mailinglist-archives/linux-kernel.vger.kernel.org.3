Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33EB50B167
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444780AbiDVH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444759AbiDVH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:28:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1D50454
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650612364; x=1682148364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xD0I5xV7kWeZLBUmPepIj83tk4qE1jeszPPagX3C5ew=;
  b=bADNML8xPJzMb4m0bHGbrN3nRxxpXGrbtHG88ClhbbwZs+i+tTIcJOK+
   riV+82LPwBGDFyIIVnsij+bzB7UbQjHTcnBSB3AgphisozFwvKPRD4nk+
   8Cp3Q4b9nd2g1iYSv+w0s/AU9Er9FJyVoUqHMlGxLvCl3uiJhOO80CtA7
   rhhBPIwFb1m9+2qnxojJSZ7M8LYvgsa09VeRWb0zW66ZtkO3kmr4tsssL
   SqaIhdc9FVWXOP+58SJ+uTx2frMz5EAueFUgDCp+r0l1c5pERXslDMUoM
   0dG3UNVX8jgFALjo8/0RL/7F+2oGoFw5+7bGhC5XY3PDlSblDJ2/ZeLu1
   A==;
X-IronPort-AV: E=Sophos;i="5.90,281,1643698800"; 
   d="scan'208";a="153462810"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Apr 2022 00:26:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Apr 2022 00:26:02 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 22 Apr 2022 00:26:00 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/4] riscv: config: enable the mailbox framework
Date:   Fri, 22 Apr 2022 08:25:31 +0100
Message-ID: <20220422072533.2582084-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220422072533.2582084-1-conor.dooley@microchip.com>
References: <20220422072533.2582084-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mailbox framework so that the system controller drivers get
compiled for PolarFire SoC.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 30e3017f22bc..e8472ffbb4dc 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -100,6 +100,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_MAILBOX=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_EXT4_FS=y
-- 
2.35.2

