Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1259A4BE948
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380043AbiBUQRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:17:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380033AbiBUQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:16:35 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D506275E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:16:12 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 720093F1D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645460170;
        bh=cguSXJTSK/jUGjEgH9bI1vq5RLn1H9fQDOjhSSVs79w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=a4EFzjDZUur7R7YNccmSMOVcwfl4gTQIls+xPg+ySJ51J5QrxGwvagPfe4kbyGx5I
         NN6aPlKjb+yHetwTWJXbAVk5kOTvfXBc45bq1wbyw790NZ6sWRlRuAmPGb6sk6h1NI
         43noR0Nmq1rYj8hIwl/uAKicu28qE/G4EXrHA1y0kT36VdzTohP7XmUwgQlSv+yZiQ
         /1V4PBj/TkKasACCiYEjR+TqHJd3hEZR3J0xli7M2f3lLulJbOMqwXNy6SqSfj5YkC
         NhpKyw5BtZ/6XyUdhG3jtdjLWrHgH0t9snVJLeGdwwI9zFkoIT8ZJGHelxXGfgw9yO
         RU5Zeykrqc8Pg==
Received: by mail-wm1-f71.google.com with SMTP id q127-20020a1ca785000000b0037faac72dcbso82011wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cguSXJTSK/jUGjEgH9bI1vq5RLn1H9fQDOjhSSVs79w=;
        b=kHTTHjB4WMU5tDzbXQ5DiesLnZ4GR3kHekNdZL4rx3ycIeMH0gjn3k7s7vFnpOT1Vq
         Dvc41DdKvloIp2SP7VvsPV3OXPDox++Nqb4sil9rHAcDph1KVKHaXDvHlZu9oLMkfMrB
         Mj8dawm8enXhl+MvO2uyJMQ9jnsgzZxy1iO28CSCYKs6MT74ThbOGpHubr0f0OK6lDOb
         TgUnGc+9apKMIlWJWB6SH3XaEkhh0rS/0cOW2tWLT87no0cWz2OpXlI3AijPG93SIYlW
         VOBLofiBsjaIIulmu/iPD9FjuPZCEsrWfwO6NrTJNkyBGfeQBraSeiOPvYUrv54TbCb9
         5+fw==
X-Gm-Message-State: AOAM533/ol7SiqRvBcbXC9RKBXG9GazBUoRgONrd7W4cPSH2EJDyVxG0
        Ho0Wr1Nbsp0KYNHD7yjRovvDZHLgzfEGovdz8Pe+NEq7FipGSDRjFP4tB5S5kiyUNB0LEWa7iyW
        x1dF3ER25rrNWpOpju228LU7PPoga294eIKzshmLr/A==
X-Received: by 2002:adf:f14e:0:b0:1e4:a64c:c1f8 with SMTP id y14-20020adff14e000000b001e4a64cc1f8mr16542827wro.512.1645460170155;
        Mon, 21 Feb 2022 08:16:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYgUE7MZQmI+ZQcdzJiIN1T9Ug6obXjiEHel6BWLTa8oJLZK8xZY9nQ5A4HYo6se/kNAsxNA==
X-Received: by 2002:adf:f14e:0:b0:1e4:a64c:c1f8 with SMTP id y14-20020adff14e000000b001e4a64cc1f8mr16542818wro.512.1645460169981;
        Mon, 21 Feb 2022 08:16:09 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id r2sm10098731wmq.24.2022.02.21.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:16:09 -0800 (PST)
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
Subject: [PATCH -fixes v2 3/4] riscv: Fix DEBUG_VIRTUAL false warnings
Date:   Mon, 21 Feb 2022 17:12:31 +0100
Message-Id: <20220221161232.2168364-4-alexandre.ghiti@canonical.com>
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

KERN_VIRT_SIZE used to encompass the kernel mapping before it was
redefined when moving the kasan mapping next to the kernel mapping to only
match the maximum amount of physical memory.

Then, kernel mapping addresses that go through __virt_to_phys are now
declared as wrong which is not true, one can use __virt_to_phys on such
addresses.

Fix this by redefining the condition that matches wrong addresses.

Fixes: f7ae02333d13 ("riscv: Move KASAN mapping next to the kernel mapping")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/physaddr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index e7fd0c253c7b..19cf25a74ee2 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -8,12 +8,10 @@
 
 phys_addr_t __virt_to_phys(unsigned long x)
 {
-	phys_addr_t y = x - PAGE_OFFSET;
-
 	/*
 	 * Boundary checking aginst the kernel linear mapping space.
 	 */
-	WARN(y >= KERN_VIRT_SIZE,
+	WARN(!is_linear_mapping(x) && !is_kernel_mapping(x),
 	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
 	     (void *)x, (void *)x);
 
-- 
2.32.0

