Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EBA5325FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiEXJBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiEXJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:01:07 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96DB07
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:01:04 -0700 (PDT)
Received: from 162.sub194.ddfr.nl ([83.136.194.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ntQPT-0006Y3-QF; Tue, 24 May 2022 11:00:59 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 09/12] staging: r8188eu: use mgmt to set the timeout
Date:   Tue, 24 May 2022 11:00:26 +0200
Message-Id: <20220524090029.242584-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220524090029.242584-1-martin@kaiser.cx>
References: <20220521153824.218196-1-martin@kaiser.cx>
 <20220524090029.242584-1-martin@kaiser.cx>
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

Use the mgmt structure in issue_action_BA to set the timeout in the
outgoing frame.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ce6327dbc534..da0c0363eb4d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5368,7 +5368,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	u16 start_seq;
 	u16 BA_para_set;
 	u16 reason_code;
-	u16 BA_timeout_value;
 	__le16	le_tmp;
 	u16 BA_starting_seqctrl = 0;
 	struct xmit_frame *pmgntframe;
@@ -5424,9 +5423,8 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 		le_tmp = cpu_to_le16(BA_para_set);
 		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
 
-		BA_timeout_value = 5000;/*  5ms */
-		le_tmp = cpu_to_le16(BA_timeout_value);
-		pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)&le_tmp, &pattrib->pktlen);
+		mgmt->u.action.u.addba_req.timeout = cpu_to_le16(5000); /* 5 ms */
+		pattrib->pktlen += 2;
 
 		psta = rtw_get_stainfo(pstapriv, raddr);
 		if (psta) {
-- 
2.30.2

