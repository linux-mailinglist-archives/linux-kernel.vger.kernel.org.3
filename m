Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D94EAA97
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiC2Jd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiC2JdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:33:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8A123422
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:31:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d7so23891796wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mol8cznyjFxndyug6ujfLFzjwVmzbwHtru6cjLlZhCo=;
        b=GFSuTgep9fw97+Fe9X/KjoPCWdufLmIv+PeBPByVwYsOgJaC9oTfSCd0l7GqCL8Dcm
         m8zb41DZm1P8YO9lq30AG64cwwH2zk/8ykqC8gqzu7Hsf40oNGcfSR81qWAWYRfISZuu
         kEi0+Zl/BEb3r4oSa56Tx2xjTJSSjgeksL5cpVRBm/Om/fj1Tz+s3i1MvRmO4USSXKQl
         tmiZWCxZxSKACyxnjDO+RyDOs++KxtODBeUci0HlujnEtxVOTnq3dMJ2kmXzhjXwLwir
         IQ24gRhXr9v1dez+6wkgOVcTteaj4BCNTL8VOlNWam4nNG2tFQzn7QNIhUnqvC0OC5o9
         uGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mol8cznyjFxndyug6ujfLFzjwVmzbwHtru6cjLlZhCo=;
        b=qID9EOvRD/OPKx0CAiChT013y65QerxqlRHfCR1oiI97zY4gaMPD955MC535FA+3r6
         Q1WYIrxt3RILxOe84wQ1E3dzRNGdv2doaHLkKe5mIhAvMwL2+AznX07cN73w3kLPviSV
         yE73WmjIjtRGZaoGZ/W/AuFBdjOQLktf4nyVG3zkBKJRbFlar4cLS1WgoZIlXSttEYG0
         Jt36LdisP86ZOnDTJZoCeM5wA1wlhwl24FEpH1I66Mnw0yIXlD5CqYqMMEsJ4lFjgOd1
         K8lzAedzElWb8dYBHNUuoWnJtqTyPVXahKZSOadU+ZgkgMl684pQKqkJaotG2QH6vSxh
         QHJA==
X-Gm-Message-State: AOAM533XW+DgVmZz+GX+tnrGI8ISxPx3N2RuugvDXDRNcLZZzVMUeYE3
        zwzQdo6C1xilFCLnAgw/0jM7rA==
X-Google-Smtp-Source: ABdhPJwTZJc+0rU8LMKH4R6JCPF3SK5AElUoxXMtiJSUpVgNsGc1NvdKq51N3f/Ghl14dUK4u7/0TA==
X-Received: by 2002:a05:6000:181a:b0:205:9051:ab6d with SMTP id m26-20020a056000181a00b002059051ab6dmr29548959wrh.191.1648546298260;
        Tue, 29 Mar 2022 02:31:38 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm17480711wrd.31.2022.03.29.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:31:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH perf] perf tools: .git/ORIG_HEAD might not exist
Date:   Tue, 29 Mar 2022 11:31:20 +0200
Message-Id: <20220329093120.4173283-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems it cannot be assumed .git/ORIG_HEAD exists if .git/HEAD is
there.

Indeed, recently our public CI reported[1] the following error when
compiling Perf tool:

  $ cd tools/perf
  $ make -j4 -l4 O=/tmp/(...)/perf DESTDIR=/usr install
  (...)
  make[2]: *** No rule to make target '../../.git/ORIG_HEAD', needed by '/tmp/(...)/perf/PERF-VERSION-FILE'.

This is because apparently[2] Cirrus Ci uses a Git client implemented
purely in Go[3] to perform a clone. Most likely, this tool doesn't
create any .git/ORIG_HEAD file but .git/HEAD is there. The error can
indeed be reproduced by renaming this .git/ORIG_HEAD file while keeping
.git/HEAD. In other words, it means it is not enough to check the
presence of .git/HEAD to assume .git/ORIG_HEAD exists as well.

With the modification here, the version file is always regenerated if
.git/ORIG_HEAD file is not present. But that is not an issue as kernel
devs probably don't use such tools in their dev env and it can be
assumed for them that they have both .git/HEAD and .git/ORIG_HEAD files.

[1] https://cirrus-ci.com/task/5673396527693824?logs=test#L5026
[2] https://cirrus-ci.org/guide/tips-and-tricks/
[3] https://github.com/go-git/go-git

Fixes: 4e666cdb06ee ("perf tools: Fix dependency for version file creation")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/perf/Makefile.perf | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9c935f86d172..2f64e4904bbb 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1143,10 +1143,12 @@ endif
 # Trick: if ../../.git does not exist - we are building out of tree for example,
 # then force version regeneration:
 #
+GIT-HEAD-PHONY =
 ifeq ($(wildcard ../../.git/HEAD),)
-    GIT-HEAD-PHONY = ../../.git/HEAD ../../.git/ORIG_HEAD
-else
-    GIT-HEAD-PHONY =
+    GIT-HEAD-PHONY += ../../.git/HEAD
+endif
+ifeq ($(wildcard ../../.git/ORIG_HEAD),)
+    GIT-HEAD-PHONY += ../../.git/ORIG_HEAD
 endif
 
 FORCE:

base-commit: ab0809af0bee88b689ba289ec8c40aa2be3a17ec
-- 
2.34.1

