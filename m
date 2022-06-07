Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2FA542053
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385595AbiFHAVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391461AbiFGW4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:56:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8E30D369
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:58:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so8405996pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DELD8KMeXui2A7kgi36tgonOPUlj758pTn6fyp8eDBE=;
        b=T8uYE9Ecxc2t6MbrOBkXDKh7eS8ltpB4bjLpACf74MlXsAbyka9SAXH1cdraZeRe9F
         /Hz/s0J3LFVZ63ghMAuFTkvDRMsdcc81bfAodrPYTgbkfioO48tib6UR+hcgaN583VHZ
         +o+fL6CTbCFLliFcOUnhK4WHiveyZFEZjr/78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DELD8KMeXui2A7kgi36tgonOPUlj758pTn6fyp8eDBE=;
        b=wppHstoYrvq41ebV9QXNlxMYAYBZGMkeIKF8FfWsJqpTNpN7WHhD71YYcbyYZbcfvz
         jIBTXkRUIid34Qpda8rs/3gQhhyRIsu/yWuIsux550llUVqTL+gm49bQrV6Bto4n2XhR
         0N5MFHU3nv4aPoIQAbwY3cgDh8UHXJDYrGlM0777D6zBKYUqShKLKvhl9VPoTUaPuoLC
         GdrumW2iuBL6E3WAfIi8e6wgdm9vEQfYyd3hIYWz+/cBcOnwdd3pipfd982DvK2KQBEA
         WNGf+Jf4vjUp9/sVIfm8KS4omwmy7sFSrREJlNTweFX7srgAmDmgR73NPDWEb2cOWzJy
         5ahw==
X-Gm-Message-State: AOAM531/ud+I6awPAdpjvlUancJWt2XNya7jYrr4eDDV6Fc0g+/kvkFM
        4VSpPvdjpdpjsTOyNn5DwFl6bYX7upK/1fCHhPodBIorDw5sj0AdrI3UohO2zTjkTHuZXtPo0Hb
        GWGpFLFrTpFNQ/kCcGSuFczfDj4e/9qmOoiQpI6/z1/stud1BTJ9ujFC6HUea6ZjM0L9j+oBXjQ
        rOWYE=
X-Google-Smtp-Source: ABdhPJzRyVhZ5MIyAhlDq+8WtxrR0UVAhUM0ei++J0NpXweubP0mJ6OZWV3QkV9K2A1cpnNouAJYeQ==
X-Received: by 2002:a17:902:758a:b0:15e:ef4f:fed5 with SMTP id j10-20020a170902758a00b0015eef4ffed5mr30609704pll.1.1654631886363;
        Tue, 07 Jun 2022 12:58:06 -0700 (PDT)
Received: from localhost.localdomain (vpn.purestorage.com. [192.30.189.1])
        by smtp.gmail.com with ESMTPSA id e186-20020a6369c3000000b003fd4bd3befesm8005432pgc.55.2022.06.07.12.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:58:05 -0700 (PDT)
From:   Brian Bunker <brian@purestorage.com>
To:     linux-kernel@vger.kernel.org
Cc:     hare@suse.de, mwilck@suse.de, hch@infradead.org,
        Brian Bunker <brian@purestorage.com>,
        Krishna Kant <krishna.kant@purestorage.com>,
        Seamus Connor <sconnor@purestorage.com>
Subject: [PATCH] scsi_lib: Don't fail the path in ALUA transition state
Date:   Tue,  7 Jun 2022 12:58:00 -0700
Message-Id: <20220607195800.43485-1-brian@purestorage.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error path for the SCSI check condition of not ready, target in
ALUA state transition, will result in the failure of that path after
the retries are exhausted. In most cases that is well ahead of the
transition timeout established in the SCSI ALUA device handler.

Instead, reprep the command and re-add it to the queue after a 1 second
delay. This will allow the handler to take care of the timeout and
only fail the path in the transition state if the target has exceeded
the transition timeout (default 60 seconds).

Acked-by: Krishna Kant <krishna.kant@purestorage.com>
Acked-by: Seamus Connor <sconnor@purestorage.com>
Signed-off-by: Brian Bunker <brian@purestorage.com>
---
 drivers/scsi/scsi_lib.c | 44 +++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6ffc9e4258a8..1afb267ff9a2 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -118,7 +118,7 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 	}
 }
 
-static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
+static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd, unsigned long msecs)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
 
@@ -128,7 +128,12 @@ static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 	} else {
 		WARN_ON_ONCE(true);
 	}
-	blk_mq_requeue_request(rq, true);
+
+	if (msecs) {
+		blk_mq_requeue_request(rq, false);
+		blk_mq_delay_kick_requeue_list(rq->q, msecs);
+	} else
+		blk_mq_requeue_request(rq, true);
 }
 
 /**
@@ -658,14 +663,6 @@ static unsigned int scsi_rq_err_bytes(const struct request *rq)
 	return bytes;
 }
 
-/* Helper for scsi_io_completion() when "reprep" action required. */
-static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
-				      struct request_queue *q)
-{
-	/* A new command will be prepared and issued. */
-	scsi_mq_requeue_cmd(cmd);
-}
-
 static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 {
 	struct request *req = scsi_cmd_to_rq(cmd);
@@ -683,14 +680,21 @@ static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 	return false;
 }
 
+/*
+ * When ALUA transition state is returned, reprep the cmd to
+ * use the ALUA handlers transition timeout. Delay the reprep
+ * 1 sec to avoid aggressive retries of the target in that
+ * state.
+ */
+#define ALUA_TRANSITION_REPREP_DELAY	1000
+
 /* Helper for scsi_io_completion() when special action required. */
 static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 {
-	struct request_queue *q = cmd->device->request_queue;
 	struct request *req = scsi_cmd_to_rq(cmd);
 	int level = 0;
-	enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
-	      ACTION_DELAYED_RETRY} action;
+	enum {ACTION_FAIL, ACTION_REPREP, ACTION_DELAYED_REPREP,
+	      ACTION_RETRY, ACTION_DELAYED_RETRY} action;
 	struct scsi_sense_hdr sshdr;
 	bool sense_valid;
 	bool sense_current = true;      /* false implies "deferred sense" */
@@ -779,8 +783,8 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 					action = ACTION_DELAYED_RETRY;
 					break;
 				case 0x0a: /* ALUA state transition */
-					blk_stat = BLK_STS_TRANSPORT;
-					fallthrough;
+					action = ACTION_DELAYED_REPREP;
+					break;
 				default:
 					action = ACTION_FAIL;
 					break;
@@ -839,7 +843,10 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 			return;
 		fallthrough;
 	case ACTION_REPREP:
-		scsi_io_completion_reprep(cmd, q);
+		scsi_mq_requeue_cmd(cmd, 0);
+		break;
+	case ACTION_DELAYED_REPREP:
+		scsi_mq_requeue_cmd(cmd, ALUA_TRANSITION_REPREP_DELAY);
 		break;
 	case ACTION_RETRY:
 		/* Retry the same command immediately */
@@ -933,7 +940,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
  * command block will be released and the queue function will be goosed. If we
  * are not done then we have to figure out what to do next:
  *
- *   a) We can call scsi_io_completion_reprep().  The request will be
+ *   a) We can call scsi_mq_requeue_cmd().  The request will be
  *	unprepared and put back on the queue.  Then a new command will
  *	be created for it.  This should be used if we made forward
  *	progress, or if we want to switch from READ(10) to READ(6) for
@@ -949,7 +956,6 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
-	struct request_queue *q = cmd->device->request_queue;
 	struct request *req = scsi_cmd_to_rq(cmd);
 	blk_status_t blk_stat = BLK_STS_OK;
 
@@ -986,7 +992,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 	 * request just queue the command up again.
 	 */
 	if (likely(result == 0))
-		scsi_io_completion_reprep(cmd, q);
+		scsi_mq_requeue_cmd(cmd, 0);
 	else
 		scsi_io_completion_action(cmd, result);
 }
-- 
2.33.1

