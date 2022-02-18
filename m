Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCC4BBA33
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiBRNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:40:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiBRNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:40:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D395C93183
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:39:46 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AF52F40304
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645191585;
        bh=JOP3F1szvziyyHwwb25WbMBDR7/phOdbs80dtO/BlA0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MtHHO6vU2uXudTT0eRyb9HtTpJSMsmVwB/Om7S8YX9jk82iV7JzupkoF+pcxPmSPf
         tTMcN11P1kpy3dxOINkCLRYOdp4slQzvmrPZ+BSb1dGspaaNxfSKxeO0vm/v2I8Qiv
         4W+K8SSKI4yLtW7WMDDtNJbDTWsjs/oRMWV7YQluJwVYD/J0F0LEm01lLeC0N0YyDJ
         5Z9S712bypNnl9n6Ngp5q/TJ8JUNX4ecxfDsiRpn49syB8mx8dk4R5nAGC8pU5WclA
         oUkFWZF8lk5/QoirWM5/FYMMS86XHEy77CVABptB11WfcFSa1OC/wRsoSGRWUMVEV9
         zXNAykb4tKZGA==
Received: by mail-wm1-f71.google.com with SMTP id r11-20020a1c440b000000b0037bb51b549aso5161526wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOP3F1szvziyyHwwb25WbMBDR7/phOdbs80dtO/BlA0=;
        b=S38h0aODv+sfKvrijKxl7jPk6SP6OxFWyiTCwBAK5Js8lyOHYGU9XTo1v10eNDD7zZ
         iz1D2PaZQIP/3xumam98kS1ufqiLhfhNNlwf7f5Km9+FVLBTsPRZpmneFzNC5KR3Sf9T
         cUniIizgmsX5IXX5g0k1ZNM2gdVc5sZO9eP3OVxkMYETrSNtooBquwbHGgLBGMmXCYUy
         5yfdtI38c96Vy7W86U3HwAo1/EhZZK7zvomGcKZyIjSw5M2/XIQiD0ZeuGV25j/7u9Zh
         oP2rwujscP+Bg4AMfTFU+XDnw9qlu7d5qHDpMnWcqz4szr4teI1F8H7icO6a9PMvH+ox
         ESIA==
X-Gm-Message-State: AOAM530P7bzRpcNrcl06IZOEzMkvVg37xpAhXx0j5gcuF18gfg3gA9CP
        7i/KnXRBu9vZ2/9S8ft2bmt9oYeAnPdQnUv+OkRKCuE5M8zecqPxLwF4dgGFvTEYaHDCkYeZBuA
        mK1YEa7akOCJh1tGDfPXgzTjlEJ5lAXJ7GWKa78nR0Q==
X-Received: by 2002:adf:e5d0:0:b0:1da:4dfb:497e with SMTP id a16-20020adfe5d0000000b001da4dfb497emr6489390wrn.282.1645191585233;
        Fri, 18 Feb 2022 05:39:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa9rnt86pwmOEJdbUgC/kacrYzPY5oQ4mpvy+Mq/o4FjRWXCIzn6psjVvt7DCwVdslstNNkQ==
X-Received: by 2002:adf:e5d0:0:b0:1da:4dfb:497e with SMTP id a16-20020adfe5d0000000b001da4dfb497emr6489383wrn.282.1645191585101;
        Fri, 18 Feb 2022 05:39:45 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id x11sm4183619wmi.37.2022.02.18.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:39:44 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes 4/4] riscv: Fix config KASAN && DEBUG_VIRTUAL
Date:   Fri, 18 Feb 2022 14:35:13 +0100
Message-Id: <20220218133513.1762929-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
References: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__virt_to_phys function is called very early in the boot process (ie
kasan_early_init) so it should not be instrumented by KASAN otherwise it
bugs.

Fix this by declaring phys_addr.c as non-kasan instrumentable.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef10ea1b..ac7a25298a04 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -24,6 +24,9 @@ obj-$(CONFIG_KASAN)   += kasan_init.o
 ifdef CONFIG_KASAN
 KASAN_SANITIZE_kasan_init.o := n
 KASAN_SANITIZE_init.o := n
+ifdef CONFIG_DEBUG_VIRTUAL
+KASAN_SANITIZE_physaddr.o := n
+endif
 endif
 
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
-- 
2.32.0

