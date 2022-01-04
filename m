Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3ED4847B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiADSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiADSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:03 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A945CC061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:21:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l16so15549430plg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKbtzICId2uICwEkwx+p0HAn0GNZyEflyRo/XXiWqDw=;
        b=B5NqPBN5UjblOonRZlos8ugVoqidC5gz6h4urMR4FwO7XUVSsKLK51vS3MZOq2AJpO
         jf4F1unQIOs7ATHXvVcwnKkk3ElzeoWf9NzzyroNgD2xq50xMbQLkCcevPVOuk6xDz29
         2GwkmqgYs+/Ug4nxfISJCw7h6QW2qIapC0YKjtYG7u12fJt4sYLhgjI3cn9jYs4rVc8J
         5idxy8EwnsAsduLn3CTcv/NQUBOuX+AnIeTwaBroPFTHtPGkRlcFYYDir8A1AcE+6Km5
         1VGSNFqN0ZlqE92xD1mVZg8kbvXgXNTaI3+S6ooavVhIkwEZW4tMHF6xCILmMVy31CHC
         PBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pKbtzICId2uICwEkwx+p0HAn0GNZyEflyRo/XXiWqDw=;
        b=KOScDWo5RKN8qlUtrvfZo9ANBp+pHje+9QkfT/Q6L1+bXCGqxDMcxTsA8e9e6dE4kw
         CE1q+jEKMOSvcdxm0RuD7v949Vy3o/agYTeYPxl6bNRUHw1my4LEOXqdA8MM/dblndoN
         KMqYYmXKS9lzylzd8H0VTrBmEtBQG43Ik2oRKvSPvYjh3rNwHD0V+ti2Kre/6tMopP8B
         mZVMjGYOTdYOQTO05asS+HkX8l7YmZAwuss9Dpym1wkffu7BpbHd6tt7elNSbhHBZ327
         HctGgFu1WVDDVNw6ASj822+bQwMwmKB47lKjws7x5MXuWCvZRjK42I66FfhB859ZBwVl
         mVcg==
X-Gm-Message-State: AOAM530hE6MFDn0UJVOh8R7QNyQBcQdlOEs9EAn7OQEWhRvmOCUHWG/t
        6E9hqfTa1CP3/DagJtrME1o=
X-Google-Smtp-Source: ABdhPJwCLbkUfjhM80kDo1vAuUE7cYhJPvX3NElsvA6/jA/dQPfFZ2+HW5io9nlLLim62Dq2YT00Zw==
X-Received: by 2002:a17:90b:164f:: with SMTP id il15mr30453776pjb.155.1641320463221;
        Tue, 04 Jan 2022 10:21:03 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:4abf:2548:40ff:6d1])
        by smtp.gmail.com with ESMTPSA id g10sm10097684pfo.103.2022.01.04.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:21:02 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 4/6] perf lock: Fix lock name length check for printing
Date:   Tue,  4 Jan 2022 10:20:52 -0800
Message-Id: <20220104182054.25009-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104182054.25009-1-namhyung@kernel.org>
References: <20220104182054.25009-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has 20 character spaces for name so lock names shorter than 20
should be printed without ellipsis.

Before:
 # perf lock report
                Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)

       rcu_read_lock     251225          0               0               0               0               0
 &(ei->i_block_re...       8731          0               0               0               0               0
 &sb->s_type->i_l...       8731          0               0               0               0               0
 hrtimer_bases.lo...       5261          0               0               0               0               0
 hrtimer_bases.lo...       2626          0               0               0               0               0
 hrtimer_bases.lo...       1953          0               0               0               0               0
 hrtimer_bases.lo...       1382          0               0               0               0               0
 cpu_hotplug_lock...       1350          0               0               0               0               0

After:
 # perf lock report
                Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)

       rcu_read_lock     251225          0               0               0               0               0
 &(ei->i_block_re...       8731          0               0               0               0               0
 &sb->s_type->i_l...       8731          0               0               0               0               0
  hrtimer_bases.lock       5261          0               0               0               0               0
  hrtimer_bases.lock       2626          0               0               0               0               0
  hrtimer_bases.lock       1953          0               0               0               0               0
  hrtimer_bases.lock       1382          0               0               0               0               0
    cpu_hotplug_lock       1350          0               0               0               0               0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 8078f7ca826d..f6adf3cdd1e2 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -710,7 +710,7 @@ static void print_result(void)
 		}
 		bzero(cut_name, 20);
 
-		if (strlen(st->name) < 16) {
+		if (strlen(st->name) < 20) {
 			/* output raw name */
 			pr_info("%20s ", st->name);
 		} else {
-- 
2.34.1.448.ga2b2bfdf31-goog

