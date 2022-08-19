Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260A65994FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbiHSGJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346586AbiHSGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5343205E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w19so6977111ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uyVgJ1+wrRmHQHbLzZkCEtfs58onJoTrNiUjQMfsElE=;
        b=f3ub8wfqCgXsggOvDWD7YThPKgrQeLezsFWKD7JNkZ3NYPkF/zkY4vAH0PC9ooLlIV
         +Nv1wNrwX1TEdf41/OZ/mYc8ZPAfjLOmXHiHS22B3UipI/WfElbUy1GnqWk3JdF+3hJM
         oLtLucbIjIWaN8g/0t2pnie/9fSrHb2rwZpOKu6ZUrzAzXVB53r3P90TgPASNXySSi4n
         KlAopEV24PQb4LwVa4zKwjDb3ZocplL2VhymDCdnMaM/v1H9z3eYuOiuG4ia3J5MvJoT
         3FUe9jAWCUd/iR5ECx8ub0totX2Yz6yfEu/5Ykvho2wkFU+TQ0OtUeAYX10G7QUfheH1
         gNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uyVgJ1+wrRmHQHbLzZkCEtfs58onJoTrNiUjQMfsElE=;
        b=PVB0UjRCSGCb4Aeu/Eh1xui4GFtwS2+Wi/UMsXKoYWzHIS82ciWfwRRzFZZSUj39Qc
         vEDsBwvzkPAzDKuY8I4D0QNiO4qFqozPaJf6RrFMHxQijaHiWzM2R9k81+TPe7Kv5umg
         ll+mjJgATwZqniXgyKcyhMrLbXgW8be6QBjinHzEYEo5b2thsk+i/TnCSTM4zwtpKrc2
         HeUb6ntC93iIFjZZMUms1Rf3gIHGtG9CMRJEgAKS1deH1XBsWexInKx9Xfn7uUzacNMH
         eeGiaGbIt1vhn0h+xOtxRQZDFIijVwEmeWLIEnsJIEg7zJOdmMFOexuNDZ8MZNAwyOZD
         +Ipg==
X-Gm-Message-State: ACgBeo3oOVRiJR+msCBt1FH3Bkxn0hMfZuS2/LfwXDxnw0zG1jHZxYrM
        h6Bj/oPPgSPk9Q/26cs+fdS6YYLO5puiOuat
X-Google-Smtp-Source: AA6agR4Gf40tIGiWcPwKD63vJim8JzCFckhdiFEXDhfFVJm+iVYsHTK6yhdRYuWPjreL/3DreBK2xg==
X-Received: by 2002:a17:907:a0c7:b0:734:e049:1af6 with SMTP id hw7-20020a170907a0c700b00734e0491af6mr3787864ejc.439.1660889304810;
        Thu, 18 Aug 2022 23:08:24 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:24 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:56 +0200
Message-Id: <20220819060801.10443-15-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ib_dma_map_sg return 0 on error.

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..d70bccbcba3e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1551,7 +1551,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
 			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	if (unlikely(!*count)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
@@ -1574,7 +1574,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 					  req->metadata_sgl->sg_table.sgl,
 					  req->metadata_sgl->nents,
 					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		if (unlikely(!*pi_count)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
-- 
2.34.1

