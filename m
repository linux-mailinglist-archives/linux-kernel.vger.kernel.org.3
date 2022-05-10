Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCB522063
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347635AbiEJQB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347256AbiEJPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D192714B;
        Tue, 10 May 2022 08:48:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t11so13819459qto.11;
        Tue, 10 May 2022 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CjDUHdg8cFM7kS83KS618TD4uElmyA10hO9dwUkMOD8=;
        b=kDJXbyhvj9QHNsY+CIMDYKuJitt2teWm52OsKOARN0n+1y8rud7V9QCrw+t5SilKMW
         GiOGonHD5UEWBztXu0e0Aq9uO8CwbFcQWvj3h+50zrc48Nk7ZmHaeUd02+YNlyyiAgHI
         93xyHdhWG2wY+nmXl3uAODcwvjJBBwb2IPAeM20M5xl5n1KAOBxxjoZLAsHL4RlaFerN
         RBGK7Av2Mm5Bt/BhTlM/4IuOY/jXEa/geNIfM3VixAJ4FMZNKLxBP2ITXgEyFRk9kYH8
         B1fdPa1WJe4S81tVdkaotLAL1V78RY57u9MPfPHbX0Y9Jxz8Z35PlhZFzcLXoBKmfIl6
         VmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CjDUHdg8cFM7kS83KS618TD4uElmyA10hO9dwUkMOD8=;
        b=ZwT0EYPb9LjnXtkXdFrA81/CKHeZAz8AMqUCo0f4KmOP3DN7oXIno6nXyS3TN39LSL
         Am0e5Q+ihXyAaDjsAEZFnqCTG1A2/Cn5LGG6UkoYqhbcUhqFXO8bOuy2ejhVPegz/YMP
         kkGyURe0X5LAGCYABIhfFYvK/gIRzo3pENAJWyPIW4y3ldS+f9cZkKNtJGM9T8O3AOMD
         Y3gjT5rOX85oKWonMSoMX8sN+JTwtaagFKzusP81bb7bQ7SwIXMXUTLPpkYSZl6ENdHi
         bPnPkswGxhskYmnnMEPKEsA7vbpdlTO2k5olaVqRB+zCIxLi+MLn183b/UPo4PT6LgZ9
         4+zg==
X-Gm-Message-State: AOAM533azuItoJHKhNZ/G0+THq3wlwoLp9ms6zvZeooNPsIH1vHPPPRj
        pKtj1JTsGYQ2DQgM38NO7bs=
X-Google-Smtp-Source: ABdhPJwrojQGWx5ySvoO7WtsNRq8OASz8gqW8BN6clOG1VkXmIodWaR5f99J4mVoKuQ9QKI3tDi2rg==
X-Received: by 2002:a05:622a:342:b0:2f3:dd79:2463 with SMTP id r2-20020a05622a034200b002f3dd792463mr7817047qtw.468.1652197691097;
        Tue, 10 May 2022 08:48:11 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a01eb00b0069fc13ce230sm2735416qkn.97.2022.05.10.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:10 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH 12/22] ia64: cleanup remove_siblinginfo()
Date:   Tue, 10 May 2022 08:47:40 -0700
Message-Id: <20220510154750.212913-13-yury.norov@gmail.com>
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

remove_siblinginfo() initialises variable 'last', but never uses it.
Drop unneeded code.

CC: Ingo Molnar <mingo@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Valentin Schneider <vschneid@redhat.com>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/ia64/kernel/smpboot.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index d10f780c13b9..d0e935cf2093 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -576,8 +576,6 @@ clear_cpu_sibling_map(int cpu)
 static void
 remove_siblinginfo(int cpu)
 {
-	int last = 0;
-
 	if (cpu_data(cpu)->threads_per_core == 1 &&
 	    cpu_data(cpu)->cores_per_socket == 1) {
 		cpumask_clear_cpu(cpu, &cpu_core_map[cpu]);
@@ -585,8 +583,6 @@ remove_siblinginfo(int cpu)
 		return;
 	}
 
-	last = (cpumask_weight(&cpu_core_map[cpu]) == 1 ? 1 : 0);
-
 	/* remove it from all sibling map's */
 	clear_cpu_sibling_map(cpu);
 }
-- 
2.32.0

