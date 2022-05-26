Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF65350DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiEZOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347796AbiEZOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:39:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FAFCC167
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:39:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q4so1581994plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYt70Prf9ko1iY4y9VLbGBtaYzweQgmLrhKnRycj0w0=;
        b=AiOAQC1mG9iLG6AJdEurRHpWzgIYvMnYXJwG8nfc74cpDzU5zIPDfLbS2aocoZsSH4
         UHGUZGxLivCAI0QYvx9PL9tLCLRzFuWTg1rxeDyCB0RZkxXErcBJl3fcHkacusxINnn1
         93OHYpaZUPLeQb83cudhYY4iKRZ/IPKWZR3s0203eO2CtoQqWpuui9G4k9o2wjJfPrGr
         Ainf3gVYHYoa32GCNpEmU7L6E63DmSVKUSH9NhqPMNDKuafmPRmxOl7kFGtDB8SBa6z1
         PEuQrtFGX9fgNGmmHPTCeFHzepQ8nYDVnps6OsZLfFhrR+NxvHH5b2omqvOtoDf+kF7A
         cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYt70Prf9ko1iY4y9VLbGBtaYzweQgmLrhKnRycj0w0=;
        b=O1EqfcUQYtId6pkwB7RmJ/t8QZiTfM08+drIy8MiTMS6Ms/EcOFEucU++iQhKpdITg
         OwlqR1xXKcaixiuv5ReABJnTTczXu9KResa1IJ1JgU7jgFBjLzAFDH+N1uVy5ZypZAA5
         b4e3ihm6f8o8/9SCVjBrxrFnJuVL2NKR6v3/oBjyXUj3aRNNhnoRbqcb9pvBVmL/0rMr
         ItT4eY6Ed/6KsaXBrrFLI0H5V/6lHFjhYj158OFmYAt03O64dDGIMfvNx+EsQlLHrzFW
         zFSsqOyjnhjD4ultaVEK17cAre58vp5sY5mQe+RhxvXukw9AXG8tsxUoUdobkt3PRXNi
         YX6w==
X-Gm-Message-State: AOAM532q5BqymRAWi8S4uCmXV2h4v/adn1OwkQOC25bLEGf5vDJu2JSJ
        xeKTViEHXZNbQRtm52WshU2yLA==
X-Google-Smtp-Source: ABdhPJzmhk0yQWm6d1KHBxZ1WxCY2JyI3bba8i10wIai3i905rTCztGVxmTb04r+/Eix2Ng8ygbWJQ==
X-Received: by 2002:a17:90b:3ecc:b0:1e0:5eba:e79a with SMTP id rm12-20020a17090b3ecc00b001e05ebae79amr2923822pjb.57.1653575972213;
        Thu, 26 May 2022 07:39:32 -0700 (PDT)
Received: from leo-build-box.lan (n058152048107.netvigator.com. [58.152.48.107])
        by smtp.gmail.com with ESMTPSA id s13-20020a63524d000000b003c18ab7389asm1626122pgl.36.2022.05.26.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:39:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1] perf c2c: Use stdio interface if slang is not supported
Date:   Thu, 26 May 2022 22:39:17 +0800
Message-Id: <20220526143917.607928-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If slang lib is not installed on the system, perf c2c tool disables
TUI mode and roll back to use stdio mode;  but the flag 'c2c.use_stdio'
is missed to set true and thus it wrongly applies UI quirks in the
function ui_quirks().

This commit forces to use stdio interface if slang is not supported,
and it can avoid to apply the UI quirks and show the correct metric
header.

Before:

=================================================
      Shared Cache Line Distribution Pareto
=================================================
  -------------------------------------------------------------------------------
      0        0        0       99        0        0        0      0xaaaac17d6000
  -------------------------------------------------------------------------------
    0.00%    0.00%    6.06%    0.00%    0.00%    0.00%   0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
    0.00%    0.00%   93.94%    0.00%    0.00%    0.00%   0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0

After:

=================================================
      Shared Cache Line Distribution Pareto
=================================================
  -------------------------------------------------------------------------------
      0        0        0       99        0        0        0      0xaaaac17d6000
  -------------------------------------------------------------------------------
           0.00%    0.00%    6.06%    0.00%    0.00%    0.00%                0x20   N/A       0      0xaaaac17c25ac         0         0        43       375    18469         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0
           0.00%    0.00%   93.94%    0.00%    0.00%    0.00%                0x29   N/A       0      0xaaaac17c3e88         0         0       173       180      135         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 042431b7b6ba..42eb5cf95816 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2926,9 +2926,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		   "the input file to process"),
 	OPT_INCR('N', "node-info", &c2c.node_info,
 		 "show extra node info in report (repeat for more info)"),
-#ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "stdio", &c2c.use_stdio, "Use the stdio interface"),
-#endif
 	OPT_BOOLEAN(0, "stats", &c2c.stats_only,
 		    "Display only statistic tables (implies --stdio)"),
 	OPT_BOOLEAN(0, "full-symbols", &c2c.symbol_full,
@@ -2958,6 +2956,10 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (argc)
 		usage_with_options(report_c2c_usage, options);
 
+#ifndef HAVE_SLANG_SUPPORT
+	c2c.use_stdio = true;
+#endif
+
 	if (c2c.stats_only)
 		c2c.use_stdio = true;
 
-- 
2.25.1

