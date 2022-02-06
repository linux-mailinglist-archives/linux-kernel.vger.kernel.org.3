Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FFF4AB10C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbiBFRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbiBFRpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:45:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A74C043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:45:12 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 192so9719732pfz.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6iskz+FBLj513LKJP0SIpTgUMOdBW2n6Z2gLN+PMSgA=;
        b=LHRm33CkBY5V8/+tm1HL8EoysUkEVoniFUHjhF+HJMBSCucOB3Ra3Fk7upn9EfNy7t
         /1svVUMeSMHcy28RwNLsbW8uHcF2lcOiT+OXWqIXjEFp6RA71kApVtCNm8VW223bzL3S
         +K46AkioawGWBEnGphgsxFFaWRv/R8SavfMRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iskz+FBLj513LKJP0SIpTgUMOdBW2n6Z2gLN+PMSgA=;
        b=8Dm22uxn++EDnM21RK2pcNH/pXbsYJ34WlDH4naEz4wnYl529kRdmxeqJROr/6mX+e
         qNd3XW1XsJ9yCydx0iVK6Rmwre1TrQe8QNkrWZKd31Pf2OwHfYEIVXUdZHDDR5K/UspD
         gtwvjqLcUZCJaWED6zQB2pdJC27Yhk2HDtncX7XbLiBNi2xzu40/C6xlOfSBAi+ynNU/
         Hgg+fYrlYwHZL9rtoGiX3fbGUj2OsuacE/yzK41YQ4fHLij+rQetp1OXIXCMaKclV10u
         UR4RZNu+c8LeWxff97qAydRD6YX4OCVNf715HoxBRUqWtKK9/yclAZYaOr82m/b9H285
         zAog==
X-Gm-Message-State: AOAM531pv7AOPpaTwp8X1e7IYSdwJ4bxRJAWeR0aq693HlD2vdIbh2sb
        NtBkMu2KS0hvIXcBT614TAxnsg==
X-Google-Smtp-Source: ABdhPJx/Hnsk7LZ4mM/pwnpvB4jp1iRjf4dKAVWIoMCBkpSDX6sj+cyHZqyOI82UGSbqYnpBj0zg1w==
X-Received: by 2002:a63:4b4a:: with SMTP id k10mr6647215pgl.488.1644169512337;
        Sun, 06 Feb 2022 09:45:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o21sm9555315pfu.100.2022.02.06.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:45:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] gcc-plugins/stackleak: Exactly match strings instead of prefixes
Date:   Sun,  6 Feb 2022 09:45:07 -0800
Message-Id: <20220206174508.2425076-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206174508.2425076-1-keescook@chromium.org>
References: <20220206174508.2425076-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; h=from:subject; bh=7ZhUIZRWBZdIwU3QloHv8YfGoYLImcCzFHMebm4HT+0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAAkjiFpI0PExnXK3EXjoT6wrAo802WUdEEqkhhYd sOsAlHKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgAJIwAKCRCJcvTf3G3AJm3SD/ 4m7rQ6j6Ecz7NmABqTILHvHzWkJNjU/p+4pk3t6w33tf0ftDnwOjecSS9JMQz8Y7w+k37Ijet2rUZc AXkXH9rCcl08/zZvfDaV3ZibARlqLTzBmXtnR8vOCkOk6ruYmlGVpQhLJisNDGbsV8vZm8KGigTmpI ErzHSK5fh/k7aorIk0MgWMBAj8FNvPOZgH96R6L2dUchVa8LboX/R7d09nnfGhAlL2oYWZf5DqHm4s frKlRXPhPv1iEb1p13hM4pJZ3WUhB7t/uyjryxIeUXDGh0ZJUE3/QUQWqypHGp/0HopAzRHFOh93tw t+W4go6Mu6d/vwSmYnk/URY4I+/zqyJM+R7BO7aKvQ/sFggvzKEXLAfm3rPlQ9PIb74+9Y+v6Ga/DF FMFWDsjl5a2w/EGjxL62ktEylPpkaEgQsTz8qwIhgIZDszTp1oRWMGcI/1u89xeErJyFeAp20CK2jW pU6vr+jB+nIfUao3lksZnjFIQzkLJoRltTxfwN8ROs/ChP3QVU8xp97KLRTPaZoQ3xTV+5+9cj5P8p UmBpsJbOmRWeilbtMD86UfEiN9i7nk3+Su7EpphDIG2wGFThTz8hDUeL62lnmhDZiVrSSX7JVJEYCq cHphz6qkNsae/nNic5nqr2UwuBqdNt5yJeveH2DBlHlbWBogTC5BU3G9kL+A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since STRING_CST may not be NUL terminated, strncmp() was used for check
for equality. However, this may lead to mismatches for longer section
names where the start matches the tested-for string. Test for exact
equality by checking for the presences of NUL termination.

Cc: Alexander Popov <alex.popov@linux.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/stackleak_plugin.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index e9db7dcb3e5f..623bcad6d0c7 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -429,6 +429,23 @@ static unsigned int stackleak_cleanup_execute(void)
 	return 0;
 }
 
+/*
+ * STRING_CST may or may not be NUL terminated:
+ * https://gcc.gnu.org/onlinedocs/gccint/Constant-expressions.html
+ */
+static inline bool string_equal(tree node, const char *string, int length)
+{
+	if (TREE_STRING_LENGTH(node) < length)
+		return false;
+	if (TREE_STRING_LENGTH(node) > length + 1)
+		return false;
+	if (TREE_STRING_LENGTH(node) == length + 1 &&
+	    TREE_STRING_POINTER(node)[length] != '\0')
+		return false;
+	return !strncmp(TREE_STRING_POINTER(node), string, length);
+}
+#define STRING_EQUAL(node, str)	string_equal(node, str, strlen(str))
+
 static bool stackleak_gate(void)
 {
 	tree section;
@@ -438,13 +455,13 @@ static bool stackleak_gate(void)
 	if (section && TREE_VALUE(section)) {
 		section = TREE_VALUE(TREE_VALUE(section));
 
-		if (!strncmp(TREE_STRING_POINTER(section), ".init.text", 10))
+		if (STRING_EQUAL(section, ".init.text"))
 			return false;
-		if (!strncmp(TREE_STRING_POINTER(section), ".devinit.text", 13))
+		if (STRING_EQUAL(section, ".devinit.text"))
 			return false;
-		if (!strncmp(TREE_STRING_POINTER(section), ".cpuinit.text", 13))
+		if (STRING_EQUAL(section, ".cpuinit.text"))
 			return false;
-		if (!strncmp(TREE_STRING_POINTER(section), ".meminit.text", 13))
+		if (STRING_EQUAL(section, ".meminit.text"))
 			return false;
 	}
 
-- 
2.30.2

