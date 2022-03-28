Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B214E9F07
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiC1Shn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiC1Shm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:37:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DA24ECF6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:36:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bi12so30563594ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOpbHhleUOYec4C6q+yoYglLTaZ68AGj/KVhdP1PgHo=;
        b=XX2FaSyk0+hHY9QsH+Mp+nz9s6J0oPRaUBkYZNQJ5Ej+lctYBQNBg8kQTTacvLHZ1e
         Y41iSp9pEq64ZdDjXL9BW//AdtB2KS5OxMKwJwQys2GT7ScQAvHslj3mA5HNB0V3ddtQ
         S5FO5oCds87GLRsnna+hF+NHkvQQs8sXN5Ad3/0WCn+OUEK6NDnEOM4cEEedXSGJcYTm
         sHNizZWBZQmf1RfaVcNv4pgCzSL3vqSogTMC/msrINBZGvwnRvzOqIR3GbWzVcCLtG53
         COlaek7yHhDosMkEea2e51QLVFTjMvLSWfWo3x5cV5DxXfLl8YIT7DTKSPBkuvYyqV3B
         JpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOpbHhleUOYec4C6q+yoYglLTaZ68AGj/KVhdP1PgHo=;
        b=dHr6JAvGESkH3bxKJfPFx7NCj1kC+pE9D1XS30O0WqgpKyT6dipEdd77R+TvqyG9Do
         Gft7Xe0JNBC/crDgzFuEFZ1Y4RxWBAjM5ZDhj7YaZKc59RJ9v8poijL92LW42xQZ3FqM
         GRh7wlQ3a9bhvN+hBGfqQu14ubGomETiE9xRl+N65Jsky0FGKwH8JgbfDlYyX5NCiuiU
         XDKrgwE1xs5HH8aI/1amt2/8e0tTgqZgby+FjhVC7CtmIP7SvhMDuHsWPI87V7T4SxyH
         oRVz0SSDJ2eAcTmnd9QyKK0bQgid+spEnuJwrGhgWFzZXO7N91rz3+Air42U4pEOt10+
         bemA==
X-Gm-Message-State: AOAM530bVo39FVfs2c9UR8rX+Ultp3ns/ShMqslwojkEXUSjzCTfcvwZ
        tyykZ7ZWR6GR+6zTBjqSZvg=
X-Google-Smtp-Source: ABdhPJwf0E0G/W9VNT+DiOL1BDp2JyL/mPUsZUzM91TpLlxSCXvml0JKUbg8sjY15SF+cZs6svkPBA==
X-Received: by 2002:a17:907:3f03:b0:6df:b04b:8712 with SMTP id hq3-20020a1709073f0300b006dfb04b8712mr29782879ejc.290.1648492560020;
        Mon, 28 Mar 2022 11:36:00 -0700 (PDT)
Received: from GAMING-PC-HARM.localdomain (62-251-120-165.ip.xs4all.nl. [62.251.120.165])
        by smtp.gmail.com with ESMTPSA id v20-20020a056402349400b00419651e513asm7574407edc.45.2022.03.28.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 11:35:59 -0700 (PDT)
From:   harm-smits <harmsmitsdev@gmail.com>
Cc:     harmsmitsdev@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Marco Bonelli <marco@mebeim.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/head/64: Codestyle fixes for loading startup GDT
Date:   Mon, 28 Mar 2022 20:35:24 +0200
Message-Id: <20220328183526.435-1-harmsmitsdev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the GDT access in `fixup_pointer` to avoid having to rely on the
compiler optimization passes to generate %rip relative access. This also
brings it in line with the rest of the code that is executed before the
virtual paging is loaded (e.g. `__startup_64` and
`startup_64_load_idt`).

Signed-off-by: harm-smits <harmsmitsdev@gmail.com>
---
 arch/x86/kernel/head64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4f5ecbbaae77..33360a1b6ffc 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -613,8 +613,9 @@ void early_setup_idt(void)
 void __head startup_64_setup_env(unsigned long physbase)
 {
 	/* Load GDT */
-	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
-	native_load_gdt(&startup_gdt_descr);
+	struct desc_ptr *desc = fixup_pointer(&startup_gdt_descr, physbase);
+	desc->address = (unsigned long)fixup_pointer(startup_gdt, physbase);
+	native_load_gdt(desc);
 
 	/* New GDT is live - reload data segment registers */
 	asm volatile("movl %%eax, %%ds\n"
-- 
2.25.1

