Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4752EB41
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbiETLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348759AbiETLyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:54:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29AE15E485
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:54:36 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F09953F1BA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047674;
        bh=deCcyVhVyKD2/JPpSzZpMIDpYKyl3Ap6BwhEK9M4/s8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=u7Ue20mcGBggvASH0NedxN1/VKeVam6fMvZNh9hOIIpgF9Y823l9rKFVc+LA5K/Cv
         QCEps+WSr91Pz6Z2DQPfmQIGLZEhLQlk2gCaFZwe91oCTi3THhU9PBPEeQvHosxILM
         6tK6L9Fj54xBXESSQp5FZh1tLKK/rfxJD3D9ZfumfK4SsYcngEJtKc6d4vgEwZXW94
         Lq6L6ZNnNWZE554P1K15f1HtJDD9EigXAW4/l6M9Ey1XXNKUS6o1wmHydLRWIbsZtT
         TiVZRlwOtr/nTdw5bi4nrBc6p/7KUUCGBVRKDKBsin4hQ8Pp60AtvuXX2f+XAdfJpK
         kRPLuRij4XteA==
Received: by mail-ed1-f72.google.com with SMTP id y1-20020a056402170100b0042aa8f679fdso5550095edu.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=deCcyVhVyKD2/JPpSzZpMIDpYKyl3Ap6BwhEK9M4/s8=;
        b=qi19YdBkJxJn1/IDqYhbXQEKLIuRsMKxjgSIuHiVFwPm4O7QF4wvYMvNlmqD3G8mIw
         zEKeYEYi7SinJRA+ByZUDYOh/Lq2ZoCU7UQumA7mmX01VlK0sdYOmAtMZH9AH7p1iH0G
         hHbKIqh7arxTNVdIw+csYzvSztw4vADDiFxEYcbePqBXxxPTwyPDY6riz3UIvJkRwv/T
         YeR+LsFKRADwXnRYI05+Y9URV8QoRYZ9OBum5qSEnu4QffDqmkB/ed9k/LmVCfAOASVk
         udJLkTdCSS+6/FKgFjgzbdPb3emQ1T4DfqbvO4jfJJkFBk9UXZrCIp5ABvTZiy8YsClV
         rjaQ==
X-Gm-Message-State: AOAM533D4ueM7Rry579Po1CwOnhMBxYZid37+As1oXzoNUi0tDPftSyV
        NQqSmmdh8/zpwZNsgTKNf2S5DUWxJ4UcWoRPUAuKWAxsE5Jyw9McYt+9D0pKT1Jmh+vSmMQkkmS
        RNKfbwym3nM6xr/ACDwITdVTwIvgqA/bR1K8kYiCeAw==
X-Received: by 2002:a17:907:3daa:b0:6fe:88ab:fe8c with SMTP id he42-20020a1709073daa00b006fe88abfe8cmr8136295ejc.575.1653047674687;
        Fri, 20 May 2022 04:54:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGYb7iuTm8Rlzr8a4NeJlgaXcvtLbYBbdOK1XLz9DVlSPQcOFRtd66KjcfayizB1DjW9FI2A==
X-Received: by 2002:a17:907:3daa:b0:6fe:88ab:fe8c with SMTP id he42-20020a1709073daa00b006fe88abfe8cmr8136282ejc.575.1653047674537;
        Fri, 20 May 2022 04:54:34 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7c80c000000b0042617ba637esm4231156edt.8.2022.05.20.04.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:54:34 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] KVM: PPC: Kconfig: Fix indentation
Date:   Fri, 20 May 2022 13:54:31 +0200
Message-Id: <20220520115431.147593-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/powerpc/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index ddd88179110a..fe84628bda64 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -149,7 +149,7 @@ config KVM_BOOK3S_HV_NESTED_PMU_WORKAROUND
 	  Old nested HV capable Linux guests have a bug where they don't
 	  reflect the PMU in-use status of their L2 guest to the L0 host
 	  while the L2 PMU registers are live. This can result in loss
-          of L2 PMU register state, causing perf to not work correctly in
+	  of L2 PMU register state, causing perf to not work correctly in
 	  L2 guests.
 
 	  Selecting this option for the L0 host implements a workaround for
-- 
2.32.0

