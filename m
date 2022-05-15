Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84306527890
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiEOPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiEOPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:54:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE0512D1B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:54:13 -0700 (PDT)
Received: from dslb-188-096-141-066.188.096.pools.vodafone-ip.de ([188.96.141.66] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nqGZO-0006NT-6Q; Sun, 15 May 2022 17:54:10 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/5] staging: r8188eu: last_rx_mgnt_pkts is set but not used
Date:   Sun, 15 May 2022 17:54:00 +0200
Message-Id: <20220515155401.352742-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220515155401.352742-1-martin@kaiser.cx>
References: <20220515155401.352742-1-martin@kaiser.cx>
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

last_rx_mgnt_pkts in struct stainfo_stats is set but not used.
Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/sta_info.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index b7e6b1f319a2..4112c837bcef 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -48,7 +48,6 @@ struct	stainfo_stats	{
 	u64 rx_ctrl_pkts;
 	u64 rx_data_pkts;
 
-	u64	last_rx_mgnt_pkts;
 	u64 last_rx_beacon_pkts;
 	u64 last_rx_probereq_pkts;
 	u64 last_rx_probersp_pkts;
@@ -230,7 +229,6 @@ struct sta_info {
 
 #define sta_update_last_rx_pkts(sta) \
 do { \
-	sta->sta_stats.last_rx_mgnt_pkts = sta->sta_stats.rx_mgnt_pkts; \
 	sta->sta_stats.last_rx_beacon_pkts = sta->sta_stats.rx_beacon_pkts; \
 	sta->sta_stats.last_rx_probereq_pkts = sta->sta_stats.rx_probereq_pkts; \
 	sta->sta_stats.last_rx_probersp_pkts = sta->sta_stats.rx_probersp_pkts; \
-- 
2.30.2

