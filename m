Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27DF4C6CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiB1Mgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiB1Mgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:36:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F456764
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1659CB81112
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFCAC340E7;
        Mon, 28 Feb 2022 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646051768;
        bh=cesg6vdoXt7YoKedudIJ9d8rtvtzfKk1Vdd6Mn77biw=;
        h=From:To:Cc:Subject:Date:From;
        b=peHg7+g9p5oF5UP0zm/QUYuSqRJ01hXxrUNSui02akRGhnRjPE+g5KK5yQiZjdP3Y
         i8CgvgQTJ1PTCQYC/M54u7HwEgCI5GDcGPDuiFTQPYTvJw2wfRlH1MFd+k/EgF3gHp
         b8EIts+79Ndi0oFBrh2o5loziNrsjAv+vWxvtXDfp19qYK4sSk6ERDU1wIQ49Myi0J
         Kf1/p0wPQlBTQFs8/88plS33l7rUYlT9nbYpjCX/WITstR0c4vWM3iz95mrFDASy7N
         CHinS6R16cHs3J2U7/KqEOU9fFhKZyS+WhzF8DAUhTXgFujm+tIk5zrWbPJbog5c19
         VJryE3s7qtVQA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: remove deprecated firmware states
Date:   Mon, 28 Feb 2022 14:36:03 +0200
Message-Id: <20220228123603.1172692-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

During driver and F/W handshake, driver waits for F/W to reach
certain states in order to progress with the boot flow.
Some of the states were deprecated a long time ago and were never
present on official firmwares. Therefore, let's remove them from
the handshake process.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 11957d36c6a9..3262126cc7ca 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1207,8 +1207,6 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		hdev,
 		cpu_boot_status_reg,
 		status,
-		(status == CPU_BOOT_STATUS_IN_UBOOT) ||
-		(status == CPU_BOOT_STATUS_DRAM_RDY) ||
 		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT),
-- 
2.25.1

