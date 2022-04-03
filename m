Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEF4F0B40
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359423AbiDCQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbiDCQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:34:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE425E8A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:32:24 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb39E-0007x0-1N; Sun, 03 Apr 2022 18:32:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: remove constant variable
Date:   Sun,  3 Apr 2022 18:32:06 +0200
Message-Id: <20220403163206.357004-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403163206.357004-1-martin@kaiser.cx>
References: <20220403163206.357004-1-martin@kaiser.cx>
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

wifi_test_chk_rate is always 1. Remove the variable and the code to
check it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ca415d123cbf..2f85d3a545cd 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -478,7 +478,6 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 	u8 is_valid_p2p_probereq = false;
 
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-	u8 wifi_test_chk_rate = 1;
 
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE) &&
 	    !rtw_p2p_chk_state(pwdinfo, P2P_STATE_IDLE) &&
@@ -493,16 +492,14 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 		/*	Commented by Kurt 2012/10/16 */
 		/*	IOT issue: Google Nexus7 use 1M rate to send p2p_probe_req after GO nego completed and Nexus7 is client */
-		if (wifi_test_chk_rate == 1) {
-			is_valid_p2p_probereq = process_probe_req_p2p_ie(pwdinfo, pframe, len);
-			if (is_valid_p2p_probereq) {
-				if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_DEVICE)) {
-					/*  FIXME */
-					report_survey_event(padapter, precv_frame);
-					p2p_listen_state_process(padapter,  get_sa(pframe));
-
-					return _SUCCESS;
-				}
+		is_valid_p2p_probereq = process_probe_req_p2p_ie(pwdinfo, pframe, len);
+		if (is_valid_p2p_probereq) {
+			if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_DEVICE)) {
+				/*  FIXME */
+				report_survey_event(padapter, precv_frame);
+				p2p_listen_state_process(padapter,  get_sa(pframe));
+
+				return _SUCCESS;
 			}
 		}
 	}
-- 
2.30.2

