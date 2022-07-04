Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24405655D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiGDMsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiGDMsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:48:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC785E0E9;
        Mon,  4 Jul 2022 05:48:00 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lc5BR5jwNzhZ2q;
        Mon,  4 Jul 2022 20:45:35 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 20:47:58 +0800
From:   Zhang Zekun <zhangzekun11@huawei.com>
To:     <Larry.Finger@lwfinger.net>, <phil@philpotter.co.uk>,
        <paskripkin@gmail.com>, <gregkh@linuxfoundation.org>,
        <martin@kaiser.cx>, <straube.linux@gmail.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <xuqiang36@huawei.com>
Subject: [PATCH -next] staging: r8188eu: use 'is_zero_ether_addr' to identify an empty address
Date:   Mon, 4 Jul 2022 12:45:53 +0000
Message-ID: <20220704124553.101792-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'is_zero_ether_addr' to identify an empty ethernet address, intead
of using 'memcpy' directly.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index cce0575e93b7..365f5b2786cf 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3513,7 +3513,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	u32	p2p_ielen;
 	struct	wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8	result = P2P_STATUS_SUCCESS;
-	u8	empty_addr[ETH_ALEN] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
@@ -3551,7 +3550,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 
 		/*	Commented by Kurt 20120113 */
 		/*	Get peer_dev_addr here if peer doesn't issue prov_disc frame. */
-		if (!memcmp(pwdinfo->rx_prov_disc_info.peerDevAddr, empty_addr, ETH_ALEN))
+		if (is_zero_ether_addr(pwdinfo->rx_prov_disc_info.peerDevAddr))
 			memcpy(pwdinfo->rx_prov_disc_info.peerDevAddr, GetAddr2Ptr(pframe), ETH_ALEN);
 
 		result = process_p2p_group_negotation_req(pwdinfo, frame_body, len);
-- 
2.17.1

