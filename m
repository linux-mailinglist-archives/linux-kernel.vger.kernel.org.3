Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E38567A01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGEWO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGEWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:14:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC212610;
        Tue,  5 Jul 2022 15:14:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso5529903pjk.3;
        Tue, 05 Jul 2022 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x7dxhw2AJ9mK9YOl+Hr0LnwAgrXApCiFJEWSuCtRDko=;
        b=BDi7i9vEGXuMYFb2o/b0/Coa9JsiKkK8bNzucunbpGHJwggkb9TlmCdIzYh5hZ2UBa
         pXVyqb5u5Np5Z4wwZlO/pb82pryyMaK2gSEM73Xegatf2x034qrZ4olGMkI3AZXXRvw5
         F7+EoRK1t5IIptdUR15YPgIBItNcxHUxo+SfK/KvryyxK41tzf06BzTrd8m7CmpGMdsd
         hruJDyvM8N1idIh7MYJ4//2/WcrL5EnJ8IXoaZyfO7j4pWtMCr9Wtu/rGWmbACdO+Rns
         NB66GWGezkBH4U+XN0CTNLh5Pry486/SOW3eIaYVcfGm6or6pVfLjYlAdNvW4kGY4Sz2
         mllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x7dxhw2AJ9mK9YOl+Hr0LnwAgrXApCiFJEWSuCtRDko=;
        b=yt9Bt8ccXpVoHw/VtMrUiYaYeWGTqeHLiMTb7PZvrMrVi0RYPRMWnHCzXzk/tkJ79i
         WRLR8kTE7U3ZUFX5pXB/sp5yjNP7Nx8nvD2gyzgzjLdUuIKlCgfHN+W3NrMyWpqi1SUX
         ijkqt7K9INLhLLTTxIQ/g2LptCPPnOYnR5ErBtvWF3B26Iln98qGkuIDuMO1jMQCwL3g
         rab9rHj1+yKDnZCK1W9tHcFgi6GVWMLlZSMKRAJj9v3J4GYTLjcwvTdWJJHpjvab8PDD
         /hFlsPxyqcTpGF+ZecRvdW4NK6bldcQfKPtUIa2EZjJpr9BPTeAi8LYHoM9xdbl7U6+v
         v2/w==
X-Gm-Message-State: AJIora96c4SPpZ0KWz0QeNlhiU+0EotcmPFogBkoAo13sbdKJq6rEuQ2
        UcqbSZjc5J7QDAElULY2oeItHBLikDoGsaKq
X-Google-Smtp-Source: AGRyM1uvjMGPcyWyUs4A6dzA+l1ysQDAuG+XqGzMNkltBadweQ/lJsl5XmKMXyiqkMqhLkOKxG5xlw==
X-Received: by 2002:a17:90b:1b0e:b0:1ec:e2f6:349e with SMTP id nu14-20020a17090b1b0e00b001ece2f6349emr45617148pjb.14.1657059263066;
        Tue, 05 Jul 2022 15:14:23 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3caa:449f:1bc2:21eb])
        by smtp.gmail.com with ESMTPSA id u9-20020a056a00158900b0051b8e7765edsm23479137pfk.67.2022.07.05.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:14:08 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: noMMU: fix vm_get_page_prot definition
Date:   Tue,  5 Jul 2022 15:14:11 -0700
Message-Id: <20220705221411.3381797-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't define protection_map and don't use DECLARE_VM_GET_PAGE_PROT in
noMMU configs, because in that case the definition for vm_get_page_prot
is provided by the include/linux/mm.h

Fixes: 61ab8053710f ("xtensa/mm: enable ARCH_HAS_VM_GET_PAGE_PROT")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index fb830ec8183c..b2587a1a7c46 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -217,6 +217,7 @@ static int __init parse_memmap_opt(char *str)
 }
 early_param("memmap", parse_memmap_opt);
 
+#ifdef CONFIG_MMU
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY,
@@ -236,3 +237,4 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_SHARED_EXEC
 };
 DECLARE_VM_GET_PAGE_PROT
+#endif
-- 
2.30.2

