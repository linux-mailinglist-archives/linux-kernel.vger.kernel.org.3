Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C7C53BEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiFBTiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiFBTh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:37:58 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1DE31225
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:37:55 -0700 (PDT)
Received: from ipservice-092-217-081-045.092.217.pools.vodafone-ip.de ([92.217.81.45] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nwqdi-0003py-Q5; Thu, 02 Jun 2022 21:37:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/11] staging: r8188eu: use u8, u16 in issue_action_BA prototype
Date:   Thu,  2 Jun 2022 21:37:26 +0200
Message-Id: <20220602193726.280922-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602193726.280922-1-martin@kaiser.cx>
References: <20220602193726.280922-1-martin@kaiser.cx>
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

Use u8 and u16 in the issue_action_BA prototype. The code expects these
parameters to be exactly 8 and 16 bits wide.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index c025f95defab..1c1598c71b78 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5363,7 +5363,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 	return ret;
 }
 
-void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned char action, unsigned short status)
+void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action, u16 status)
 {
 	u16 start_seq;
 	u16 BA_starting_seqctrl = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 573d65b175cc..71864733b1c0 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -524,8 +524,7 @@ int issue_deauth(struct adapter *padapter, unsigned char *da,
 		 unsigned short reason);
 int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason,
 		    int try_cnt, int wait_ms);
-void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
-		     unsigned char action, unsigned short status);
+void issue_action_BA(struct adapter *padapter, unsigned char *raddr, u8 action, u16 status);
 unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr);
 unsigned int send_beacon(struct adapter *padapter);
 bool get_beacon_valid_bit(struct adapter *adapter);
-- 
2.30.2

