Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACAF54A543
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352647AbiFNCQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353687AbiFNCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:14:00 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E533A70A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lrL/+oGY+uk9L4jKJpNu2GWREzFwvgfDUFYM4/JAZPE=; b=Sfz7aF+5rivC9q4x6TicBF6p+p
        mJZnXG3zbLCFd+eoChYJSmaiBQYtA270Wv+UYOs/o7IQGUS9WRbfT9L/ZvffdA1pC9oPHvV2FD5me
        jwgkmRgnIEWEIds3WbClH7+Au9YX7+96KhtSlmTEcKfu55yY2ENisaotpbhkAOLRvXnQ=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o0vyD-000895-PL; Mon, 13 Jun 2022 19:07:53 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH 3/4] staging: r8188eu: remove leading '_' on _rtw_IOL_append_WD_cmd
Date:   Mon, 13 Jun 2022 19:07:32 -0700
Message-Id: <5eded481b16599ccca5546d776932f75e39db702.1655171591.git.ozzloy@challenge-bot.com>
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

name the function rtw_IOL_append_WD_cmd and call it directly,
instead of using wrapper macro

delete wrapper macro, which is not needed

NOTE: code compiles, not tested on hardware

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
 drivers/staging/r8188eu/core/rtw_iol.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_iol.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 7292bab126074..b7ee3833c908c 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -95,7 +95,7 @@ int rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr, u16 value, u1
 	return rtw_IOL_append_cmds(xmit_frame, (u8 *)&cmd, cmd.length);
 }
 
-int _rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr, u32 value, u32 mask)
+int rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr, u32 value, u32 mask)
 {
 	struct ioreg_cfg cmd = {8, IOREG_CMD_WD_REG, 0x0, 0x0, 0x0};
 
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index c99d7d5151099..9ad467759ef1c 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -45,12 +45,10 @@ int rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			  u8 value, u8 mask);
 int rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			  u16 value, u16 mask);
-int _rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
-			   u32 value, u32 mask);
+int rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
+			  u32 value, u32 mask);
 int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
 			    u16 addr, u32 value, u32 mask);
-#define rtw_IOL_append_WD_cmd(xmit_frame, addr, value, mask)		\
-	_rtw_IOL_append_WD_cmd((xmit_frame), (addr), (value), (mask))
 #define rtw_IOL_append_WRF_cmd(xmit_frame, rf_path, addr, value, mask)	\
 	_rtw_IOL_append_WRF_cmd((xmit_frame),(rf_path), (addr), (value), (mask))
 
-- 
2.34.1

