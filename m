Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714E547A0BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhLSNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233148AbhLSNxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639922000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wCpHDM0T3ASnKDBX4WnWQJhJeGDzWQ/mvsQaGLGKzRw=;
        b=L74GplSQx9ZNcWQWvx6oEkDvv/WWwPPZICWwuH/yaQ/G3mxk/yrORPCZdCOQnLjuJYrKYw
        +mGY/inKOdFDWtJgVl5hES0prpN8TCWfEwPHYFtit8zPKG9d0xWokGlvdUO+Qd2otW5h28
        5y7Y4Pb3BzpF6+21sWmLZAtZuhEsoSI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-UnvQz1BmMeSsbP6LXfTeAQ-1; Sun, 19 Dec 2021 08:53:19 -0500
X-MC-Unique: UnvQz1BmMeSsbP6LXfTeAQ-1
Received: by mail-wm1-f70.google.com with SMTP id v190-20020a1cacc7000000b003456d598510so5137112wme.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 05:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCpHDM0T3ASnKDBX4WnWQJhJeGDzWQ/mvsQaGLGKzRw=;
        b=jOIanhr8bqFUkH1HeBWjPt+QGqIAh6rw0XYFacnmYvD8WjQX3H7Bj/cF32ZHaD2htU
         MA466yy50YhiEaDMG9yfcvQhpR0AY8I1PI0JDBVug0fdJ8M/dDvnpCvpqyYEhy9/pma7
         DTqQr+E3C8rTtnfWxDWm1HEbo4/Rt0Jig+bOtYSMWjE3WJHZtKQ+oMivl1xZCF0/5fdM
         E9GCBadDKpLkETuZqeAY5V6xbPIu028KlHBZL+mecOxL3uCUcqpD1epRF8AdMKN+rZJ0
         XqvBtuZEQPTKGepY/N+YNOjUwPaHs6AZU+Cg1lh4PlQuuOBK7aqBVTsQFG9d2xbNGi/S
         fFbA==
X-Gm-Message-State: AOAM533NiV71xVooTMqEqCjShEgF93JJyD/w37vQGcv6LWtB1Vkv5oeT
        6bBqJa8UPeZ4mNszjz3BovSI57VaOOCRNeR8FnFLr12UKGHVUA3T6hZMwi3YFEH2MTFk4SN6Re3
        1n1W+TMMyiVsh3PI0CL84CSzJ
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr1763569wri.45.1639921998409;
        Sun, 19 Dec 2021 05:53:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaCnxtEx4pWLffaP/Uf80mPpUrMzwH5wq7xAv3EAlLGO5n2FINCAK+yEnMt+ITPmbEuXH3hQ==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr1763557wri.45.1639921998253;
        Sun, 19 Dec 2021 05:53:18 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b6sm19660226wmq.45.2021.12.19.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 05:53:17 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH] ftrace/samples: Add missing prototypes direct functions
Date:   Sun, 19 Dec 2021 14:53:17 +0100
Message-Id: <20211219135317.212430-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's another compilation fail (first here [1]) reported by kernel
test robot for W=1 clang build:

  >> samples/ftrace/ftrace-direct-multi-modify.c:7:6: warning: no previous
  prototype for function 'my_direct_func1' [-Wmissing-prototypes]
     void my_direct_func1(unsigned long ip)

Direct functions in ftrace direct sample modules need to have prototypes
defined. They are already global in order to be visible for the inline
assembly, so there's no problem.

The kernel test robot reported just error for ftrace-direct-multi-modify,
but I got same errors also for the rest of the modules touched by this patch.

[1] 67d4f6e3bf5d ftrace/samples: Add missing prototype for my_direct_func

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e1067a07cfbc ("ftrace/samples: Add module to test multi direct modify interface")
Fixes: ae0cc3b7e7f5 ("ftrace/samples: Add a sample module that implements modify_ftrace_direct()")
Fixes: 156473a0ff4f ("ftrace: Add another example of register_ftrace_direct() use case")
Fixes: b06457c83af6 ("ftrace: Add sample module that uses register_ftrace_direct()")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 samples/ftrace/ftrace-direct-modify.c       | 3 +++
 samples/ftrace/ftrace-direct-multi-modify.c | 3 +++
 samples/ftrace/ftrace-direct-too.c          | 3 +++
 samples/ftrace/ftrace-direct.c              | 2 ++
 4 files changed, 11 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 690e4a9ff333..2877cb053a82 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -4,6 +4,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func1(void);
+extern void my_direct_func2(void);
+
 void my_direct_func1(void)
 {
 	trace_printk("my direct func1\n");
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 91bc42a7adb9..6f43a39decd0 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -4,6 +4,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func1(unsigned long ip);
+extern void my_direct_func2(unsigned long ip);
+
 void my_direct_func1(unsigned long ip)
 {
 	trace_printk("my direct func1 ip %lx\n", ip);
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 6e0de725bf22..b97e5ed46233 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -5,6 +5,9 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func(struct vm_area_struct *vma,
+			   unsigned long address, unsigned int flags);
+
 void my_direct_func(struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index a30aa42ec76a..c918b13edb49 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -5,6 +5,8 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
+extern void my_direct_func(struct task_struct *p);
+
 void my_direct_func(struct task_struct *p)
 {
 	trace_printk("waking up %s-%d\n", p->comm, p->pid);
-- 
2.33.1

