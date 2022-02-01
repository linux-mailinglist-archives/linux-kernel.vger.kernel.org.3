Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4298D4A64FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbiBAT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:26:29 -0500
Received: from mail.efficios.com ([167.114.26.124]:53348 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242362AbiBAT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:26:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7D74D33FC17;
        Tue,  1 Feb 2022 14:26:24 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0PdxbvaKTw7s; Tue,  1 Feb 2022 14:26:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 278AA33FC16;
        Tue,  1 Feb 2022 14:26:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 278AA33FC16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643743584;
        bh=UerzEHT0HokfvobQ6Sx0XXHkVzDdD+XuQ7F7dL2bDt4=;
        h=From:To:Date:Message-Id;
        b=lcUnLu59tpKPeUMApFtzsnz3PFre7XjC114lnEuPMWK6kHaeDbOZM6S3ocftaotzq
         jtXt1tCTX/Qn+Zzc5ryNzcLmTuHsvnlWLEaWu+zNUziqKO1tih+ZUcVGTAGcJH/Rlf
         c2uZpsulMq2KIuGWGpDTTFJCNJ1+ndXsRa8X50X/qWnL8aeIU/n+nrYICKvY04/GSI
         VdEycjx375ExAHsCs4nNM6rVDNdmItd28C6RTJdM6vbUSlQt0lHbzUgq6WW6Q1dBfz
         GggTDMozEDTlHruLOWXBhMr7SFrGGmqwfwW8BDgFBn5Bv2h8XzM9oWoI4QsPPRjAYd
         6qrrvQrcb0GMg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id juUsdtvvD7aA; Tue,  1 Feb 2022 14:26:24 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 17F7233F8FB;
        Tue,  1 Feb 2022 14:26:23 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/3] selftests/rseq: Implement rseq tg_vcpu_id field support
Date:   Tue,  1 Feb 2022 14:25:40 -0500
Message-Id: <20220201192540.10439-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h | 15 +++++++++++++++
 tools/testing/selftests/rseq/rseq.c     |  6 +++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index 850827e8d089..929183c2b3c0 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -169,6 +169,21 @@ struct rseq_abi {
 	 * rseq_len. Use the offset immediately after the node_id field as
 	 * rseq_len.
 	 */
+
+	/*
+	 * Restartable sequences tg_vcpu_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's virtual CPU ID
+	 * (allocated uniquely within thread group).
+	 */
+	__u32 tg_vcpu_id;
+
+	/*
+	 * This is a valid end of rseq ABI for the purpose of rseq registration
+	 * rseq_len. Use the offset immediately after the tg_vcpu_id field as
+	 * rseq_len.
+	 */
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 #endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 4b0e68051db8..c8d30e770d59 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -88,7 +88,7 @@ int rseq_register_current_thread(void)
 		/* Treat libc's ownership as a successful registration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, rseq_offsetofend(struct rseq_abi, node_id), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, rseq_offsetofend(struct rseq_abi, tg_vcpu_id), 0, RSEQ_SIG);
 	if (rc)
 		return -1;
 	assert(rseq_current_cpu_raw() >= 0);
@@ -103,7 +103,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc = sys_rseq(&__rseq_abi, rseq_offsetofend(struct rseq_abi, node_id), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, rseq_offsetofend(struct rseq_abi, tg_vcpu_id), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (rc)
 		return -1;
 	return 0;
@@ -126,7 +126,7 @@ void rseq_init(void)
 		return;
 	rseq_ownership = 1;
 	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
-	rseq_size = rseq_offsetofend(struct rseq_abi, node_id);
+	rseq_size = rseq_offsetofend(struct rseq_abi, tg_vcpu_id);
 	rseq_flags = 0;
 }
 
-- 
2.17.1

