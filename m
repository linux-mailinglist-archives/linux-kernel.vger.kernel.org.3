Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211F254CF93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349289AbiFORRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiFORRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:17:09 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47F3616F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WlExQDboUBB3aNQneLRIPLnOzP5E0AYkRUI3hfSOlME=; b=HV/XIvbpsy1UqyiqTKVjmbuB1j
        W1B/ypp3/YgWPgrMxBfByt9CrJhoRad85QVdoyGzggPKq51b01XC63aYMBM0/MB7531pmVrRfXnWP
        UyAfn8WTjoegm/jmRSKP78DVQK2jqBh2iEOXAefUuxSD5GdSATLIzYAZ1YVynVG/IBSw=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o1Wdd-0005ic-VR; Wed, 15 Jun 2022 10:17:05 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH v3 2/4] staging: r8188eu: call rtw_IOL_append_WW_cmd directly
Date:   Wed, 15 Jun 2022 10:17:01 -0700
Message-Id: <ca53fca1d5557684a4f6430ecd88aef481238ada.1655312169.git.ozzloy@challenge-bot.com>
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

Call rtw_IOL_append_WW_cmd directly, instead of using wrapper macro.

Delete wrapper macro, which is not needed.

Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
---
Changes in v2:
  - Make the commit message clearer
Changes in v3:
  - None

Note: This code has not been run on hardware.

 drivers/staging/r8188eu/core/rtw_iol.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_iol.h | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 8c990b1af5a70..7292bab126074 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -81,7 +81,7 @@ int rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr, u8 value, u8
 	return rtw_IOL_append_cmds(xmit_frame, (u8 *)&cmd, cmd.length);
 }
 
-int _rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr, u16 value, u16 mask)
+int rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr, u16 value, u16 mask)
 {
 	struct ioreg_cfg cmd = {8, IOREG_CMD_WW_REG, 0x0, 0x0, 0x0};
 
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index a648f9ba50a62..c99d7d5151099 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -43,14 +43,12 @@ void read_efuse_from_txpktbuf(struct adapter *adapter, int bcnhead,
 
 int rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			  u8 value, u8 mask);
-int _rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
-			   u16 value, u16 mask);
+int rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
+			  u16 value, u16 mask);
 int _rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
 			   u32 value, u32 mask);
 int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
 			    u16 addr, u32 value, u32 mask);
-#define rtw_IOL_append_WW_cmd(xmit_frame, addr, value, mask)		\
-	_rtw_IOL_append_WW_cmd((xmit_frame), (addr), (value),(mask))
 #define rtw_IOL_append_WD_cmd(xmit_frame, addr, value, mask)		\
 	_rtw_IOL_append_WD_cmd((xmit_frame), (addr), (value), (mask))
 #define rtw_IOL_append_WRF_cmd(xmit_frame, rf_path, addr, value, mask)	\
-- 
2.34.1

