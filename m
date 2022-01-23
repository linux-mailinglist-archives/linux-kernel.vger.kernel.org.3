Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E16D49746B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiAWSkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiAWSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:39:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47680C06173D;
        Sun, 23 Jan 2022 10:39:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c9so13468678plg.11;
        Sun, 23 Jan 2022 10:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Y67UpGJgCeGI3YjkkCV3h1RWBz0EaSLMoBqw+YNaKM=;
        b=fj2Be3j4ZXRuOSxn0ZBVfLiLCyC1T7HgxLBl1dbJ+1GQMBP1uFWdWTNbPb+uWf/xrO
         fEq/nS9cpgMQq4Z/EeGzuaSIb6mOIrZ7LgCI/XoIPnvJf3RsIJv7y1hkMvE+QnCq9zKA
         JMV8tbR5pot6iHL3EBKW2XXAqJM5+ApGwCvEnj7iWYw02WTqJjO0ci1TnCiThd9Xg445
         pcSMonvfQBFpKb5hWyBaJtMySDLtJzDJSIYoXZXdot1LheibM6eHhYHQWrtYShBnp/K+
         iwi8TcO5n5tk0ketawzGGBBDDj8oY+p4hunGEj1VW3/rokkCis1vkQfda195htV4ArRP
         EnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Y67UpGJgCeGI3YjkkCV3h1RWBz0EaSLMoBqw+YNaKM=;
        b=i4JhkczdiVAZxbJ8/hC6I8OSUtGal6kftEu+QieyBk9lIMir0JiKqkGmS47QamLxjL
         d1PTX72aJDrGjfcI2t7eqlliwGSEZP5ZBKdTYv8VGwOz4YJAg1fAe6kG+E3K2BjUhl34
         HvuBuo/++8dU60Mlc8RxpN3f8AIJV7kyNL/NguW8+Sfx/zBkxDAgB6Qz1S+t+b7XcArI
         PkgYC629xqLOPEuJEUsw2+m7RMIO5lYciiX9GZN0mvvSmc5CVoK1Qx48/A7upEeQ/Sfp
         edzkxutQsYlzu0wezb1PmK7Iv/dKhrhhiV8MwhQvHRwxtp63JVrrp1Qp+En5wJk3mM5x
         LQqA==
X-Gm-Message-State: AOAM532JgeIgVfGsW9BTN3PPcCuIhFrcrilQkQquuTcuz/r05gfQwh+h
        oE7qPyIX/Vj0h3ZHoCzHaIg=
X-Google-Smtp-Source: ABdhPJxGVSXvOUZjhokqqNWOPu2slOcHKradSt7jDO2Wwih5XKmhc8jCE0q6lk4Znh/tsr/lxxzGbw==
X-Received: by 2002:a17:90b:1b0e:: with SMTP id nu14mr9710263pjb.39.1642963197744;
        Sun, 23 Jan 2022 10:39:57 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d8sm9389575pjz.32.2022.01.23.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:39:57 -0800 (PST)
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
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 03/54] thermal/intel: don't use bitmap_weight() in end_power_clamp()
Date:   Sun, 23 Jan 2022 10:38:34 -0800
Message-Id: <20220123183925.1052919-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call bitmap_weight() if the following code can get by
without it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 14256421d98c..c841ab37e7c6 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -556,12 +556,9 @@ static void end_power_clamp(void)
 	 * stop faster.
 	 */
 	clamping = false;
-	if (bitmap_weight(cpu_clamping_mask, num_possible_cpus())) {
-		for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
-			pr_debug("clamping worker for cpu %d alive, destroy\n",
-				 i);
-			stop_power_clamp_worker(i);
-		}
+	for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
+		pr_debug("clamping worker for cpu %d alive, destroy\n", i);
+		stop_power_clamp_worker(i);
 	}
 }
 
-- 
2.30.2

