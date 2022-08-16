Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F159655B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiHPWSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiHPWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:17:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7296A901B7;
        Tue, 16 Aug 2022 15:17:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l64so10482704pge.0;
        Tue, 16 Aug 2022 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=84gL6qYXoIL91eAhUH7dgvAezoFgyrY4+iuV6650YZc=;
        b=cYK3wI6YLLfLwF08C0BXRx0SjLpb5jVdFgPwFiFNGD7iqYTo8GOVDvWG7Jmb/7WXKj
         LZqDhlcFpn1xH3Rt+OkY8yAesdoU+LiRMTqkoFuxLQ3RqgA/b9Yk/uzjHTId2jQ9OOWR
         0CAzm282cGgT6on95ZFkONfXjLnxT2yWLDFx+0JrPUQjyFIE9wrMllZel1FMDJVV+yVF
         NmDUSrT/6W04x3S5qm5drBTu/mXHtmn65n5P1J4kKVufEF2Xrvgr4rH1DZ04QUdkZi/n
         EkiovqyPY+bDGmO41dlaUlvTJreyii310HhegiZDWOUHyZnWSVM8qyCr0/lS8GQyXald
         Smew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=84gL6qYXoIL91eAhUH7dgvAezoFgyrY4+iuV6650YZc=;
        b=vBVjC4V9sEmJ/RMcSvNbv7dil+988uamzcKJFJKpkktrXqDlSyNN6ltIvGjwsye05A
         yhM5usYh964xje0vMAN/S2NCtGgckanrOYQzNdCsLdh3bimvdszO1Ub3tksor88F/Qmz
         ivW61qmtHCyGTDymdjA39BdsPE3OIlGGjn3G3MKRifNh97TVknW3ewiX4iOvffIaoeOY
         2TXW48mb1Or/6N79DD7yozA+tF+JJHLVRxjWnzoPrnw1xPSs55o7H6akwB+BudNH8ZpV
         57cSTekNegynBwFoCggng825sO93pU+aO0JI/qNTpfa2IQQfkSpQawhyVKTHMM2tXwP4
         9AKg==
X-Gm-Message-State: ACgBeo2CIO9xXShY/vQaIzX5RHj1IAaikFCdPTK3QxxuxT3Jnv/Aw9Ca
        BZ5Ia+jMUdz9AR1EGtZzc/U=
X-Google-Smtp-Source: AA6agR65u1hPTOpZiganCVlM6hJi4TdQ8cu//l+GzkFJSC517cP01lba9WOpusrLCNOakdJIhLZdHQ==
X-Received: by 2002:a05:6a00:1a4f:b0:52e:33bf:f3d with SMTP id h15-20020a056a001a4f00b0052e33bf0f3dmr22914951pfv.61.1660688270902;
        Tue, 16 Aug 2022 15:17:50 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:d539:e967:9fd8:5c81])
        by smtp.gmail.com with ESMTPSA id 3-20020a620603000000b0052b7f0ff197sm8965943pfg.49.2022.08.16.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:17:50 -0700 (PDT)
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
Date:   Tue, 16 Aug 2022 15:17:44 -0700
Message-Id: <20220816221747.275828-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220816221747.275828-1-namhyung@kernel.org>
References: <20220816221747.275828-1-namhyung@kernel.org>
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

