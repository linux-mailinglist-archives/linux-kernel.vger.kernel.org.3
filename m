Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE349747C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbiAWSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiAWSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFEEC06173B;
        Sun, 23 Jan 2022 10:40:29 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f8so13142887pgf.8;
        Sun, 23 Jan 2022 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EaZo6YWz+PE4Amu8QukF1Cw8oSIakZDIQiKoGR/62wY=;
        b=V2jPEDWq3IwIGuJgkDE35gcjcxe2X2oRT+W5/8zZD364JRtYsD/NetC+jPipdlP248
         VCZINxrgU8tohaAr/uOO2w7qtXxaF4tnonr9b/tMDnGy8/JWEsbHewV6ABBhs9UVYadY
         ZRHqPkouoaRfLkfknvSgvJd3V0Cre7vIvYAmqjqhx7RQhsyXW3ho+RqXj9q9WBKZaFnw
         0zGgSRnEyOR8m11UhivzNB8lHiu2vzn+ZubLLiEtRJUlCjBZqg4O7WmF/YhdMkw1DmSN
         owVHE4zq1o6nHuVmcX62AylgLcK1BDygi77X2PO2ga9uCd6LKSXnMX8BIaj6I1/fkfLo
         NAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EaZo6YWz+PE4Amu8QukF1Cw8oSIakZDIQiKoGR/62wY=;
        b=uBCUNFEZwWUKpj/628Wq+7kN8o08g5iVLv9Kd737PSnl4SsN7tbNasARBXl+usdZnE
         8Jo3et3ffhU1GlAyWejJ5VUG4RT4e3EblfLPTZNLYjPSAqrQswAw1A/eHOWgUSGehUEZ
         AzjkPYflubawOk8p35zyzZ1lRULyoDc7fXQkqCE1tUrK51qMpwj7vMKzKbOHMF9RQ67J
         7i+eclm8WWL1MuvY6VUG5AU9K8vckAq38B2pa7O8A9z7/pgF3wAHxKJN2PLCcLsNXTqa
         30bO1sdRfP2Z2LWvuTOt1uWWu9C9+v3vLg2xs9xbXRgvQ5aNBYypNJPeMoGrcufV+oWE
         q7Tg==
X-Gm-Message-State: AOAM532WQs9YN6rKVqNAEMWx9rUZMPOV8qZgrEH6zFSflRd61buWe0Yt
        WlGr3Thb8dhwqDR2m0dfTiE=
X-Google-Smtp-Source: ABdhPJzeWapOdx/1eEYuO99kEzZ9xJia7gM6ZniR9//pywure5qlypDffs4P/Vm6jWZrQqOitmIbkg==
X-Received: by 2002:a63:fe10:: with SMTP id p16mr9366634pgh.546.1642963229253;
        Sun, 23 Jan 2022 10:40:29 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c8sm14350494pfl.122.2022.01.23.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:28 -0800 (PST)
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
Subject: [PATCH 13/54] arch/alpha: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:44 -0800
Message-Id: <20220123183925.1052919-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.30.2

