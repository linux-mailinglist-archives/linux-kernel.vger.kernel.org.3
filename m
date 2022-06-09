Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758D454435B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiFIF5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFIF46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:56:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2889C23BE4;
        Wed,  8 Jun 2022 22:56:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id r1so2207526plo.10;
        Wed, 08 Jun 2022 22:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmb76XFaytNa5GMenz/Iq3bisUs3tEEphpm082+YSy8=;
        b=mmoLHQHn6q9tnQoEFtbD5bA1Q4oFUIj4+9TCOiDkIAftRVzLuW9SU7sTZY/1zcBCkP
         FKzd7URLYshYZhCWyEGguaxF/cl2aqGMeUj1OiiPnnuErji/6KSK0lgi/Bsgu6FN0Quf
         h/ldtpyhhYWaIcrIiWQl+f7RHe7jf2nuqYRaTobL9VvliqpWQqADN6XEXafdYUhpf4T+
         4M7iBpKWPL2LJ4wA4BdCWV5RIzGml1lvBqEd1yp88GBk1ITUZUiUHXpZIQmfBiAnxbLZ
         f/KCeR6m5y3v3KlGbED/z66XQX8lZeCAarDSuLxqZE6s/bURjf2mJSisp5jknUAMkKG4
         F0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wmb76XFaytNa5GMenz/Iq3bisUs3tEEphpm082+YSy8=;
        b=qTr3sYfTmbMG5MZZ7j2jhjO+dWwKA52C539MvmrPsAk5++SX1tHvDhmPBAbit3/bfd
         vxm0wPQTrNVT98qGal/LDC6PqiIyi1cL1lUp1XRRTmkuUXTzs7ULlaF7GwExLpiLmAmP
         XIEKcI8/s1heefmNIN6ZBV/uEpK/BbbqV7bBl5NnlojFGP2OpdqkMrcHuIoWBX6PK4fu
         z6XH6VcFEB5+y03zrxrJ9T3TcsrytATORIsDt8U9nvJD30g3K9UFmAyK0BwS2ZmZhO7d
         tdEYQyUoX0Lxw2j0ZjPJt2QuzDB+qnFjQ+BObJkUo59dXJ3BavXASh2ZCPpRErqZH2ze
         N03w==
X-Gm-Message-State: AOAM5330rkkOQMG9e7mR0siwiGfUgD5jSJ9PN9FjlPHTpJCjeGIH1S/d
        SJsj0jIDes6h31knr3FVXtw=
X-Google-Smtp-Source: ABdhPJweNR4OXPCwmodeqUi9IIO7Z+w4wu9MAza14JvumyYSPkJUntwwFTFIvu+QvKILkv4qKcVMsw==
X-Received: by 2002:a17:90b:1d06:b0:1e6:7a84:3c6e with SMTP id on6-20020a17090b1d0600b001e67a843c6emr1788728pjb.202.1654754216640;
        Wed, 08 Jun 2022 22:56:56 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:56:56 -0700 (PDT)
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
Date:   Wed,  8 Jun 2022 22:56:47 -0700
Message-Id: <20220609055652.938821-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609055652.938821-1-namhyung@kernel.org>
References: <20220609055652.938821-1-namhyung@kernel.org>
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
2.36.1.255.ge46751e96f-goog

