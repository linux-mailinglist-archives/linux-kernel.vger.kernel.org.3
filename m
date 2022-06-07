Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90594540164
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiFGOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbiFGOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:30:44 -0400
Received: from smtp.ruc.edu.cn (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F5FCE5C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:30:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp.ruc.edu.cn (Hmail) with ESMTPSA id C45008009E;
        Tue,  7 Jun 2022 22:30:40 +0800 (CST)
From:   Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Varun Prakash <varun@chelsio.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cxgbit_target: Reject immediate data underflow larger than SCSI transfer length
Date:   Tue,  7 Jun 2022 22:30:35 +0800
Message-Id: <20220607143035.29541-1-xiaohuizhang@ruc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIZGU9WQhgaTkhNS0weSx
        1CVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDY6Mzo4ED0rKRcfEU5JSw0a
        SgwaCi5VSlVKTU5PTUpJSU9KT0pIVTMWGhIXVQMSGhQTDhIBExoVHDsJDhhVHh8OVRgVRVlXWRIL
        WUFZSUtJVUpKSVVKSkhVSUpJWVdZCAFZQUlPQ0s3Bg++
X-HM-Tid: 0a813e932aaa2c20kusnc45008009e
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the handling of iscsit_get_immediate_data in commit abb85a9b512e
("iscsi-target: Reject immediate data underflow larger than SCSI transfer length"),
we thought a patch might be needed here as well.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
---
 drivers/target/iscsi/cxgbit/cxgbit_target.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_target.c b/drivers/target/iscsi/cxgbit/cxgbit_target.c
index acfc39683c87..800bec4b1e88 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
@@ -920,6 +920,18 @@ cxgbit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 	 */
 	if (dump_payload)
 		goto after_immediate_data;
+	/*
+	 * Check for underflow case where both EDTL and immediate data payload
+	 * exceeds what is presented by CDB's TRANSFER LENGTH, and what has
+	 * already been set in target_cmd_size_check() as se_cmd->data_length.
+	 *
+	 * For this special case, fail the command and dump the immediate data
+	 * payload.
+	 */
+	if (cmd->first_burst_len > cmd->se_cmd.data_length) {
+		cmd->sense_reason = TCM_INVALID_CDB_FIELD;
+		goto after_immediate_data;
+	}
 
 	immed_ret = cxgbit_handle_immediate_data(cmd, hdr,
 						 cmd->first_burst_len);
-- 
2.17.1

