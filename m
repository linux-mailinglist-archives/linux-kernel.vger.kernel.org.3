Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288EE472B14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhLMLRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhLMLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:17:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446DC061574;
        Mon, 13 Dec 2021 03:17:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t9so26407644wrx.7;
        Mon, 13 Dec 2021 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHBBE8+l46O+iEZZyPl8/vI38kRLjbuHmhUW5ho+bYM=;
        b=aaDiIurDYLSXqQnGeRVGq7DDD/Tj4EVYBJbXtfOzG9Ze3wMs1ck28mHYnXXAhYb61o
         xnJM6xdkFx/VX+xwsYRJNbXukKzyQan7SB2LB/hUkTFCvLMGHDu+jpyPbc294uoerdDC
         fY/9N1QDjv5qWK4nSOUrSWfe0lduHLnHc1XMWDPdKT6dIc/91oOPjz8YcDWy9aQsNhC+
         ovYQMwHHTqfRy2LhEkJk94igu76kotOPyBu43Q30WDrMlsI6svr/cYK1PgNkWnmOq16I
         qto/MV8WEJh+7GQRLw28ecORyYMB9uFfZ2NqMN8ZdIlNjrSDuLjn0gbLZtkIfKZTTv0i
         xZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHBBE8+l46O+iEZZyPl8/vI38kRLjbuHmhUW5ho+bYM=;
        b=MTdkg9hSP1wG+96vZxROOoJ02uNJ+0AtZaVW+l+Z2D6cy2etbH3hWKTxEkXNgyYSzr
         DpLRc2VKAdiSc3RGB+pP+IBBcG2i0J/vPD50LB1qXtx6LyYFVqGTOkRY70BotgzuZxPU
         y5rW5vUqs8s6kidYuNdFcFkKusEltP8b8BnhKt0h5aMbhJZ+M5F9CRwGVYinAeD03E2p
         7HIYrHgrM68n4QU4N37JytA/V4F9cz3NZMkbvbPCuqROSwc4GTikjPeuIGRFoVst8j1x
         J+tQAf8xFek6zeK4Kv8jmnmXoFnVqz/qQNX869QtiWkCXf3FEsSfLzZi6VTEpA1rKA11
         iSEA==
X-Gm-Message-State: AOAM532mUaKI/UYJqXXyF+SMIsoucDp/TWAXzYlNaZh56LusGqloLdgT
        i8v7g1O7rkJLKlq5x9HoMS5wxDdKoIg=
X-Google-Smtp-Source: ABdhPJzUY5wqFlVdodF92RCx2vdH/tYLUvLMzcixAq0aahNeJmZkKcyo9Mm1OzW0MkZ0bMbI6f4Kdg==
X-Received: by 2002:a5d:4b8a:: with SMTP id b10mr31483819wrt.413.1639394223655;
        Mon, 13 Dec 2021 03:17:03 -0800 (PST)
Received: from DEL01603w.ebgroup.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id t17sm7255255wmq.15.2021.12.13.03.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:17:03 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Sander Vanheule <sander@svanheule.net>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/9] mips: dec: provide the correctly capitalized config CPU_R4X00 in init error message
Date:   Mon, 13 Dec 2021 12:16:37 +0100
Message-Id: <20211213111642.11317-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config for MIPS R4000-series processors is named CPU_R4X00 with
upper-case X, not CPU_R4x00 as the error message suggests.

Hence, ./scripts/checkkconfigsymbols.py reports this invalid reference:

  CPU_R4x00
  Referencing files: arch/mips/dec/prom/init.c

When human users encounter this error message, they probably just deal
with this minor discrepancy; so, the spelling never was a big deal here.

Still, the script ./scripts/checkkconfigsymbols.py has been quite useful
to identify a number of bugs with Kconfig symbols and deserves to be
executed and checked regularly.

So, repair the error message to reduce the reports made the script and
simplify to use this script, as new issues are easier to spot when the
list of reports is shorter.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/dec/prom/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
index cc988bbd27fc..cb12eb211a49 100644
--- a/arch/mips/dec/prom/init.c
+++ b/arch/mips/dec/prom/init.c
@@ -113,7 +113,7 @@ void __init prom_init(void)
 	if ((current_cpu_type() == CPU_R4000SC) ||
 	    (current_cpu_type() == CPU_R4400SC)) {
 		static const char r4k_msg[] __initconst =
-			"Please recompile with \"CONFIG_CPU_R4x00 = y\".\n";
+			"Please recompile with \"CONFIG_CPU_R4X00 = y\".\n";
 		printk(cpu_msg);
 		printk(r4k_msg);
 		dec_machine_halt();
-- 
2.26.2

