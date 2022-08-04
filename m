Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8466D58972C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiHDEvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiHDEvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:51:06 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E87186FC;
        Wed,  3 Aug 2022 21:51:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0B5C14C291E;
        Thu,  4 Aug 2022 04:51:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6A2314C28AC;
        Thu,  4 Aug 2022 04:51:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1659588661; a=rsa-sha256;
        cv=none;
        b=mN9g4jCb6G3ADvYLR35/ECaMIh/KFNkgDyA1cYJmazqBt6mVjLB73LJuFAFemBfDXEGNor
        nsK1f/4bHc1s5+LBF+qoXjR2+E6KpNngi29MMSn9WMmapa2FsGtGHil+40ZlMIbKuPOIuA
        nrdB0wpcdTzZIRGkaySljWMh80IkwxVPUl94QPSgNKzYv6wMVBvAU9rT0tniZHzS1TmT6w
        Ujib+DP89VNKQtVnGprnPdq4330HnwQABfh8ZGd5FRPQ5syLI9UatUJqpw6qdwQ3pYIfEe
        2o+leH498onpzQE5xc7h0V2hO0eKmYcG3xuxcKQ/wjQNWvBdYl4cALa6fONLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1659588661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WkIXfRdJ/sh0Jku0JWqijDrGOzpVL0okpB6JJxtZjac=;
        b=C2tNBrW4ivSM7Jv3d2gGDvhH9mM1SQ3I1g25DxhV6WfsWtibhGRNtOwgLWMwcZQewkxSDE
        mFvC/zaJnHlZQ1v0YSCSbKCziheHipM1PcnyXPQQrs/eAskLn2eerX84wghilJ692R22iY
        XHQidSt/GK9RwdkMj9RfQn8d42PjIFmuD1NcjzwU7hnGqB6M0F5W5ZY23fWPPC3Fy2pjts
        paNMXoKeKN08NIf+LPijCj/pKQuYKlPJY975XM9UJJis/WbQXzkzGUIwv0Pz15tyQWXiMP
        FK8A60gFvvoVUNavbTAWlpOacHx/YzXJh+gJw8vNckLjKk9yo0DjoxcwsCFJ0g==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-88fjl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Drop-Trail: 078ff1eb2f5ae21a_1659588661844_3695828368
X-MC-Loop-Signature: 1659588661844:2657074481
X-MC-Ingress-Time: 1659588661844
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.239 (trex/6.7.1);
        Thu, 04 Aug 2022 04:51:01 +0000
Received: from offworld.. (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4LyxBX47RXzGR;
        Wed,  3 Aug 2022 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1659588661;
        bh=WkIXfRdJ/sh0Jku0JWqijDrGOzpVL0okpB6JJxtZjac=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=laS1RtWcPki1FzfWTgvUV6UyWGCkpFmzcIzj51NIBC2HAJS/TKdtkOt4EfzKexNHU
         OW9ae3ROdJrGkiXGWxQyOn6LtHkIt3zJMXUUL0KllWYebDQmCa7C77WseoAekE5+2+
         YpT31vDgCVzFPJjO/0zjC+zNjf6LM3IX3+WhU3hJ9gvxMYIonE0ZRMVuTVO6ElXzgz
         W7qreh3Y+SwSUEntZ7N3nNR6sVbU1i5Rzc04V4VehAs93GBIB+sTZL3Lo8+qs5TJCR
         SjRDufNW3hirVhGVaajJmKSpmCDKsCn0OGEywBqPr5g+ugqaRTd1IR46nWTysrdlkN
         GWRz2Lfitio7g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, mcgrof@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cxl/mbox: Add background operation handling machinery
Date:   Wed,  3 Aug 2022 21:50:28 -0700
Message-Id: <20220804045029.2905056-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804045029.2905056-1-dave@stgolabs.net>
References: <20220804045029.2905056-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for handling background operations, as defined in
the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
can run asynchronously in the background, these are limited to:
transfer/activate firmware, scan media, sanitize (aka overwrite)
and VPPB bind/unbind.

Completion of background operations, successful or not, can be handled
via irq or poll based. This patch deals only with polling, which
introduces some complexities as we need to handle the window in which
the original background command completed, then a new one is
successfully started before the poller wakes up and checks. This,
in theory, can occur any amount of times. One of the problems is
that previous states cannot be tracked as hw background status
registers always deal with the last command.

So in order to keep hardware and the driver in sync, there can be
windows where the hardware is ready but the driver won't be, and
thus must serialize/handle it accordingly. While this polling cost
may not be ideal: 1) background commands are rare/limited and
2) the extra busy time should be small compared to the overall
command duration.

The implementation extends struct cxl_mem_command to become aware
of background-capable commands in a generic fashion and presents
some interfaces:

- Calls for bg operations, where each bg command can choose to implement
  whatever needed based on the nature of the operation. For example,
  while running, overwrite may only allow certain related commands to
  occur, while scan media does not have any such limitations.
  Delay times can also be different, for which ad-hoc hinting can
  be defined - for example, scan media could use some value based on
  GET_SCAN_MEDIA_CAPS and overwrite has predefined values based on
  pmem DSM specs[0]. Similarly some commands need to execute tasks
  once the command finishes, such as overwriting requires CPU flushing
  when successfully done. These are:

  cxl_mbox_bgcmd_conflicts()
  cxl_mbox_bgcmd_delay()
  cxl_mbox_bgcmd_post()

- cxl_mbox_send_cmd() is extended such that callers can distinguish,
  upon rc == 0, between completed and successfully started in the
  background.

- cxl_mbox_bgcmd_running() will atomically tell which command is
  running in the background, if any. This allows easy querying
  functionality. Similarly, there are cxl_mbox_bgcmd_start() and
  cxl_mbox_bgcmd_done() to safely mark the in-flight operation.
  While x86 serializes atomics, care must be taken with arm64, for
  example, ensuring, minimally, release/acquire semantics.

There are currently no supported commands.

[0] https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |   2 +-
 drivers/cxl/core/mbox.c | 199 ++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c |   9 +-
 drivers/cxl/cxl.h       |   8 ++
 drivers/cxl/cxlmem.h    |  62 ++++++++++++-
 drivers/cxl/pci.c       |   3 +-
 drivers/cxl/pmem.c      |   5 +-
 drivers/cxl/security.c  |  13 +--
 8 files changed, 274 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1a50c0fc399c..ffc625fdb795 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -19,7 +19,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
-void cxl_mbox_init(void);
+int cxl_mbox_init(void);
 void cxl_mbox_exit(void);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f162743e598d..db6e5a4d1f6d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -10,6 +10,7 @@
 #include "core.h"
 
 static bool cxl_raw_allow_all;
+static struct workqueue_struct *cxl_mbox_bgcmd_wq;
 
 /**
  * DOC: cxl mbox
@@ -24,7 +25,7 @@ static bool cxl_raw_allow_all;
 	for ((cmd) = &cxl_mem_commands[0];                                     \
 	     ((cmd) - cxl_mem_commands) < ARRAY_SIZE(cxl_mem_commands); (cmd)++)
 
-#define CXL_CMD(_id, sin, sout, _flags)                                        \
+#define __CXL_CMD(_id, sin, sout, _flags, _bgops)			       \
 	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
 	.info =	{                                                              \
 			.id = CXL_MEM_COMMAND_ID_##_id,                        \
@@ -33,8 +34,13 @@ static bool cxl_raw_allow_all;
 		},                                                             \
 	.opcode = CXL_MBOX_OP_##_id,                                           \
 	.flags = _flags,                                                       \
+	.bgops = _bgops,                                                      \
 	}
 
+#define CXL_CMD(_id, sin, sout, _flags) __CXL_CMD(_id, sin, sout, _flags, NULL)
+#define CXL_BGCMD(_id, sin, sout, _flags, _bgops)                              \
+	__CXL_CMD(_id, sin, sout, _flags | CXL_CMD_FLAG_BACKGROUND, _bgops)
+
 #define CXL_VARIABLE_PAYLOAD	~0U
 /*
  * This table defines the supported mailbox commands for the driver. This table
@@ -63,7 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
 	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
-	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
+	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
 	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
@@ -145,6 +151,130 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 	return cxl_command_names[c->info.id].name;
 }
 
+unsigned long cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
+{
+	struct cxl_mem_command *c;
+	unsigned long ret = 0;
+
+	cxl_for_each_cmd(c) {
+		if (!(c->flags & CXL_CMD_FLAG_BACKGROUND))
+			continue;
+		if (opcode != c->opcode)
+			continue;
+
+		if (c->bgops && c->bgops->delay)
+			ret = c->bgops->delay(cxlds);
+		break;
+	}
+	return ret * HZ;
+}
+
+void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
+			 u16 opcode, bool success)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_cmd(c) {
+		if (!(c->flags & CXL_CMD_FLAG_BACKGROUND))
+			continue;
+		if (opcode != c->opcode)
+			continue;
+
+		if (c->bgops && c->bgops->post)
+			c->bgops->post(cxlds, success);
+		break;
+	}
+}
+
+/*
+ * Ensure that ->mbox_send() can run safely when a background
+ * command is running. If so, returns zero, otherwise -EBUSY.
+ *
+ * check 1. bg cmd running. In most cases we can just be on
+ *          our merry way.
+ * check 2. @new incoming command is not capable of running
+ *          in the background. If there is an in-flight bg
+ *          operation, all these are forbidden as we need
+ *          to serialize when polling.
+ * check 3. @new incoming command is not blacklisted by the
+ *          current running command.
+ */
+static int cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
+{
+	struct cxl_mem_command *c;
+
+	/* 1 */
+	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
+		return 0;
+
+	cxl_for_each_cmd(c) {
+		if (new != c->opcode)
+			continue;
+
+		/* 2 */
+		if (c->flags & CXL_CMD_FLAG_BACKGROUND)
+			break;
+		/* 3 */
+		if (c->bgops && c->bgops->conflicts)
+			return c->bgops->conflicts(new);
+		break;
+	}
+
+	return -EBUSY;
+}
+
+/*
+ * Background operation polling mode.
+ */
+static void cxl_mbox_bgcmd_work(struct work_struct *work)
+{
+	struct cxl_dev_state *cxlds;
+	u64 bgcmd_status_reg;
+	u16 opcode;
+	u32 pct;
+
+	cxlds = container_of(work, struct cxl_dev_state, bg_dwork.work);
+
+	bgcmd_status_reg = readq(cxlds->regs.mbox +
+				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK,
+			   bgcmd_status_reg);
+
+	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
+	if (pct != 100) {
+		unsigned long hint;
+		u64 status_reg;
+
+		status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
+		if (!FIELD_GET(CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION,
+			       status_reg))
+			dev_WARN(cxlds->dev,
+				 "No background operation running (%u%%).\n",
+				 pct);
+
+		hint = cxl_mbox_bgcmd_delay(cxlds, opcode);
+		if (hint == 0) {
+			/*
+			 * TODO: try to do better(?). pct is updated every
+			 * ~1 sec, maybe use a heurstic based on that.
+			 */
+			hint = 5 * HZ;
+		}
+
+		queue_delayed_work(cxl_mbox_bgcmd_wq, &cxlds->bg_dwork, hint);
+	} else { /* bg operation completed */
+		u16 return_code;
+
+		return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
+					bgcmd_status_reg);
+		cxl_mbox_bgcmd_post(cxlds, opcode,
+				    return_code == CXL_MBOX_CMD_RC_SUCCESS);
+
+		put_device(cxlds->dev);
+		cxl_mbox_bgcmd_done(cxlds);
+	}
+}
+
 /**
  * cxl_mbox_send_cmd() - Send a mailbox command to a device.
  * @cxlds: The device data for the operation
@@ -153,6 +283,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * @in_size: The length of the input payload
  * @out: Caller allocated buffer for the output.
  * @out_size: Expected size of output.
+ * @return_code: (output) HW returned code.
  *
  * Context: Any context.
  * Return:
@@ -167,8 +298,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
  */
-int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size)
+int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode,
+		      void *in, size_t in_size,
+		      void *out, size_t out_size, u16 *return_code)
 {
 	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 	struct cxl_mbox_cmd mbox_cmd = {
@@ -183,12 +315,46 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	if (out_size > cxlds->payload_size)
 		return -E2BIG;
 
+	/*
+	 * With bg polling this can overlap a scenario where the
+	 * hardware can receive new requests but the driver is
+	 * not ready. Handle accordingly.
+	 */
+	rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
+	if (rc)
+		return rc;
+
 	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
+	if (return_code)
+		*return_code = mbox_cmd.return_code;
 	if (rc)
 		return rc;
 
-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
+	switch (mbox_cmd.return_code) {
+	case CXL_MBOX_CMD_RC_BACKGROUND:
+	{
+		int err;
+
+		dev_dbg(cxlds->dev, "Opcode 0x%04x: %s\n", opcode,
+			cxl_mbox_cmd_rc2str(&mbox_cmd));
+
+		err = cxl_mbox_bgcmd_begin(cxlds, opcode);
+		if (err) {
+			dev_WARN(cxlds->dev,
+				 "Corrupted background cmd (opcode 0x%04x)\n",
+				 err);
+		}
+
+		get_device(cxlds->dev);
+		/* do first poll check asap before using any hinting */
+		queue_delayed_work(cxl_mbox_bgcmd_wq, &cxlds->bg_dwork, 0);
+		fallthrough;
+	}
+	case CXL_MBOX_CMD_RC_SUCCESS:
+		break;
+	default:
 		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
+	}
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
@@ -198,6 +364,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 		if (mbox_cmd.size_out != out_size)
 			return -EIO;
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mbox_send_cmd, CXL);
@@ -575,7 +742,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		int rc;
 
 		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
-				       out, xfer_size);
+				       out, xfer_size, NULL);
 		if (rc < 0)
 			return rc;
 
@@ -628,7 +795,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
 		return ERR_PTR(-ENOMEM);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL, 0, ret,
-			       cxlds->payload_size);
+			       cxlds->payload_size, NULL);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
@@ -733,7 +900,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
-			       &pi, sizeof(pi));
+			       &pi, sizeof(pi), NULL);
 
 	if (rc)
 		return rc;
@@ -766,7 +933,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
-			       sizeof(id));
+			       sizeof(id), NULL);
 	if (rc < 0)
 		return rc;
 
@@ -845,6 +1012,9 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 	}
 
 	mutex_init(&cxlds->mbox_mutex);
+	INIT_DELAYED_WORK(&cxlds->bg_dwork, cxl_mbox_bgcmd_work);
+	atomic_set(&cxlds->bg, 0);
+
 	cxlds->dev = dev;
 
 	return cxlds;
@@ -853,7 +1023,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_dev_state_create, CXL);
 
 static struct dentry *cxl_debugfs;
 
-void __init cxl_mbox_init(void)
+int __init cxl_mbox_init(void)
 {
 	struct dentry *mbox_debugfs;
 
@@ -861,9 +1031,18 @@ void __init cxl_mbox_init(void)
 	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
 	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
 			    &cxl_raw_allow_all);
+
+	cxl_mbox_bgcmd_wq = alloc_ordered_workqueue("cxl_mbox_bgcmd", 0);
+	if (!cxl_mbox_bgcmd_wq) {
+		debugfs_remove_recursive(cxl_debugfs);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 void cxl_mbox_exit(void)
 {
 	debugfs_remove_recursive(cxl_debugfs);
+	destroy_workqueue(cxl_mbox_bgcmd_wq);
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index dbce99bdffab..1350b99e7287 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -104,7 +104,7 @@ static ssize_t name##_show(struct device *dev,                       \
 			   struct device_attribute *attr, char *buf) \
 {                                                                    \
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);              \
-                                                                     \
+								     \
 	return sysfs_emit(buf, "%s\n",                               \
 			  (cxld->flags & (flag)) ? "1" : "0");       \
 }                                                                    \
@@ -1525,11 +1525,13 @@ static __init int cxl_core_init(void)
 {
 	int rc;
 
-	cxl_mbox_init();
+	rc = cxl_mbox_init();
+	if (rc)
+		return rc;
 
 	rc = cxl_memdev_init();
 	if (rc)
-		return rc;
+		goto err_mbox;
 
 	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
 	if (!cxl_bus_wq) {
@@ -1547,6 +1549,7 @@ static __init int cxl_core_init(void)
 	destroy_workqueue(cxl_bus_wq);
 err_wq:
 	cxl_memdev_exit();
+err_mbox:
 	cxl_mbox_exit();
 	return rc;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6799b27c7db2..5eca9dc7397b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -80,14 +80,22 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQNUM_MASK GENMASK(10, 7)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
 #define CXLDEV_MBOX_CTRL_OFFSET 0x04
 #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
+#define   CXLDEV_MBOX_CTRL_BGCMD_IRQ BIT(2)
 #define CXLDEV_MBOX_CMD_OFFSET 0x08
 #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
 #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
 #define CXLDEV_MBOX_STATUS_OFFSET 0x10
+#define   CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION BIT(0)
 #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
+/* CXL 3.0 8.2.8.4.7 Background Command Status Register */
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4bcb02f625b4..c05dc1b8189a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -192,6 +192,8 @@ struct cxl_endpoint_dvsec_info {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @bg: opcode for the in-flight background operation on @dev
+ * @bg_dwork: self-polling work item
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -225,12 +227,15 @@ struct cxl_dev_state {
 	u64 serial;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	atomic_t bg;
+	struct delayed_work bg_dwork;
 };
 
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
+	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
@@ -250,17 +255,46 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_ERASE	= 0x4505,
+	CXL_MBOX_OP_BIND_VPPB		= 0x5201,
+	CXL_MBOX_OP_UNBIND_VPPB		= 0x5202,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
-#define DEFINE_CXL_CEL_UUID                                                    \
-	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
+/*
+ * CXL 3.0 supported commands that can run in the background.
+ *
+ * Commands that require a longer execution time shall be
+ * completed asynchronously in the background. At a hw level
+ * only one command can be executed in the background at a
+ * time, and therefore additional background commands shall
+ * be rejected with the busy return code.
+ *
+ * Barriers pair with release/acquire semantics. When done,
+ * clearing ->bg must be the very last operation before
+ * finishing the command.
+ */
+static inline int cxl_mbox_bgcmd_begin(struct cxl_dev_state *cxlds, u16 opcode)
+{
+	return atomic_xchg(&cxlds->bg, opcode);
+}
+static inline int cxl_mbox_bgcmd_running(struct cxl_dev_state *cxlds)
+{
+	return atomic_read_acquire(&cxlds->bg);
+}
+static inline void cxl_mbox_bgcmd_done(struct cxl_dev_state *cxlds)
+{
+	atomic_set_release(&cxlds->bg, 0);
+}
+
+#define DEFINE_CXL_CEL_UUID						\
+	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62, \
 		  0x3b, 0x3f, 0x17)
 
 #define DEFINE_CXL_VENDOR_DEBUG_UUID                                           \
@@ -323,16 +357,32 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+/**
+ * struct cxl_mbox_bgcmd_ops - Ad-hoc handling of background cmds
+ * @conflicts: How to handle a @new command when one is currently executing
+ * @post: Execute after the command completes
+ * @delay: Delay hint for polling on command completion
+ */
+struct cxl_mem_bgcommand_ops {
+	int (*conflicts)(u16 new);
+	void (*post)(struct cxl_dev_state *cxlds, bool success);
+	unsigned long (*delay)(struct cxl_dev_state *cxlds);
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
  * @opcode: The actual bits used for the mailbox protocol
  * @flags: Set of flags effecting driver behavior.
+ * @bg_ops: Set of callbacks to handle commands that can run in the background
  *
  *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
  *    will be enabled by the driver regardless of what hardware may have
  *    advertised.
  *
+ *  * %CXL_CMD_FLAG_BACKGROUND: The command may execute asynchronously in the
+ *    background if the operation takes longer than ~2 seconds.
+ *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
  * the hardware. The driver will use @info to validate the fields passed in by
@@ -344,8 +394,9 @@ struct cxl_mem_command {
 	struct cxl_command_info info;
 	enum cxl_opcode opcode;
 	u32 flags;
-#define CXL_CMD_FLAG_NONE 0
+	struct cxl_mem_bgcommand_ops *bgops;
 #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
+#define CXL_CMD_FLAG_BACKGROUND BIT(1)
 };
 
 #define CXL_PMEM_SEC_STATE_USER_PASS_SET	0x01
@@ -383,7 +434,10 @@ enum {
 };
 
 int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size);
+		      size_t in_size, void *out, size_t out_size,
+		      u16 *return_code);
+void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds, u16 opcode, bool success);
+unsigned long cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode);
 int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5a0ae46d4989..57ad19050c2c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -176,7 +176,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
+	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0; /* completed but caller must check return_code */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 1a85168bd2d1..63f51124bc24 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -156,7 +156,8 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
 	};
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
-			       sizeof(get_lsa), cmd->out_buf, cmd->in_length);
+			       sizeof(get_lsa), cmd->out_buf,
+			       cmd->in_length, NULL);
 	cmd->status = 0;
 
 	return rc;
@@ -188,7 +189,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_LSA, set_lsa,
 			       struct_size(set_lsa, data, cmd->in_length),
-			       NULL, 0);
+			       NULL, 0, NULL);
 
 	/*
 	 * Set "firmware" status (4-packed bytes at the end of the input
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index eb65c299c890..735cbe4d817a 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -20,7 +20,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
-			       &sec_out, sizeof(sec_out));
+			       &sec_out, sizeof(sec_out), NULL);
 	if (rc < 0)
 		return 0;
 
@@ -71,7 +71,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 	memcpy(set_pass->new_pass, new_data->data, NVDIMM_PASSPHRASE_LEN);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_PASSPHRASE,
-			       set_pass, sizeof(*set_pass), NULL, 0);
+			       set_pass, sizeof(*set_pass), NULL, 0, NULL);
 	kfree(set_pass);
 	return rc;
 }
@@ -95,7 +95,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	memcpy(dis_pass->pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_DISABLE_PASSPHRASE,
-			       dis_pass, sizeof(*dis_pass), NULL, 0);
+			       dis_pass, sizeof(*dis_pass), NULL, 0, NULL);
 	kfree(dis_pass);
 	return rc;
 }
@@ -118,7 +118,8 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY, NULL, 0, NULL, 0);
+	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY,
+				 NULL, 0, NULL, 0, NULL);
 }
 
 static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
@@ -132,7 +133,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 
 	memcpy(pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_UNLOCK,
-			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0);
+			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0, NULL);
 	if (rc < 0)
 		return rc;
 
@@ -161,7 +162,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 	/* Flush all cache before we erase mem device */
 	flush_cache_all();
 	rc =  cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_ERASE,
-				erase, sizeof(*erase), NULL, 0);
+				erase, sizeof(*erase), NULL, 0, NULL);
 	kfree(erase);
 	if (rc < 0)
 		return rc;
-- 
2.37.1

