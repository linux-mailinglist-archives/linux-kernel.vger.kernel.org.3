Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7552204A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiEJP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347247AbiEJPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9058722BC7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh4so13812857qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKum/y+r6etzQiDAncOGvinx4476e/+0uZXTw6pzwzs=;
        b=gW0t2QRbTyXmQvXyimlegclNnIEB2oz1Q2shjZ39XuWnPGlqj4KNZ0qpRhj0fKscpl
         cnjA8BtdGugJAErQ/HU8DJ/dsZkwoZ7BSSgTFS3o2Ra6snQf8kalMqJV7Z1E1ACwsSWo
         5Sddgvu0qSXC+zgKYuWGwVBlY9JUUw+ncgV1uJ1F8HQOrhbwlvwHPwsjwlDyFYZiScfv
         mlP0EeM7Yygzq2Y6bpsLYjCliTNntkC+zkIjkyKrwaT0ca5n6C2Ay5KBcb9FBB4UlLug
         wc8H+vo20SJrhy118uJW+/eNG6vblqSGHG2s3aAf35TrzbH+YuT1vIuMRDY0jL/jEXiX
         T0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKum/y+r6etzQiDAncOGvinx4476e/+0uZXTw6pzwzs=;
        b=1IpSNfJLRehnkiGN7nFHiygJZcOos/XJNob9lr2xdy9NmG0bW8VEZrELOSLo8nceal
         /oSsuS3sHPzq1srgxPoqtt1EOiOaoI8c+Pbf9M/A1Gpr/uOQtPJ9WPnCw2l0IRA+2DkC
         ju3ZHMlB0dYEf2BSUYIHndwoK+vct83BjunVhUs0IH+xfmx9X4XyAv+T5HFHSVQnyjnt
         wYJJBDoYb/L8L0z/iI2OIKimHbBSStzppbU6SO/TbbUAHoTpV4m44PanuDSYqZ0JHcSJ
         dn0yBn8FahQLsnqZNfMU19kyZhhzCQZkKzu788+GY9XGxcO/ASl7toWLp8vFFZOlUZ2q
         I9Og==
X-Gm-Message-State: AOAM533Z9dYYaJYLG+wRpIN00ya6eD4HJZONkQhWuFn9uhMHJeuXAgBs
        Q0GHs+tL1UOjHPkczZzKQmo=
X-Google-Smtp-Source: ABdhPJz4ankS+cAqYT1bVrUsTcE2UHlB2KcHnUHYsVNYUl/deyqgn3ghukaHi8q8RzXf3c5GanpkYw==
X-Received: by 2002:a05:622a:174b:b0:2f3:b473:13c6 with SMTP id l11-20020a05622a174b00b002f3b47313c6mr20251974qtk.198.1652197682702;
        Tue, 10 May 2022 08:48:02 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id b3-20020ac85403000000b002f39b99f6adsm9459897qtq.71.2022.05.10.08.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:02 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 07/22] risc-v: replace bitmap_weight with bitmap_empty in riscv_fill_hwcap()
Date:   Tue, 10 May 2022 08:47:35 -0700
Message-Id: <20220510154750.212913-8-yury.norov@gmail.com>
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

bitmap_empty() is better than bitmap_weight() because it may return
earlier, and improves on readability.

CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Anup Patel <anup@brainfault.org>
CC: Atish Patra <atishp@atishpatra.org>
CC: Jisheng Zhang <jszhang@kernel.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Tsukasa OI <research_trasio@irq.a4lg.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/riscv/kernel/cpufeature.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..f0298d756f66 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -206,11 +206,10 @@ void __init riscv_fill_hwcap(void)
 		else
 			elf_hwcap = this_hwcap;
 
-		if (bitmap_weight(riscv_isa, RISCV_ISA_EXT_MAX))
-			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
-		else
+		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
 			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
-
+		else
+			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
 	/* We don't support systems with F but without D, so mask those out
-- 
2.32.0

