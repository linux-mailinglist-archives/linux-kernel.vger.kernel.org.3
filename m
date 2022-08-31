Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141935A8580
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiHaS0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiHaSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E15FC30B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93ADA61CE3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F5FC4314A;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=ji7Ed4q5NuKbjIkgjEFzkBepKawEfl7hcBFRLDYPOOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jH5dGoI7dwzUvb9xbHnxXkdaEdEXKojiLHWsoVR+4UKLEFsutoqcSf/aLlBTn1RAb
         XZOagUdC7E/VQz6YnquoLWV/D2+MlmKScQrKDqT3qjrQ/FH2KttbbUby/gUxS03P6e
         eTXw/oVMp4c8QrnBabSALBpCIxcbU0InjC4PTZRUrmhHAY9hHtdmAzBuLaWzmOjUHE
         8BlFqmVmbRcTDFBm4f/kGBc4PdN2sVebVp74GBXYgxhi1cjwIdCi6vzsouqO8HONle
         4hcGt+cwtSCcrjXVe19CN8J2Rrcqwn0bV1YUTPCnchrTq2zuqsCxrJh/nEIMFf0faX
         CPPrAxV66jDDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E24F55C0AAE; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 09/18] selftests/nolibc: on x86, support exiting with isa-debug-exit
Date:   Wed, 31 Aug 2022 11:21:39 -0700
Message-Id: <20220831182148.2698489-11-paulmck@kernel.org>
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

QEMU, when started with "-device isa-debug-exit -no-reboot" will exit
with status code 2N+1 when N is written to 0x501. This is particularly
convenient for automated tests but this is not portable. As such we
only enable this on x86_64 when pid==1. In addition, this requires an
ioperm() call but in order not to have to define arch-specific syscalls
we just perform the syscall by hand there.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 291d96bfd7c12..eeb254749239c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -638,6 +638,15 @@ int main(int argc, char **argv, char **envp)
 		printf("Leaving init with final status: %d\n", !!ret);
 		if (ret == 0)
 			reboot(LINUX_REBOOT_CMD_POWER_OFF);
+#if defined(__x86_64__)
+		/* QEMU started with "-device isa-debug-exit -no-reboot" will
+		 * exit with status code 2N+1 when N is written to 0x501. We
+		 * hard-code the syscall here as it's arch-dependent.
+		 */
+		else if (my_syscall3(__NR_ioperm, 0x501, 1, 1) == 0)
+			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
+		/* if it does nothing, fall back to the regular panic */
+#endif
 	}
 
 	printf("Exiting with status %d\n", !!ret);
-- 
2.31.1.189.g2e36527f23

