Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BB46D6C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhLHPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230036AbhLHPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638976511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fB17ERvhnfnqQZGJ/upsvsApSZysJvXR2vgj624dke8=;
        b=b3DXnQRRE9xKtFsjT6RnFi3o63zCebPbNRAvuANyRykf7ed+QH5M0ww4wYZZNIwIA4zlK0
        8oB5IusM2fiFnGZ8lzG26KEK+2iJ+3YS+6YDZqg+NpF4GjUhN4cjTtQ4DsvQ/XAlVHw88f
        Kn0pMLfcUNixMUAl6VT5oVKMBYhPbZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-ZNTLP1JRMYSOmYQEAxA8Gg-1; Wed, 08 Dec 2021 10:15:08 -0500
X-MC-Unique: ZNTLP1JRMYSOmYQEAxA8Gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86AC03E743;
        Wed,  8 Dec 2021 15:15:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36EED60C4A;
        Wed,  8 Dec 2021 15:15:04 +0000 (UTC)
Received: by localhost.localdomain (sSMTP sendmail emulation); Wed, 08 Dec 2021 16:15:03 +0100
From:   "Jerome Marchand" <jmarchan@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     =?UTF-8?q?=E7=8E=8B=E8=B4=87?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: disable preemption when recursion locked in arch/s390/kernel/ftrace.c
Date:   Wed,  8 Dec 2021 16:15:03 +0100
Message-Id: <20211208151503.1510381-1-jmarchan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like commit ce5e48036c9e76a2 ("ftrace: disable preemption
when recursion locked") missed a spot in kprobe_ftrace_handler() in
arch/s390/kernel/ftrace.c.
Removes the superfluous preempt_disable/enable_notrace() there too.

Fixes: ce5e48036c9e76a2 ("ftrace: disable preemption when recursion locked")
Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 arch/s390/kernel/ftrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 5510c7d10ddc..21d62d8b6b9a 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -290,7 +290,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		return;
 
 	regs = ftrace_get_regs(fregs);
-	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -318,7 +317,6 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	}
 	__this_cpu_write(current_kprobe, NULL);
 out:
-	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
-- 
2.31.1

