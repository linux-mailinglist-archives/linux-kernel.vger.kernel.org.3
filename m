Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2E5060D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbiDSASY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbiDSASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690EC140BC;
        Mon, 18 Apr 2022 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5346261342;
        Tue, 19 Apr 2022 00:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB7C385BF;
        Tue, 19 Apr 2022 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327327;
        bh=NKVth+gfOmO3QLXYe/5IPSeGXFvTVCqstq4rU8c6jlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKJMYb/09FMBmu2B0GdsjPRrD6dnVgBFD+J25blppA9J5/v6HNz9o9jbeXFo3KdhI
         zQd8zbFj8YsuPTgkk70oD6DAYUnVpni6ze7pcWfuBznjXx3uC4YelH7JX+d2bq0/gZ
         90AEMEfng3NRBzZDghHxSKD38dGlW6VqCFlua5CRmVX0+8V9P6VdP+UHwQ6luGfxPK
         w4XbGvhhIALj905/SG6IXuUo3TyFGZ30M/r644YSuvuwU1QNmvmfXwerPYO7h07FMh
         X35Dk3xCK563MJCSSu4pInNci4sw4Es875LxSk+cjlBZDvByledecQHniJiAVUq98f
         0z+PSDhcmBTHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D46335C1308; Mon, 18 Apr 2022 17:15:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/12] rcutorture: Make kvm.sh allow more memory for --kasan runs
Date:   Mon, 18 Apr 2022 17:15:23 -0700
Message-Id: <20220419001525.3950505-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
References: <20220419001519.GA3950405@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN allots significant memory to track allocation state, and the amount
of memory has increased recently, which results in frequent OOMs on a
few of the rcutorture scenarios.  This commit therefore provides 2G of
memory for --kasan runs, up from the 512M default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index af58b86a503a..263e16aeca0e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -44,6 +44,7 @@ TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
+torture_qemu_mem_default=1
 TORTURE_REMOTE=
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
@@ -180,6 +181,10 @@ do
 		;;
 	--kasan)
 		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
+		if test -n "$torture_qemu_mem_default"
+		then
+			TORTURE_QEMU_MEM=2G
+		fi
 		;;
 	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
@@ -202,6 +207,7 @@ do
 	--memory)
 		checkarg --memory "(memory size)" $# "$2" '^[0-9]\+[MG]\?$' error
 		TORTURE_QEMU_MEM=$2
+		torture_qemu_mem_default=
 		shift
 		;;
 	--no-initrd)
-- 
2.31.1.189.g2e36527f23

