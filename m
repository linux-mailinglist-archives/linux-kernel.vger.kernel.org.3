Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD65A8588
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiHaS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHaSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E21F2C2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2998B82282
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D974C4314B;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=fmmGXrtft4WY+vYxlsPoch8NfKf9311WO6goU05GNWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKiFWYHWw3ttCgjlsyc2E1INvfoTWR9OpKuHkufgBVo5RJr1haye3k19z1zICIyDb
         Y45L3NkcrTYqzl/LkYwzg5PEUkYcD805Z7uE2apsuloFYftTH4YQzhM7j/d3XNuoeg
         MfL5xtC8p0wpAAX4Fs3nPbsVNVt7zWosCh7uyJS3Fad2BLZJWZokgEL4qUOSu70PDc
         9RUgK9CLEwMyHj5aXhhiZSORjNQ6LdA+Kve3cAd59VQudoFtoQJ0AxO0HHReRvjiHM
         2fuvLc4A7HqzuLtjUP63Xr8qhwsDIrDvVXgVDm0GuyUcYzk23lmoSRE2BdoTjM/Pr/
         fdcXIe0stWfYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E09525C0A6B; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 08/18] selftests/nolibc: exit with poweroff on success when getpid() == 1
Date:   Wed, 31 Aug 2022 11:21:38 -0700
Message-Id: <20220831182148.2698489-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The idea is to ease automated testing under qemu. If the test succeeds
while running as PID 1, indicating the system was booted with init=/test,
let's just power off so that qemu can exit with a successful code. In
other situations it will exit and provoke a panic, which may be caught
for example with CONFIG_PVPANIC.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b928f099431f7..291d96bfd7c12 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -626,6 +626,20 @@ int main(int argc, char **argv, char **envp)
 	}
 
 	printf("Total number of errors: %d\n", ret);
+
+	if (getpid() == 1) {
+		/* we're running as init, there's no other process on the
+		 * system, thus likely started from a VM for a quick check.
+		 * Exiting will provoke a kernel panic that may be reported
+		 * as an error by Qemu or the hypervisor, while stopping
+		 * cleanly will often be reported as a success. This allows
+		 * to use the output of this program for bisecting kernels.
+		 */
+		printf("Leaving init with final status: %d\n", !!ret);
+		if (ret == 0)
+			reboot(LINUX_REBOOT_CMD_POWER_OFF);
+	}
+
 	printf("Exiting with status %d\n", !!ret);
 	return !!ret;
 }
-- 
2.31.1.189.g2e36527f23

