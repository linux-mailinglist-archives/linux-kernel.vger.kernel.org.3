Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1056CEF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGJMNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGJMNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:13:18 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E313D74
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:13:17 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AVoHoPKXWP8ApAVoHoYufd; Sun, 10 Jul 2022 14:13:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 10 Jul 2022 14:13:15 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 3/3] crypto: marvell/octeontx: Avoid some useless memory initialization
Date:   Sun, 10 Jul 2022 14:13:11 +0200
Message-Id: <4bf1a510b8c21297ac3261c2b291b1833dc7ac5c.1657455082.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <eb4dc7930c66b659718555edcf7fc1bbea6f5298.1657455082.git.christophe.jaillet@wanadoo.fr>
References: <eb4dc7930c66b659718555edcf7fc1bbea6f5298.1657455082.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cpt_detach_and_disable_cores(), 'bmap' is initialized just a few lines
below, so there is no need to initialize it when it is declared.

In eng_grp_update_masks(), 'tmp_bmap' is zero'ed at each iteration in the
first 'for' loop.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index 407e1a3ae841..45d1c9902cf5 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -204,7 +204,7 @@ static int cpt_detach_and_disable_cores(struct otx_cpt_eng_grp_info *eng_grp,
 					void *obj)
 {
 	struct otx_cpt_device *cpt = (struct otx_cpt_device *) obj;
-	struct otx_cpt_bitmap bmap = { {0} };
+	struct otx_cpt_bitmap bmap;
 	int timeout = 10;
 	int i, busy;
 	u64 reg;
@@ -1056,7 +1056,7 @@ static int eng_grp_update_masks(struct device *dev,
 				struct otx_cpt_eng_grp_info *eng_grp)
 {
 	struct otx_cpt_engs_rsvd *engs, *mirrored_engs;
-	struct otx_cpt_bitmap tmp_bmap = { {0} };
+	struct otx_cpt_bitmap tmp_bmap;
 	int i, j, cnt, max_cnt;
 	int bit;
 
-- 
2.34.1

