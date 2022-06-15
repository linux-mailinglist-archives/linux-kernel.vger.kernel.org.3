Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8854BEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbiFOAtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiFOAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:49:35 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566834C430
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CnX0C4kEKoPLx63PlbawLXiCLHspF4rFGDo4Tu+RTJY=; b=DiTsYjpwn7BrzQTBBWpyLDWSip
        a1yVI1fZWySNNyrgSALWm6RwUF0V3JTKdAp/Cfmukda9rvC3fo9Jr4mLxO0B+EkhSnYCml3v8Qaah
        oh0/9XzNtvR7IcPpXmjqpJYBYoHfljRUvNE8moANDtss+olPyM5LGfn+MzNkzYtOeps4=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o1HDu-0002T3-6u; Tue, 14 Jun 2022 17:49:30 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH v2 3/4] staging: r8188eu: call rtw_IOL_append_WD_cmd directly
Date:   Tue, 14 Jun 2022 17:49:27 -0700
Message-Id: <338bf7d1067d625299c2077fcd01d7bb09c2bc37.1655249804.git.ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1655249804.git.ozzloy@challenge-bot.com>
References: <cover.1655249804.git.ozzloy@challenge-bot.com>
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

Call rtw_IOL_append_WD_cmd directly, instead of using wrapper macro.

Delete wrapper macro, which is not needed.

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
Changes in v2:
  - Make the commit message clearer

Note: This code has not been run on hardware.

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

