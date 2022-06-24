Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA155912B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiFXEuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiFXEsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2866998A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g186so1374492pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=4THMhvS8M5ZnFTHvTFejhkWhYsuAvg/ZgzsYmQOutl8=;
        b=jZ+UoLM3M7Aw8FzFUs4vfV0xGVF+Z1rgG06Q0g6ddvpteFSUct4m0aAnWG/UHlIHcy
         xDIWATlB0GGjs/hfRkxe6UQ1V4kDs2Fm3V/6fxpXi023MU/ojZBBXm7JW8wCFWafwRbY
         ZPHpdFFCz4HQaws9xVkBWt/pnD6GgEBKfUCt/XZPKwwH8Eji0UWJl8bjjLOYO2Km/VcU
         riLaGCyFAc2cIrl3N/VncOYPKf8urgmhHUYRlJWR81bCqV+fn5a5+P3hY9dVVfzj35qZ
         3V3zmkqcGPJtvORY1fF7FSMecx1wrSvXDD/7UYn08WWFqdnoryi8KMch/00RWyQK0gLR
         DpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=4THMhvS8M5ZnFTHvTFejhkWhYsuAvg/ZgzsYmQOutl8=;
        b=snP6FyFy2Qg2ztVWZ/1dT5U2L23HB68p8Xzhyi/oA9i/8qK9b3Yq+BV6uo64w/SlUN
         WA2OgNMZCTQM3FywnOhzj4ePUmk8UDRXW67caxq+dDYaJl2qDP4hjNNPLVnUtZnDcSZN
         /QZVqTPSxPEyAdBcjuvmVNDS5s5WmCR7xF3V+jeSzYsKtHii83jIXWSiQWh357NJH1cF
         DE6oIeA079prRXho/0dU0ZdtzQffgZcrZuHt7XV+mtpWpB9mRHn7NMsSKRWURvpF15ru
         /iXxyLE9pACga3/crWfm0WgIL6T5xqxO1OmyEfNTqgDUAbZ/IFphrU95cW1h/RQbBdGV
         eeCw==
X-Gm-Message-State: AJIora8j2HmOOcVcVNegKS1AxpLVn16MCKRCGdPY017aMHFStSG2gH5j
        /tBBlv67qA/fE07CcJGt/i51X+pVDnYWxw==
X-Google-Smtp-Source: AGRyM1tjG9XTGQzrvxKP1b0oJm9GIdXwYRdfAbtw1YGd6ry6SLMEHPonI2hZnL7q9k/q2Z13VDkRjA==
X-Received: by 2002:aa7:9206:0:b0:525:1068:c026 with SMTP id 6-20020aa79206000000b005251068c026mr31366064pfo.52.1656046110313;
        Thu, 23 Jun 2022 21:48:30 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7821a000000b0052517150777sm555865pfi.41.2022.06.23.21.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:29 -0700 (PDT)
Subject: [PATCH v2 5/5] RISC-V: Allow kexec_file() on 32-bit platforms
Date:   Thu, 23 Jun 2022 21:48:11 -0700
Message-Id: <20220624044811.9682-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the build issues now sorted out we can enable kexec_file() on
32-bit platforms as well.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 898052ff743e..a246f2fe60c2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -388,7 +388,6 @@ config KEXEC_FILE
 	select KEXEC_CORE
 	select KEXEC_ELF
 	select HAVE_IMA_KEXEC if IMA
-	depends on 64BIT
 	help
 	  This is new version of kexec system call. This system call is
 	  file based and takes file descriptors as system call argument
-- 
2.34.1

