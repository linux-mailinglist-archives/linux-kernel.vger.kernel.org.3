Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9F4BEED0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiBUXlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:41:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiBUXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:41:19 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 15:40:54 PST
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B3D240AB;
        Mon, 21 Feb 2022 15:40:54 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 980FA2B00246;
        Mon, 21 Feb 2022 18:23:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 18:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6imnI/
        zZbKqPNPFvmFE1m1mDE+tzBp4CGoapLd8H0Ak=; b=W+yvzUKn52dBRw5CTupp+s
        3uwzSYWym16KC79u5k+NqGaMbHsDHdVPlD4jfo62XpMF8D5dv8my0/9e/dD+NO8q
        LZBA+O4LdG6Mw89BDX5v3xemwvUtqQfeB7CT64EfZ15RZGwB3CLmVPBjAk8lzN4M
        UuqX9GPrJK34sKTY8tZkfOiDRf5tixR4H4s1uMAyzJRmJLpJCdQOKBLzaAlfBzDl
        LTJGq/YthJTTrjSCS8mh6ODmoRDvWWie5lBIs5A0YUU+51NES5PRNfuJVmqJHV+i
        UMZ6KxVY3B5+eBekg3NTD01+5XAaCjtUHajQ7sAGba+S1CkPsYYe1Y7Ce8wxMadA
        ==
X-ME-Sender: <xms:Cx8UYvUd-W_L-eTOsTw7rRrIpsYI_epJfTdEhYWgfoWYKMoiepjYjQ>
    <xme:Cx8UYnn7zdmfLXNExOI3izRT75o35cIoh3EcliWpBZWsWIoLlkcK1zMUUlP6OdQCD
    BawtRXYbPrIagv4KXs>
X-ME-Received: <xmr:Cx8UYrYgj4XNy2nUgCSSeRYCMI94drQYCiV-CZovv1r7xRPlVk71T249DAw0CM4lenh963a2FRVLr8Fw9KblEqQuiPiH_kmPWy8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeejgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fhohhrsghiugguvghnjfgurhculdehtddtmdenucfjughrpefvkffhufffsedttdertddt
    tdenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmie
    ekkhdrohhrgheqnecuhfhorhgsihguuggvnhfjughrpefvkffhufffsedttdertddttddp
    vffkhffuffestddtredttddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:Cx8UYqXd_7UPZcBIOMK-HwxhagFIBuy5_riSp3wkmjnWxpGPh2_QPw>
    <xmx:Cx8UYplhcwUgzKrjVk61x6XiRM8K3jyJtsIbnCf89BnjgruDC_8mmg>
    <xmx:Cx8UYnegwiPHPPgH5IosyQCrj_GLvPTLIhLJZDFMruf8-viprhtrsA>
    <xmx:DB8UYpsY1f_Mj4DZz9MxC76ySrJ8w2Hfu4uxytN4EfG8zP7zen5iDEgjDPk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 18:23:53 -0500 (EST)
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <fbf930e64af5b15ca028dfe25b00fe933951f19b.1645484982.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] mesh: Stop using struct scsi_pointer
Date:   Tue, 22 Feb 2022 10:09:42 +1100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't use SCp.ptr to save a SCSI command data pointer
which means "scsi pointer" is a complete misnomer here. Only a few
members of struct scsi_pointer are used and the rest waste memory.
Avoid the "struct foo { struct bar; };" silliness.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/scsi/mesh.c | 19 +++++++++----------
 drivers/scsi/mesh.h | 10 +++++-----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index de9ae36def42..322d3ad38159 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -586,12 +586,12 @@ static void mesh_done(struct mesh_state *ms, int start_next)
 	ms->current_req = NULL;
 	tp->current_req = NULL;
 	if (cmd) {
-		struct scsi_pointer *scsi_pointer = mesh_scsi_pointer(cmd);
+		struct mesh_cmd_priv *mcmd = mesh_priv(cmd);
 
 		set_host_byte(cmd, ms->stat);
-		set_status_byte(cmd, scsi_pointer->Status);
+		set_status_byte(cmd, mcmd->status);
 		if (ms->stat == DID_OK)
-			scsi_msg_to_host_byte(cmd, scsi_pointer->Message);
+			scsi_msg_to_host_byte(cmd, mcmd->message);
 		if (DEBUG_TARGET(cmd)) {
 			printk(KERN_DEBUG "mesh_done: result = %x, data_ptr=%d, buflen=%d\n",
 			       cmd->result, ms->data_ptr, scsi_bufflen(cmd));
@@ -605,7 +605,7 @@ static void mesh_done(struct mesh_state *ms, int start_next)
 			}
 #endif
 		}
-		scsi_pointer->this_residual -= ms->data_ptr;
+		mcmd->this_residual -= ms->data_ptr;
 		scsi_done(cmd);
 	}
 	if (start_next) {
@@ -1173,7 +1173,7 @@ static void handle_msgin(struct mesh_state *ms)
 	if (ms->n_msgin < msgin_length(ms))
 		goto reject;
 	if (cmd)
-		mesh_scsi_pointer(cmd)->Message = code;
+		mesh_priv(cmd)->message = code;
 	switch (code) {
 	case COMMAND_COMPLETE:
 		break;
@@ -1264,7 +1264,7 @@ static void set_dma_cmds(struct mesh_state *ms, struct scsi_cmnd *cmd)
 	if (cmd) {
 		int nseg;
 
-		mesh_scsi_pointer(cmd)->this_residual = scsi_bufflen(cmd);
+		mesh_priv(cmd)->this_residual = scsi_bufflen(cmd);
 
 		nseg = scsi_dma_map(cmd);
 		BUG_ON(nseg < 0);
@@ -1594,13 +1594,12 @@ static void cmd_complete(struct mesh_state *ms)
 			break;
 		case statusing:
 			if (cmd) {
-				struct scsi_pointer *scsi_pointer =
-					mesh_scsi_pointer(cmd);
+				struct mesh_cmd_priv *mcmd = mesh_priv(cmd);
 
-				scsi_pointer->Status = mr->fifo;
+				mcmd->status = mr->fifo;
 				if (DEBUG_TARGET(cmd))
 					printk(KERN_DEBUG "mesh: status is %x\n",
-					       scsi_pointer->Status);
+					       mcmd->status);
 			}
 			ms->msgphase = msg_in;
 			break;
diff --git a/drivers/scsi/mesh.h b/drivers/scsi/mesh.h
index 1afa8b37295b..f70181acceac 100644
--- a/drivers/scsi/mesh.h
+++ b/drivers/scsi/mesh.h
@@ -9,14 +9,14 @@
 #define _MESH_H
 
 struct mesh_cmd_priv {
-	struct scsi_pointer scsi_pointer;
+	int this_residual;
+	int message;
+	int status;
 };
 
-static inline struct scsi_pointer *mesh_scsi_pointer(struct scsi_cmnd *cmd)
+static inline struct mesh_cmd_priv *mesh_priv(struct scsi_cmnd *cmd)
 {
-	struct mesh_cmd_priv *mcmd = scsi_cmd_priv(cmd);
-
-	return &mcmd->scsi_pointer;
+	return scsi_cmd_priv(cmd);
 }
 
 /*
-- 
2.32.0

