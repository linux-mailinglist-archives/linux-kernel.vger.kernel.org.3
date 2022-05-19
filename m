Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2D52D111
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbiESLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiESLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:02:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883D5DA5D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:02:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id A1BE41F45A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652958165;
        bh=Z+gW0P5sGsUp4ykJPGmElehexTGF1kbDnbejPEKwZ9c=;
        h=From:To:Cc:Subject:Date:From;
        b=Uevjx3rYjqqSNuK62J8Fbi8xsTvoSJcJPJl2ZQlG7jjH4/zUyWJfKs6jXO21mZkm7
         ffZiL8xfeFqsx7HmK5ldFXe6YdvanDGgOMevV6vzTgP+xR6B9NBfxQL42v6ig/x2wg
         VDvGRFlfWCwLh45yn8AwTZKtKUSSGcRBIHRqMJh2Nf/vOILLuIAxk1VtJp6RcQMx+9
         0B3JAwxsBgVWxX0WaLWzmIGfoa+qiu3C09f6XzrgTsRLyzW6OJfuWHlxuLiE8Ia5ob
         EFCHEbIBqBsF0usM9p4P3C0X7s/UStj51gkA6nVIfLyWqKt2Vnik/wUnyeyIm5tZx3
         OhIViF2Smtj6A==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v10] notifier: Add atomic_notifier_call_chain_is_empty()
Date:   Thu, 19 May 2022 14:02:32 +0300
Message-Id: <20220519110232.1198823-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_notifier_call_chain_is_empty() that returns true if given
atomic call chain is empty.

The first user of this new notifier API function will be the kernel
power-off core code that will support power-off call chains. The core
code will need to check whether there is a power-off handler registered
at all in order to decide whether to halt machine or power it off.

Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---

Changelog:

v10: - Corrected another doc-comment typo s/atomicnotifier/atomic_notifier/.

v9: - Extended commit message with a usage example.

    - Corrected doc-comment with s/blocking/atomic/.

 include/linux/notifier.h |  2 ++
 kernel/notifier.c        | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 87069b8459af..95e2440037de 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -173,6 +173,8 @@ extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh
 extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
 
+extern bool atomic_notifier_call_chain_is_empty(struct atomic_notifier_head *nh);
+
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index ba005ebf4730..137b902c985b 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -204,6 +204,19 @@ int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
 NOKPROBE_SYMBOL(atomic_notifier_call_chain);
 
+/**
+ *	atomic_notifier_call_chain_is_empty - Check whether notifier chain is empty
+ *	@nh: Pointer to head of the atomic notifier chain
+ *
+ *	Checks whether notifier chain is empty.
+ *
+ *	Returns true is notifier chain is empty, false otherwise.
+ */
+bool atomic_notifier_call_chain_is_empty(struct atomic_notifier_head *nh)
+{
+	return !rcu_access_pointer(nh->head);
+}
+
 /*
  *	Blocking notifier chain routines.  All access to the chain is
  *	synchronized by an rwsem.
-- 
2.35.3

