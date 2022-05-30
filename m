Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B0B537936
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiE3KjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiE3Kix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0A6B093;
        Mon, 30 May 2022 03:38:52 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cX2diM0hx2QDVuYjxjJ2Th0skcEyhMoeTFbxjTZ3Hyk=;
        b=WEXXVLug8xcM7tNeXVw0ROX3ip50mrSwc2wSGX/ypEV2tTdOnmxzZp4H5dt70Iin7Y9E7i
        8dLUIOACq8ygUWmjPoHJXnwUjiYmLnyghUITRoaDnBDuNbCeTpGCfzy5DjafFCRVjxDE/Y
        +sXXCBveCCbgOxmH/K/tbF5KBwW5IZqqhE0PheduxxOi/KK4FoI1lIZVbAluyMzo1I5sj4
        EBRYKXQQJE+8z3Eerhw0gEe0mWNfmY/zF99TrcxuhWUirNJRkleO3Hd0tmmMqhth6IYS41
        mynVZNliqRfUr50i3FIVdaMeidOiTeStL0nzetguX4ByhQFOY+xIzJsgbqwREw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cX2diM0hx2QDVuYjxjJ2Th0skcEyhMoeTFbxjTZ3Hyk=;
        b=4rGHFUqONaupfIYTEb0l9llHcsf8g7YvyH4fS5jjpZkcxzXC5VyRy+CBeZAQuyPpIrw2VT
        kuabXfHoTb93JXCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] jump_label,noinstr: Avoid instrumentation for
 JUMP_LABEL=n builds
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <165390712965.4207.7873247519209876133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     656d054e0a15ec327bd82801ccd58201e59f6896
Gitweb:        https://git.kernel.org/tip/656d054e0a15ec327bd82801ccd58201e59f6896
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 02 May 2022 12:30:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:44 +02:00

jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds

When building x86_64 with JUMP_LABEL=n it's possible for
instrumentation to sneak into noinstr:

vmlinux.o: warning: objtool: exit_to_user_mode+0x14: call to static_key_count.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_exit_to_user_mode+0x2d: call to static_key_count.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_exit_to_user_mode+0x1b: call to static_key_count.constprop.0() leaves .noinstr.text section

Switch to arch_ prefixed atomic to avoid the explicit instrumentation.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 107751c..bf1eef3 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -256,9 +256,9 @@ extern void static_key_disable_cpuslocked(struct static_key *key);
 #include <linux/atomic.h>
 #include <linux/bug.h>
 
-static inline int static_key_count(struct static_key *key)
+static __always_inline int static_key_count(struct static_key *key)
 {
-	return atomic_read(&key->enabled);
+	return arch_atomic_read(&key->enabled);
 }
 
 static __always_inline void jump_label_init(void)
