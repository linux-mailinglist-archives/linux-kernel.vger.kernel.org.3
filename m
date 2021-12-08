Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1746DCBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhLHUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:15:04 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:43562 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbhLHUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:15:02 -0500
Received: by mail-oi1-f171.google.com with SMTP id o4so5580857oia.10;
        Wed, 08 Dec 2021 12:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWW1E/t9pfEdNssngznEsk6lzbpnH9Rra30gS4jQWgM=;
        b=hWXdhI1D77thDIwyxTVVjUx/k0dZXNumFo9wAh+d0wlFyDilEXhoKwZl9TeWHBq2ho
         62E+eSUhf7KfYCkEWfb9cp2gB9EbNIWHRa3sO2VR+5MTHQ9rdhAHNs+WnM94wy6YiFPE
         naeCzl1MZnORgGUKBsD+HjrztLkSLg22W/MUJpZrxAMKpZ2mfBoGut04tw18ItBioZGU
         L89jqiaDDFIFjQomJCFY5DnsYl2XIdUo781XPsa4zIMb2gLDGSlqZ9VQMHGbwX8pEsuI
         Z6zXMghgwU1NKTKBfoDUL/N378Tmr03Zza2y0st+taD8NUfYMflDS22g6U0Odjnh0Afu
         xHhQ==
X-Gm-Message-State: AOAM530dtYHAnoqndLtl1UdF+BCA2p4fobCFszEG0HVMAtrRlBKUu5W7
        oS3hEddIfsH15F9HRqxvaQ==
X-Google-Smtp-Source: ABdhPJwvDqYUsSc+36IQZd5Gn0F8osm4042Wgki0XAJgGZwzCUQcjRxjtBdhmrl7gI1ZGPZhAtQ9tw==
X-Received: by 2002:a05:6808:1396:: with SMTP id c22mr1725581oiw.59.1638994289957;
        Wed, 08 Dec 2021 12:11:29 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id o2sm927926oik.11.2021.12.08.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:11:29 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v13 2/5] perf: Add a counter for number of user access events in context
Date:   Wed,  8 Dec 2021 14:11:21 -0600
Message-Id: <20211208201124.310740-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208201124.310740-1-robh@kernel.org>
References: <20211208201124.310740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, user space counter access will be controlled differently
compared to x86. On x86, access in the strictest mode is enabled for all
tasks in an MM when any event is mmap'ed. For arm64, access is
explicitly requested for an event and only enabled when the event's
context is active. This avoids hooks into the arch context switch code
and gives better control of when access is enabled.

In order to configure user space access when the PMU is enabled, it is
necessary to know if any event (currently active or not) in the current
context has user space accessed enabled. Add a counter similar to other
counters in the context to avoid walking the event list every time.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v13:
 - Rewrote commit message to give more background/reasoning
v10:
 - Re-added.
 - Maintain the count in the perf core
v9:
 - Dropped
v8:
 - new patch
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ba9467972c09..411e34210fbf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -831,6 +831,7 @@ struct perf_event_context {
 
 	int				nr_events;
 	int				nr_active;
+	int				nr_user;
 	int				is_active;
 	int				nr_stat;
 	int				nr_freq;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 523106a506ee..68952c134968 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1808,6 +1808,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 
 	list_add_rcu(&event->event_entry, &ctx->event_list);
 	ctx->nr_events++;
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
 
@@ -1999,6 +2001,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	event->attach_state &= ~PERF_ATTACH_CONTEXT;
 
 	ctx->nr_events--;
+	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
+		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
 
-- 
2.32.0

