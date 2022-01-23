Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B04974C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiAWSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240176AbiAWSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8A6C06178C;
        Sun, 23 Jan 2022 10:42:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h12so14115127pjq.3;
        Sun, 23 Jan 2022 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Hn/0KEFQM0VohxFbDN7o+rKVell2I9YQDMnO10ziuwg=;
        b=RLWSVVHhK5sS0VJoSJh5qzr3kvxFKZMIuqha6nZABD5yiUFV891TsT6pr+BuRKkmau
         Jr3NQlJfn60hdMW9oRHukDxgvDsry86rj7D7fDQ8hAMfFCHdYoGZ3xOOJS3VxiMXiCQN
         WnJ2HgK8tLMAJO17kJRpJTZd8jvdJSm4IT9rLQFWHGLA0yOqUkzDIoW/kt5NFH+HADLb
         2tR+oOK30YBZYNgEdS7t6hR2kTpNLr7opXgJIUR7uT0EagLXFCDKhdsJMzGULlhJQXBq
         ZXbfYZZn9gq9VNQqPhfrLOtLeJu+QgAk81hoKa+JbgquZkSqgiXO36WP2fNwoKI4MuU2
         KYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hn/0KEFQM0VohxFbDN7o+rKVell2I9YQDMnO10ziuwg=;
        b=MSgXdiFbGidJlosx3rJr7JXboPggUaQHjtMgqcsl7i6senjOutUDPb9oBHxo+6JgIQ
         H11FbGozgpng2VkNraxPovYXwoYvNSkW7GdB3qghaBKp+seZu2QysfrlYOsnbN5gBD+Z
         uebO/kyX55F2cQFtAQQ/4MJgw8HjhN4DCv+DziRRfxSycp54DPOqM/a7u0bzYe2dsrsU
         leZ5ARobQchDk8y9nSc4u5kDwr+e1LxCH9UFx9AgppBzNXAOxrxBtrytfBg0p13gE1UO
         Fxh9EnloBvgd7BmsDqUjOZeFjXp7lj0W4OejHPyO3hmBG85JksGB/37WGlEl0Kfk1m/H
         VEWw==
X-Gm-Message-State: AOAM531ZkzSLhilAQgoHg8Z6fs5zCzqzqZmrxFXqvN1oZDOvTynwNqw6
        50MnPZN3wDXZauCRO7Bi1/T6LhPNV78=
X-Google-Smtp-Source: ABdhPJyBszq+12k1TYVOUS+HW7O6m3uyaICRkRGYjMlRMdlMz+xzwmFYZQSU4jgwO4Co8mlvCOHd+Q==
X-Received: by 2002:a17:902:9a83:b0:14a:a893:f7ff with SMTP id w3-20020a1709029a8300b0014aa893f7ffmr11718191plp.6.1642963345210;
        Sun, 23 Jan 2022 10:42:25 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id ck21sm10634905pjb.51.2022.01.23.10.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:24 -0800 (PST)
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
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 50/54] acpi: replace nodes__weight with nodes_weight_ge for numa
Date:   Sun, 23 Jan 2022 10:39:21 -0800
Message-Id: <20220123183925.1052919-51-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_map_pxm_to_node() calls nodes_weight() to compare the weight
of nodemask with a given number. We can do it more efficiently with
nodes_weight_eq() because conditional nodes_weight may stop
traversing the nodemask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/acpi/numa/srat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 3b818ab186be..fe7a7996f553 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -67,7 +67,7 @@ int acpi_map_pxm_to_node(int pxm)
 	node = pxm_to_node_map[pxm];
 
 	if (node == NUMA_NO_NODE) {
-		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
+		if (nodes_weight_ge(nodes_found_map, MAX_NUMNODES))
 			return NUMA_NO_NODE;
 		node = first_unset_node(nodes_found_map);
 		__acpi_map_pxm_to_node(pxm, node);
-- 
2.30.2

