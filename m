Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC14580E01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiGZHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiGZHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEF10E2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31ea3f0e357so76440117b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9z1geK001Lgo4aQzTlFwh7+mdMHid79qtYIr9n0hiZw=;
        b=akqv8KPpQa1VNcDlRwBAf0WpbIAk4vEtYIJMvicQmBFeAaugRk9kLN6l+vafdsELTk
         NtqHPyYUML5CJ4AjDiY3dTaY+cSkOpg128D4ZkUQUG9Fz38Uro8ofjsPN0WzDtIet4WQ
         SZYEv+uBqfLl3qepTZ0OG6h7bYpZ3eDokb5EaIFJXHoiXBj3RK1eGwGvMWUb7qW6iO7g
         nyY0uYsGfoAPSXbog85aTEium1GWJ1Xhh3lcJ8Yp8ebpVrv98qa30n06S4cvxkTePaJB
         VUVCyyYygnDOUIC/8x/7m9q/JVzqjGe8IUGeLpvtVWbUFSdClA40lQjVHGIkuc85K3fB
         gYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9z1geK001Lgo4aQzTlFwh7+mdMHid79qtYIr9n0hiZw=;
        b=F+1X03rpQpxtG7vFMLI80YCN+sAR0T/DE0XsTTC3+yGhz1Yoa4XyFK3SH5zmVW+3FA
         gx3NdWh0MRzMaX9Y72/cAxq7xYnhPDsbbDyw85wLDn6GjlX+VK2rrknza/v0VrsThuli
         bEziY6CLPMVNQvVOXFVq7Q/YaKFdb98yhmAF9PwJcov/9MVYN32xo6PYg51gBjjTZIE+
         5sVyikSf7MamYGPbLXr6UL6s0xzJ8DNx67me6I+bqkv2AkRjueODCAMOHsV2rb6i8BD9
         CPeMjGz5nwdgEEeV5KfnpSg9jRvELIqfGturQaFH6tTS4/kFAtpoi21MZ0nk7ZK2NmFU
         FJgA==
X-Gm-Message-State: AJIora8nnVAMuSf6d4xpC2UnttFkurTSEERrUHV65Fy/1Nl+WD+yaLVg
        e/Dkk71bkCbBj++7tXgfoE0t6SSaeQk+i+oVmg==
X-Google-Smtp-Source: AGRyM1u5wMrg3Dj62VDc19qLELQ21pNgDjr7RG8JmDND2ovfsQwBtAh8lTkmGF1a/0WVMU+4RWrNFRXG8A0elKLu0w==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ccca:0:b0:66e:c109:a884 with SMTP
 id l193-20020a25ccca000000b0066ec109a884mr12597907ybf.161.1658821105018; Tue,
 26 Jul 2022 00:38:25 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:45 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-13-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 12/17] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
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

This can be used to disable stacktrace for the protected KVM
nVHE hypervisor, in order to save on the associated memory usage.

This option is disabled by default, since protected KVM is not widely
used on platforms other than Android currently.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

Changes in v5:
  - Make PROTECTED_NVHE_STACKTRACE depend on NVHE_EL2_DEBUG, per Marc

 arch/arm64/kvm/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 8a5fbbf084df..09c995869916 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,21 @@ menuconfig KVM
=20
 	  If unsure, say N.
=20
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
--=20
2.37.1.359.gd136c6c3e2-goog

