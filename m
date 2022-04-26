Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DA850FA06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbiDZKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiDZKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:17:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639BF83B2C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:41:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y38so1733594pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1jOH8rAGyNAfrVKutMKwb0QCsVCCxKT/dVNbhlwht0k=;
        b=Ek72Yl6tIpqA1Fs2+GFRgaQs/2NH3RexVJ6XT8LGU1K9T2HgxCxgkIJd9e3OJyiDBC
         5hBSrFUxUD51pu6oGsxjdQ8bL5mWXqgYSRhlZRuQyoEeW55IQC4g0Pqghy/uVVv3lJLJ
         QgptL4RrcOoY73ItHLHy/1SgUYKkmszKYUCe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1jOH8rAGyNAfrVKutMKwb0QCsVCCxKT/dVNbhlwht0k=;
        b=Nfr293hf2dSofqnTvu7PGZyknbi7GqKbFu11/BacLUM6meFqw+r/UcGxX2ZBHwsTzd
         OBD+T72s03izOeJe9mKy3R1+POLl90V+jwon4KZ66CaeHMmNIM965RInhx7Z4LTHHVof
         0z97gxsutyR5VSErzF43la9ecRV9jUaQ6whsvURpuCjK+rN4I0Wfzwhj7JTiXA6y4il0
         g67wUzBcTjVSuRXg6nK5jq3HhB86zoTp4Bm4EQANMv7dXNc0cxCli3KzJkV5KggQsVwf
         j6zS3HO5LlGuzwBKWqK3IGYR1ZiFfkJl7R6zSekJT57f22GGHVE7tqSnAl75y1YSLMXq
         pU0g==
X-Gm-Message-State: AOAM530SFQr7ehdo6AlrhMXu/uFWgv6SVqhov9SbhfnFvqK2yl85dg/M
        +OmOFqM71v3St6ouZmT4NijdzA==
X-Google-Smtp-Source: ABdhPJxOZtau5W7MdbpmUhec9B1zfXcdNRcZ0cGxGRDb7pmzc+b6ZvmOrf9+o2UFy6sF4GbX2WaaBA==
X-Received: by 2002:a65:6751:0:b0:3aa:1a59:49f7 with SMTP id c17-20020a656751000000b003aa1a5949f7mr18988384pgu.35.1650966079847;
        Tue, 26 Apr 2022 02:41:19 -0700 (PDT)
Received: from saltlake.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.gmail.com with ESMTPSA id n92-20020a17090a5ae500b001d93118827asm2274502pji.57.2022.04.26.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:41:19 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     sdeodhar@marvell.com, aeasi@marvell.com,
        Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        stable@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrew Vasquez <andrew.vasquez@qlogic.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xx: Fix double free in qla2x00_probe_one()
Date:   Tue, 26 Apr 2022 09:40:30 +0000
Message-Id: <20220426094031.750135-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qla2x00_probe_one() -> qla2x00_mem_alloc(), fields in variable ha
is allocated and initialized. Fields ha->loop_id_map and ha->npiv_info
are also allocated in this function, but are freed when the function
encounters an error. Function qla2x00_probe_one() then calls
qla2x00_mem_free() to handle the error, which frees the corresponding
fields again. This results in double free of ha->loop_id_map and ha->
npiv_info, since the fields are not NULLed after freed the first time.

Fix this by storing NULL to the corresponding fields inside
qla2x00_mem_alloc() error handlers.

Fixes: e4e3a2ce9556 ("scsi: qla2xxx: Add ability to autodetect SFP type")
Fixes: b64b0e8fd964 ("[SCSI] qla2xxx: Pass in optional extended-initialization control block.")
Cc: stable@vger.kernel.org
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 762229d495a8..a0b40578dbc8 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4396,6 +4396,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	    ha->sfp_data, ha->sfp_data_dma);
 fail_sfp_data:
 	kfree(ha->loop_id_map);
+	ha->loop_id_map = NULL;
 fail_loop_id_map:
 	dma_pool_free(ha->s_dma_pool, ha->async_pd, ha->async_pd_dma);
 fail_async_pd:
@@ -4404,6 +4405,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	dma_pool_free(ha->s_dma_pool, ha->ex_init_cb, ha->ex_init_cb_dma);
 fail_ex_init_cb:
 	kfree(ha->npiv_info);
+	ha->npiv_info = NULL;
 fail_npiv_info:
 	dma_free_coherent(&ha->pdev->dev, ((*rsp)->length + 1) *
 		sizeof(response_t), (*rsp)->ring, (*rsp)->dma);
-- 
2.25.1

