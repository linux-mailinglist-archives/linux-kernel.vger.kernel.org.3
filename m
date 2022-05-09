Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF551F77B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiEII7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiEII1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6622B1D8B64
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B383361493
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A593C385A8;
        Mon,  9 May 2022 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652084544;
        bh=TjaA8AHT/x4D0xemiw/65Fas3g+l185CjtVeFyP7Ju0=;
        h=From:To:Cc:Subject:Date:From;
        b=R/JFcPhCZbciZgfJyv0YWzGbCWKbkj0lqG6XWdaf2xTS7qUSbOHvYjuL12PjpDHNg
         yLwaOrTXnTyM3Ho6zMk9QgKu5zupPFpsap/EWsZX/8JlwfYa5Pm/nSE8COUo1/trcW
         jQttTIxaGd2GIWCbUeQu+jdhlhzK82WXWl8Rk7RFd3qHWrimq41S925ZL8nn8o6v15
         91iFx7cnXfZIdT2mD1hDIx0RitQhmtrBBfCkxGlmib7lq/emhTXDc90GKCtmMhlXzm
         nxxTgrru9R5uHSXe0/7MXdGmG/ctbep2eXn3BReUBCYBVK5mEJr1M37n7cgBm5v7nT
         CSoir9mrEFEGQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 1/3] habanalabs: handle race in driver fini
Date:   Mon,  9 May 2022 11:22:16 +0300
Message-Id: <20220509082218.956916-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Scenario:

1. During hard reset, driver executes device_kill_open_processes.
2. Drivers file descriptor is not closed yet (user process is alive),
   hence we are starting loop on all open file descriptors.
3. Just before getting task struct of user process, according to
   pid, SIGKILL is sent to the user process, hence get_pid_task
   fails, driver prints a warning and device_kill_open_processes
   returns an error.
4. Returned error causing driver fini do disable the device object
   of the process which causes a kernel crash.

The fix is to handle this case not as an error and continue fini flow
as normal, since the killed process (by the SIGKILL) will release its
resources just like it will do when the driver sends him the sigkill.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index dbec98736a31..15df89b31e1b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1024,10 +1024,13 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout, bool
 
 			put_task_struct(task);
 		} else {
-			dev_warn(hdev->dev,
-				"Can't get task struct for PID so giving up on killing process\n");
-			mutex_unlock(fd_lock);
-			return -ETIME;
+			/*
+			 * If we got here, it means that process was killed from outside the driver
+			 * right after it started looping on fd_list and before get_pid_task, thus
+			 * we don't need to kill it.
+			 */
+			dev_dbg(hdev->dev,
+				"Can't get task struct for user process, assuming process was killed from outside the driver\n");
 		}
 	}
 
-- 
2.25.1

