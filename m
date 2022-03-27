Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE54E8940
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiC0SLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiC0SLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:11:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59EA38183
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:10:01 -0700 (PDT)
Received: from dslb-178-004-173-219.178.004.pools.vodafone-ip.de ([178.4.173.219] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nYXKv-00019B-7Q; Sun, 27 Mar 2022 20:09:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/9] staging: r8188eu: use ieee80211 define for version check
Date:   Sun, 27 Mar 2022 20:09:36 +0200
Message-Id: <20220327180944.712545-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220327180944.712545-1-martin@kaiser.cx>
References: <20220323074859.177425-1-martin@kaiser.cx>
 <20220327180944.712545-1-martin@kaiser.cx>
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

Use the IEEE80211_FCTL_VERS define to check the version number
of a received frame.

Covert IEEE80211_FCTL_VERS to le16 before using it as a mask for fc,
which is also an le16 value. The ieee80211_... helper functions use
the same approach.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2
 - fix a sparse warning, conver IEEE80211_FCTL_VERS to little endian

 drivers/staging/r8188eu/core/rtw_recv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 8800ea4825ff..fc7f2a559f9b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1063,7 +1063,6 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	u8 *ptr = precv_frame->rx_data;
 	__le16 fc = *(__le16 *)ptr;
-	u8  ver = (unsigned char)(*ptr) & 0x3;
 	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
@@ -1072,8 +1071,7 @@ static int validate_recv_frame(struct adapter *adapter, struct recv_frame *precv
 			pmlmeext->channel_set[ch_set_idx].rx_count++;
 	}
 
-	/* add version chk */
-	if (ver != 0)
+	if ((fc & cpu_to_le16(IEEE80211_FCTL_VERS)) != 0)
 		return _FAIL;
 
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
-- 
2.30.2

