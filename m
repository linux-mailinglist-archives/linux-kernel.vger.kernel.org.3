Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7F54CF91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbiFORRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiFORRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:17:09 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC9381B7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FgBxiGnfGrCDvBNxSUTPi2WkWIMaKs3eEhesYlN4HNQ=; b=Ud8UiChSQh/KM827G6GFOfbKFR
        Z726YXmATZMgmO0rLFjWphayLhbEKitum67LIhMoYIv2xUkpjrbd9Tj2OlypC9CCdFpTr4DJFedrf
        KHQbTpYJuGTb6O89HtlQYJMrOUZTRSd2dzSCBNI3Z1kQVa2NzH0YQqzM/41nigBDdgFc=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o1Wdd-0005iU-PG; Wed, 15 Jun 2022 10:17:05 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH v3 1/4] staging: r8188eu: call rtw_IOL_append_WB_cmd directly
Date:   Wed, 15 Jun 2022 10:17:00 -0700
Message-Id: <e0002dcce35e78a4c7308515f68e473cad2f290b.1655312169.git.ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1655312169.git.ozzloy@challenge-bot.com>
References: <cover.1655312169.git.ozzloy@challenge-bot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Watson <ozzloy@challenge-bot.com>

Call rtw_IOL_append_WB_cmd directly, instead of using wrapper macro.

Delete wrapper macro, which is not needed.

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
Changes in v2:
  - Make the commit message clearer
Changes in v3:
  - fix typo in first line "Call rtf..." -> "Call rtw..."

Note: This code has not been run on hardware.

 drivers/staging/r8188eu/core/rtw_iol.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_iol.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index af8e84a41b851..8c990b1af5a70 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -67,7 +67,7 @@ bool rtw_IOL_applied(struct adapter  *adapter)
 	return false;
 }
 
-int _rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr, u8 value, u8 mask)
+int rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr, u8 value, u8 mask)
 {
 	struct ioreg_cfg cmd = {8, IOREG_CMD_WB_REG, 0x0, 0x0, 0x0};
 
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index fb88ebc1dabb1..a648f9ba50a62 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -41,16 +41,14 @@ int rtw_IOL_append_END_cmd(struct xmit_frame *xmit_frame);
 void read_efuse_from_txpktbuf(struct adapter *adapter, int bcnhead,
 			      u8 *content, u16 *size);
 
-int _rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr,
-			   u8 value, u8 mask);
+int rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr,
+			  u8 value, u8 mask);
 int _rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			   u16 value, u16 mask);
 int _rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			   u32 value, u32 mask);
 int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
 			    u16 addr, u32 value, u32 mask);
-#define rtw_IOL_append_WB_cmd(xmit_frame, addr, value, mask)		\
-	_rtw_IOL_append_WB_cmd((xmit_frame), (addr), (value) ,(mask))
 #define rtw_IOL_append_WW_cmd(xmit_frame, addr, value, mask)		\
 	_rtw_IOL_append_WW_cmd((xmit_frame), (addr), (value),(mask))
 #define rtw_IOL_append_WD_cmd(xmit_frame, addr, value, mask)		\
-- 
2.34.1

