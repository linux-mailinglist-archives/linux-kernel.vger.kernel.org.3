Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DB4C3790
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiBXVYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiBXVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEC421A1C5D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645737824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BY7N70q7sXGBDdrQKQWopMeqmb4Jr71LPGZFNt/ZGqQ=;
        b=KRogMAUMzGH4l7DdfYCt2dNv2QHeQb3CTLhhV57h8tH1o68rgOC2Fv/r6vL0xpslMJx3io
        Xv4ZTiCT9/h1BPfE2gxLJT2rDu4gjXv7ocipi5HsjpYZws/GeXpZAFay8n+VIDacfu3Nrs
        Yl0beAD6CEDtBhcvhMQs5gz4YnJFeeE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-zcU2IoA2NpWysQiJlhj-0w-1; Thu, 24 Feb 2022 16:23:43 -0500
X-MC-Unique: zcU2IoA2NpWysQiJlhj-0w-1
Received: by mail-qv1-f72.google.com with SMTP id hu9-20020a056214234900b0042c4017aeb3so4154658qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BY7N70q7sXGBDdrQKQWopMeqmb4Jr71LPGZFNt/ZGqQ=;
        b=EeJIBWElRwdXUa0PyOYqEoa1siMr8aCQ0ETD1E40hYy1+noQw+JIZXaJBtMzSj6+r9
         rk/cnmXG6Bo8pkGvIok4o5sv7PgtFmtdaMldAC9FZR1666XfoF4lu5MZtbB+p4EmhlDE
         LwkbAUM81I+ZYxqTPz/dBJXj/YsRSkqzvKuDmPqsnscKcVFc3Uyc7jgdpovaL0ovKMxa
         BbNSSNhsNiwwv+HbPXwVGP65QaudgV2Bsshqz/1HmtBkCX3FNPspiAYZ0R64KN9056MT
         JQwbm6QKYOo0kqR/Xt6wLgDt0S3a5YK6gRLuV5qlb7NwAxh8M3skpMCR6K88UvqpzM5l
         Q8DQ==
X-Gm-Message-State: AOAM532aoV4DaeUjIICKU7iqNPKFIHbMeEF+JEu4EsKOrYZTsV9Ty12p
        9cPxOCqqV8FBs8wUiFaYoSoFzTWJiA+8hrN//27996MzMw8Au/fp8XIg1Hqopv+Vhx7Uir05654
        /bU/SgCrXPanja7pws8gySYYi
X-Received: by 2002:ac8:5b0d:0:b0:2dd:d99a:9b6e with SMTP id m13-20020ac85b0d000000b002ddd99a9b6emr4144680qtw.643.1645737822550;
        Thu, 24 Feb 2022 13:23:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCZfIYg09SRdJR3eRunjCHeN4Ra4Qf2OqWmWgdEOCswGYk7JiiMJOOGgH5rjNSKefuUMHdug==
X-Received: by 2002:ac8:5b0d:0:b0:2dd:d99a:9b6e with SMTP id m13-20020ac85b0d000000b002ddd99a9b6emr4144664qtw.643.1645737822344;
        Thu, 24 Feb 2022 13:23:42 -0800 (PST)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id l7-20020a37f507000000b0047b528ef416sm340999qkk.93.2022.02.24.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:23:41 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     corbet@lwn.net
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>
Subject: [PATCH] Documentation/locking/locktypes: Fix PREEMPT_RT _bh() description
Date:   Thu, 24 Feb 2022 15:23:12 -0600
Message-Id: <20220224212312.2601153-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PREEMPT_RT the _bh() version of a spinlock leaves preemption
enabled, align the doc to say that instead of the opposite.

Reported-by: Leah Leshchinsky <lleshchi@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 Documentation/locking/locktypes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 4fd7b70fcde1..bfa75ea1b66a 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -247,7 +247,7 @@ based on rt_mutex which changes the semantics:
    Non-PREEMPT_RT kernels disable preemption to get this effect.
 
    PREEMPT_RT kernels use a per-CPU lock for serialization which keeps
-   preemption disabled. The lock disables softirq handlers and also
+   preemption enabled. The lock disables softirq handlers and also
    prevents reentrancy due to task preemption.
 
 PREEMPT_RT kernels preserve all other spinlock_t semantics:
-- 
2.35.1

