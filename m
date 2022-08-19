Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5B5991CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiHSAgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiHSAgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:36:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF8DEA7F;
        Thu, 18 Aug 2022 17:36:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 202so2526813pgc.8;
        Thu, 18 Aug 2022 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=84gL6qYXoIL91eAhUH7dgvAezoFgyrY4+iuV6650YZc=;
        b=X4JKtGGQOwyyDoEC+VjchavxLOpFCxVxZQ0CCAZ7ACmwPRkTvgUONVgjP3rC1he8K0
         7hKw5+oE8a1OmPwaTVVyL+qktbAuXlzkb7vC7Ul4Kusr2fnmIZVL+HoL/uSpEnjWuguE
         NKxj/NogYkNlG1IeOxq61SxDQKdXf1BDS5PX8aquzO5V+EhdXyMaIwaEVUg9oHMQv6OH
         bd83XVnJFLm+sHAQVFfuEhBGKRRCEFSeOvMRVbjMpUJIupMJ5azWO/8XVws2aJ3mY75m
         TMGpfTYRw2HU0NuahqwxO4cAeu32caQVBzFTayJlof6nWY1QVhX0SJgRGQClblSvtfv3
         hEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=84gL6qYXoIL91eAhUH7dgvAezoFgyrY4+iuV6650YZc=;
        b=bJ7sz9rJIog2LjRGQPEPWu4pvxrn/mUKD8yg4hX/yYINjeB/Ia4LZh9+hgz4pnApPN
         7hDX3D52qveRevWxIlJOnkaar2R/I5nX3o7N0qPNM5v073t9mDdHFJwS3i2Ggt5kGJz0
         AVu+eGA6o3o0O6q5gnouJMdmx2jykXsgje4ELdCzrACfO7SfEeREDWmue7T7fXdqq2kF
         cUTWFwgcHh1WqRzm5Up59aUEuOHsoGfauNCwfl33lel1h/aniZLg2wuhwtGCJkKqm6Vk
         GjB31JUyOs/kBgvhGY6+5de9GBfU4uStb0iWnle/r0JgST1G9FxlMnjrx/oyuq5EvPaw
         QaBA==
X-Gm-Message-State: ACgBeo21RePOxROogOLLAtLvg7d/eY7l+DUW76dP7loxcbJYJMuosk6m
        WXnh5vEzeG6QbxmK0Wuo7FY=
X-Google-Smtp-Source: AA6agR7dHikG9IfUHMQRRWFsLO3xfKjnnMD8fKhAVwzmi6Mc9ill7Io6mAvEK1mjqDDSreQDebQmRg==
X-Received: by 2002:aa7:96d5:0:b0:52e:e2a:9c79 with SMTP id h21-20020aa796d5000000b0052e0e2a9c79mr5338582pfq.55.1660869408017;
        Thu, 18 Aug 2022 17:36:48 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:436c:3fa9:2b77:a856])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b001f303d149casm2057567pjh.50.2022.08.18.17.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:36:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] tools headers UAPI: Sync linux/perf_event.h with the kernel sources
Date:   Thu, 18 Aug 2022 17:36:41 -0700
Message-Id: <20220819003644.508916-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819003644.508916-1-namhyung@kernel.org>
References: <20220819003644.508916-1-namhyung@kernel.org>
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

To pick the trivial change in:

  119a784c8127 ("perf/core: Add a new read format to get a number of lost samples")

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index e2b77fbca91e..581ed4bdc062 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -301,6 +301,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -308,6 +309,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -317,8 +319,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
-- 
2.37.1.595.g718a3a8f04-goog

