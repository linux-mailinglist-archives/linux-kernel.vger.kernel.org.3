Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A0554BF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbiFOBmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFOBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:42:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F12D35254;
        Tue, 14 Jun 2022 18:42:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z14so5176601pjb.4;
        Tue, 14 Jun 2022 18:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RM1736vw8chYXeHFe7e3lr1ecchAK8y6/yn77lePcYw=;
        b=IplICM+yMdz3vaL2+ZOfVGVFKpzZPXkiLvQQN/RDK76D9dB4cX0+w1LuFydCzZaNpB
         8qJggGssUWzpFkZd2OAfPZM6mXLRrWHWg+usVGRxIrquARShLmARBDWi02OcwhPKF7xS
         ZDd3fHNZF3+x8iFMsW8zwsZl5ewjojido/3CCUBbK3BprxhCmeSa24kQpZ4G+860DKIg
         b1pUl9gHW5X8fc8erljXUY/kpFbA+exj5TUX0l/0kQ0IgOBDt8yzEyLAHTGf5M7GZpNh
         r1JcxQGynXxv890Ymyn2pDBLffJYeOHzJo1B5hkifvOlUo6Sw947ityPAUDrs39HoWfv
         O1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RM1736vw8chYXeHFe7e3lr1ecchAK8y6/yn77lePcYw=;
        b=JKHoI3tmnWn/zROr/Ge7rZOmCpgj7EgpXnda5lj+V0KzaiJGC8hpMd1haTjumfNeNz
         8I1EJ2lYnjHTjWQ+vGcvWkGgB/zjwstc+tRnuF0A5+lkFceFdnRIefteiLnXS+4/dvY2
         NYtYZMfBcFDIhTCu1haonTd2g9OfJVe/LzbpsOHjEZ8/dK5gGwQdoJrZT08Fy/TQaU6w
         WtrxILSsffNG4nyHM28S82OAtw82uJTOaLNvEXYdgEhtlwNVOnldhdy1saf8WpdGBzk7
         rg96RyYTkm/iZUk0ZM4+SlPHqgvTujJRxv8ZpsexJjlR1ND5mrip6PZ91V3W/Uo615TP
         gIWQ==
X-Gm-Message-State: AOAM530BCWG8uTZKlEtSPjGF1M7e/RqOZOuhPgu/B5l33tzNB3z5ryEq
        HysYfpmcamFZfvrALwzSvCQ=
X-Google-Smtp-Source: AGRyM1uw/e5D6lAGbQnzjILGRoXMj8zFwKOjpbwkUjT3HY9Vb7x22Q09KQ8J8yXhrsJsakuYM1/yFQ==
X-Received: by 2002:a17:902:aa4b:b0:164:11ad:af0f with SMTP id c11-20020a170902aa4b00b0016411adaf0fmr7271481plr.54.1655257330847;
        Tue, 14 Jun 2022 18:42:10 -0700 (PDT)
Received: from rpi400.lan (c-73-70-190-118.hsd1.ca.comcast.net. [73.70.190.118])
        by smtp.gmail.com with ESMTPSA id 199-20020a6300d0000000b003f24d67d226sm8468197pga.92.2022.06.14.18.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:42:09 -0700 (PDT)
From:   Ian Rogers <rogers.email@gmail.com>
X-Google-Original-From: Ian Rogers <irogers@google.com>
Received: by rpi400.lan (Postfix, from userid 1001)
        id 447CC2FC2BA; Tue, 14 Jun 2022 18:42:08 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Subject: [PATCH] perf python: Avoid deprecation warning on distutils
Date:   Tue, 14 Jun 2022 18:42:06 -0700
Message-Id: <20220615014206.26651-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following DeprecationWarning:

tools/perf/util/setup.py:31: DeprecationWarning: The distutils
package is deprecated and slated for removal in Python 3.12. Use
setuptools or check PEP 632 for potential alternatives

Note: the setuptools module may need installing, for example:
sudo apt install python-setuptools

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/setup.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index c255a2c90cd6..5a3c74bce836 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -11,7 +11,7 @@ def clang_has_option(option):
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
 
 if cc_is_clang:
-    from distutils.sysconfig import get_config_vars
+    from sysconfig import get_config_vars
     vars = get_config_vars()
     for var in ('CFLAGS', 'OPT'):
         vars[var] = sub("-specs=[^ ]+", "", vars[var])
@@ -28,10 +28,10 @@ if cc_is_clang:
         if not clang_has_option("-ffat-lto-objects"):
             vars[var] = sub("-ffat-lto-objects", "", vars[var])
 
-from distutils.core import setup, Extension
+from setuptools import setup, Extension
 
-from distutils.command.build_ext   import build_ext   as _build_ext
-from distutils.command.install_lib import install_lib as _install_lib
+from setuptools.command.build_ext   import build_ext   as _build_ext
+from setuptools.command.install_lib import install_lib as _install_lib
 
 class build_ext(_build_ext):
     def finalize_options(self):
-- 
2.34.1

