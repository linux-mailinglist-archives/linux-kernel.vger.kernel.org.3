Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41B46CC0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhLHEP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbhLHEPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:15:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800DC061574;
        Tue,  7 Dec 2021 20:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 347C1B81F5F;
        Wed,  8 Dec 2021 04:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B7EC00446;
        Wed,  8 Dec 2021 04:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638936710;
        bh=Jwh/IcVCIy1tBRw7SlT1zlgLiIm03nZ4YhwPblrnhX4=;
        h=Date:From:To:Cc:Subject:From;
        b=hrkypQYVkUVIQG8PPtX9a8kZexqGvFoZCejjHjhg/3+ogxHHgFbSaRQyfAMPSm8q3
         dOsvul+225Ew9iueO2ql8GoVShontjxq+A0Vvs3vZVOBxeUe5o780UJgMEDJfbF1j/
         rAgI2Q9DnswYULnAUYugv6MNnGNWi14rUseZqwxPLRXjR6GHV/saciwaJWSl4lwpu+
         mBzASdqUEetwOyrAKdamLuP3itQrgmgD2j7qnvZLQBtbMNSJJ6MPFnbJR/eCXRl0De
         EX6Z6YxjCEXSqoAhrSB+U2vmZFC3iOCKQMn3+o91bnTTFcVM3JrZaNN787+C3y3ZwB
         SLVGOnWKG/J+A==
Date:   Tue, 7 Dec 2021 22:17:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto: marvell/octeontx - Use kcalloc() instead of
 kzalloc()
Message-ID: <20211208041721.GA171099@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
index c076d0b3ad5f..b681bd2dc6ad 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -94,15 +94,13 @@ static int alloc_pending_queues(struct otx_cpt_pending_qinfo *pqinfo, u32 qlen,
 				u32 num_queues)
 {
 	struct otx_cpt_pending_queue *queue = NULL;
-	size_t size;
 	int ret;
 	u32 i;
 
 	pqinfo->num_queues = num_queues;
-	size = (qlen * sizeof(struct otx_cpt_pending_entry));
 
 	for_each_pending_queue(pqinfo, queue, i) {
-		queue->head = kzalloc((size), GFP_KERNEL);
+		queue->head = kcalloc(qlen, sizeof(*queue->head), GFP_KERNEL);
 		if (!queue->head) {
 			ret = -ENOMEM;
 			goto pending_qfail;
-- 
2.27.0

