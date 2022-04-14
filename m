Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3B500E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbiDNNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiDNNAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D191573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A746660C42
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA98C385A1;
        Thu, 14 Apr 2022 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649941071;
        bh=hbAVdSRRHrtynkXjCb+15k2FLopnvXLAKT5pIbcNIlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wxp6kMFlsxvd0jYJhFU7xX6a0yEtucKr00ybW0MYTPPGVtVDfsTktfY5ixryc+O1T
         Cv1cS0xZY8NmQ7X6wcqbybw1tm511BEfLgN2K+M/dpqrKMlNdbtiltGXoAWsnzUkpn
         Wswxnb/I3VqXdjNsCfCFajpfnufUcmHROxCh04/T85trYCzvZG6vr8DsB4QfswiX5f
         OcA6C7MBZjZriX9Xeniu7YFPc6EGL0odq9lXYJkb8XhtcQjNjOLAR9Ea7hEnK70iLN
         d5Sh3nomNK1N+RRivCaMrhLoel9L5rGyGphAyPpAK7FiizaIwi8OpJMiZ26X/qviDy
         gkrHbBTWNCcxQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 2/2] habanalabs: use get_task_pid() to take PID
Date:   Thu, 14 Apr 2022 15:57:44 +0300
Message-Id: <20220414125744.1928306-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414125744.1928306-1-ogabbay@kernel.org>
References: <20220414125744.1928306-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

find_get_pid() isn't good in case the user process was run inside
docker.

As a result, we didn't had the PID and we couldn't kill the user
process in case the device got stuck and we needed to reset the
device.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 28549d34d99c..b85ca1e66eb2 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -237,7 +237,7 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	hpriv->filp = filp;
 	nonseekable_open(inode, filp);
 
-	hpriv->taskpid = find_get_pid(current->pid);
+	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
 
 	mutex_lock(&hdev->fpriv_ctrl_list_lock);
 
-- 
2.25.1

