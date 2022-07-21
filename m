Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40C57C3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiGUF6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiGUF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD479ED4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so596657ybi.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=innDUxJqwACKwxXV5MqFrMuXYhJfRcgn5/z66I4MfpY=;
        b=j93Q+9vCOMIlrd8JUKeoSlEgKUhZAN3jSK2XP3BhOFfL5yOpWBENrI60zOwAPbO91x
         N6XQSWNcmzIhWj8QkGWW07DP7EeyA/mqAvAChzhCELfCbJeCF8pigRfOnmDEu/LFP7Wc
         gU926Sr383UjK2SWUbwqn7Qb7r0pBoMdXlpP9SU6nVu+aodOUXYuu8NsDoDaW2y+puqr
         s0UynAbnY7+79mAByXBhH4o/jDbNBk4CrLATYNetHf6lfi1CJ5b3j0Nelut1331YvmyO
         iMtm0q/sWDjIGFky7wv3hVEEFfWt3aspQ2gQmPPLX6M4E8bxwwznpbjEnbAXpy8kgXog
         rVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=innDUxJqwACKwxXV5MqFrMuXYhJfRcgn5/z66I4MfpY=;
        b=wm8ond59S9pqVLJN0NYovb5M+7Am++uQr+9T2rjdJxbFRJIos4QOpOcnXGPeMJT799
         aYJWHN1v7WYMqv1foR7itWYUT4enUz0+1RI22Vc7/h2ZlgVhecZrK6reKolC8y68QnVw
         7OQ7sPHbzgeQyDGWp+VMde4rqRRL4sLl+/JL0+zMR2D3FE3PODLqc4szI5fUgO4sV2hE
         +7vi7MHcZnSi0ivwtTG8+nOLj1QAGf5zNjbB4o1zn3kE2hAB0SLxD/C7DjrsyM2QCw/6
         WM+rFxkFjCb67my6mcttYvG2XQ4v6lDfins1MfNX6H0N3pMwlPZ9RJw6aFI7E36mhvwC
         Tadg==
X-Gm-Message-State: AJIora/n1p+257Vj0vzABNW2cNxQ1Fs/NOO34eczopJ1IRMa8NgLpYKA
        8iEvV4b54w8UECSBca8xX0Mfp7b2b39RPytoTg==
X-Google-Smtp-Source: AGRyM1sfor76YmofP6IuFGP7/vlKV7Yykd8ZozDRP+vyvW6PfvuolIS6g+LFmS4sH9UnTfXd9e/iHAUsYmoQeAReYg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a81:1a52:0:b0:31e:8774:6e9b with SMTP
 id a79-20020a811a52000000b0031e87746e9bmr369844ywa.78.1658383073351; Wed, 20
 Jul 2022 22:57:53 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:19 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-9-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 08/17] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v5:
  - Make PROTECTED_NVHE_STACKTRACE depend on NVHE_EL2_DEBUG, per Marc

 arch/arm64/kvm/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..09c995869916 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,21 @@ menuconfig KVM
 
 	  If unsure, say N.
 
+config PROTECTED_NVHE_STACKTRACE
+	bool "Protected KVM hypervisor stacktraces"
+	depends on NVHE_EL2_DEBUG
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

