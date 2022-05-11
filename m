Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653B1522E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbiEKIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243816AbiEKIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF39443D7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso1423203pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=renU6boUc8bjl7+T0+5P6aUpTemVDlmCU6gWIarVu9c=;
        b=VuzX83IZhRm4Pe99Gm3V7OoCvEp0z84v8JRxEiPiBz2aAGi9cn16IY9IcrHbA00wF2
         RPK4sUNQyFimpqbf1avolryq3OyRAeepmiwY0IuVNUcYQHlVlvXbIq5XN9dINsywodV0
         WkX9Co6NTbSDi03nyGX74NJOnZQQgR0bb4vrfP7Lr2DnUvwdUmxwPgGB4BMwKVVQTb9i
         FixbVPkUYrMIoSQD850nMr5GUM36+NdL6BxV0VT7BLJswWN1a6zwFLKOq1eeQ7/Ua7Kz
         VZf+HuXS+X7k5pRNuNtX3osHiAY4X69bsMo1JDtDloJxdVnEg1E0ayGVyl//Z1TZzw0s
         YOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=renU6boUc8bjl7+T0+5P6aUpTemVDlmCU6gWIarVu9c=;
        b=GI8qW/MjNM2NRW6ghIg7MbYG9EcEPtn2FzWkmlsMWssx9eiUZ4UOXIPrH0ryplg/dg
         TuLvUD3oqV4/g1HJNt0zaDAJUWpcm/0l365AsHLwIOm6AQ7pQO9F58m09gK4ibHsuMTT
         9pYW0F+BEx1nqejWDwXRfmvR1Whm4CNHmmtyFBUjTTRD1WIN5NqlemMNtNhoOgnu3jj3
         O36+n+zZ/sf9tu2N1zYb8RVwU1ff9VL7lRaSO/NlY0bVWV/27CEp5nimk5PIot+N43d+
         DxpfBkaXGar60F0oGSuRgl5VMi9x0WC8Ai5PVJCCXpCfFeHnfuqm/oFf+EAKW0rkAh3Y
         c/hQ==
X-Gm-Message-State: AOAM533X3un7TWvQaX51QxlldtOuGxd20AjGnYR6KHqvOVhfBiVn3Crv
        7weScFMOLvqex20mzY94v0AzDnJOd8Xsnw==
X-Google-Smtp-Source: ABdhPJzTt/eBd9wV+KzZVC98MS1893vrJwmEN4p2oHY/UTvF/oBUGO0yuU1T278iz6ZleFC0OUckmA==
X-Received: by 2002:a17:902:e851:b0:15e:d129:fb20 with SMTP id t17-20020a170902e85100b0015ed129fb20mr23797543plg.140.1652257914323;
        Wed, 11 May 2022 01:31:54 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:53 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 15/16] riscv: Add V extension to KVM ISA allow list
Date:   Wed, 11 May 2022 08:31:25 +0000
Message-Id: <b8c1bf264d50c075620258dc27a05aadc42628ba.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

Add V extension to KVM_RISCV_ISA_ALLOWED list to enable VCPU
to support V extension.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kvm/vcpu.c          | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0734e42f74f2..02ad7cf64d1c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -33,6 +33,7 @@ extern unsigned long elf_hwcap;
 #define RISCV_ISA_EXT_m		('m' - 'a')
 #define RISCV_ISA_EXT_s		('s' - 'a')
 #define RISCV_ISA_EXT_u		('u' - 'a')
+#define RISCV_ISA_EXT_v		('v' - 'a')
 
 /*
  * Increse this to higher value as kernel support more ISA extensions.
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 7461f964d20a..c0a3be86d613 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -39,7 +39,8 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 };
 
 #define KVM_RISCV_ISA_DISABLE_ALLOWED	(riscv_isa_extension_mask(d) | \
-					riscv_isa_extension_mask(f))
+					riscv_isa_extension_mask(f)  | \
+					riscv_isa_extension_mask(v))
 
 #define KVM_RISCV_ISA_DISABLE_NOT_ALLOWED	(riscv_isa_extension_mask(a) | \
 						riscv_isa_extension_mask(c) | \
-- 
2.17.1

