Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1614E4771
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiCVU0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiCVU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:26:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563596660C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:24:50 -0700 (PDT)
Received: from dslb-178-004-174-067.178.004.pools.vodafone-ip.de ([178.4.174.67] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWl3e-0006W7-Ev; Tue, 22 Mar 2022 21:24:46 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: remove empty rtw_dummy_event_callback
Date:   Tue, 22 Mar 2022 21:24:38 +0100
Message-Id: <20220322202439.157999-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322202439.157999-1-martin@kaiser.cx>
References: <20220322202439.157999-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the empty function rtw_dummy_event_callback.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme.c        | 4 ----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 5 ++---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 59af1df81565..4ef50224c775 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -747,10 +747,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	rtw_os_xmit_schedule(adapter);
 }
 
-void rtw_dummy_event_callback(struct adapter *adapter, u8 *pbuf)
-{
-}
-
 void rtw_fwdbg_event_callback(struct adapter *adapter, u8 *pbuf)
 {
 }
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 3dde2bd0d77a..3da7b93ba5e9 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -744,7 +744,6 @@ struct C2HEvent_Header {
 	unsigned int rsvd;
 };
 
-void rtw_dummy_event_callback(struct adapter *adapter, u8 *pbuf);
 void rtw_fwdbg_event_callback(struct adapter *adapter, u8 *pbuf);
 
 enum rtw_c2h_event {
@@ -781,7 +780,7 @@ enum rtw_c2h_event {
 #ifdef _RTW_MLME_EXT_C_
 
 static struct fwevent wlanevents[] = {
-	{0, rtw_dummy_event_callback},	/*0*/
+	{0, NULL},	/*0*/
 	{0, NULL},
 	{0, NULL},
 	{0, NULL},
@@ -795,7 +794,7 @@ static struct fwevent wlanevents[] = {
 	{sizeof(struct stassoc_event), &rtw_stassoc_event_callback},
 	{sizeof(struct stadel_event), &rtw_stadel_event_callback},
 	{0, NULL},
-	{0, rtw_dummy_event_callback},
+	{0, NULL},
 	{0, NULL},	/*15*/
 	{0, NULL},
 	{0, NULL},
-- 
2.30.2

