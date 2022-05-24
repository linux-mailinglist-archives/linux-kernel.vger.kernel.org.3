Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529755325EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiEXJBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiEXJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:01:05 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52200B47
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:01:02 -0700 (PDT)
Received: from 162.sub194.ddfr.nl ([83.136.194.162] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ntQPQ-0006Y3-W9; Tue, 24 May 2022 11:00:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 05/12] staging: r8188eu: use mgmt to set the sequence number
Date:   Tue, 24 May 2022 11:00:22 +0200
Message-Id: <20220524090029.242584-6-martin@kaiser.cx>
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

Use the mgmt structure in issue_action_BA to set the sequence number of
the outgoing frame.

pwlanhdr is now unused, it can be removed.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- remove pwlanhdr, it's not used any more

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f08521cb1ff7..e64f2a0ec626 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5375,7 +5375,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct xmit_frame *pmgntframe;
 	struct pkt_attrib *pattrib;
 	u8 *pframe;
-	struct ieee80211_hdr *pwlanhdr;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
@@ -5395,7 +5394,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	memset(pmgntframe->buf_addr, 0, WLANHDR_OFFSET + TXDESC_OFFSET);
 
 	pframe = (u8 *)(pmgntframe->buf_addr) + TXDESC_OFFSET;
-	pwlanhdr = (struct ieee80211_hdr *)pframe;
 	mgmt = (struct ieee80211_mgmt *)pframe;
 
 	mgmt->frame_control = cpu_to_le16(IEEE80211_STYPE_ACTION | IEEE80211_FTYPE_MGMT);
@@ -5404,7 +5402,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	memcpy(mgmt->sa, myid(&padapter->eeprompriv), ETH_ALEN);
 	memcpy(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN);
 
-	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
+	mgmt->seq_ctrl = cpu_to_le16(pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
-- 
2.30.2

