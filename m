Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61DE522060
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbiEJQBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbiEJPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E829C90
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n8so13036701qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Up5mCRghdypCXqXuJXfOWXocHqkgAdBl0+nsIM6Ysk=;
        b=JrNKu8ky7+tpeG4ipUBQNtHzamSzZvYFj1Jd6PRPJedGnMmLC/UH9a8NiwkmteVTzu
         d/+hLjUfYQ1fZO2CZKwt/XZkYe+OEoggGwWT33OfPOWDldoSBohHekj0AgQIdS+iw6OY
         YhFlVKAE3EhotCYNBKwmA/GbOfAY0s9EkvEfB0a886iD+j550LL5VN5ELQBxg9nXbMyY
         +OG9Z9EcqaJedFV1SkQwScKv3AXmgaBv5M7b9o+Ej9qwE3kBiKWzxUmZqPhegRS20Qwt
         i3b6hDk2Tlgjkjfg/HiOt/+ncui0jqfeBgr2f+UTLGe0ssXiFMyC3OwvKUlswUQlTZc6
         L+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Up5mCRghdypCXqXuJXfOWXocHqkgAdBl0+nsIM6Ysk=;
        b=uvGaaGEsVrtgtHIEXB+J85+fdHWbihRoYE0kN7d2TEBe6Sn8dCSxxMcImVGD9w8ZH5
         1s5pNphuiJbz2TLGMQAZzbyTGdHqFmhGm1yd7K3T+2gKhS/S3zJ3096uNi3JEO/FwqrR
         Glxhe+vnxr1f75tw0xXac6zpnop/RwkFDuYtipms68BWuRyULJUl5ekHY06l8BZ/rXRq
         NHTI2O7JSyMJatZjWoGm7jNO3GjK3Y36hV2JaIuLSA6KshNh0+ICVorAN39yV4AprxI9
         nyJmkSmjRTrxR3a5pqoru4gH1//gawYjAwifLmSIqcU0EKFIe+TZp6apZW2DoViab43F
         rWdQ==
X-Gm-Message-State: AOAM5300LV70sbn2vgr9JB7zgHf8P1a24Doi4/dkU8hc4YDDG61h8TUC
        XxhgZtnjukv1fGq9g9g1ta4=
X-Google-Smtp-Source: ABdhPJxt6oOjgPrazsh7EG7WhxZdH/RZY9aRthrd5IIpfiwxm4IanfNY3MYjHZh2X3jzG1aDQuKJzA==
X-Received: by 2002:a05:620a:270c:b0:6a0:92b9:8196 with SMTP id b12-20020a05620a270c00b006a092b98196mr7469614qkp.417.1652197696083;
        Tue, 10 May 2022 08:48:16 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id h3-20020ac85483000000b002f39b99f6c7sm9105610qtq.97.2022.05.10.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:15 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 16/22] x86/tsc: use cpumask_weight_gt() in loop_timeout()
Date:   Tue, 10 May 2022 08:47:44 -0700
Message-Id: <20220510154750.212913-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask_weight_gt() is more efficient because it may stop traversing
cpumask depending on condition.

This piece is not performance-critical, but helps keeping consistency of
cpumask_weight() usage.

CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Feng Tang <feng.tang@intel.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/kernel/tsc_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 9452dc9664b5..2dc80e6f0a4f 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -340,7 +340,7 @@ static cycles_t check_tsc_warp(unsigned int timeout)
  */
 static inline unsigned int loop_timeout(int cpu)
 {
-	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
+	return cpumask_weight_gt(topology_core_cpumask(cpu), 1) ? 2 : 20;
 }
 
 /*
-- 
2.32.0

