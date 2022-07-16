Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A482D576BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiGPFAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPFAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:00:41 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A440BD6;
        Fri, 15 Jul 2022 22:00:34 -0700 (PDT)
X-QQ-mid: bizesmtp65t1657947577tegsdf7s
Received: from localhost.localdomain ( [223.86.65.215])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 12:59:35 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000000
X-QQ-FEAT: PXJK6C+SdL1zWBD2r1dwXVWoJNFGSxML4kNGB47Zd/vMvHzldRq1HCJXarKEW
        UmWtuorVig3z4d2+/wTKtMKvNj38eVh7uKRzSWxxWhIN8pdJWXVvs95rwhrkFbkxdUceivp
        GctfELb/61rM6FwAyZrxhnLps69L7fqO2d4oD7jY+b0d6J2/O1bHhx5lN9rum4kXrM4B5ql
        ABb33lz1HSobucNDQQ4FsrHKBz3qjC76kpOoq6vQbWn0Hyh1aYuItGEyJIwV8C7bg0NsviS
        hcqT4ij0mMYVC2/HmQLga0fL2/gRk2PNkqD7D+AJo6BJvAp8YxGR9vEq83pOxDbTuPxVNn6
        GwigwVMdnYYW6xBQnAAfHJh22aF0g==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     mirela.rabulea@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: imx-jpeg: Remove unnecessary memset() after dma_alloc_coherent()
Date:   Sat, 16 Jul 2022 20:25:43 +0800
Message-Id: <20220716122543.34218-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `dma_alloc_coherent()' already zeroes out memory for us, so we don't
need the redundant memset().

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 32fd04a3d8bb..482177ee01b6 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -519,7 +519,6 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
-	memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
 	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
-- 
2.35.1

