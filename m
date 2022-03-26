Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950F4E81E3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiCZQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiCZQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 12:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C6CE46B10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648310597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bry4AKMS/vevGStNrgObkjRlJ6h49H/diQKhGrm6CHM=;
        b=dXK4rSZTD4qBWtDudidVrq1TofDjcAS5r6cxJ1sevJQ2U/VlswHlTSeZDgSqhEkr4nrlu+
        nrnRKPv0LaXCiaCSrLokT0jbtNXoKB1SbQ0saCjg7k75gCoSgAU+l8Bw71f7bMCKd/TN5L
        djVn7S8uFcn9++ZjAJqH6+oPlYdVSSw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-HACD7b9NNRiV7n-fkAnjbA-1; Sat, 26 Mar 2022 12:03:15 -0400
X-MC-Unique: HACD7b9NNRiV7n-fkAnjbA-1
Received: by mail-qt1-f198.google.com with SMTP id z18-20020ac84552000000b002e201c79cd4so8309890qtn.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 09:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bry4AKMS/vevGStNrgObkjRlJ6h49H/diQKhGrm6CHM=;
        b=tqw6V0UkFJywRIjOzpCn7zayFDK0CUJXV0NvJcurH/uyRmeMDKKYh7EnjC3CjeNhQk
         KG75koXrBWemTZ6Tdxbm2AiEELS+wtUPz9pXjWPXrhZSSfvOB1O+8Vb8D3Ba6YaSgup8
         V41nJl/13o+2p3zjNwPPPtZLJOSY8H3NGMqc8W21swum6aqF9QDydnZvVI+a2VSFsdt2
         UqKPa4vt/FtbUu3TvKzYIpe6mgF7RE6BL5/wFjzSg4F1J7x9zq2s2bplGThWO8yFBIp1
         MtvevowqwZFOtmTHA7wnu5PdHB4kGgVxkLy1eI97R7s9qwm2GaVGJhUN2mpi4PreSJN6
         tLkg==
X-Gm-Message-State: AOAM530KT1itS+oB+2W6bGzj6Pgg4kQes1KyXpHmMXlIjg8PpK2azrds
        ZU/MZi0bJfKZxDZGHDd4tTESh2xZOLUKbez+iNlvGuX/thMkcBrk73Zr1zm6hlhneXdbQdQy5Vc
        Mu+j8aqXmHArdDkBTgE1f3qhM
X-Received: by 2002:a05:622a:54f:b0:2e1:cc45:312a with SMTP id m15-20020a05622a054f00b002e1cc45312amr14704601qtx.435.1648310595348;
        Sat, 26 Mar 2022 09:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6fronfcMnuSXyF+/ES2DFJZAdcP9f7lNHvdhha7BUhvMBoQroYbjy5RKRi0G+aIYV6wEqOA==
X-Received: by 2002:a05:622a:54f:b0:2e1:cc45:312a with SMTP id m15-20020a05622a054f00b002e1cc45312amr14704574qtx.435.1648310595081;
        Sat, 26 Mar 2022 09:03:15 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm8590906qta.52.2022.03.26.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 09:03:14 -0700 (PDT)
From:   trix@redhat.com
To:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        Sunil.Goutham@marvell.com, naveenm@marvell.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] octeontx2-af: initialize action variable
Date:   Sat, 26 Mar 2022 09:03:06 -0700
Message-Id: <20220326160306.2900822-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative issue
rvu_npc.c:898:15: warning: Assigned value is garbage
  or undefined
  req.match_id = action.match_id;
               ^ ~~~~~~~~~~~~~~~

The initial setting of action is conditional on
 if (is_mcam_entry_enabled(...))
The later check of action.op will sometimes be garbage.
So initialize action.

Reduce setting of
  *(u64 *)&action = 0x00;
to
  *(u64 *)&action = 0;

Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c   | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 91f86d77cd41b..3a31fb8cc1554 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -605,7 +605,7 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	struct npc_install_flow_req req = { 0 };
 	struct npc_install_flow_rsp rsp = { 0 };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	struct nix_rx_action action;
+	struct nix_rx_action action = { 0 };
 	int blkaddr, index;
 
 	/* AF's and SDP VFs work in promiscuous mode */
@@ -626,7 +626,6 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
 						      blkaddr, index);
 	} else {
-		*(u64 *)&action = 0x00;
 		action.op = NIX_RX_ACTIONOP_UCAST;
 		action.pf_func = pcifunc;
 	}
@@ -657,7 +656,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int blkaddr, ucast_idx, index;
-	struct nix_rx_action action;
+	struct nix_rx_action action = { 0 };
 	u64 relaxed_mask;
 
 	if (!hw->cap.nix_rx_multicast && is_cgx_vf(rvu, pcifunc))
@@ -685,14 +684,14 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 						      blkaddr, ucast_idx);
 
 	if (action.op != NIX_RX_ACTIONOP_RSS) {
-		*(u64 *)&action = 0x00;
+		*(u64 *)&action = 0;
 		action.op = NIX_RX_ACTIONOP_UCAST;
 	}
 
 	/* RX_ACTION set to MCAST for CGX PF's */
 	if (hw->cap.nix_rx_multicast && pfvf->use_mce_list &&
 	    is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc))) {
-		*(u64 *)&action = 0x00;
+		*(u64 *)&action = 0;
 		action.op = NIX_RX_ACTIONOP_MCAST;
 		pfvf = rvu_get_pfvf(rvu, pcifunc & ~RVU_PFVF_FUNC_MASK);
 		action.index = pfvf->promisc_mce_idx;
@@ -832,7 +831,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	struct rvu_hwinfo *hw = rvu->hw;
 	int blkaddr, ucast_idx, index;
 	u8 mac_addr[ETH_ALEN] = { 0 };
-	struct nix_rx_action action;
+	struct nix_rx_action action = { 0 };
 	struct rvu_pfvf *pfvf;
 	u16 vf_func;
 
@@ -861,14 +860,14 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 							blkaddr, ucast_idx);
 
 	if (action.op != NIX_RX_ACTIONOP_RSS) {
-		*(u64 *)&action = 0x00;
+		*(u64 *)&action = 0;
 		action.op = NIX_RX_ACTIONOP_UCAST;
 		action.pf_func = pcifunc;
 	}
 
 	/* RX_ACTION set to MCAST for CGX PF's */
 	if (hw->cap.nix_rx_multicast && pfvf->use_mce_list) {
-		*(u64 *)&action = 0x00;
+		*(u64 *)&action = 0;
 		action.op = NIX_RX_ACTIONOP_MCAST;
 		action.index = pfvf->mcast_mce_idx;
 	}
-- 
2.26.3

