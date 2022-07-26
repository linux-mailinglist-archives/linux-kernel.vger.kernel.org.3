Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549B580E07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiGZHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiGZHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE859AB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y13-20020a5b09cd000000b0067114eb5b50so5462640ybq.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=VavrLtXbRNR5iYY6DuWJsiPM2oJzRiMbR593lo0d1Rw=;
        b=j96IaEX62h71DWb6L/1x3UIPVuOe11L4SskRUNLfEpqgu2vu4jVoT7hkbCAryRObVn
         Zi9PUjFc3msAp6dAeAxLeAvs5ursb0jnWMfa66uohrRUKiYMKU6skuOaJAlmHKMEnNXn
         osaNYizMUsQjs8peiYd/0YDjLYH7izn6TGf8Vejoqckt5OSYyCR7wAWcWajSZnntZDeQ
         G8qLCUQzdjzgvYlwgCnfYmJjBnkmOh5UZMKCFOUAbItZYA5Di/+5IJKFfMmR5lxLeFg+
         6H5z7pSY/XdyftcagV0boM4TJERzjbvtdEnrnWDxPwe3kwN/CDSKVtd3hu6+6QLzA8Z7
         0jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=VavrLtXbRNR5iYY6DuWJsiPM2oJzRiMbR593lo0d1Rw=;
        b=LyjCWlR2cRHaz6PzCbZZLg/VZDJTpa4VlR3vvTDzFrHiNeMf10XsMkoGmwEEvp0Vbc
         Ce9xmaqF10TZ82WxEeJITJY0GA/FVqugq1/pF8EceBpslhZSid4Mhm8JtnAzAmVgUn37
         FLR1k4zdNriYfTcjpjqvGn8ccVSEpy7Wot9PBK1CQzIglRKIMmcUzdEG/6SLkS7oCDWM
         euQpYIVl5SKdN7TPFu8ktgQCKDAGNDDD/ub2dXFSATtREHnsMFGvGNLfDqF8J/WQE4MX
         /Wvv2nauZGr9IbmlcvsP5nG+pP9WyzACc82VNKS1EmYlKxkojbNMyn0gkdDcvGZP4Gnh
         aSrg==
X-Gm-Message-State: AJIora8aeYomWUkEUSQ09OMBQZZAw+Mz3qD0JkLLW0FXWkI83rL73isO
        K1PnKSGVBXlvoOmGMIYzNKa2ngwfKQ+sGRcxtA==
X-Google-Smtp-Source: AGRyM1uLngP1y5rfZv7qcR91UDrsOk5KX5o+Z2nFXgrbRkoOxYN5kjOvh7dIZvVEJTbG63rkQ3WbCIEv9Qf04bN+kA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP
 id b145-20020a811b97000000b002db640f49d8mr13021154ywb.326.1658821090210; Tue,
 26 Jul 2022 00:38:10 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:39 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 06/17] arm64: stacktrace: Add description of stacktrace/common.h
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brief description on how to use stacktrace/common.h to implement
a stack unwinder.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by tag

Changes in v5:
  - Add short description of each required function, per Fuad and Marc

 arch/arm64/include/asm/stacktrace/common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/includ=
e/asm/stacktrace/common.h
index 4b632141d91c..45474b383630 100644
--- a/arch/arm64/include/asm/stacktrace/common.h
+++ b/arch/arm64/include/asm/stacktrace/common.h
@@ -2,6 +2,21 @@
 /*
  * Common arm64 stack unwinder code.
  *
+ * To implement a new arm64 stack unwinder:
+ *     1) Include this header
+ *
+ *     2) Provide implementations for the following functions:
+ *          on_overflow_stack():   Returns true if SP is on the overflow
+ *                                 stack.
+ *          on_accessible_stack(): Returns true is SP is on any accessible
+ *                                 stack.
+ *          unwind_next():         Performs validation checks on the frame
+ *                                 pointer, and transitions unwind_state
+ *                                 to the next frame.
+ *
+ *         See: arch/arm64/include/asm/stacktrace.h for reference
+ *              implementations.
+ *
  * Copyright (C) 2012 ARM Ltd.
  */
 #ifndef __ASM_STACKTRACE_COMMON_H
--=20
2.37.1.359.gd136c6c3e2-goog

