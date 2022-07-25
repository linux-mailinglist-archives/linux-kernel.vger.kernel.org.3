Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58857FEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiGYMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiGYMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:08:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD19DF70;
        Mon, 25 Jul 2022 05:08:24 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:08:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658750902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gk8CPxljSGi8h/toKgfaY1Sja4UpRi79bK/PS63Ce4=;
        b=gPB7SrcnX8SDYZjl0/8Z8U4Jf2jb4kh9vf/rd4wZ5aAUeRUEo0QpE3naqxHAiMng0RSxL8
        pO+G8ut0FDw9bqUBSxfpNZfho6a69rAY4/9fuZmpVu7J1ViEtefNRU6d/IL5RigtzQNsGd
        BavH9E11mBa7w456HxeLYQgaZZ28oYs2nsq5fhK4m1pPX6VOwbAZcm4r8hoarA87FxLvfZ
        ewE4PII2SFOsIO9NjiQ/ulnI5zpwZEia95sABDeHwGDuJHD2GYnf4hPIS2CQBcSuF9PfrC
        PvvS+V9WgHAaX5rQJBPYDEKPt3GvdswLUrJVkspY+NwwhYX/WmkvZMhXLs7gdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658750902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Gk8CPxljSGi8h/toKgfaY1Sja4UpRi79bK/PS63Ce4=;
        b=FR8vef3P9kxoTgbcrsyRsmCfO4m4lAoJ8YUKGRrWyrQOmSQvH6891dh4wryd525OGx7luu
        a+EqZi31WRvVYIAQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/purgatory: Hard-code obj-y in Makefile
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220725020812.622255-1-masahiroy@kernel.org>
References: <20220725020812.622255-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <165875090170.15455.11194369295899993249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     61922d3fa686733e08387a8a4e11b02b4af6d43c
Gitweb:        https://git.kernel.org/tip/61922d3fa686733e08387a8a4e11b02b4af6d43c
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 25 Jul 2022 11:08:11 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Jul 2022 10:26:49 +02:00

x86/purgatory: Hard-code obj-y in Makefile

arch/x86/Kbuild guards the entire purgatory/ directory, and
CONFIG_KEXEC_FILE is bool type.

$(CONFIG_KEXEC_FILE) is always 'y' when this directory is being built.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220725020812.622255-1-masahiroy@kernel.org
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54..248b009 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
+obj-y += kexec-purgatory.o
