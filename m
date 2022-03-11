Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC74D6807
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350470AbiCKRs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiCKRst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:48:49 -0500
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBAB4754E;
        Fri, 11 Mar 2022 09:47:37 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KFYKz2khTzMqKrZ;
        Fri, 11 Mar 2022 18:47:35 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KFYKz1CGvzlhRVr;
        Fri, 11 Mar 2022 18:47:35 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] certs: Remove panic() calls from blacklist_init()
Date:   Fri, 11 Mar 2022 18:47:40 +0100
Message-Id: <20220311174741.250424-2-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311174741.250424-1-mic@digikod.net>
References: <20220311174741.250424-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Replace panic() calls from device_initcall(blacklist_init) with proper
error handling using -ENODEV.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
Link: https://lore.kernel.org/r/Yik0C2t7G272YZ73@iki.fi [1]
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220311174741.250424-2-mic@digikod.net
---
 certs/blacklist.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 486ce0dd8e9c..ea7a77f156da 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -313,12 +313,16 @@ static int __init blacklist_init(void)
 	const char *const *bl;
 	struct key_restriction *restriction;
 
-	if (register_key_type(&key_type_blacklist) < 0)
-		panic("Can't allocate system blacklist key type\n");
+	if (register_key_type(&key_type_blacklist) < 0) {
+		pr_err("Can't allocate system blacklist key type\n");
+		return -ENODEV;
+	}
 
 	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
-	if (!restriction)
-		panic("Can't allocate blacklist keyring restriction\n");
+	if (!restriction) {
+		pr_err("Can't allocate blacklist keyring restriction\n");
+		goto err_restriction;
+	}
 	restriction->check = restrict_link_for_blacklist;
 
 	blacklist_keyring =
@@ -333,13 +337,24 @@ static int __init blacklist_init(void)
 			      , KEY_ALLOC_NOT_IN_QUOTA |
 			      KEY_ALLOC_SET_KEEP,
 			      restriction, NULL);
-	if (IS_ERR(blacklist_keyring))
-		panic("Can't allocate system blacklist keyring\n");
+	if (IS_ERR(blacklist_keyring)) {
+		pr_err("Can't allocate system blacklist keyring\n");
+		goto err_keyring;
+	}
 
 	for (bl = blacklist_hashes; *bl; bl++)
 		if (mark_raw_hash_blacklisted(*bl) < 0)
 			pr_err("- blacklisting failed\n");
 	return 0;
+
+
+err_keyring:
+	kfree(restriction);
+
+err_restriction:
+	unregister_key_type(&key_type_blacklist);
+
+	return -ENODEV;
 }
 
 /*
-- 
2.35.1

