Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0AB4CE54E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiCEOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiCEOmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:42:31 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD06929A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:41:42 -0800 (PST)
Received: from dslb-084-059-247-134.084.059.pools.vodafone-ip.de ([84.59.247.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nQVbG-0007ms-Fk; Sat, 05 Mar 2022 15:41:38 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: don't initialize drvinfo_sz to 0
Date:   Sat,  5 Mar 2022 15:41:15 +0100
Message-Id: <20220305144117.1380534-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220305144117.1380534-1-martin@kaiser.cx>
References: <20220305144117.1380534-1-martin@kaiser.cx>
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

In update_recvframe_attrib_88e, there's an initial memset which sets
all of pattrib to 0. There's no need to set pattrib->drvinfo_sz = 0
again later.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
index aee6b8c23811..6b83d7e80ad9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -91,10 +91,8 @@ void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat
 		pattrib->shift_sz = (u8)((le32_to_cpu(prxstat->rxdw0) >> 24) & 0x3);
 	} else if (pattrib->pkt_rpt_type == TX_REPORT1) { /* CCX */
 		pattrib->pkt_len = TX_RPT1_PKT_LEN;
-		pattrib->drvinfo_sz = 0;
 	} else if (pattrib->pkt_rpt_type == TX_REPORT2) { /*  TX RPT */
 		pattrib->pkt_len = (u16)(le32_to_cpu(prxstat->rxdw0) & 0x3FF);/* Rx length[9:0] */
-		pattrib->drvinfo_sz = 0;
 
 		/*  */
 		/*  Get TX report MAC ID valid. */
-- 
2.30.2

