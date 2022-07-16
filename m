Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E800F577273
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiGPXST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiGPXRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A922530
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:40 -0700 (PDT)
Message-ID: <20220716230953.680326814@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Gik5ycS44UWfcpIctkiTE3e/YDYlUOruM5e3iQXUL0g=;
        b=X807HrVwl4RC2I76VLm1mwNFcLukNwIJy98zK5GuKfgtZf78axpgJZQWCpN+TOlzWC7ftR
        LtYqIgn/J1aBEXXH103KQVkF9zwYkdibcM35upniyt2knLFbZWZ06H4RG5Lln3768u5Gw2
        Y2SRVNMu6fHvgffnewmw86eCkEfstW6tYMlutpTFZsAUF5ueHmuoiFAm5ORKmqLBAHHZjo
        zBCMeLvQGzJ/NHyNgtttC4hKxegc0OHeUmELscK+O5/7B/ClV7qUUhDmnJk2aNIkYZk+th
        dWgiAqX1xI2XjVXT3t0th/uszclhma45tc8XZD4rHeubm7Usb8hEeJ0JN7YdMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Gik5ycS44UWfcpIctkiTE3e/YDYlUOruM5e3iQXUL0g=;
        b=QqaQ2T5Dv6mWQOTLxLrNYUm+MJF5Ji3sORMs+v8m7dX0/HQBtK0TPd61XAHx09Fow5UZjr
        oicTaWnbsQyvabDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 17/38] module: Add arch_data to module_layout
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:37 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming call depth tracking it's required to store extra
information in the module layout. Add a pointer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/module.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -87,6 +87,9 @@ struct module_layout {
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 	struct mod_tree_node mtn;
 #endif
+#ifdef CONFIG_CALL_THUNKS
+	void *arch_data;
+#endif
 };
 
 extern ssize_t __modver_version_show(struct module_attribute *,

