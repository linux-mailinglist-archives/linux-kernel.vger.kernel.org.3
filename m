Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7168C54CEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356221AbiFOQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348146AbiFOQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC33C7B;
        Wed, 15 Jun 2022 09:32:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso2575434pjk.0;
        Wed, 15 Jun 2022 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEfnqww0vhMlkVHiAk0LS1yqqikkfJ8P8/TMa6OHIgk=;
        b=pVULSWm1v8HJ3x39vt+zJEuX905ymHetz97g76i4hkrDv1/vjIrq3kpEifIvu5MxOr
         2qDZr6bOfE8kZzcabDhPJY7awFZMPOyNh91Icp1nuWhmPc+JhL/8Kt38VpattRAFDeOZ
         pki3VDAtDz7xopAMLTVSHOBm5LDoF02Rsvr2Q2L4zzwySfY9rA6iRlRkRNzLtk3f/U+6
         3CD8YY17KL9JrG1Ph9j1oOb/1iIiknoU1kF7N/KJUhYlxhIL5GgqS+au2j3e/becV8XS
         SPpeoF7IDJTxNjv7OAkyvDIEmP0vd27vGataP6J5xrYGlGb3yQ2BlTo3Ji90zPy3OPwJ
         zfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SEfnqww0vhMlkVHiAk0LS1yqqikkfJ8P8/TMa6OHIgk=;
        b=k9DJVueNkKYV4000icyalB1Ob8WfuG3+Hny1SCurbVZWvzcojXMBQNpHkwD8h94hYa
         57Yx71alRpx9n6CGTTsWRDzFKn5GmDTHpvxYwMN6fnihjRq7qUW9Cy5sNSlO73Kwb8Is
         tCm6+6ySC8zmElwCy/cEUMAVLRaOOzUCXp+AdmslKUXelAkifLuPzZYNEVY5m2VWDe59
         VXUrDcSkP06sln6LDF4Ch3Bf1C+Cbuj7jgVmuePQ6duMgJC1us4dluHulAW5ykK/2Qaj
         CrOqxafH/5VU9yxRq3Vr37+jV5EZPnw/2GXn967WdkyMKCBjKxZysbirUU5Ys+90q2dB
         hHSg==
X-Gm-Message-State: AJIora+bth/NXcvzNaWrFILuZfSlKyizae57UFSw1fhsMKI4RnA+M11l
        d9yBDeUhfMS2jUxmThVncBY=
X-Google-Smtp-Source: AGRyM1vMDUaakpBkI+Ebb9s7inI0Xj0cvuVf8NoHbN/yu5jJHpwMj6mLO/Pb55P266slffVhpdLfUg==
X-Received: by 2002:a17:90b:2241:b0:1e8:8ad8:5f22 with SMTP id hk1-20020a17090b224100b001e88ad85f22mr11104674pjb.73.1655310748910;
        Wed, 15 Jun 2022 09:32:28 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/7] perf lock: Allow to use different kernel symbols
Date:   Wed, 15 Jun 2022 09:32:17 -0700
Message-Id: <20220615163222.1275500-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --vmlinux and --kallsyms options to support data file from
different kernels.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt | 7 +++++++
 tools/perf/builtin-lock.c              | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 656b537b2fba..4b8568f0c53b 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -46,6 +46,13 @@ COMMON OPTIONS
 --force::
 	Don't complain, do it.
 
+--vmlinux=<file>::
+        vmlinux pathname
+
+--kallsyms=<file>::
+        kallsyms pathname
+
+
 REPORT OPTIONS
 --------------
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 57e396323d05..118a036a81fb 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1162,6 +1162,10 @@ int cmd_lock(int argc, const char **argv)
 	OPT_INCR('v', "verbose", &verbose, "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace, "dump raw trace in ASCII"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
+	OPT_STRING(0, "vmlinux", &symbol_conf.vmlinux_name,
+		   "file", "vmlinux pathname"),
+	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
+		   "file", "kallsyms pathname"),
 	OPT_END()
 	};
 
-- 
2.36.1.476.g0c4daa206d-goog

