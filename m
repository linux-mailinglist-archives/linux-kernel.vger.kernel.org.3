Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6222649D67C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiA0ABG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiA0ABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:01:01 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBECDC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:01:00 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u130so1122992pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihUPCTAjmv8P3pRhjuXxq0KY3Z6v+ZT6Zl7bAgi/+Ls=;
        b=Mw9tCO6BYAzlms3ZjyXrajFiphRfPOuUVktHDlu48wEcrzEYMa8t404luPWZqkF9DC
         /hO2owv0DAC6h7FNdBDgFauEk20t+R3G4U+JUzl4N6ioaa4Peji5m36thFreGjB3QPpQ
         Mjdua3bts6bvHj/X5g7LLMBZFIJ4/BEjN2UOg9sZu6LUk/Y1oeOz6pReTuPTwOpt4Ney
         qZiJvFf8xUjtFfpid24F1PIC92on0YkeFt8o4C7tPPmDMHp+8/0xDdf1APw5c0sx74hq
         0mxKDKWEFmZ3+qhTwkkdVD0DJYOOqEaPd8i4axAaClo1CzeqhP3Q9xD9Nz0gcAYxnmaT
         E/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ihUPCTAjmv8P3pRhjuXxq0KY3Z6v+ZT6Zl7bAgi/+Ls=;
        b=WiPh3zgViH//t8Kgg/zgowsDgpV/VsQVaghIUWlzTKTc+3nvY885BK60x2UN1nCAEt
         /8wJj4SIcy7aE0rfGVmJYG+jYJkLStAwLXo3z1Bxg7VKeV6ivrgfrDC9f1IHhzrRfpqG
         XcaChFLpzxK3XwQik4OEkEI1K5TreNlvSRbv0rQV1n3pwllZr0WqVquTFU9ngI7HGcYh
         W2QCE8aARSRDeglRSKMqjgVfIAjGTztrzXZa1gyTS+xI2uM+opQb0wUWMZhlM9lO5JcF
         sZvZ1so4l8gyjz75hHuiCTtbNW2qtmv6VodtFKe/6JCBkyO2tGJvxJyXWv1QYaCU7VhW
         hYsQ==
X-Gm-Message-State: AOAM530mfugufCT+vwsV5mmau1zZIRVF6cjLcF9ELFG3FvGpx5gBLdOv
        VtZEofPnlcWFUFdrUJUS++o=
X-Google-Smtp-Source: ABdhPJzOSTVzfmJcWjxj4ZYlmZs3Cv157LVSfKNAu1iAOfxLxaz7fee3OMRQtC4rvuwln4uFDxBiDA==
X-Received: by 2002:a05:6a00:1709:: with SMTP id h9mr755145pfc.23.1643241660446;
        Wed, 26 Jan 2022 16:01:00 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e94:fba2:6768:ac75])
        by smtp.gmail.com with ESMTPSA id t24sm3545546pfg.92.2022.01.26.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:00:59 -0800 (PST)
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
Date:   Wed, 26 Jan 2022 16:00:48 -0800
Message-Id: <20220127000050.3011493-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127000050.3011493-1-namhyung@kernel.org>
References: <20220127000050.3011493-1-namhyung@kernel.org>
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

Acked-by: Jiri Olsa <jolsa@redhat.com>
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
2.35.0.rc0.227.g00780c9af4-goog

