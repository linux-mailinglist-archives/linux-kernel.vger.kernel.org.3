Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FD52EB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbiETLte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbiETLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:49:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B095A132A2E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:49:31 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F31D402E2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047370;
        bh=4ti1KqlurwIS5Lcd/ebOvDddoubXmSS5qghPXE8ncpM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=lHVZENAQeevoWNJg+BX3zPmGqCcR0hk3F3kfk6krXMYukzahY/+Wl4MxKKqGM86RX
         3O4jab/rCwpR6MKGjm1prajpdwu20QiLGjO/hTMSTgxDnsViU7OdJwMnq8EZtSMB/v
         2j35cV8xR3HwgW71odQqY1SYTflhAgibFoA85CTailha6s2A3Kz0J0vsc4ufrdW4OU
         t71syhqB0IeWjzESQ3zbIylPieD4L+QFgVza8s7WyotYCnzUYHZAt3wGFC9J9GRfwM
         /5Tpxuz1kN4TGL8dPaXFiO+KNjPYl4KNRCt36NwDwt9HY2zRS0gMUnNRSD+LDyKUxD
         2JKVYmzlkhKvg==
Received: by mail-ej1-f70.google.com with SMTP id sh14-20020a1709076e8e00b006f4a5de6888so3927048ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ti1KqlurwIS5Lcd/ebOvDddoubXmSS5qghPXE8ncpM=;
        b=oPdHg8TwuSQvZIquFikQc1GQQ6T6OkyuZZRE0n9k/goRnh+koqtLD0kwlq7FiaRhNQ
         v2sdU4EEfxqnI20+uj+6Y8rCvoExr7ZoALqQc44ehAfPi/cbVpG4ikYAo7HoYe/ZeZ/H
         6OyiuAb6ou/p4TGR7S1UKiP6TyCrro+VOl/1Gnhxl8+EwWmNf69etm0r/Y80cWzrtDL0
         1n0tHHfIgTKB5qem8xSBOh1wjfa8LhBZw1Lx8hzl+VFUM25rocY2omneCcJJu0xAkBYo
         aTGX3Lj40JdkWyjBozELezsD8XgYlNZb8nK1RUqSTryDqhiyM5AC+M597dWDyTJ7whii
         3ZAw==
X-Gm-Message-State: AOAM530JTQVBg17QMsk+kQ4NhiH1gqDBSZeE3YgMV/bkhrTJ7h1wUveq
        Ofbe/PZZ/Vjx7gjmsRQXoqIfHz+BSV6zYP0OdtLRqqN3ogAynSZoefQsBT1Cgx1L+NFkZry4KIp
        0c4wmpjwTO21ZbZQjy0CJhecuqO6ffNWVogMXBxn1ag==
X-Received: by 2002:a05:6402:51d2:b0:428:48d0:5d05 with SMTP id r18-20020a05640251d200b0042848d05d05mr10489699edd.28.1653047369136;
        Fri, 20 May 2022 04:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/qSQuv4tmlwL29CDe5xjmk8u6qdJ33QeQ3W/C+U4U3T4kq1mQvqmQfFAyieWTaF8gmidmzg==
X-Received: by 2002:a05:6402:51d2:b0:428:48d0:5d05 with SMTP id r18-20020a05640251d200b0042848d05d05mr10489681edd.28.1653047368960;
        Fri, 20 May 2022 04:49:28 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id d3-20020a170907272300b006f3ef214e53sm3048527ejl.185.2022.05.20.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:49:28 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: vt8500: Kconfig: Fix indentation
Date:   Fri, 20 May 2022 13:49:24 +0200
Message-Id: <20220520114924.146968-1-juergh@canonical.com>
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
 arch/arm/mach-vt8500/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index d01cdd9ad9c7..408e405ae568 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -9,9 +9,9 @@ config ARCH_VT8500
 
 config ARCH_WM8505
 	bool "VIA/Wondermedia 85xx and WM8650"
- 	depends on ARCH_MULTI_V5
- 	select ARCH_VT8500
- 	select CPU_ARM926T
+	depends on ARCH_MULTI_V5
+	select ARCH_VT8500
+	select CPU_ARM926T
 
 config ARCH_WM8750
 	bool "WonderMedia WM8750"
-- 
2.32.0

