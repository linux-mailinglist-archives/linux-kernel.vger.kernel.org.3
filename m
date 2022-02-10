Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26D4B1965
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbiBJXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:22:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345626AbiBJXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:22:48 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6633E88;
        Thu, 10 Feb 2022 15:22:48 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id f13so5657416ilq.5;
        Thu, 10 Feb 2022 15:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dreoFKrn4wH6smW2GLCfxxjyjJhnljmILHzGoj0K5Es=;
        b=nLj6aJoGZkZ+ciKqW/DpUozk1sjRaY94bK8YuXc85MMjn3ka8sf0yQDAo55lM3nr9s
         1UIDIaeoEc4NFplxVMfgEZe4JIrvw8GFfSt1bRxcGbE0R7FyhYrq+5ERL2XmXd+8DMkk
         msBJbFAY1A+uHQjX7pxCUlcRExj2gbm5HbdzAQorQnEsygPb0hInpXn+NwVt3GhNOenQ
         J0K9n2OBOnFaqIu1bZ69zDwx9EEDX1LJK5djkopX8BKeW9OK8X83/KG1m+Y67AzZEzoo
         b5YViod/+8inu3M7Flygc6qvfuFZ1LVXz4M9bMQ7qyAMxhj5BHtXI5n7+YviS6OqDhuk
         u4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dreoFKrn4wH6smW2GLCfxxjyjJhnljmILHzGoj0K5Es=;
        b=BdZ5mf8XOyTXv/AoUZ0FkAeaR/f5BYJNKHQtPqEPImDnh/hquRzCNetdhyVGSejExO
         8f3gh0pK0sMydmV6NrSObPEdM2BHtP6d0/e6s7Y5DqqFPHbzx2nNfLf9ugstXQQT3MlG
         y357IS3anr6pGgYyHwEPEagXnbucQ9Fht3DY8Ffn3CTydVlqkCDTJEsbiWnWVZ70P7gv
         1e8kNVdYFx5LnWiA/pvUbVPSdv5oYFy0OZDHRM+G8vqfzUTPsDFls3U9fK5G1BX1FfXW
         XEsp+AiqY6pXP+s4aJ7rz/A3uh/r2q58ARztWl9XRHKMtS8NIr92ya3jy+O9vERLQBID
         iqfg==
X-Gm-Message-State: AOAM532//5hpNDgCRpYTltpVX240ShTNZkK8qMi9AziuoI61lpegd4+Q
        yNemIsrlg5np+YlHCn6z5+A=
X-Google-Smtp-Source: ABdhPJzuNm5GQuSv8w6TkAKuXFVsVX65utYXnMni+atUYXD3oSutdfGyrMKCf7cbLeQuGZaxI0sXhA==
X-Received: by 2002:a92:c52f:: with SMTP id m15mr4414085ili.160.1644535368211;
        Thu, 10 Feb 2022 15:22:48 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id p5sm7962108ilq.71.2022.02.10.15.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:22:47 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, linux-alpha@vger.kernel.org
Subject: [PATCH 14/49] arch/alpha: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:48:58 -0800
Message-Id: <20220210224933.379149-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

common_shutdown_1() calls cpumask_weight() to check if any bit of a
given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/alpha/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 5f8527081da9..0d4bc60828bf 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -125,7 +125,7 @@ common_shutdown_1(void *generic_ptr)
 	/* Wait for the secondaries to halt. */
 	set_cpu_present(boot_cpuid, false);
 	set_cpu_possible(boot_cpuid, false);
-	while (cpumask_weight(cpu_present_mask))
+	while (!cpumask_empty(cpu_present_mask))
 		barrier();
 #endif
 
-- 
2.32.0

