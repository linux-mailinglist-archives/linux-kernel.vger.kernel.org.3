Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6840D54A5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353331AbiFNCQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353523AbiFNCNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:13:52 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762C3A197
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7llz2Z7K7wv92C5VRhxFn9lqL16Y/uLeIOxsPH/Dch0=; b=oyhkw8A5sytlweL7XIAw6unIVd
        VEjGUR2Jv5PYTw6dvzOc0S4ixI3owkhcgwxy2IFBx06Qgzr/7uOXVj/vhZTKXyiWAjG20fdOZSaOR
        kNMpsTlCII1Tdf76Pk/FKyxU5zuoR6o/3DzWXGnkZQnrT+5F7j1Kek5e2wVQuXpp5rQU=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o0vyD-000899-Rz; Mon, 13 Jun 2022 19:07:53 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH 4/4] staging: r8188eu: remove leading '_' on _rtw_IOL_append_WRF_cmd
Date:   Mon, 13 Jun 2022 19:07:33 -0700
Message-Id: <3797496ad258ba3d0184b82194c6db729eff28d9.1655171591.git.ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1655171591.git.ozzloy@challenge-bot.com>
References: <cover.1655171591.git.ozzloy@challenge-bot.com>
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

name the function rtw_IOL_append_WRF_cmd and call it directly,
instead of using wrapper macro

delete wrapper macro, which is not needed

NOTE: code compiles, not tested on hardware

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>

staging: r8188eu: remove leading '_' on  _rtw_IOL_append_WRF_cmd

call rtw_IOL_append_WRF_cmd directly instead of using wrapper macro
delete wrapper macro, which is not needed

NOTE: code compiles, not tested on hardware

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
 drivers/staging/r8188eu/core/rtw_iol.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_iol.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index b7ee3833c908c..31e196ccd899a 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -109,7 +109,7 @@ int rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr, u32 value, u3
 	return rtw_IOL_append_cmds(xmit_frame, (u8 *)&cmd, cmd.length);
 }
 
-int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path, u16 addr, u32 value, u32 mask)
+int rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path, u16 addr, u32 value, u32 mask)
 {
 	struct ioreg_cfg cmd = {8, IOREG_CMD_W_RF, 0x0, 0x0, 0x0};
 
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 9ad467759ef1c..099f5a075274c 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -47,10 +47,8 @@ int rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			  u16 value, u16 mask);
 int rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			  u32 value, u32 mask);
-int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
-			    u16 addr, u32 value, u32 mask);
-#define rtw_IOL_append_WRF_cmd(xmit_frame, rf_path, addr, value, mask)	\
-	_rtw_IOL_append_WRF_cmd((xmit_frame),(rf_path), (addr), (value), (mask))
+int rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
+			   u16 addr, u32 value, u32 mask);
 
 u8 rtw_IOL_cmd_boundary_handle(struct xmit_frame *pxmit_frame);
 
-- 
2.34.1

