Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B1146C9D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhLHBXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhLHBXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:23:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADCC061574;
        Tue,  7 Dec 2021 17:19:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D53D3B81F30;
        Wed,  8 Dec 2021 01:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA23C341C5;
        Wed,  8 Dec 2021 01:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638926369;
        bh=GdmKyLXfUHMiqCkt1zrvcCOc1McinA0NXGV2XO0Nl7w=;
        h=Date:From:To:Cc:Subject:From;
        b=cjUFUbYHJ7e3bSLdckmjJTQZibPJAVAQp0HjYHYo6lttBsCM2dZ2f7RXd0Zsgm3rx
         cn6ApzyzApjSvAszk7AUQCEfqp/a+/hdpIWGV6BtGmQOzCtmOQuNSSsRoYmNl8jsAz
         KAhqo1Bt8zUHBoukGKFzJU9eEbT0VqN0yj9yK54XkLXfWaLs+rWt2HTJjKIm9p1OIs
         wGwyscxxKcSyFVTymUAYobHElbtfpWhr/EnTeNqoNC0L1j2bUmL3Wc63nilrdn64Ro
         bNPDq2POTCfl8TMraEb3W9QQGaxGW2R/8XEMYAozKgdwB+Ts9ClWJd4TU/ADrAGh+f
         zv3PQDIXSTr9g==
Date:   Tue, 7 Dec 2021 19:24:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     George Cherian <gcherian@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] crypto: cavium - Use kcalloc() instead of kzalloc()
Message-ID: <20211208012459.GA145349@embeddedor>
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
 drivers/crypto/cavium/cpt/cptvf_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_main.c b/drivers/crypto/cavium/cpt/cptvf_main.c
index 112b12a32542..c246920e6f54 100644
--- a/drivers/crypto/cavium/cpt/cptvf_main.c
+++ b/drivers/crypto/cavium/cpt/cptvf_main.c
@@ -104,17 +104,14 @@ static int alloc_pending_queues(struct pending_qinfo *pqinfo, u32 qlen,
 				u32 nr_queues)
 {
 	u32 i;
-	size_t size;
 	int ret;
 	struct pending_queue *queue = NULL;
 
 	pqinfo->nr_queues = nr_queues;
 	pqinfo->qlen = qlen;
 
-	size = (qlen * sizeof(struct pending_entry));
-
 	for_each_pending_queue(pqinfo, queue, i) {
-		queue->head = kzalloc((size), GFP_KERNEL);
+		queue->head = kcalloc(qlen, sizeof(*queue->head), GFP_KERNEL);
 		if (!queue->head) {
 			ret = -ENOMEM;
 			goto pending_qfail;
-- 
2.27.0

