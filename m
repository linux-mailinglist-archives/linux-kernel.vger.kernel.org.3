Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B255767BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiGOTsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGOTsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:48:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40907C189
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657914494;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=P/BPGntKrlJzEPfvltLN0Erobid99m4v2m2RxQ2xveo=;
    b=S0mro0BHCuqvDBoy21k1GUKqwTk5dSdwtvSUBuUU+LttOD4sjv4YRTX5/EQgjh2psR
    aCDANAqjn5PGprXF3hd8mkaCz/lMI1z0S01RvCIX3qwKfLBD1i+ktAfmplVby2AhB8RK
    2x0ZeQYWxuxSFDH5rt+e33IwKtBP1iBNteCbotEKsGrlRHsh8aFN0GUFtGaP0g7YHQiE
    DXAjAnPdCb2xRf73XUNvCu+P8ja0ZdzcMGTxHYqW8enTkK5KJTs5byO6MFp3kH25x2+c
    u3yaDs3wQDlHzB2nNbxyR0aXQQ3qmeIs/AoZ0eP5IlHzO91wlSoMKi36xTjYPSyWx6jX
    ztKw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UzWvoOJrrSACWlJOqXdPodE67SDBKlmD1RX4Q=="
X-RZG-CLASS-ID: mo00
Received: from linux.speedport.ip
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id z88edfy6FJmEE5I
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 15 Jul 2022 21:48:14 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, beanhuo@micron.com
Subject: [PATCH] nvme: Use command_id instead of req->tag in trace_nvme_complete_rq()
Date:   Fri, 15 Jul 2022 21:48:04 +0200
Message-Id: <20220715194804.324158-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

use command_id instead of req->tag in trace_nvme_complete_rq(),
because of commit e7006de6c238 ("nvme: code command_id with a genctr
for use authentication after release"), cmd->common.command_id is set to
((genctl & 0xf)< 12 | req->tag), no longer req->tag, which makes cid in
trace_nvme_complete_rq and trace_nvme_setup_cmd are not the same.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..fe8c90080731 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -98,7 +98,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->qid = nvme_req_qid(req);
-		__entry->cid = req->tag;
+		__entry->cid = nvme_req(req)->cmd->common.command_id;
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
-- 
2.34.1

