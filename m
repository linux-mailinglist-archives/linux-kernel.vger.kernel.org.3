Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E853A45D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351638AbiFALvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiFALvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:51:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175B737AC;
        Wed,  1 Jun 2022 04:51:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id me5so2692801ejb.2;
        Wed, 01 Jun 2022 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=5Sf0h7Bia9lnN+oCGwH1nTYxUI7tju/WCO7FgYY7WtA=;
        b=F9OCHUYrm8F3KCIynre/u87EXofbbUJjRVxGaQEffNcIYtDndY2zJR+AMifZH1XdVT
         2fBbbfRsgMhk/caMTuo+MYWdUcgUy1h94FB5zBU/Dr5IWTwyb7F7Utkr2TICnbRuQiAt
         D8acvbH58mKCZVc1J5beW3RNP9XuY07BWQyZbV06NnX69/Dc0YvPmQh6BhdI8hkisdrV
         JzipDKV3eDCeGfYg2rB5QA5JL/6Vm3Qy5tB/JwC7bxPSbhV1kZYUBjAAe5jsWGtHdEVd
         +ZPjuUTKtMpMePfnDHpBqm1QqsFi46O2g4cpZrAwfyYg89xecu8iAwwT4VDRXa3t34hs
         ZMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Sf0h7Bia9lnN+oCGwH1nTYxUI7tju/WCO7FgYY7WtA=;
        b=duJszSTVe368hYqj1B+FuoCjknarFdZ6dysP4K90X996hcBG5Q8z+LJDtOvjCcrv+Q
         zBDSED/mxuyw5Tavzh39VKmUPcpYmsAdoVnQjT9UiEjT9UsOq0My28tv406WO62E7QCB
         22Bmzf+/5AoSoc8dyTAFeXszbKjRvhi3XxBbUOpLsdofC92qeJcyQdhzzI91bAAm9JkP
         B1Ye6WzXEENtOo/vGIZl9sIaQOFY5rOrVHjTq7Iz2YamelJnQjI/HzSOZADkC+5cg4uj
         5Py88DGj37ksJIKZcg846vucDFAEUYnLw2iZwO3/VB/CSCdchxxTWikZK7P9V0u39gT6
         25iQ==
X-Gm-Message-State: AOAM532MZoxGDOew09w3qp3gzJ7H1UHE4uaGeeEVqSUzZ3tDYnqCAIvA
        UKWlKCrdulZaB6HJN/sVPQY=
X-Google-Smtp-Source: ABdhPJzKKgbTzWxfv8Vv6APAutBncHQ1tS1uL4fFMHnQALj6o1qRuhucNOOifGR86lJqaSUiWhha+A==
X-Received: by 2002:a17:907:7284:b0:6ff:16b8:3073 with SMTP id dt4-20020a170907728400b006ff16b83073mr30728569ejc.196.1654084292852;
        Wed, 01 Jun 2022 04:51:32 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7dbc4000000b0042de38b8c49sm864889edt.34.2022.06.01.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 04:51:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Peter Jones <pjones@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] efi: x86: Fix config name for setting the NX-compatibility flag in the PE header
Date:   Wed,  1 Jun 2022 13:50:43 +0200
Message-Id: <20220601115043.7678-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21b68da7bf4a ("efi: x86: Set the NX-compatibility flag in the PE
header") intends to set the compatibility flag, i.e.,
IMAGE_DLL_CHARACTERISTICS_NX_COMPAT, but this ifdef is actually dead as the
CONFIG_DXE_MEM_ATTRIBUTES does not exist.

The config is actually called EFI_DXE_MEM_ATTRIBUTES. Adjust the ifdef to
use the intended config name.

The issue was identified with ./scripts/checkkconfigsymbols.py.

Fixes: 21b68da7bf4a ("efi: x86: Set the NX-compatibility flag in the PE header")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Peter, please review and ack.
Ard, please pick this fix-up patch.

 arch/x86/boot/header.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 0352e4589efa..f912d7770130 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -163,7 +163,7 @@ extra_header_fields:
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
-#ifdef CONFIG_DXE_MEM_ATTRIBUTES
+#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
 	.word	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	# DllCharacteristics
 #else
 	.word	0				# DllCharacteristics
-- 
2.17.1

