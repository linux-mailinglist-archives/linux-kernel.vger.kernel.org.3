Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6605533B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348884AbiFUNhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350729AbiFUNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:36:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB42CC82;
        Tue, 21 Jun 2022 06:35:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g4so10047675lfv.9;
        Tue, 21 Jun 2022 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzAosVTA9b9PugXkA4Upw/+iMo4tmsufzeUut4m9uC0=;
        b=E5fJoQH/G+nmrT3zZKHouHp23ouJ1Q1Nztd0CggUcBII8aM3q7AbcJ2TrvvvoTHwa8
         4/W02HElN7Y8ZxttJFL0Kc9dMzeSj/Eg9CuxpJEmAudpg6vOGag1eVdl8yx01Po13qCZ
         oTu8JSVTJ4H+3p6PWXYLJxIR8y+DmGvS3gRAmYe/B7AhTJH8fdq1DViFNJv1aPYCAZTQ
         S/4w320UFZ9xNGKmRqwGTPlHscewaIFiNgfq1HNac2NyJ90NL0BIfTk5klk9FzyZvXfI
         wfu7ZZjC0JDT7zjDRUccLRyCnYWI+NLU14cEKZNW09IjcoxQxnmGu0yVh3uKHFCdoBj4
         q/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzAosVTA9b9PugXkA4Upw/+iMo4tmsufzeUut4m9uC0=;
        b=ra3aNVtHCCjH3wHRXxDYHbub1mk4t7+K8c9+R5mDiWaBpwZ/j3eHMsqwQb7v4sXD/a
         wg2uJDb8tq++S3/uGMaycFah97r76gpKsXFJZSAP9hHio8iZzLDwW5cUhe7q+zyfeyMh
         5nhu0+eFi4vcFitzGCX3odcYkGRRPpRMgOBe42tZFt0n39oHil2WwbiDro5zVur3zmC6
         HWGLXAlqAx3MshFW0GnTwdddqL3vRD30RohrFgtMuHMWZGct4RyqjxrOqUqydOpSJAGg
         0BVolAQ3/vZLk4T/UFCDYqw48t3XHjSwLPp4fccSoLGE5gZniu8aHM4XgBbI09FeDjwW
         SwCQ==
X-Gm-Message-State: AJIora+3B4lUr/fHOFKGCibkuy8FwMfDs9+uFbfgTexj87HlTNat+icE
        63TDJESE4MdEXekMYPvPxvAQM9f4/UOQPPUW
X-Google-Smtp-Source: AGRyM1vEh8l3dmR/pm7rQ2srim+u6z+RnxxX8uX8BXWCQpknShwN6WzuxVUV2RY8vGWNiZDz4y1+Pg==
X-Received: by 2002:a05:6512:e9d:b0:478:fc65:328c with SMTP id bi29-20020a0565120e9d00b00478fc65328cmr16821362lfb.312.1655818527696;
        Tue, 21 Jun 2022 06:35:27 -0700 (PDT)
Received: from sakura.myxoz.lan (2-248-181-228-no2390.tbcn.telia.com. [2.248.181.228])
        by smtp.gmail.com with ESMTPSA id a16-20020a19ca10000000b00478a8b7ab1csm347142lfg.150.2022.06.21.06.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:35:27 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: [PATCH 1/2] Kconfig: Mark -O3 as experimental
Date:   Tue, 21 Jun 2022 15:35:25 +0200
Message-Id: <20220621133526.29662-2-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621133526.29662-1-mikoxyzzz@gmail.com>
References: <20220621133526.29662-1-mikoxyzzz@gmail.com>
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

Mark -O3 as experimental, as it might cause unwanted regressions for
users.

Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
---
 init/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index c7900e897..9c292acb2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1402,12 +1402,15 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
 	  helpful compile-time warnings.
 
 config CC_OPTIMIZE_FOR_PERFORMANCE_O3
-	bool "Optimize more for performance (-O3)"
+	bool "Optimize more for performance (-O3) (EXPERIMENTAL)"
 	depends on ARC
 	help
 	  Choosing this option will pass "-O3" to your compiler to optimize
 	  the kernel yet more for performance.
 
+	  This option is EXPERIMENTAL; you may encounter compiler bugs and/or
+	  kernel bugs with this option enabled.
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size (-Os)"
 	help
-- 
2.36.1

