Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F64C44CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbiBYMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiBYMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:44:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BB1C8847
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:44:03 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B105E3FC9E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645793041;
        bh=JOP3F1szvziyyHwwb25WbMBDR7/phOdbs80dtO/BlA0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LLJ6IWhpJ6nKNMqqShVRMVnNn4J9YumQp3stAbxcpEJ0RnmNXnk/rNVg6SGNanG27
         +QT7s39/jdtDzDVljmRtn6l+7ScI1VObQ6yN83+YGJhp/PIEtEz28vR8+6mBq5czzS
         6dOG8HjyvtgNLWP6Y5xDpw5Xjz/1jX4ZXeIzdCNiAn0GhlR0Qpcdc7atoMaIZDkrYk
         BOar5vJeuNq/sji1jI+ZTO4IzhHWMWHwYVsLzFwfk1zQb2o8iRHlpsh4UiXzyMXmFz
         uNr+L3gtxs1U9JmSkCC9Zbu+ln6OrmeCGGIXSYUKVjjrj3z0UIX3xYAhoXZzv2Lqr/
         6B/uD0n8PLXZQ==
Received: by mail-wm1-f69.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so460680wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOP3F1szvziyyHwwb25WbMBDR7/phOdbs80dtO/BlA0=;
        b=i3F9QY8XTaXnHhL91NmFRilioObzPgaPswmylIssHMozN8d5EH9tcpNLzaxoBRKbA7
         zY988/nL6eYzv8TR+rVzfloHswKWWwMu4QQv1w9DHf2Z+eJ7mSJMVWIgBSRz3Rqf27nE
         9tK22T1nhQg9eXfMI+PaXdDBQeippp6hJngdvduaoWUuByGeh5h1vmxyhsJxkXLhcKBc
         sEp/qVk9Ep5rTO7Wk+sSH20ODwbjP/qtWOMOYog4R6WzyahNg3GDt7aXeshJeLssgk5M
         ZUak44pCtjd5C2QGBiEFqgOZqvRBspqd6MEw35qUjOOqP6kNpSyLFPS+txn2WlQiotF0
         iCLQ==
X-Gm-Message-State: AOAM531v5/4/W2X2HZyqTO+SpFhdqkA3Ju7mDLsmyXAMOfo/kTJUbQP7
        Pi1B6O/kosYW8eG8RcF3LPczFaLoL/6ZBLJAfjHsfIWa0DrJDi0eO2NTAfKgVy1MS9SqSGqh5gl
        qF7j1Y7K+/HPZfC0pOFU7Ozul8olWzoWuSoHrQIKttQ==
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id q4-20020a7bce84000000b0037c52fea3ffmr2567642wmj.48.1645793040998;
        Fri, 25 Feb 2022 04:44:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztvmWREbdipkwIP+Q6hL7beS4tVObs1D+0g7s/qnUUZuZ6sJgmbN9exqgPVTMCY5OVHLM1OQ==
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id q4-20020a7bce84000000b0037c52fea3ffmr2567618wmj.48.1645793040749;
        Fri, 25 Feb 2022 04:44:00 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c154a00b0037bbbc15ca7sm10658533wmg.36.2022.02.25.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:44:00 -0800 (PST)
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
Subject: [PATCH -fixes v3 4/6] riscv: Fix config KASAN && DEBUG_VIRTUAL
Date:   Fri, 25 Feb 2022 13:39:51 +0100
Message-Id: <20220225123953.3251327-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

