Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72FC503359
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiDPCo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiDPCo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:44:27 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496417E32;
        Fri, 15 Apr 2022 19:41:58 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e2442907a1so9461232fac.8;
        Fri, 15 Apr 2022 19:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cYq+2F/bEonU/DO+vgP5ahGjGGTEVFinNWKQ+3P1dA=;
        b=e3t0LJ31dAW3tgBgLwggCET7d3nYF4ZzincvzXr3nWxyy+4KLgHG7ii18LvvBdrW3h
         7Nv9+WpNMYiq27uI2efgeWtX/mNDml9C6ydY4XrIYZIRxQKwLn3RJjKFHnbJ3Q0xu9Lr
         /i+2ykLemDcaG1DUJMCnqEflD141djoRj+dEk0JXnfcWLvPEVRkLxjDARi850BB7qZ4u
         wU4BqWCf7XAuksnTJPWW7hzYOaBPVd1pDStLHpadiiVzmaEW2On4cIEoWH7ML4MneeNw
         XnzIAynLdhza93C9Pm9LsOusWj8jFiYYDNLIk2xT7xQuDt+UlN8OKltDM62qN3KJ2kzn
         /aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8cYq+2F/bEonU/DO+vgP5ahGjGGTEVFinNWKQ+3P1dA=;
        b=5wGGBIq9dzlBWb8y0QKNfyCzG2GZ1moVAHS51VAHoqUQuIFkkIiooUClAVkbAsVMf6
         0Q4Vh26ov1mWRcwe2oZ3kj7JpTWrnFyA3YfIeF50JVVoyjxGYzcGSl4wHoishO4MryD+
         Hi7Si30ksc8/q4A0P0MekWjwkt+k9/PUhEC7KdW7LE6ITJRuhd5gmrXGdB43igOqtClZ
         sBFa44sm4aQpi8+HhIyATTBjNvSQodpFVfP6THWwptOamyw/WODch+5mJIUzUJA+EyIE
         31HY58cO7+3v/7QZiO+byTNWgS/BkZRVGiZ4mWDJ+rM0bMBIPlLskZCAWUK4uF1W1Q1V
         e0UA==
X-Gm-Message-State: AOAM532xARm4WVVBdINc1wumEK/Xz0gw2rBB0DutfyGgE7kipJv3qgz/
        Tvke2KfdxWkEWq7FSYp21PqIsRv52Z0=
X-Google-Smtp-Source: ABdhPJzxX5yhHHrTm7NAJCXbKqHI5E6hvIAvMJcX5k+3LzscvqDrkPHyuj0MwnZd8nFQZVC6TYtuVw==
X-Received: by 2002:a17:90a:4405:b0:1cd:5fe6:dd99 with SMTP id s5-20020a17090a440500b001cd5fe6dd99mr1491754pjg.210.1650069659895;
        Fri, 15 Apr 2022 17:40:59 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:461:36d2:dba1:7530:2cda:19b1])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm3913537pfu.82.2022.04.15.17.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:40:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/3] perf symbol: Update symbols__fixup_end()
Date:   Fri, 15 Apr 2022 17:40:47 -0700
Message-Id: <20220416004048.1514900-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220416004048.1514900-1-namhyung@kernel.org>
References: <20220416004048.1514900-1-namhyung@kernel.org>
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

Now arch-specific functions all do the same thing.  When it fixes the
symbol address it needs to check the boundary between the kernel image
and modules.  For the last symbol in the previous region, it cannot
know the exact size as it's discarded already.  Thus it just uses a
small page size (4096) and rounds it up like the last symbol.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1b85cc1422a9..623094e866fd 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -217,8 +217,8 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 	}
 }
 
-void symbols__fixup_end(struct rb_root_cached *symbols,
-			bool is_kallsyms __maybe_unused)
+/* Update zero-sized symbols using the address of the next symbol */
+void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 {
 	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
@@ -232,8 +232,29 @@ void symbols__fixup_end(struct rb_root_cached *symbols,
 		prev = curr;
 		curr = rb_entry(nd, struct symbol, rb_node);
 
-		if (prev->end == prev->start || prev->end != curr->start)
-			arch__symbols__fixup_end(prev, curr);
+		/*
+		 * On some architecture kernel text segment start is located at
+		 * some low memory address, while modules are located at high
+		 * memory addresses (or vice versa).  The gap between end of
+		 * kernel text segment and beginning of first module's text
+		 * segment is very big.  Therefore do not fill this gap and do
+		 * not assign it to the kernel dso map (kallsyms).
+		 *
+		 * In kallsyms, it determines module symbols using '[' character
+		 * like in:
+		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
+		 */
+		if (prev->end == prev->start) {
+			/* Last kernel/module symbol mapped to end of page */
+			if (is_kallsyms && (!strchr(prev->name, '[') !=
+					    !strchr(curr->name, '[')))
+				prev->end = roundup(prev->end + 4096, 4096);
+			else
+				prev->end = curr->start;
+
+			pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
+				  __func__, prev->name, prev->end);
+		}
 	}
 
 	/* Last entry */
-- 
2.36.0.rc0.470.gd361397f0d-goog

