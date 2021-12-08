Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865DD46D81C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhLHQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbhLHQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638980883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fCVWpc3lU7ppGwwJG1R7x7mdqXrPoeFyulQeUTsj+yA=;
        b=V3b3DfpzSi0d3aptDgPPYmeNk/2qnQ3xr69gDYklPhJSpiiaLi248KOn46wVr62RPVVdVo
        xURef77/dlqmr0BPSBK1K3ymD8dGstaIDcfzVn+02DDtbh24so9HwxfafMf0/TwQmAK0Xz
        IUnmuvdKV4QlO996uZkZ1SG8EhWcofA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-276-cnznCWvIPhOBGRSaBTZ1SQ-1; Wed, 08 Dec 2021 11:27:57 -0500
X-MC-Unique: cnznCWvIPhOBGRSaBTZ1SQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5361118A0F31;
        Wed,  8 Dec 2021 16:27:56 +0000 (UTC)
Received: from wcosta.com (ovpn-116-207.gru2.redhat.com [10.97.116.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7092F694D9;
        Wed,  8 Dec 2021 16:27:50 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Cc:     Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH] s390: remove useless preempt_(dis/en)able calls in ftrace code
Date:   Wed,  8 Dec 2021 13:27:19 -0300
Message-Id: <20211208162719.178393-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ce5e48036c9e("ftrace: disable preemption when recursion locked")
moved the preempt disabling/enabling code to
ftrace_test_recursion_trylock() and ftrace_test_recursion_unlock(), and
cleaned up all direct calls in the ftrace code. But it left s390 behind.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
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
2.27.0

