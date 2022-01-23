Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54149748C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiAWSlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiAWSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE56C061759;
        Sun, 23 Jan 2022 10:40:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n8so13502444plc.3;
        Sun, 23 Jan 2022 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cO0Z3PvJvrtBIn6aCGpasZToGZcZBgiQnRAFqmRKoUA=;
        b=VTMY+YdRuNkseAuKEB0sacTZvHBgfmV4zPDgBlUHO02zbXakt4ftdzjgYgBnhNFYrJ
         Gq/uz/GbVuYEBJ11Si9b0Vn28HMi/mKcmODrHWStsvvykUL1wKNDqrObs/faG5tjJnMP
         OFcvcKedlRAfcJ0JntIkaDRTuDhuOwUp6/XHLbkcuMjlet0EBexHnDi/ng57aRf/xLdn
         1R/z7KVKOdfOw/cNFfqJCxm+KwLQZH3lH+oCNAjmxn67gPX35JUauw2ASaBtUHJW84ui
         7X7hf94iixk6ny58oeNC4S0XBdNtjpDuPJIvRp+WVBgHJCoL0Ieo81r93udRPOdgTwY0
         3e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cO0Z3PvJvrtBIn6aCGpasZToGZcZBgiQnRAFqmRKoUA=;
        b=G9OX+MsPW8hB9aTVfrhDYWPI/3f6yU6LtHjJq+HMEgedto9yeYfnXcbcrdHqwmwuLj
         r9j36Xn/Qu09sW9CL9RRMfbA3VlfDHuVUilmdqHojmBqsqgrV8BZJ/SVdHEq+aVM2hm8
         oNWzOZ206W9iEv4EwqirKTUkihIDoMA8EqG/bbhai/lJuD243z9BJs+o6L4834YXIrc6
         aH+3aLDckl+ou5mr2KBEa2SRFprBz+mPrGR4Bs2HMnNQ+WJj+EXsIu8rTpXFlkC+sywC
         AQ5ko7/iIgBT+EVXAWoFoeK5d5s8pCtaB9RL5B9iNZzNTPfZhEspfmcNy7NQFvpHD2ic
         cOqQ==
X-Gm-Message-State: AOAM532CSSVdJpNxlb3Tcr2DoCQqz8o/AiuecbJo/GcnNePMIGFJLDX1
        BsdXpupwTvnC9E6XhnartrI=
X-Google-Smtp-Source: ABdhPJwrgZ6tKrcQ8FvcUHvDuVXP9x3ixqRStUB6a92ecxEbeN5yZXa/hXjzJafBTJp3VTMlXUGOfA==
X-Received: by 2002:a17:902:ec82:b0:14a:6b35:903 with SMTP id x2-20020a170902ec8200b0014a6b350903mr11826986plg.78.1642963248015;
        Sun, 23 Jan 2022 10:40:48 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q21sm13893599pfj.94.2022.01.23.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:47 -0800 (PST)
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
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org
Subject: [PATCH 19/54] drivers/irqchip: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:50 -0800
Message-Id: <20220123183925.1052919-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcm6345_l1_of_init() calls cpumask_weight() to check if any bit of a given
cpumask is set. We can do it more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index fd079215c17f..142a7431745f 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -315,7 +315,7 @@ static int __init bcm6345_l1_of_init(struct device_node *dn,
 			cpumask_set_cpu(idx, &intc->cpumask);
 	}
 
-	if (!cpumask_weight(&intc->cpumask)) {
+	if (cpumask_empty(&intc->cpumask)) {
 		ret = -ENODEV;
 		goto out_free;
 	}
-- 
2.30.2

