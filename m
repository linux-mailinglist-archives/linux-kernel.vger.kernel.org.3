Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D51575B56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiGOGLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiGOGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:11:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6669C7AB2E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317f6128c86so33579367b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3a/b4pln92HS2a1AnnvuOdac8xZP1xDPa4SrMkGLjR0=;
        b=q4C1JK+RQNNz76sRdeaP39mUzrBswZ6WynqoMQ6MKDm8YuAxyRhzVsfEvCXanehao4
         k08Pi42tfwzVKaJ/csOoB8UeWhtI7W1QCy9bY+R8OOq/Tmlbkj6AM8hN1G8VVfDH9g6J
         PjQhLyB7sX4Nw2ShhZyWeWNS6Ke+I9KTVSozUpiBpss5tuOGiAPO+ZobMPwBDxLrFxE7
         zigNiQz1lT/DdliNuWo2n7LVM1Hm0B6jAbBGylJ1zabLyv9YuXpFLMj1nc5SWdqRFE0C
         kUmZ3mPGCWamcUSLxEpDiVl7ylw4U2x4CdiGJoYyQ38S/H18B/rPV+u0xLmXPa5tDHtV
         ZGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3a/b4pln92HS2a1AnnvuOdac8xZP1xDPa4SrMkGLjR0=;
        b=gElF4PxcxfAFnuWq0VanIeMokYD4l6H5xf1korwJX5BUWdjBKiBDWaNNINPdMQMYs2
         h/opkArtDwqOdcDJoPnA/6tfKDgzhnYAgZPt/vAIUcuNrlmvNIOfho7OuDBzFs9y0VAx
         W9ltKlKTSBg/ZiFHzYdIT6uq6EJoETKlJ0KzOPz91u5gN6OnWLQDZOBIuv9NyORi/VFj
         5ALW/B9d2y4E6tK2eE8Ypleck2h2K0epj5G6otoqAQy5essBiym8fKetTYTAKST1ZEs8
         fhuSh1bmVTjWGFSu4wCFCusJeP40kd60MAYdcecEzHlhPesn5gkr8FcPn3ELO3eddipF
         fovg==
X-Gm-Message-State: AJIora+xdwvixX/d5rg7GOpf5A59ukl41YzvCf7vwrbB/wDWH3z6k2PZ
        +BSRtJFTF8kntDNWmeUvnYt4wUJNTmqj5SE5SA==
X-Google-Smtp-Source: AGRyM1sPOtLVKeDmWy879CSPJRglmjW5aqZxQkCzJXmhwSfCnvkLDVoRYFusSgov/9niuUM5cImhZ1ZTKOCqCOKMnQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f010:455b:62ce:19e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:17ca:0:b0:31c:9a75:1f2b with SMTP
 id 193-20020a8117ca000000b0031c9a751f2bmr14665610ywx.83.1657865484575; Thu,
 14 Jul 2022 23:11:24 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:10:17 -0700
In-Reply-To: <20220715061027.1612149-1-kaleshsingh@google.com>
Message-Id: <20220715061027.1612149-9-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 08/18] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        kaleshsingh@google.com, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, andreyknvl@gmail.com,
        russell.king@oracle.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used to disable stacktrace for the protected KVM
nVHE hypervisor, in order to save on the associated memory usage.

This option is disabled by default, since protected KVM is not widely
used on platforms other than Android currently.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kvm/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..1edab6f8a3b8 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,21 @@ menuconfig KVM
 
 	  If unsure, say N.
 
+config PROTECTED_NVHE_STACKTRACE
+	bool "Protected KVM hypervisor stacktraces"
+	depends on KVM
+	default n
+	help
+	  Say Y here to enable pKVM hypervisor stacktraces on hyp_panic()
+
+	  If you are not using protected nVHE (pKVM), say N.
+
+	  If using protected nVHE mode, but cannot afford the associated
+	  memory cost (less than 0.75 page per CPU) of pKVM stacktraces,
+	  say N.
+
+	  If unsure, say N.
+
 config NVHE_EL2_DEBUG
 	bool "Debug mode for non-VHE EL2 object"
 	depends on KVM
-- 
2.37.0.170.g444d1eabd0-goog

