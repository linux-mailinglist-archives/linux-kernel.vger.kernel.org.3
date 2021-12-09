Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A40B46E089
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhLIB7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLIB7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:59:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EAEC061746;
        Wed,  8 Dec 2021 17:56:16 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z6so4031428pfe.7;
        Wed, 08 Dec 2021 17:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yj/KHzXtiJk54EmuUvfEvZXW5iSFJAcLfourAbdrQ04=;
        b=AvC7qQ3fY6ARHqbdXisocOVt0TFLn2o+xgvRtMf5tiqVV0QssI7ZKcRtyfCwftHTTq
         fDLtNTbVoNqo3xkhiJi37KOz9yUyNcIqhBZtlwyvUNnWwH0lArPpTrdvq5c5ELMFuG/o
         WkXRkeedt08NP4gqnPr5OKCpR6zw7vE0hlv6sEWMlGMz5aimc4HH3NY/Jj/1y2ErVwbE
         ym6YCZQsFw+gfu4GrvFR980QGa9tmpJiPt1KGZ0d47Lo7RDXvp0tc82mNJzaPOb+cDdd
         FxU80RU0j+7bcYXMopeknAMOYzKyxRqxyolx8bQp41/jPKcgNHYuZmwVT571jApHTxmX
         +9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yj/KHzXtiJk54EmuUvfEvZXW5iSFJAcLfourAbdrQ04=;
        b=RP2lYpQ827VpqLCjRRQaW/mCe7Y3msS7GyAOSFUJAGUx+/tojLFpfaFzpYM0OVKr7D
         v+ykOBHzdua60urjrMgw4K40HxTu2BibYdhGG9bnfVrxLuIkTgn9e4klsfEwVYD64ORj
         aJcG7jZs+x+gR78tW9xyaYNWU3efI60D3lfO0nX8j1I6F090dbAwD+Wo+vMndhhqgnix
         LJSiZ4EZpRr/HsG3iHiiHWllonbaM1OsyPySfXIonxHj35FEWySjEgt+QlmPAvokWBJj
         Ksnk5Q07j9uNt8Y6nntCH0qeKEhc0NP3AzJd+Y2c7s0CJG9htpLyR3tywcSAYG5nD7Ek
         JzZA==
X-Gm-Message-State: AOAM532/QhRvj+zwkuGQL5IsPiQcBLvNpwCly86+PwoLbcFKtGn7iovh
        hk3XZdAfhx603JjhBVJ4aHU=
X-Google-Smtp-Source: ABdhPJx54V5jIoQN0/D/P22BeZiOxi7m+wS62SX9TKLJijQ4OTJrOPF4yeYIsv7T2jW0QNqkgR5Igw==
X-Received: by 2002:a63:af4e:: with SMTP id s14mr14935456pgo.273.1639014976134;
        Wed, 08 Dec 2021 17:56:16 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g22sm5376431pfj.29.2021.12.08.17.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:56:15 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] x86:intel:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:56:10 +0000
Message-Id: <20211209015610.409791-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 arch/x86/events/intel/core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 603964408d2d..6ba7e0ef8db4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4106,23 +4106,17 @@ static struct event_constraint *
 glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
-	struct event_constraint *c;
-
 	/* :ppp means to do reduced skid PEBS which is PMC0 only. */
 	if (event->attr.precise_ip == 3)
 		return &counter0_constraint;
 
-	c = intel_get_event_constraints(cpuc, idx, event);
-
-	return c;
+	return intel_get_event_constraints(cpuc, idx, event);
 }
 
 static struct event_constraint *
 tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
-	struct event_constraint *c;
-
 	/*
 	 * :ppp means to do reduced skid PEBS,
 	 * which is available on PMC0 and fixed counter 0.
@@ -4135,9 +4129,7 @@ tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		return &counter0_constraint;
 	}
 
-	c = intel_get_event_constraints(cpuc, idx, event);
-
-	return c;
+	return intel_get_event_constraints(cpuc, idx, event);
 }
 
 static bool allow_tsx_force_abort = true;
-- 
2.25.1

