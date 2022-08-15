Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C4593CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346682AbiHOUax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiHOUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:22:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0713533E36;
        Mon, 15 Aug 2022 12:02:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gj1so7722403pjb.0;
        Mon, 15 Aug 2022 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=84gL6qYXoIL91eAhUH7dgvAezoFgyrY4+iuV6650YZc=;
        b=jSMG8Jug+aL1qEMcn+JaVOdPAILDwRdcaGp9YeL+6lMX1w36/c7YMc0rFNPgcA1/zD
         rDdxOPAn3QOKYG/kGuRLcgrwczvCaR0zDN/xaIvc5Pt1+wFyF/pM9kyl0919pOfYv78W
         E9F66io5oP9v1Q0HZNrsgn7Oc0T1o3JLifsDt5RwUeREgp7VpAHXa8CP00fJS2wDfvuJ
         BWyVIa83Tq4QD6W9+vPKRT/SOqb+QE4FYoc34vE0HAHQCx4pBUSm1QhZ7nVI4v1e0XuF
         n/rER/u07yf+s7b7I6HEe6EqaZ8pwm7yJULdpw3BL1xSVH2XqMnGqzEuvdNhXvJPfpQX
         Fvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=84gL6qYXoIL91eAhUH7dgvAezoFgyrY4+iuV6650YZc=;
        b=graC1WKtNq03DQuArUaVH818WxqXGUya1Qcf74uif0xTBHij7EOh4PD6Z4uueIVhhF
         wDxU1rCGv/FrvCkvgsiNOmstIUEoemJ2+tRIFTNEdORjqKYWcmMFiQ5IoQiHkrs1B6nJ
         gLXFOoZK5LRxrMzFbgGeUWODcWYISwdj2XJtxV+NTXfRxfJfRyb1+dcTh0fbCq3csozR
         fDR0Vv4wcof3DQpj40UF5uolJ5w7O5ysZu7p61IJenRIe0zdTMYKY1jWoJLbuQI7sktS
         VHM1ouG8Jnt6dSEHjuyeiVYHUR19rDZtMLxwVWdLfWLukAAP9yb+Yq1PRvPIO+aZq85m
         iVyg==
X-Gm-Message-State: ACgBeo34KGFnfUaFme4B6GwkW4guUsbZh+9/mcz8OWtfHMhhONIzeWXz
        TN+/C7iijQRZvc8ra31Aou4H/6I6vSe1yw==
X-Google-Smtp-Source: AA6agR5v8h/l8L4a2l4uFMG3eittr5svYMMW7mudoTU1ePgOr5JOXPq8o1Q3H7A+CdIIIJFaS/f0TQ==
X-Received: by 2002:a17:902:8f8a:b0:16f:975e:7c6e with SMTP id z10-20020a1709028f8a00b0016f975e7c6emr18748120plo.136.1660590161502;
        Mon, 15 Aug 2022 12:02:41 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:df3e:22e0:b905:822b])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016a4db13429sm7266926plb.192.2022.08.15.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:02:40 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] tools headers UAPI: Sync linux/perf_event.h with the kernel sources
Date:   Mon, 15 Aug 2022 12:01:03 -0700
Message-Id: <20220815190106.1293082-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815190106.1293082-1-namhyung@kernel.org>
References: <20220815190106.1293082-1-namhyung@kernel.org>
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

