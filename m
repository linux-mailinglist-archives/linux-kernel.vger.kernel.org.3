Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D609513231
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbiD1LPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiD1LPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C352250C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28AE61F1F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F7EC385A0;
        Thu, 28 Apr 2022 11:11:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OuGIwjQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651144313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=md1MNTc1vspPVRzc4103iVAWg3qcKbg05zQ16mss5wU=;
        b=OuGIwjQDeOI2B7bguWdrvoPU23TV9BZIGknyDcDeIiorX0maglyOOtCGowJ10EBFj6JHQp
        JLlr7/a127+CbZJn5HQHWqL8Avt4ZiE+KyUcS5bftw9c5rApmgiYuYjKPeVcKYsp7aokcU
        A2gA1jGTCo5qxMzglRfMtKTKUrENyWo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ed39d4e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 28 Apr 2022 11:11:53 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     shorne@gmail.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] openrisc: define nop command for simulator reboot
Date:   Thu, 28 Apr 2022 13:11:39 +0200
Message-Id: <20220428111139.1330966-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simulator defines `l.nop 1` for shutdown, but doesn't have anything
for reboot. Use 13 for this, which is currently unused, dubbed
`NOP_REBOOT`.

Cc: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/all/YmnaDUpVI5ihgvg6@zx2c4.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/openrisc/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 3c0c91bcdcba..4cce95fa6eb5 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -52,6 +52,8 @@ void machine_restart(char *cmd)
 {
 	do_kernel_restart(cmd);
 
+	__asm__("l.nop 13");
+
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
 
-- 
2.35.1

