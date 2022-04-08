Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C54F9F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiDHVxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiDHVxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:53:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84C26B580
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:51:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so7744697ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NOC+O5Rk8+8ShoFYS0hhE9T1UfuRrDXF6xCi+hMGyBQ=;
        b=XjBxxOXa5KPARVD93nVU1PCPhpRzGSxqlSWNIxj3oRrCKudJHAs95kv07q6+GghFvX
         oaJoYjigTxz0b1aDNfVmbQVZRCf4P9gXO/TU/3p5TYObgUSq3+ssLnCz4YxkyR6njYXc
         wQeARHuISMs69hv2Q9z1t1b0tJwalmDS0DaM8rjiPJ7nbnMOFWQ+im0RFTFaP/MKrrj3
         sn3PKwmPHOkezhHg3mgjlRj7ModvuSYfBe+FK+4P3D54W+zBMRpIM7CzlQEgMZ2MqfBl
         pmyTNDCEq0u9CEMm2ydWKvKV0+rPS7xhikaCMov6bhpiDA9R4lW3A+4x/AP19wOsPu5J
         m3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NOC+O5Rk8+8ShoFYS0hhE9T1UfuRrDXF6xCi+hMGyBQ=;
        b=G/AfYcU2cS0j6uwhZiXagFLGJ2X8deQ/LSuaHq24zT1LS6NsUv4mMOn3+bc+blaKqQ
         7+pDrXUasbOALZtiH0I/3V/1VV+AIm4L7dKAlZw6q26ThIi5ixrvlM+oX5HaJaPWVyBC
         PuNM9bwwZxmkSOT89rexihs1A7R24W1Vxxp6iJkKHyei9rVtCDlknsr6bEk1ki9Dsvmm
         vkw5IKNCUX9XNIWFCgsX3MYaSe68G+bY1aiXzn4dRXHhvNh4c0gw53zyxKjqC9jFBcsx
         2UBTbbaYIzEQmneG1/l5rtoKOGppAHNgFDBubugByaMhaYraVEBzO5XOwocGHgLSyzLv
         egjQ==
X-Gm-Message-State: AOAM531NdEGKGd80bEB2iaRdMVtFZHc6WNttELG0YvBEU6ynhWqtCcWV
        ThZts5Aw+/JaSlRfPJMNf/j+YiIrNxAv7A==
X-Google-Smtp-Source: ABdhPJz06hvO8hFK2NmiMF2rMjE9pvCU0IHQpAyb+mBh3zQ9EzxqqJFvzX4a4z9+k3VLFdE81w1UkoBtq0R0fA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:5da8:b87d:4887:c585])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:114a:b0:63d:fcc5:5075 with SMTP
 id p10-20020a056902114a00b0063dfcc55075mr16956209ybu.277.1649454673546; Fri,
 08 Apr 2022 14:51:13 -0700 (PDT)
Date:   Fri,  8 Apr 2022 14:51:05 -0700
Message-Id: <20220408215105.2332902-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2] kunit: tool: update test counts summary line format
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before:
> Testing complete. Passed: 137, Failed: 0, Crashed: 0, Skipped: 36, Errors: 0

After:
> Testing complete. Ran 173 tests: passed: 137, skipped: 36

Even with our current set of statuses, the output is a bit verbose.
It could get worse in the future if we add more (e.g. timeout, kasan).
Let's only print the relevant ones.

I had previously been sympathetic to the argument that always
printing out all the statuses would make it easier to parse results.
But now we have commit acd8e8407b8f ("kunit: Print test statistics on
failure"), there are test counts printed out in the raw output.
We don't currently print out an overall total across all suites, but it
would be easy to add, if we see a need for that.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
Changes:
v1: https://lore.kernel.org/linux-kselftest/20220407223019.2066361-1-dlatypov@google.com/
Combined with the patch David posted in reply after some bikeshedding
about the format.

Now this patch will print the total # of tests as well.
---
 tools/testing/kunit/kunit_parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 807ed2bd6832..de1c0b7e14ed 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -94,11 +94,11 @@ class TestCounts:
 	def __str__(self) -> str:
 		"""Returns the string representation of a TestCounts object.
 		"""
-		return ('Passed: ' + str(self.passed) +
-			', Failed: ' + str(self.failed) +
-			', Crashed: ' + str(self.crashed) +
-			', Skipped: ' + str(self.skipped) +
-			', Errors: ' + str(self.errors))
+		statuses = [('passed', self.passed), ('failed', self.failed),
+			('crashed', self.crashed), ('skipped', self.skipped),
+			('errors', self.errors)]
+		return f'Ran {self.total()} tests: ' + \
+			', '.join(f'{s}: {n}' for s, n in statuses if n > 0)
 
 	def total(self) -> int:
 		"""Returns the total number of test cases within a test

base-commit: b04d1a8dc7e7ff7ca91a20bef053bcc04265d83a
-- 
2.35.1.1178.g4f1659d476-goog

