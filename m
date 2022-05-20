Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F072252EB25
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348729AbiETLv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348722AbiETLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:51:23 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAAD193EF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:51:20 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DBDD53F1EE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047477;
        bh=ulZqruHzuXibmsmfjZ5kTMOimfHFQdq4BeiWtFLLtng=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cunq3yYICOjhgmxy2olxG1fcA0tIhbu3rQFiS9BfNPEKYaHFhgnqW7BemCM9v7rHs
         WxL/cLM50XRpch9h6L9zl5npW5uwj02tYgJY2Cfj1FQbR4b1M+YPu1024hCWrAQEOe
         lq/Yg0WTdFCSz+WAnZveIDlCz7fCWGEWUUHviv7uu+ZdOko19cdnJlEiQWmN93E6/L
         Z6obT9I1sPVOPtycNnrDZbsDq67dB+Wr8mstJmleGUhM4yAVk0WsZ3aminTBasagya
         WdYkMPc4Jpw6crB7N+BpNYL+I0dBeoXcpLt67rLFXHLVTMEcMQ1NIBE1fJV1USGsbC
         kugaBZyo3JjDQ==
Received: by mail-ed1-f71.google.com with SMTP id p13-20020aa7c4cd000000b0042ab847aba8so5535553edr.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulZqruHzuXibmsmfjZ5kTMOimfHFQdq4BeiWtFLLtng=;
        b=P0RQGcHhy3z9vW4lSUSKzRbhFyHfsU4UkR0a43EE27Mq5NckK3PACbgd0Z3E7pVT4V
         GhDck9C5VQHhkThUysnoIyM2fWiBptwiBpCxNt0sSkLlK8+nkkf7rIjNov7RwO+TOGCD
         F7GU/JF4Iqu1thi1h5OlCPnnxa6r4JZzLI+Pu2cDlvbKlx4Vr3InDgUgTnx4a/LyBfK5
         otzB2Ax7NbdKqyoT5ruY0Uec8bsE/U7ygWcXuyELnhaMKKsSgae2k+xpyOQ1Cr/rNi4c
         NF6t+T1XjN5XAnxXBgGpfH2VQUUOgK7Ipl1oX5mHeMM2Gjqj/HQNiTZwKkMrpMbiJRRP
         hDSQ==
X-Gm-Message-State: AOAM532u6IhXi7PxJRjCTidd7DYln9QCT97BXXeYKMGaVU0awF6Wv5JI
        DE8mXplSAfopQ/cOzyZtvwAoC0PGMPQxjkQMnIn/JeGd8x6IQB+zP02n+khy+Gyx00vRCP3MFm3
        b1eZqD7mQlvGvsJQ1jKArRJx5QfuAf78C68V2H4GHZQ==
X-Received: by 2002:a17:907:7ea2:b0:6fe:7ef2:b71d with SMTP id qb34-20020a1709077ea200b006fe7ef2b71dmr8127410ejc.508.1653047477468;
        Fri, 20 May 2022 04:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcRQRee3TWn0TijUw5yehWrcDOC+S3/Ig1s/PEUC/T4w2AOT2xmnYsTj5rT1lS6xgC2pgVrQ==
X-Received: by 2002:a17:907:7ea2:b0:6fe:7ef2:b71d with SMTP id qb34-20020a1709077ea200b006fe7ef2b71dmr8127397ejc.508.1653047477330;
        Fri, 20 May 2022 04:51:17 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id e18-20020a50fb92000000b0042ab8c5e99fsm4112411edq.14.2022.05.20.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:51:16 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     keguang.zhang@gmail.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] MIPS: loongson32: Kconfig: Remove extra space
Date:   Fri, 20 May 2022 13:51:13 +0200
Message-Id: <20220520115113.147170-1-juergh@canonical.com>
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

Remove extra space between 'prompt' keyword and string.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/mips/loongson32/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index e27879b4813b..2ef9da0016df 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -46,7 +46,7 @@ menuconfig CEVT_CSRC_LS1X
 	  If unsure, say N.
 
 choice
-	prompt  "Select clockevent/clocksource"
+	prompt "Select clockevent/clocksource"
 	depends on CEVT_CSRC_LS1X
 	default TIMER_USE_PWM0
 
-- 
2.32.0

