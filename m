Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD655C8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiF0WPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242488AbiF0WPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:15:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0096158
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:14:58 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k11-20020a170902ce0b00b0016a15fe2627so5984973plg.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=halO5xko12XH4zAvHEKQ5zmzUmfFRvZ3Utz1WBQAJ5I=;
        b=TUZpSz6I66lTiZJ2+MuSpgF+LAKORQy/0IIF+rBC2wkqltFMsAqaBHMzmeSR4e/WNM
         pH3BFR1+sabdJ1Cm7szJBlUzHIXpwmqtrF2/Bfr+tlBxECw+DdwXlaWTqlNVclUJowpB
         gvQKICUg7AKfNjX3MyN95uhU7IeatqfsphKBHyQX/6gZu4Co2xWkKDheGxtrBQYlE0Vu
         XJMEP7O4DF0H8abEaL3al6Ne+rgOE31kMb0CirhkcvgHH2DTnjeaoBoiFN5si4r9uNiT
         ugo1zjjn2wNQ73iZMvT1daMd+DJh3P5CXBmovvEMcZ0eaBhiE95M1L+KG5wIMCdukUd+
         V4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=halO5xko12XH4zAvHEKQ5zmzUmfFRvZ3Utz1WBQAJ5I=;
        b=vuiO47NWQnB1x2zUZvyjbKxLxwP01X+AC/2bzglB74f5QGhcDQIMluy5bByzGy7EnT
         2TiVyR2JGrbuRnS5XWt2fHwr+P5fxw5Wf9AYo/wy+vhFcV+fe5uQwO8R5UvGKvuAPEjp
         Em36Imztbk//BKu/ehHEZZee1lxwxIkc20mVAmv1gWsEY64K0nquZSFpBcOgho77yLk1
         +ogCag7eINBv0KVf3EkPIVHLHffaHNyG55gKGnaW6hh04oZ9u72i7y08JQFrQq856lHC
         DG8o1zxlSAlzHNmewkedf3ZXF9xHS4lEgpBDKf8WrFy89WHla1K0Z4ygKGln1JjQ7aJ3
         Hp/g==
X-Gm-Message-State: AJIora/G42NoE30ui86xgmtTItiFch7pyVlf8d0r5klsbFXIgRpgrfc5
        PPZ/hnAAHuisfAbZVUewTYW1s+OEI4YL6w==
X-Google-Smtp-Source: AGRyM1vAMvaX4mJzFm94kAjnLXpyVtX5wLX2+N2wLhkC7vFFQZVZ5uMSFyMpzWEI+mp5RGyFoJJOc32uubYQBA==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:c402:b0:1e6:8254:3478 with SMTP
 id i2-20020a17090ac40200b001e682543478mr17726287pjt.101.1656368098261; Mon,
 27 Jun 2022 15:14:58 -0700 (PDT)
Date:   Mon, 27 Jun 2022 22:14:46 +0000
In-Reply-To: <20220627221446.82157-1-dlatypov@google.com>
Message-Id: <20220627221446.82157-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220627221446.82157-1-dlatypov@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 3/3] kunit: add coverage_uml.config to enable GCOV on UML
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

Now that kunit.py's --kunitconfig is repeatable, let's create a file to
hold the various options needed to enable coverage under UML.

This can be used like so:
$ ./tools/testing/kunit/kunit.py run \
  --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
  --kunitconfig=tools/testing/kunit/configs/coverage_uml.config \
  --make_options=CC=/usr/bin/gcc-6

which on my system is enough to get coverage working [1].

This is still a clunky command, but far better than before.

[1] at the time of this commit, I get:
  Overall coverage rate:
    lines......: 11.6% (34112 of 295033 lines)
    functions..: 15.3% (3721 of 24368 functions)

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v3: merge with kunitconfig refactor patch
---
 Documentation/dev-tools/kunit/running_tips.rst  |  3 +--
 tools/testing/kunit/configs/coverage_uml.config | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/kunit/configs/coverage_uml.config

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index c36f6760087d..205ea21c9cca 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -123,8 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
 .. code-block:: bash
 
 	# Append coverage options to the current config
-	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
-	$ ./tools/testing/kunit/kunit.py run
+	$ ./tools/testing/kunit/kunit.py run --kunitconfig=.kunit/ --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
 	# Extract the coverage information from the build dir (.kunit/)
 	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
 
diff --git a/tools/testing/kunit/configs/coverage_uml.config b/tools/testing/kunit/configs/coverage_uml.config
new file mode 100644
index 000000000000..bacb77664fa8
--- /dev/null
+++ b/tools/testing/kunit/configs/coverage_uml.config
@@ -0,0 +1,11 @@
+# This config fragment enables coverage on UML, which is different from the
+# normal gcov used in other arches (no debugfs).
+# Example usage:
+# ./tools/testing/kunit/kunit.py run \
+#   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
+#   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config
+
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_GCOV=y
-- 
2.37.0.rc0.161.g10f37bed90-goog

