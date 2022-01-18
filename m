Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E479491F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiARGFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiARGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:05:14 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56604C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:05:14 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id c75-20020a63354e000000b003408e4153d1so8960526pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wq0C/fowqjD1zfGdKb5yayiyRBlCcZFXN6rlR5ZBXBo=;
        b=thlIhNMk/BLsR8M38JfIQ6msIRbLsO0zMDgD5kxuqFu09hW3PSd0IMCRuDSSf/2ODZ
         bkcHBKMmP96L+TN2L/pjTlPC7PF9gYwG3Tri4qBVNoOsAZzEpXF67ls3X++YRGRiDVCu
         IZ7D21dPcm8KK8yrSeu7or3irDaJXhhEOW2g2hgEI6m8Ul+LQ/1mSfBzUV94TunoO+DM
         TQP79+0qatMCqPv181uWoAk5ddwatWC65n0/P9N0/95T0DM0+AXBDosgs24DwnbE6uIO
         /8VWOZ6q7abHpgBqXLHUGV4+56pns4oddRbHSqm2Pm428Zzmd1G+spZzKhBdkbjiRPzh
         bfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wq0C/fowqjD1zfGdKb5yayiyRBlCcZFXN6rlR5ZBXBo=;
        b=x8jQbankx3D+H9Iab4DD7mJN7+TeOA0va9j+k3tvaRDn31Icxft1UV+vhWWsIXiI2B
         xrvBlaAv8zL8I4hAjOPCftXXl+BY9v3m98PGIN4P4B66IA3y01KTeXlGetUJNoGULipW
         5nt7e8kVT5LGn7zrGvX3lwqMpdZ6TbMl5eLik2VWPptchEvzeycGgnQuTcfFXq1i23DC
         dzQwXFP90po9dolAC9ItBENWg0pg5ScWvvOA8FhnlYCy+pP03ZyZHYxnEuJhleOzI8y/
         v3X2d9vTIlc2Erp967YinWIMfvlqGxAoKfpaOBfaOjS2aIWw9y7FsX44M1P59e8Uhs9r
         BEDw==
X-Gm-Message-State: AOAM533IHp3vpl47tBxIgzeczM+kqv/awHJ9Z/YedtjhY/xOc0BwbnE6
        L84s1IDIWz8h89jrJ6+fzwN0XkG6kHk2VdI=
X-Google-Smtp-Source: ABdhPJwdNQnwc6z4Qp+CC6b1DBeT4d9Z1I4voKcaBhsx+tDNOlbARRMn5R0iRShUC3fJqWam443RMFQD/6AjfC4=
X-Received: from jsperbeck8.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:301f])
 (user=jsperbeck job=sendgmr) by 2002:a63:3d4a:: with SMTP id
 k71mr21578897pga.410.1642485913316; Mon, 17 Jan 2022 22:05:13 -0800 (PST)
Date:   Tue, 18 Jan 2022 06:04:31 +0000
Message-Id: <20220118060431.1368538-1-jsperbeck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] kernel: count warnings and make count accessible to userspace
From:   John Sperbeck <jsperbeck@google.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing, it's common to consider a warning to be a test failure,
but it's currently awkward to determine which of multiple sequential
tests is responsible for triggering a warning.  Scraping dmesg or
/var/log/messages is somewhat expensive and error-prone.  Setting
panic_on_warn is reliable, but spoils test runs for minor issues.
Looking at the taint bit is also reliable, but only works for a single
warning.

We can track the warning count and expose it as a sysfs file.  Test
infrastructures can snapshot the value before and after a test.  If
the value changes, they can do more expensive things like extracting
logs.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 kernel/panic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..5262c2a0ebf4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -571,6 +571,8 @@ struct warn_args {
 	va_list args;
 };
 
+static atomic_t  __maybe_unused warn_counter;
+
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
@@ -612,6 +614,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	atomic_inc(&warn_counter);
 }
 
 #ifndef __WARN_FLAGS
@@ -667,6 +671,7 @@ static __init int register_warn_debugfs(void)
 	/* Don't care about failure */
 	debugfs_create_file_unsafe("clear_warn_once", 0200, NULL, NULL,
 				   &clear_warn_once_fops);
+	debugfs_create_atomic_t("warn_count", 0444, NULL, &warn_counter);
 	return 0;
 }
 
-- 
2.34.1.703.g22d0c6ccf7-goog

