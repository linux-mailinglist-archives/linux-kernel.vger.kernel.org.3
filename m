Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB24A7426
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiBBPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345317AbiBBPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:00:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB060C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:00:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A641AB83118
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64614C004E1;
        Wed,  2 Feb 2022 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643814000;
        bh=tD/khbOVNufPcC6Di2abvTiRxrIVfIxefQCq92Qvzmc=;
        h=From:To:Cc:Subject:Date:From;
        b=QK7S66uegOZ/bjXgelI2EE2+UtC3hyNcUlv0fKucGq6UJInT94Gw0i02cYTU9ilDk
         ghyxiGw1H3luwrzVK8tRZth8xzjEvZZCoXJu8ubSWVrLdcQxBSh+tJ+F0KndM8FfKM
         D43p3bFi7PI2D9cXKL55ImnDpRa2BunoZAbzl6tp7d5Ii5QJ3ev0D/Cuh7pbqtLD3L
         8T8dxmjP2dUyLhTS9I1rXFBBCsMD0euZI8ZP46Qdwi9SPaJYgdw76fByVR6n5MzHhU
         pK2amGesJGGmPaiivbNjPI4W4u7k4ycgQaHsLznsv2RD2DIq+iel+l1KTjmYhdfz/C
         afxF7XK9e+GBA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers
Date:   Wed,  2 Feb 2022 15:59:54 +0100
Message-Id: <20220202145954.458370-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Displaying "PREEMPT" on kernel headers when CONFIG_PREEMPT_DYNAMIC=y
can be misleading for anybody involved in remote debugging because it
is then not guaranteed that there is an actual preemption behaviour. It
depends on default Kconfig or boot defined choices.

Therefore, tell about PREEMPT_DYNAMIC on static kernel headers and leave
the search for the actual preemption behaviour to browsing dmesg.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 init/Makefile       |  3 ++-
 scripts/mkcompile_h | 15 +++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/init/Makefile b/init/Makefile
index 06326e304384..d82623d7fc8e 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -31,7 +31,8 @@ quiet_cmd_compile.h = CHK     $@
       cmd_compile.h = \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
 	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
-	"$(CONFIG_PREEMPT_RT)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
+	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
+	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
 
 include/generated/compile.h: FORCE
 	$(call cmd,compile.h)
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 6a2a04d92f42..f4d6ca3c6fd7 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -5,9 +5,10 @@ TARGET=$1
 ARCH=$2
 SMP=$3
 PREEMPT=$4
-PREEMPT_RT=$5
-CC_VERSION="$6"
-LD=$7
+PREEMPT_DYNAMIC=$5
+PREEMPT_RT=$6
+CC_VERSION="$7"
+LD=$8
 
 # Do not expand names
 set -f
@@ -41,7 +42,13 @@ fi
 UTS_VERSION="#$VERSION"
 CONFIG_FLAGS=""
 if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
-if [ -n "$PREEMPT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"; fi
+if [ -n "$PREEMPT" ] ; then
+	if [ -n "$PREEMPT_DYNAMIC" ] ; then
+		CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC";
+	else
+		CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT";
+	fi
+fi
 if [ -n "$PREEMPT_RT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"; fi
 
 # Truncate to maximum length
-- 
2.25.1

