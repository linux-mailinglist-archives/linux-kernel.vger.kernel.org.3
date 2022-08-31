Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDAD5A857D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHaS00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiHaSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C1FCA2C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F780B82278
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D613C43147;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=Cc1PozE4Kvo2KpHAs/2aNkgoLKg3JAhc3RNFnVGkdlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DonB0/CVLG3l2uQY+D8qFgEMnR1rFNq4Af5Svwo2EM5tXyCJm4wjRcUw1YLb3b9/L
         Kti+1NzP41QbSzjO7oqaB54J6asvqX7e0/d3Yp7DAIiFmxs/cGaVBvT3Y3zKQkZFt4
         BL1Ak7etLvMHCb8uk84YwcZ2wES2rt/xLqkAvMGu85khdbbprH+JiZgDP2DKD8zGfe
         YUBXqdCgZ5x0jbxNtd3eIug9+HR6O4I14ajmDQNdS3XAviHQZYiEyRdRGt2I35Z4Qv
         4duFMw1hdLZg6oSflkMXGAlh0FoVLTO+UNi5Rd58Nm9fRQX7f668CL5xSwKOtUYjyF
         8cSSaj9V/uMAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DEE785C09C2; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 07/18] selftests/nolibc: add a few tests for some libc functions
Date:   Wed, 31 Aug 2022 11:21:37 -0700
Message-Id: <20220831182148.2698489-9-paulmck@kernel.org>
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

The test series called "stdlib" covers some libc functions (string,
stdlib etc). By default they are automatically run after "syscall"
but may be requested in argument or in variable NOLIBC_TEST.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dc87832912ce4..b928f099431f7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -496,11 +496,46 @@ int run_syscall(int min, int max)
 	return ret;
 }
 
+int run_stdlib(int min, int max)
+{
+	int test;
+	int tmp;
+	int ret = 0;
+	void *p1, *p2;
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; // line length
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(getenv_TERM);        EXPECT_STRNZ(1, getenv("TERM")); break;
+		CASE_TEST(getenv_blah);        EXPECT_STRZR(1, getenv("blah")); break;
+		CASE_TEST(setcmp_blah_blah);   EXPECT_EQ(1, strcmp("blah", "blah"), 0); break;
+		CASE_TEST(setcmp_blah_blah2);  EXPECT_NE(1, strcmp("blah", "blah2"), 0); break;
+		CASE_TEST(setncmp_blah_blah);  EXPECT_EQ(1, strncmp("blah", "blah", 10), 0); break;
+		CASE_TEST(setncmp_blah_blah4); EXPECT_EQ(1, strncmp("blah", "blah4", 4), 0); break;
+		CASE_TEST(setncmp_blah_blah5); EXPECT_NE(1, strncmp("blah", "blah5", 5), 0); break;
+		CASE_TEST(setncmp_blah_blah6); EXPECT_NE(1, strncmp("blah", "blah6", 6), 0); break;
+		CASE_TEST(strchr_foobar_o);    EXPECT_STREQ(1, strchr("foobar", 'o'), "oobar"); break;
+		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
+		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
+		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
 
 /* This is the definition of known test names, with their functions */
 static struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "syscall",   .func = run_syscall  },
+	{ .name = "stdlib",    .func = run_stdlib   },
 	{ 0 }
 };
 
-- 
2.31.1.189.g2e36527f23

