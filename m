Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991B34CE67A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiCESzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiCESy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 13:54:57 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB71D451C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 10:54:07 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQZXX-00016k-4k; Sat, 05 Mar 2022 19:54:03 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/6] staging: r8188eu: make rtl8188e_process_phy_info static
Date:   Sat,  5 Mar 2022 19:53:49 +0100
Message-Id: <20220305185351.1409232-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220305185351.1409232-1-martin@kaiser.cx>
References: <20220305185351.1409232-1-martin@kaiser.cx>
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

rtl8188e_process_phy_info is used only in rtl8188e_rxdesc.c. Make the
function static and remove its prototype from rtl8188e_recv.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c   | 2 +-
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index 387af789797d..9bf7a9248026 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -45,7 +45,7 @@ static void process_link_qual(struct adapter *padapter, struct recv_frame *prfra
 	signal_stat->avg_val = signal_stat->total_val / signal_stat->total_num;
 }
 
-void rtl8188e_process_phy_info(struct adapter *padapter, void *prframe)
+static void rtl8188e_process_phy_info(struct adapter *padapter, void *prframe)
 {
 	struct recv_frame *precvframe = (struct recv_frame *)prframe;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index 8d06815d0374..b752c5c06309 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -36,7 +36,6 @@ enum rx_packet_type {
 s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
 void rtl8188eu_free_recv_priv(struct adapter * padapter);
 void rtl8188eu_recv_tasklet(unsigned long priv);
-void rtl8188e_process_phy_info(struct adapter * padapter, void *prframe);
 void update_recvframe_phyinfo_88e(struct recv_frame *fra, struct phy_stat *phy);
 void update_recvframe_attrib_88e(struct recv_frame *fra, struct recv_stat *stat);
 
-- 
2.30.2

