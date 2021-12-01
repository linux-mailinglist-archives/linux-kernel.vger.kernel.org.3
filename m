Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3B464465
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbhLABGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbhLABGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:06:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD40C061757
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so32513361ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fTp0vgqRua+xYpWV6ZLptS7hu5t9D5PP933svkj3UCc=;
        b=SJkIAmIAmIF7ZtoFC7oy217k+dFNxuUYIaPAYamU6kMyIOi9ESBTCFAIg2teC28a1h
         DLlAmP8JNbjx/4Z3yds+0I4gsCOQv8DqrJAkYYGQV2Pf9WVlmc9brBrhBYVxGZYSRs5x
         V5l/V9ZdT+51D/e/WM4yp7X5I/C0Jt1rbfN7AEhL0Qa3LB+Wcu3BX26mjSbMameuOwKo
         8nDv3ILSNX/rYcNTuthh6WWylBa+e7AJhWbhEbFBPnm3SGbguiKFuIuyfjehGRerIsxr
         aV26wGR7IX2fMDMsODxx/HHHvbjiUkPyS+mI8yCjUmsmqWYiS/KGevnTXiy9U9h+jnIj
         xi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fTp0vgqRua+xYpWV6ZLptS7hu5t9D5PP933svkj3UCc=;
        b=ZToUvOE3S6X+A0L3k6AgUrOXl8dcT/QqCCOugpaMLVi3l46Rb0bxPGl+vOpW0KV6hb
         dfv0v4RaWBxo6VM+imbMfUUqCGBGoZTbA6JDqzh1WTb5ftbvBT5UIu8gnV4sRFGoM9hW
         gpoMInST+3Gzjq46Iy9F9cRiyu6iVc2GfUm4uLuj5iBL7iZ0+7qEDaCij5CEBv2wmBQP
         SrQBVWYXdy7oppPIRbVX2JIByFnUFa5t+Hi1adT8P72pXZCXD92dOwzeua3hpHRNj9nj
         TpmfkzECR05EcVRiXOOgZF538ZWInyJAqbj9ncDC5r2GB2w4kPGzC6OBqJ64aXqvS4AW
         3kRw==
X-Gm-Message-State: AOAM531ixN/55JZn5pEVm84opSO4Szb8VIDrEV8LnoXO8FKX+Wn2yvju
        ytnrSTbYXlzcscs3SpodftRz5UkA8fXXJNhz4H0sb66lajxEEAhXRhi0xX2JK7n08dJQv5LWUnM
        2YHsvTst0vlZgDw3jc4KovB0jYB72E46io3IiwsAe+s0N09Asyg8IgDpUl9IJW4QnTMW8s9Za
X-Google-Smtp-Source: ABdhPJyyt2Hy3fwSuHebXDrc5A0qNYJ2L+RKBPs/11bsjpv880wPrqyvKDUWTCaO+UCSyag5AP4uoVmaO5n4
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a25:9011:: with SMTP id
 s17mr3261225ybl.545.1638320562780; Tue, 30 Nov 2021 17:02:42 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:14 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-11-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 10/13] perf tools: add branch-brs as a new event
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although branch-brs is specific to AMD Zen3, we provide it in the list of
events recognized by perf as a convenience. It allows: $ perf stat -e
branch-brs $ perf list

and enable some test suite to pass.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/parse-events.l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4efe9872c667..97e70368e7c7 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -366,6 +366,7 @@ mem-loads-aux				|
 mem-stores				|
 topdown-[a-z-]+				|
 tx-capacity-[a-z-]+			|
+branch-brs				|
 el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
-- 
2.34.0.rc2.393.gf8c9666880-goog

