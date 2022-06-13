Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60E549C36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbiFMSyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbiFMSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:52:59 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88801F45DF;
        Mon, 13 Jun 2022 08:55:26 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id A549F42F30;
        Mon, 13 Jun 2022 11:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135723;
        bh=SWPSI20N9+E24+l0tBdoFLtGZC1kdcZDFhWRonHbGG4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FrJWOwQJCMYGXc5Yre2qItXay0jvQzUdkzrhrFHHUeiagNCiocNqKPoQWnSMVypsF
         Rmp7B2FgVD2pRwxlLhdu6Lo94xm+W9sJMa25MyzmX/GmEyI8WNEdrLmh1GGP9GvqQI
         ioiC9QH1CoGkyH1YLUEOeum51ZB7cNHY5Fk2MkZMX+31p0WeSxpbwVU3P5curzP00p
         fBXyxxmJavMDl+XxfxAY1kt4dEyWLYw7/TMsDUde1C67aT+ek9ajr6mtXLIE/CHnx7
         bF97oOvkXw2+q/mJU7uFwNsLhF/sffBWo9h+Mc9Iz17l8PR92g9tAV3Dqwu47VqNoA
         lklH0ITnbKi6Q==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:55:04 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 20/20] block, blksnap: adds a blksnap to the kernel tree
Date:   Mon, 13 Jun 2022 18:53:13 +0300
Message-ID: <1655135593-1900-21-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/Kconfig  | 2 ++
 drivers/block/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index fdb81f2794cd..e8e12bed6cc4 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -410,4 +410,6 @@ config BLK_DEV_RBD
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/blksnap/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 934a9c7c3a7c..0d95279bbe92 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -38,5 +38,6 @@ obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
+obj-$(CONFIG_BLK_SNAP)	+= blksnap/
 
 swim_mod-y	:= swim.o swim_asm.o
-- 
2.20.1

