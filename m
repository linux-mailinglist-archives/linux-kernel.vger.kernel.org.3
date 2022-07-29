Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09D1585553
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbiG2TDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiG2TDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:03:07 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84E989A48;
        Fri, 29 Jul 2022 12:02:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 032D6319289;
        Fri, 29 Jul 2022 15:02:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C_e5cOg2bAPe; Fri, 29 Jul 2022 15:02:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4A9EC318AAA;
        Fri, 29 Jul 2022 15:02:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4A9EC318AAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121368;
        bh=84B9YOyXv7c3EB71cteYmLNG2oHcoRDleMv6nuC252o=;
        h=From:To:Date:Message-Id;
        b=o3UsOEmjBfGQi5AiHHd+MmgnHXS8IluYh/0o7KlOtfbrUVy0zOq290Ha0tRvV/tlc
         /aAKOu8B2GwCfBXwh3o3hjL7/Il3ToI3tVbA8YobUZ/cvuc5qocC6s81E1bmr1mFY3
         2aBDs138lLCfyusGSJNJSoVJuQiU6Ncc10mqdnNl25zy8zJt0mqvSW4IqWohHgdaF/
         etE2gZ+pb/ZsGH5Q2zTOymhZljGRyKjPAXGP3Ch95JJpyIU1eKGXXJKoIcJNhvHyQg
         LWNVozDQSdSHeYtuVXFJh5FEbu7MMfacsZxAapsOyRVLVbfCjv2PL6yl16lSYBgOnH
         un9m3pAcEvDOA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6du7qYx850Fh; Fri, 29 Jul 2022 15:02:48 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 9B087318D7A;
        Fri, 29 Jul 2022 15:02:44 -0400 (EDT)
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
Subject: [PATCH v3 12/23] selftests/rseq: Implement rseq vm_vcpu_id field support
Date:   Fri, 29 Jul 2022 15:02:14 -0400
Message-Id: <20220729190225.12726-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h |  9 +++++++++
 tools/testing/selftests/rseq/rseq.h     | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
index a1faa9162d52..1ee4740ebe94 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -155,6 +155,15 @@ struct rseq_abi {
 	 */
 	__u32 node_id;
 
+	/*
+	 * Restartable sequences vm_vcpu_id field. Updated by the kernel. Read by
+	 * user-space with single-copy atomicity semantics. This field should
+	 * only be read by the thread which registered this data structure.
+	 * Aligned on 32-bit. Contains the current thread's virtual CPU ID
+	 * (allocated uniquely within a memory space).
+	 */
+	__u32 vm_vcpu_id;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index fd17d0e54a1b..003e0e3750ce 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -191,6 +191,16 @@ static inline uint32_t rseq_current_node_id(void)
 	return RSEQ_ACCESS_ONCE(rseq_get_abi()->node_id);
 }
 
+static inline bool rseq_vm_vcpu_id_available(void)
+{
+	return (int) rseq_feature_size >= rseq_offsetofend(struct rseq_abi, vm_vcpu_id);
+}
+
+static inline uint32_t rseq_current_vm_vcpu_id(void)
+{
+	return RSEQ_ACCESS_ONCE(rseq_get_abi()->vm_vcpu_id);
+}
+
 static inline void rseq_clear_rseq_cs(void)
 {
 	RSEQ_WRITE_ONCE(rseq_get_abi()->rseq_cs.arch.ptr, 0);
-- 
2.17.1

