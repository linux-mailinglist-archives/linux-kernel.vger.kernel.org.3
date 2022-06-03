Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165FF53D28F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbiFCT6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348160AbiFCT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:57:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127C1F610
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:57:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i4-20020a25f204000000b006607ca067baso3012104ybe.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+0BJkP7LQA7GM1MPeGO3z/t5dz9swoXFRqhRmsZFFPo=;
        b=XgqsCrfxLrG3S04UfcYNJfVoH5ccnQjNtz4xJnA0tnNYj8f3CmKGcspLcmL9hzGQkN
         zOLnmRdyHyyR36jS7Osm5HwK09Ft3Ql4i9E/JnNdaTh+V/bcWCMhFSK1feT/tqnw1AE6
         76DCh1hY0Q36NB4nLsVDbBIrKkI0lyuVbktdsxtLAIlHDziorFLtHlrbjC8M13/wC2nP
         4BlN0e57iMF3pO47ug5R6MOZGMO0SdwLiPCNcpskuEmOryKg6XnqA9U4oNPHgvqYJXA5
         0SJR8CQneq6FyS7nADbHPFJsILTJsrs8J7S5SjE/3CoQtn3CdV+BE+JL0v+OQb6efoLk
         ynOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+0BJkP7LQA7GM1MPeGO3z/t5dz9swoXFRqhRmsZFFPo=;
        b=cfZcv7+2Kuph1eK76zwD0o3F85xNSq0ks1cD7MLhbU1kyTCBY4LTEf3N705KSOLIX9
         7z55PI83c6hrXeo16PpBUeHMZiF6BhuCBfq7Rl3ENPxLrl2+geJpfnInE/elTM6JcMsn
         LAJkcsnj4r8Jh0BcHYjmGiP9KM+zC8p4XkMI/JoiZswIpPVol7nM/BANRDPyXk6JRIzO
         lUkNvCG0U1GSYy1H3ajP0U5IaM6ImH/tgzBN2ABEg5+iJq9soky9VBhXOhnvMw6j1SC1
         yKaFfq3KxaYbTYyqniN4IJZJmjQJWMbUvk3Z3e23OuxHwgMYSMN9DgOtNpL4Sr5HVfdA
         rZbg==
X-Gm-Message-State: AOAM531ZgeSM8Yookg3oY+9AK0a9TiEv0FUlVetMtkr6jDcgBPcNY2PV
        E5ofydOk2ZnKwcxHbLb3GuAOkqr4qxxK9g==
X-Google-Smtp-Source: ABdhPJwHQHGSl3m9zUFvEI3sbSQwNUh2f2XGX55AQDH0UH+u9m6F6gc6Zk1TgV+GsgfajBktCzXA3OPsTcHVwg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9ff0:c6ec:46df:8f8a])
 (user=dlatypov job=sendgmr) by 2002:a25:9cc5:0:b0:65c:c760:9e34 with SMTP id
 z5-20020a259cc5000000b0065cc7609e34mr12465282ybo.518.1654286264235; Fri, 03
 Jun 2022 12:57:44 -0700 (PDT)
Date:   Fri,  3 Jun 2022 12:56:26 -0700
In-Reply-To: <20220603195626.121922-1-dlatypov@google.com>
Message-Id: <20220603195626.121922-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220603195626.121922-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 3/3] Documentation: kunit: rewrite section on .kunitconfig
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
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

This section was slightly out of date and redundant.
* the `note` was obsolete since commit 4c2911f1e140 ("kunit: tool:
  reconfigure when the used kunitconfig changes")
* we don't want users to grab the default config manually, running
  kunit.py config/build/run will do that for them as noted in the
  section above.

This rewrite tries to pull back the curtain and show that .kunitconfig
isn't magic by giving some example commands a user can run to emulate
kunit.py.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 47 +++++++------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 1fccf2e099f7..e0ddd18f8c2e 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -57,45 +57,32 @@ To view kunit_tool flags (optional command-line arguments), run:
 
 	./tools/testing/kunit/kunit.py run --help
 
-Create a  ``.kunitconfig`` File
-===============================
-
-If we want to run a specific set of tests (rather than those listed
-in the KUnit ``defconfig``), we can provide Kconfig options in the
-``.kunitconfig`` file. For default .kunitconfig, see:
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/kunit/configs/default.config.
-A ``.kunitconfig`` is a ``minconfig`` (a .config
-generated by running ``make savedefconfig``), used for running a
-specific set of tests. This file contains the regular Kernel configs
-with specific test targets. The ``.kunitconfig`` also
-contains any other config options required by the tests (For example:
-dependencies for features under tests, configs that enable/disable
-certain code blocks, arch configs and so on).
+.kunitconfig
+============
 
-To create a ``.kunitconfig``, using the KUnit ``defconfig``:
+We mentioned it above, but a ``.kunitconfig`` is a *minconfig*, i.e. you only
+need to specify the options you care about, e.g.
 
 .. code-block::
 
-	cd $PATH_TO_LINUX_REPO
-	cp tools/testing/kunit/configs/default.config .kunit/.kunitconfig
+	CONFIG_KUNIT=y
+	CONFIG_KUNIT_EXAMPLE_TEST=y
 
-We can then add any other Kconfig options. For example:
+Concretely, here's more or less what ``kunit.py run`` does by default:
 
-.. code-block::
+.. code-block:: bash
 
-	CONFIG_LIST_KUNIT_TEST=y
+   $ cp $KUNITCONFIG .kunit/.config
+   $ make O=.kunit ARCH=um olddefconfig
+   $ make O=.kunit ARCH=um -j `nproc`
+   $ .kunit/linux </dev/null 2>&1 | ./tools/testing/kunit/kunit.py parse
 
-kunit_tool ensures that all config options in ``.kunitconfig`` are
-set in the kernel ``.config`` before running the tests. It warns if we
-have not included the options dependencies.
+See `Parse Test Results`_ for more details about ``kunit.py parse``.
 
-.. note:: Removing something from the ``.kunitconfig`` will
-   not rebuild the ``.config file``. The configuration is only
-   updated if the ``.kunitconfig`` is not a subset of ``.config``.
-   This means that we can use other tools
-   (For example: ``make menuconfig``) to adjust other config options.
-   The build dir needs to be set for ``make menuconfig`` to
-   work, therefore  by default use ``make O=.kunit menuconfig``.
+  .. note:: Note: ``make olddefconfig`` will drop ``CONFIG`` options that aren't visible
+            (e.g. are inside an unsatisfied ``if`` block) or have missing dependencies.
+            kunit.py will validate every option in ``$KUNITCONFIG`` is present in the final
+            ``.config``, so it should be safer and less error-prone than doing this manually.
 
 Configure, Build, and Run Tests
 ===============================
-- 
2.36.1.255.ge46751e96f-goog

