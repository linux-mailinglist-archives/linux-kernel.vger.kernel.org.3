Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503BD4B790B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbiBOUuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:50:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbiBOUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:50:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61B0BC11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:49:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b187-20020a251bc4000000b0061e15c5024fso42976953ybb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BSIelYmbPm1PuRZo7j2Bm2YpHBp5n2KMNsW2+koRF9o=;
        b=OmOAzde3hQuPTuUUuGTkKQgKqvdyaE/pxNZKEZAB5iLQVTOdo20BMzFWWZZl5ZbEuO
         sd1n997b8ys5m/fBIWHZk3R3yVqnEhs3ac+tNR/QL3TbIKDeDc62lEtuIZ+MTihDeNt+
         /uMoEIQYhieWPpxjXMGJrySmFhr6E2Pz2jG4b9ZqxnGNp3uMfAKLGZPE310w3JihB6Ib
         OYleI1I1Od0cR5gz1VdeuTIKI4KRWWERhthYNiBNlzzfeN6M5islxffXtHWTDYPL/OBP
         oNw/HgJ2MVEPIIkZWMx+JbBuobi/Fc76/A58iX0Jry+a8W5t3vfGgWIhQw5UpJEYFWQ0
         sjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BSIelYmbPm1PuRZo7j2Bm2YpHBp5n2KMNsW2+koRF9o=;
        b=hOfGx4JoKF3WVAxSuKBa6qcB9rwkOtJDPIXZBue0B/9ajs5j18Xd/NdMLMqgtfkMON
         AoeB4C5ySOSG5nVXnrxBxx6TIy79AhFe20sUcfnKgvQykwLwibE46wctmcHU8kcIgWrb
         2P2YkSgbPRDBM8cxgclf7sGAft0vzvgqcoKSPK8xxrCZvy1QpPjnGq43c1Glrr1JQTp7
         CNBSTy5MZPFmHkN3jrnxqOGVKfjCeP/l9MqfITS0Gw69u3Dl4xQwn28W3dHB7WY47BcV
         VDsmBLpX0qmX3lj+53sy3N1Y+yFDq/W2gH3+E7gfc6faf4h9STrP25yMzb9SslzDK3GJ
         5LOg==
X-Gm-Message-State: AOAM5307dEj1DHcK8KotiYnHcSy1ef9Cs/pAK1k9LpVQh28cUaIdeDi0
        A4MP6Fb2Id55TYDhjW/fIPKE2dwGqY0XGldEhyM=
X-Google-Smtp-Source: ABdhPJzP9ryL032NQtZ90yOl34xGEV9EIKEu/dsnCdcGdVufhTNhFh8paAmrE7BnYvSQ/nYsBzO5GcuJqvTablHmSFk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:dfad:458b:9fb2:b77a])
 (user=ndesaulniers job=sendgmr) by 2002:a81:c501:: with SMTP id
 k1mr756814ywi.116.1644958191153; Tue, 15 Feb 2022 12:49:51 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:49:47 -0800
Message-Id: <20220215204947.1719516-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644958187; l=6237;
 s=20211004; h=from:subject; bh=KRPwLsTNNlHCWxCWXknX1SGak/+wjdb7pX5i8pARYhc=;
 b=MLcVqidAwW+ao1oHaVwGiibzFPdmdQSKX4iTNyUvI6u4uHIfv8BAO/pUH3DozcXFBD7mf8xaLcnQ
 OQKIrOg2BJTK0EvgDF4JpA04IH8tfxy/EXcxeGbLFrXi3Wg8qg0f
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH] Documentation/llvm: refresh docs for LLVM=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Yujie Liu <yujie.liu@intel.com>,
        Philip Li <philip.li@intel.com>, julie.du@intel.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Refresh the docs for 2022:
* add link to Chimera Linux.
* add Quick Start section pointing out that LLVM=1 is the simple
  recommended method.
* Re-order the sections on Clang and Cross Compiling to come after the
  section on LLVM utilities. I think the documentation flows better this
  way.
* Add note about LLVM=1 to Omitting CROSS_COMPILE section.
* Change note in Supported Architectures from discussing CC=clang vs.
  LLVM=1 to discussion LLVM=1 vs. LLVM_IAS=0.
* Update make command column of support architecture table; we now
  support LLVM=1 everywhere; just some more work to get ARCH=s390
  assembling with clang.
* Word wrap a few columns over 80 lines.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/kbuild/llvm.rst | 82 +++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index d32616891dcf..7f52cde70bc7 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -15,36 +15,27 @@ such as GCC and binutils. Ongoing work has allowed for `Clang
 <https://clang.llvm.org/>`_ and `LLVM <https://llvm.org/>`_ utilities to be
 used as viable substitutes. Distributions such as `Android
 <https://www.android.com/>`_, `ChromeOS
-<https://www.chromium.org/chromium-os>`_, and `OpenMandriva
-<https://www.openmandriva.org/>`_ use Clang built kernels.  `LLVM is a
+<https://www.chromium.org/chromium-os>`_, `OpenMandriva
+<https://www.openmandriva.org/>`_, and `Chimera Linux
+<https://chimera-linux.org/>`_ use Clang built kernels.  `LLVM is a
 collection of toolchain components implemented in terms of C++ objects
 <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM that
 supports C and the GNU C extensions required by the kernel, and is pronounced
 "klang," not "see-lang."
 
-Clang
------
+Quick Start
+-----------
+::
 
-The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
-``CC=`` should be set when selecting a config and during a build. ::
+	make LLVM=1
 
-	make CC=clang defconfig
+for native builds or
 
-	make CC=clang
+or ::
 
-Cross Compiling
----------------
+	ARCH=arm64 make LLVM=1
 
-A single Clang compiler binary will typically contain all supported backends,
-which can help simplify cross compiling. ::
-
-	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
-
-``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
-``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``. For
-example: ::
-
-	clang --target=aarch64-linux-gnu foo.c
+for cross compiling.
 
 LLVM Utilities
 --------------
@@ -63,6 +54,32 @@ They can be enabled individually. The full list of the parameters: ::
 The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
 disable it.
 
+Clang
+-----
+
+The compiler used can be swapped out via ``CC=`` command line argument to
+``make``.  ``CC=`` should be set when selecting a config and during a build.
+``CC=clang`` is implied by ``LLVM=1``, but if it's desired to simply use clang
+as the compiler for the target, then ``CC=`` is a quick substitute. ::
+
+	make CC=clang defconfig
+
+	make CC=clang
+
+Cross Compiling
+---------------
+
+A single Clang compiler binary will typically contain all supported backends,
+which can help simplify cross compiling. ::
+
+	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
+
+``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
+``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``.
+For example: ::
+
+	clang --target=aarch64-linux-gnu foo.c
+
 Omitting CROSS_COMPILE
 ----------------------
 
@@ -71,7 +88,8 @@ As explained above, ``CROSS_COMPILE`` is used to set ``--target=<triple>``.
 If ``CROSS_COMPILE`` is not specified, the ``--target=<triple>`` is inferred
 from ``ARCH``.
 
-That means if you use only LLVM tools, ``CROSS_COMPILE`` becomes unnecessary.
+That means if you use only LLVM tools via ``LLVM=1``, ``CROSS_COMPILE`` becomes
+unnecessary.
 
 For example, to cross-compile the arm64 kernel::
 
@@ -88,13 +106,13 @@ Supported Architectures
 LLVM does not target all of the architectures that Linux supports and
 just because a target is supported in LLVM does not mean that the kernel
 will build or work without any issues. Below is a general summary of
-architectures that currently work with ``CC=clang`` or ``LLVM=1``. Level
-of support corresponds to "S" values in the MAINTAINERS files. If an
-architecture is not present, it either means that LLVM does not target
-it or there are known issues. Using the latest stable version of LLVM or
-even the development tree will generally yield the best results.
-An architecture's ``defconfig`` is generally expected to work well,
-certain configurations may have problems that have not been uncovered
+architectures that currently work with ``LLVM=1`` but may need the integrated
+assembler disabled via ``LLVM_IAS=0``. Level of support corresponds to "S"
+values in the MAINTAINERS files. If an architecture is not present, it either
+means that LLVM does not target it or there are known issues. Using the latest
+stable version of LLVM or even the development tree will generally yield the
+best results.  An architecture's ``defconfig`` is generally expected to work
+well, certain configurations may have problems that have not been uncovered
 yet. Bug reports are always welcome at the issue tracker below!
 
 .. list-table::
@@ -112,16 +130,16 @@ yet. Bug reports are always welcome at the issue tracker below!
      - ``LLVM=1``
    * - mips
      - Maintained
-     - ``CC=clang``
+     - ``LLVM=1``
    * - powerpc
      - Maintained
-     - ``CC=clang``
+     - ``LLVM=1``
    * - riscv
      - Maintained
-     - ``CC=clang``
+     - ``LLVM=1``
    * - s390
      - Maintained
-     - ``CC=clang``
+     - ``LLVM=1 LLVM_IAS=0``
    * - x86
      - Supported
      - ``LLVM=1``

base-commit: c5d9ae265b105d9a67575fb67bd4650a6fc08e25
-- 
2.35.1.265.g69c8d7142f-goog

