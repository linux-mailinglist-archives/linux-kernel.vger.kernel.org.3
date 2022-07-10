Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC456CEEF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGJMNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGJMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:13:09 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC513D74
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:13:07 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AVo7odRUEYwJ7AVo7oWmtO; Sun, 10 Jul 2022 14:13:06 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 10 Jul 2022 14:13:06 +0200
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
Subject: [PATCH 2/3] crypto: marvell/octeontx: Use the bitmap API to allocate bitmaps
Date:   Sun, 10 Jul 2022 14:13:01 +0200
Message-Id: <8653848bcd6f309565a6f161a6f5bcc820073a7f.1657455082.git.christophe.jaillet@wanadoo.fr>
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

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index 40b482198ebc..407e1a3ae841 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -1598,7 +1598,7 @@ void otx_cpt_cleanup_eng_grps(struct pci_dev *pdev,
 	for (i = 0; i < OTX_CPT_MAX_ENGINE_GROUPS; i++) {
 		grp = &eng_grps->grp[i];
 		for (j = 0; j < OTX_CPT_MAX_ETYPES_PER_GRP; j++) {
-			kfree(grp->engs[j].bmap);
+			bitmap_free(grp->engs[j].bmap);
 			grp->engs[j].bmap = NULL;
 		}
 	}
@@ -1635,9 +1635,8 @@ int otx_cpt_init_eng_grps(struct pci_dev *pdev,
 		snprintf(grp->sysfs_info_name, OTX_CPT_UCODE_NAME_LENGTH,
 			 "engine_group%d", i);
 		for (j = 0; j < OTX_CPT_MAX_ETYPES_PER_GRP; j++) {
-			grp->engs[j].bmap =
-				kcalloc(BITS_TO_LONGS(eng_grps->engs_num),
-					sizeof(long), GFP_KERNEL);
+			grp->engs[j].bmap = bitmap_zalloc(eng_grps->engs_num,
+							  GFP_KERNEL);
 			if (!grp->engs[j].bmap) {
 				ret = -ENOMEM;
 				goto err;
-- 
2.34.1

