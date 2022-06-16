Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365C954EC41
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379096AbiFPVKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379085AbiFPVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:10:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC560B8E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:10:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s22-20020a252d56000000b0065d1ef35f9dso2084660ybe.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KURsuV8TI+ATVlfiPoD0dDzYcHxpBF6tQO88IJ4dTj0=;
        b=NPwKpqicoiF3JrI3nvAy2wavL/qdxmApmwUODLbg9kllBq3O7YIU7scvwDOn25KzpP
         jC0cGPcobMV2UjA/u/07U8UO5etg6EO+lETP0sa7aPA+g02oqAT2q4Zct/xj0RbRQss4
         0AgamnAU0JkWNr0r8gkXn5MTJtB0HBGC+WiYaoC841iycAdEdrtgE2TPt2nKA6MK9gVw
         ennDDk0WH1D9+ls4IAUfpDluG86Tyb5bV8IececwSKnTYyU42AMNcWhNMjFH/a6hN3iN
         /AIxCU6fkESR39R5t5poGacKGtADiZlwtEGJQmfePUEkviQSC9rObt9j2eCwa9UV+Az9
         zIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KURsuV8TI+ATVlfiPoD0dDzYcHxpBF6tQO88IJ4dTj0=;
        b=d4/F4Ewp0KLgNasV1Kk+EjDOVXk3CWHz3lAr61FTJkUhQazWd9JG5Q2BiSMJdF8aeA
         PSVpU0g3usn178d0mGS8kDRDNDxRfUCoEZg3t0OMOLO95A1/dtKwp0Q40221inWF9xSj
         dClsdxvJrIjZwKRHUPKsQEDmHksgMbNVfJwvyRJyEopODHorLRABb1+zy531kYvPWaIi
         vvTl6qcQborFYeHg9ZwoWXldnwOZQ+biB4HbVvZIITAmbicNc/JHcz5V9UVItoD6Zhvx
         f1Finq/ofLvMnBGPbBpB7yWteDigzmNN2qxqRp6lbEOZUe9SLNUlQwr1fZDuebexSzCm
         pi4w==
X-Gm-Message-State: AJIora8qZYtYl7wWak1K1UqFPgUS5QBwtoJwnWa0YcFbZ+c6pVc1Yc9f
        rPAlusldsGct/VgDg4zEFoQXea7Wp25mkdV3Rg==
X-Google-Smtp-Source: AGRyM1uyocs/VCv/SSpacc2XdE8qNYAeZuQBDEG16K8OvRmn50r0ngLRzhMzRvrsEd2ZP4RW/0B+YqsFlSSJK1o7sA==
X-Received: from pickles.svl.corp.google.com ([2620:15c:2cd:202:784d:8898:15c0:fd93])
 (user=dylanbhatch job=sendgmr) by 2002:a25:504d:0:b0:668:b120:6d0a with SMTP
 id e74-20020a25504d000000b00668b1206d0amr1304727ybb.584.1655413834064; Thu,
 16 Jun 2022 14:10:34 -0700 (PDT)
Date:   Thu, 16 Jun 2022 14:10:16 -0700
Message-Id: <20220616211016.4037482-1-dylanbhatch@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
From:   Dylan Hatch <dylanbhatch@google.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Dylan Hatch <dylanbhatch@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test would erroneously fail the /proc/$PID/maps case if
vsyscall=xonly since the existing probe of the vsyscall page only
succeeds if the process has read permissions. Fix this by checking for
either no vsyscall mapping OR an execute-only vsyscall mapping in the
case were probing the vsyscall page segfaults.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 28604c9f805c..5ca85520131f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -213,9 +213,12 @@ static int make_exe(const uint8_t *payload, size_t len)
 
 static bool g_vsyscall = false;
 
-static const char str_vsyscall[] =
+static const char str_vsyscall_rx[] =
 "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
 
+static const char str_vsyscall_x[] =
+"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
+
 #ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 {
@@ -261,6 +264,7 @@ int main(void)
 	int exec_fd;
 
 	vsyscall();
+	const char *str_vsyscall = g_vsyscall ? str_vsyscall_rx : str_vsyscall_x;
 
 	atexit(ate);
 
@@ -314,7 +318,8 @@ int main(void)
 
 	/* Test /proc/$PID/maps */
 	{
-		const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
+		const size_t len_buf0 = strlen(buf0);
+		const size_t len_vsys = strlen(str_vsyscall);
 		char buf[256];
 		ssize_t rv;
 		int fd;
@@ -325,11 +330,16 @@ int main(void)
 			return 1;
 		}
 		rv = read(fd, buf, sizeof(buf));
-		assert(rv == len);
-		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
 		if (g_vsyscall) {
-			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
+			assert(rv == len_buf0 + len_vsys);
+		} else {
+			/* If vsyscall isn't readable, it's either x-only or not mapped at all */
+			assert(rv == len_buf0 + len_vsys || rv == len_buf0);
 		}
+		assert(memcmp(buf, buf0, len_buf0) == 0);
+		/* Check for vsyscall mapping if buf is long enough */
+		if (rv == len_buf0 + len_vsys)
+			assert(memcmp(buf + len_buf0, str_vsyscall, len_vsys) == 0);
 	}
 
 	/* Test /proc/$PID/smaps */
-- 
2.36.1.476.g0c4daa206d-goog

