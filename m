Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1691255F4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiF2EGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiF2EGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:06:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392335ABF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:06:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3178996424dso121620517b3.21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uIeiIEzFplvAzBGqNrgwb+/frtODXi7QQmCM1QfILf0=;
        b=fJHmG5+mqv6xEsnNUekE5yEFa9Y84/Dwll6IuK8Vbd49BBWd5c38s8lEanyPsyVS4l
         cVPrCli1On0lLPm5yWg64vfnpUPmTg6JlHZaOABFJC4nJaVpilSgler1JEBk667QO//H
         6hCtSUOPZP+5MmWzINIyZGJQR/HrtKi0lPdYymNQ9E89eGS5DgLcNhD23fJ+niqQPz6l
         Yy93pIT9nqOZIQI9CVWzNXTPWkcAMcms49T0fyEoUYzBx86Qji28Luum4Qr+tqm/dBWF
         RSKx+oLrSdgwyH2k/AGw2sFLGUgRe10c2gTsTSzi6HzG8ndh3Bpdl0KKwbNbC3mXBCIM
         Iv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uIeiIEzFplvAzBGqNrgwb+/frtODXi7QQmCM1QfILf0=;
        b=32Zu0lrIQEGrZoJXgdhE3+cma6BoTYCSA3u58SmLr/FFOy7VL1mnwQzxTkWB+MNebL
         AUOW5lSgO32QCujgcUxwL45GSmuOwXk+uONS+u2PseVwH0CHV6ahTtL8PIjaKTISeQ6+
         uRj7+XAOZUPrmzPT08PcxI7ZqWFYzywC69uoqj8ECN35/ztMuFJYWikJSnV/znGK01zI
         86VX2tfP6Zc50Ad+WTGFeOEzrOPhq81IgSnw3OTRPexcex+09+9vK/xXdyHiKugaERhb
         e/rrZ6FLoDNI88VrmpoCmNMlDv6o9w/YzH9fGI18N6SNqPLtmj73f3Vpwnr3xUklvpEk
         Dp5A==
X-Gm-Message-State: AJIora9JwQP+jGzTLZfd+KTDycq1cA2gyZsMnaSiaktpkoJ1vFSNGNKE
        6Nr4pLaUiuktRWI4Hcx0SF8gMgVNyo3lXA==
X-Google-Smtp-Source: AGRyM1vIGaCrak84h5u7xpU2uIQRe0z/mRue+DkZ/SLRycbxbAQ7DgAf/nv8cUt7MwPUsHTAF6wVHS5CVNMJsQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:24c7:0:b0:314:1e60:a885 with SMTP id
 k190-20020a8124c7000000b003141e60a885mr1721959ywk.301.1656475571200; Tue, 28
 Jun 2022 21:06:11 -0700 (PDT)
Date:   Wed, 29 Jun 2022 12:06:05 +0800
In-Reply-To: <20220626101553.1885428-1-davidgow@google.com>
Message-Id: <20220629040605.2395481-1-davidgow@google.com>
Mime-Version: 1.0
References: <20220626101553.1885428-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] Documentation: kunit: Cleanup run_wrapper, fix x-ref
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

The "Run Tests on qemu" section of run_wrapper.rst had a few issues left
over from the last big documentation refactor[1]:
- It referenced a non_uml.rst page, which was integrated into the other
  pages (including run_wrapper.rst).
- It skimmed over the use of --arch= and --cross_compile= in favour of
  using a custom --qemu_config. Since most users will want to use the
  former, let's give examples.

Remove the reference to the non-existant page, and add a couple of
examples to encourage the use of --arch= and --cross_compile=.

With this change, there should be no more broken references in the KUnit
documentation (i.e., the one mentioned in [2] is gone).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46201d47d6c4be594c1d57b7f3251c371626a9c4
[2]: https://lore.kernel.org/linux-doc/cover.1656234456.git.mchehab@kernel.org/

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220626101553.1885428-1-davidgow@google.com/
- Reword the --cross_compile example (Thanks Bagas Sanjaya)
- Fix the name of run_uml.rst -> non_uml.rst in the commit description.

---
 Documentation/dev-tools/kunit/run_wrapper.rst | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 653985ce9cae..5e560f2c5fca 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -192,6 +192,21 @@ via UML. To run tests on qemu, by default it requires two flags:
     if we have downloaded the microblaze toolchain from the 0-day
     website to a directory in our home directory called toolchains.
 
+This means that for most architectures, running under qemu is as simple as:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --arch=x86_64
+
+When cross-compiling, we'll likely need to specify a different toolchain, for
+example:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run \
+		--arch=s390 \
+		--cross_compile=s390x-linux-gnu-
+
 If we want to run KUnit tests on an architecture not supported by
 the ``--arch`` flag, or want to run KUnit tests on qemu using a
 non-default configuration; then we can write our own``QemuConfig``.
@@ -214,9 +229,6 @@ as
 		--jobs=12 \
 		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
 
-To run existing KUnit tests on non-UML architectures, see:
-Documentation/dev-tools/kunit/non_uml.rst.
-
 Command-Line Arguments
 ======================
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

