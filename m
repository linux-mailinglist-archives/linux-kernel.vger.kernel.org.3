Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655594974B4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiAWSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbiAWSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B0DC061755
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d5so11712781pjk.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SXSPpkBNjFI2449vR4ZOBpkrXqfQ1QSZDhxzDBOLdyY=;
        b=eiPAXI/WjLAblkhca2uJhe8/W1CRBsKo7ESuVXB0ckdjmDbHwcwgeLa2vXoJEA0fxt
         Lk59qbjVjcrnZW1unyX5auKxG1xSZWfPJLHePY7jbbfw6OU/1dAOiaW9oqdl3dEpJ3Xn
         sakgCeMBvaAp3NPshZro4hIL2pKSOLMTNpsTpVv9/0QG/GJwtcdeptM9Yq4T2QuU6dXK
         UTfY8b5LygRS843t6y5kmY8IYWkURJI+hhQfQcy71BSS5so3P9u58xxmG18sNMn9oYSq
         pafGE5mVfB/hgq0mIoQ+ZMVlM2mnFF+ic2R7UXat+e/IHhEQ+9l8LdM2qfjQ5lJdjt7W
         AaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXSPpkBNjFI2449vR4ZOBpkrXqfQ1QSZDhxzDBOLdyY=;
        b=us95joowT3/ZtECP6SY0PY4wZ/iwTQp403UNTlhLuPQ0d8z1qbpQ7jv4N5EeQlO6Ra
         dgYJqU39xUPAZtqV04A58V/se+jJXe6OjUmQIxknvU9n4O6fdU8LfqgLdd6nDHAPX8qo
         AoHsYKuSZWQ1PLqe6SNZjIhETUa6HEhgIN1LXG81Gv3sBOBhjxeszaM0K3OP6rlEH4No
         j1l2rNI/qoDVFn1WeTdzqK4eS/I4Bp6VCRuRpCgJ/HyAzTHABBqhhoejRhu0Xaild8U4
         9NuBYyKc2YvJnFq+FeOgdPYkXJ4hSsne6kl3xP3HMjsQqOeFoVy79Xga6eZ/SgepxhPG
         o5Yg==
X-Gm-Message-State: AOAM532rmazHEXhmTlJ/yLYJnd68R/T6r6eiGLpQsY5LaGUBHYGkZApH
        Zi7AyTAs7BkpDVLD2qfhm/Q=
X-Google-Smtp-Source: ABdhPJyKnDsoQFq8L/+C1ePy3bLtIDZz3wYrVC6GemjQIHFlwG9Gr4xw7tsDXE/Qezv8iRphFZXolQ==
X-Received: by 2002:a17:90a:8807:: with SMTP id s7mr9725127pjn.223.1642963319695;
        Sun, 23 Jan 2022 10:41:59 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id mi6sm12051532pjb.40.2022.01.23.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:59 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 42/54] firmware: pcsi: replace cpumask_weight with cpumask_weight_eq
Date:   Sun, 23 Jan 2022 10:39:13 -0800
Message-Id: <20220123183925.1052919-43-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

down_and_up_cpus() calls cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 116eb465cdb4..90c9473832a9 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -90,7 +90,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 		 * cpu_down() checks the number of online CPUs before the TOS
 		 * resident CPU.
 		 */
-		if (cpumask_weight(offlined_cpus) + 1 == nb_available_cpus) {
+		if (cpumask_weight_eq(offlined_cpus, nb_available_cpus - 1)) {
 			if (ret != -EBUSY) {
 				pr_err("Unexpected return code %d while trying "
 				       "to power down last online CPU %d\n",
-- 
2.30.2

