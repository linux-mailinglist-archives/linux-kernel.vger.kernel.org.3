Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7BB48BF65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351334AbiALIBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiALIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:01:17 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD05C06173F;
        Wed, 12 Jan 2022 00:01:17 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id l13so570019qvz.10;
        Wed, 12 Jan 2022 00:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSKd7XgfSfcgFDjRKFApj8oc4nFN+qAZkCxPvybSL+8=;
        b=V9OjQLkfoBsangbrsXdK7kyQwCXR8utG3+vX0hMvzyZ/07ziwfWsTCRHre9fe2daUi
         jyYMUnN3QDqjw8auj91W66wMnvmnzWTCqL+ok15skMBZ/LiiUSUQ6ikE4+E5Pe2vYB1n
         RYNh4n+RZGJBIGHOMqwUEZdz/wI0c4zHlD6W2RI5KDIhb/PPt/wn2bxSw/35UvXEkT+X
         aphhH7HZxk33JxGpNTuoql/coDTe2a3Cck9WhgLVsXbULGgTwzEBXymlHSANEsUBMB0t
         GxKv2vAshMjULdSK+i4n5Zwh68BBOv3EPCB8c/wI3xXcmL+IOxcr5VuJfClwmFiKkggu
         /tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSKd7XgfSfcgFDjRKFApj8oc4nFN+qAZkCxPvybSL+8=;
        b=z4Y32y7Ud8CSp0pUhjxOJ3L3ZSf7y2JZ4y9w8MSlfllxZI10NJVbaIdie6H8H+Subg
         wyXfoQbtd9mvpLC+2P3/uCdyPlsSxKifHhs0wS+YhCQ/mL4LzbmVnfaKSNIjEIvCuO1C
         vAG7j11otWB500w1x4cjsaM3K6sXxOetFMgbH5pX8fGyLGbgY8agVFqKkQqVB+qkZgu1
         MRFwOywAAMFBkp7eDJ2wxM5I/lnBoYpNPiezfs/LbKIe5ErECzlyTMz1jXDj+wZ1VQVZ
         Afzogz9YMLuPv8YyR/P++I9lg0HZZvMYPeGg8hVZag84UTwLUhi6rnFBxsdAsf23nk/X
         VPmA==
X-Gm-Message-State: AOAM532pkKVUxfngohnOrl1fPT9KoOWgODlc8tq5Al80HVE9fZqd/++a
        XRSilNLYLxjporTuBk6P1ys=
X-Google-Smtp-Source: ABdhPJx9joBxWwiwxF+/GDnJoo0WjC17LNN/3jkLjz/UhcORu498jTeqn3jzxUl7JMo+PT19L8qvgQ==
X-Received: by 2002:a05:6214:19e1:: with SMTP id q1mr7001729qvc.115.1641974476590;
        Wed, 12 Jan 2022 00:01:16 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m4sm9207420qtw.27.2022.01.12.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:01:15 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mingo@redhat.com
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] tools/perf: remove redundant err variable
Date:   Wed, 12 Jan 2022 08:01:09 +0000
Message-Id: <20220112080109.666800-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from perf_event__process_tracing_data() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 tools/perf/builtin-inject.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 409b721666cb..fbf43a454cba 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -535,12 +535,9 @@ static int perf_event__repipe_exit(struct perf_tool *tool,
 static int perf_event__repipe_tracing_data(struct perf_session *session,
 					   union perf_event *event)
 {
-	int err;
-
 	perf_event__repipe_synth(session->tool, event);
-	err = perf_event__process_tracing_data(session, event);
 
-	return err;
+	return perf_event__process_tracing_data(session, event);
 }
 
 static int dso__read_build_id(struct dso *dso)
-- 
2.25.1

