Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC264CA83D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiCBOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbiCBOeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:34:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A5DC4B4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC7C61444
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98050C004E1;
        Wed,  2 Mar 2022 14:33:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WXxqO1sV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646231623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DAalu/meWS+7af75bmhJcZ2XwBifj5HW+kM+Ikye6Ug=;
        b=WXxqO1sVnF42m/q5baBynua88lsm+pGXHqwtai0NIS3VysLM4GMIUo04jP5xpqBcRefLoU
        gycFtJg5wkcmPWs9qn3y/gB+ULLX8t6jTmJ/uIjG4BSP4KyDgwwqNbTOCfUkaW+uIa7JJy
        QnVB9r4L/ODQvQxz+nTVWP3UGhTm09I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6c37631f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 2 Mar 2022 14:33:43 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Adrian Catangiu <adrian@parity.io>,
        Jann Horn <jannh@google.com>
Subject: [PATCH RFC v1] random: add vm_id sysctl with polling
Date:   Wed,  2 Mar 2022 15:33:31 +0100
Message-Id: <20220302143331.654426-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an RFC, because I'm in no rush to add new userspace APIs without
being quite sure that this is the way forward.

In order to inform userspace of virtual machine forks, this commit adds
a "vm_id" sysctl, with the same semantics as the existing "boot_id" one,
except it changes after a VM fork and allows userspace processes to
poll() on it for changes.

It avoids exposing the actual vmgenid from the hypervisor to userspace,
in case there is any randomness value in keeping it secret.

The main purpose of posting this patch is just to have something
concrete to demonstrate the idea, as well as to show how simple this is
to implement. The discussion of races and such is for the thread in the
link below.

Link: https://lore.kernel.org/lkml/Yh4+9+UpanJWAIyZ@zx2c4.com/
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Alexander Graf <graf@amazon.com>
Cc: Adrian Catangiu <adrian@parity.io>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 07ca3164522c..942a6dc4f00b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1142,6 +1142,8 @@ EXPORT_SYMBOL_GPL(add_bootloader_randomness);
 
 #if IS_ENABLED(CONFIG_VMGENID)
 static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
+static DEFINE_CTL_TABLE_POLL(sysctl_vmid_poll);
+static u8 sysctl_vmid[UUID_SIZE];
 
 /*
  * Handle a new unique VM ID, which is unique, not secret, so we
@@ -1156,6 +1158,10 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t size)
 		pr_notice("crng reseeded due to virtual machine fork\n");
 	}
 	blocking_notifier_call_chain(&vmfork_chain, 0, NULL);
+	if (IS_ENABLED(CONFIG_SYSCTL)) {
+		WRITE_ONCE(sysctl_vmid[8], 0);
+		proc_sys_poll_notify(&sysctl_vmid_poll);
+	}
 }
 #if IS_MODULE(CONFIG_VMGENID)
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
@@ -1684,6 +1690,15 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
+#if IS_ENABLED(CONFIG_VMGENID)
+	{
+		.procname	= "vm_id",
+		.data		= &sysctl_vmid,
+		.mode		= 0444,
+		.proc_handler	= proc_do_uuid,
+		.poll		= &sysctl_vmid_poll,
+	},
+#endif
 	{
 		.procname	= "uuid",
 		.mode		= 0444,
-- 
2.35.1

