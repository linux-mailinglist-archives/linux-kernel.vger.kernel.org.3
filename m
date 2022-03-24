Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87F4E6A87
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbiCXWOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCXWN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA456B0A74
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648159944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kVBjsNb2VDJLwgcDZYe43jQSQ0QHWlb+IMiUnQWI++k=;
        b=Xjir/MOWTkMQQWhbf4+lec1P10/pPTlhY4Uz+8OGrkiVaMjDYB6CarcAQSZMJ+Nw8ndGhD
        ccwNYNd9KVTeJBlFEn+GFb0s38YEZXdIwcRPb7emmsS/N52J99XR7T0rgTMnnIO/AidSeU
        6mtjhLus/zkmKSbDcGtbo+cF2Hulf3s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-mogqiX2INry9iokN0gUTXw-1; Thu, 24 Mar 2022 18:12:18 -0400
X-MC-Unique: mogqiX2INry9iokN0gUTXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E77CD381D8A0;
        Thu, 24 Mar 2022 22:12:17 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.33.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA8E40E7F02;
        Thu, 24 Mar 2022 22:12:15 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rob Herring <robh@kernel.org>, Wang Qing <wangqing@vivo.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/sysctl: document max_rcu_stall_to_panic
Date:   Thu, 24 Mar 2022 18:11:56 -0400
Message-Id: <20220324221156.44813-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit dfe564045c65 ("rcu: Panic after fixed number of stalls")
introduced a new systctl but no accompanying documentation.

Add a simple entry to the documentation.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 803c60bf21d3..4e48139b9a34 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -781,6 +781,13 @@ is useful to define the root cause of RCU stalls using a vmcore.
 1 panic() after printing RCU stall messages.
 = ============================================================
 
+max_rcu_stall_to_panic
+======================
+
+When ``panic_on_rcu_stall`` is set to 1, this value determines the
+number of times that RCU can stall before panic() is called.
+
+When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.
 
 perf_cpu_time_max_percent
 =========================
-- 
2.27.0

