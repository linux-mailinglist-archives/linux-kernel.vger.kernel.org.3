Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82A502A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbiDOM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbiDOM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:56:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F9BF967
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650027237; x=1681563237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xD0I5xV7kWeZLBUmPepIj83tk4qE1jeszPPagX3C5ew=;
  b=Bl2PLZ3OO6qbRWqWMPIhKlAnM/M1gXXqEGqjkHQbSYoXAk94sNhN2SPQ
   faU6IqNBlJf12he+moQ1idxzb2HSJL5AS3bKPWWsh0kJ49fRsBGCpEuDi
   iSOWaY1tFD+EjAUGXaHN44SK99SVh3ngQMzCKsTusYLE4pXuqJmaRkGdd
   0LBXsBRh4cR/tkQfGXxPywIsas+vHJm+KVcjtkNwr69c1/W2/gNDdgdL8
   E8AKC4OxhNgdQ6uvoqahWJgksacdsLHPSWU82KF0qN/0lH9y4o7qYi+nl
   ZfDRghVaCs473PhJEyYyqtWJeaOqiryqh09xCvLFL8XM198AWsX4hP3fq
   A==;
X-IronPort-AV: E=Sophos;i="5.90,262,1643698800"; 
   d="scan'208";a="169769320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2022 05:53:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Apr 2022 05:53:56 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 15 Apr 2022 05:53:55 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 2/4] riscv: config: enable the mailbox framework
Date:   Fri, 15 Apr 2022 13:52:20 +0100
Message-ID: <20220415125221.2871991-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415125221.2871991-1-conor.dooley@microchip.com>
References: <20220415125221.2871991-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

