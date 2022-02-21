Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086534BDF07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380129AbiBUQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:17:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380124AbiBUQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:17:36 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6815A1E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:17:13 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E9A294025B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645460231;
        bh=JOP3F1szvziyyHwwb25WbMBDR7/phOdbs80dtO/BlA0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=o6EukZQ8zM9KFiyjjWt91Mw/lHEpWlHO3z4p/T1PQ/LyAtU9uJZrkiu6m5+Bv05uA
         Xmg7qHoxgOykf6BaDg6E4+MY+SZEyAusjIc+Awq7Y2Z0OaQXtF3kFD+rWAojcYtYGq
         F3cWfb0SKFDUG+4nb0UU3i8oucARxPZY5DLEmN9qT4JPmEFte0G/P5iLg5WIf80eAL
         YgVOupU/E5NC+gWGNJSevFUNXYA4O2wJujyvfZKwYe65jQflfJiDkEoNRaP7+M3T3j
         iPuIsXcNOY1aGCUflhS/k1DAz5nmdUPqjvUVDr6EjNyDOuOdcEfJNFBZSfZE0IkpUQ
         pnSTavhokJelw==
Received: by mail-wm1-f72.google.com with SMTP id n3-20020a05600c294300b0037bc685b717so4577857wmd.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JOP3F1szvziyyHwwb25WbMBDR7/phOdbs80dtO/BlA0=;
        b=DeDM32a9ISPlM2EXlGGp26wz4jFaZZBr5WxlJGTBM8dArQ4tfwZP4m3FjsdEjncPJQ
         O2JC7t/C0YEblsnWX0TeQisblWHSSXQMVmqi2qtXQewnfpQEnUbdBnstE5/o8bDDLnkR
         yh9YajcagGF7xBZ/zwa7ksQSUTnt3vrFSeUQQYPDJ1njShFtwaVeEid2qI0HnGXT2bHg
         YLrCmY5QUGvwSJQcFYdQSOYAxzCqwpKPvSeQEfa0fCF31w8sZW0LTW9M91Z0wJskm/sp
         Q8OW5GeOtPltj1+ZSP4/A81IW86FzWms4L438XqKBUvPBuRe2ALNQFhiLE5Qzi6r8qdF
         uwYQ==
X-Gm-Message-State: AOAM532Krx/ueCIcMrDNmaig6/NqFw1jFsPVF9h3AH6t0ww95jHssynj
        XEnAvp58qmHYWMe5fwwb8y/uzBfwjC+Q3XaCXdgAOdGe5DlmPEgZratvfEbfP4/lPG3vwjegvsV
        iI3nSHNwQ8zZxUTA7p+Xbn6fi5RxOJJI9QdggsUL2Uw==
X-Received: by 2002:a5d:5885:0:b0:1e8:edbf:2d07 with SMTP id n5-20020a5d5885000000b001e8edbf2d07mr15598191wrf.85.1645460231240;
        Mon, 21 Feb 2022 08:17:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXKrYccEg4SGZYpkC/dp+cdaF1zX9TsezjyOZb4KizvNQIRmWsWVT22DWvpfUqlPM3f+r6/A==
X-Received: by 2002:a5d:5885:0:b0:1e8:edbf:2d07 with SMTP id n5-20020a5d5885000000b001e8edbf2d07mr15598169wrf.85.1645460231012;
        Mon, 21 Feb 2022 08:17:11 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm9825161wmq.40.2022.02.21.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:17:10 -0800 (PST)
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
Subject: [PATCH -fixes v2 4/4] riscv: Fix config KASAN && DEBUG_VIRTUAL
Date:   Mon, 21 Feb 2022 17:12:32 +0100
Message-Id: <20220221161232.2168364-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
References: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
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

