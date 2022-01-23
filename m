Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE43B49748A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiAWSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiAWSko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414AC061748
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:40:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e8so13479916plh.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=475Re6o4qrxmTY2+dJD1szR+aZ9ztNBAVJwVf2XomiQ=;
        b=jmVObv+DHvV/nfgWMGm7G0AiVWxWK811CYrpCGiHV6xY0cRphRK/F1bxcyarhazE7G
         QO3y6iESjwSCWQV4XxfbN0VGrGzLnz+MQAZouCPpYGATGaaGpx/xFlQQHIUbUBuvRRw5
         0P/sPgZ/Zob1yCiUwsGdNVWUVVlgMqpf+xC55wv1WQFaeiZGDLCbtdTLECSRwzD1BwDr
         5hJchQzstXRUP379uF+B/2jyU8zwFVQtEt3XnUASMZLgJzQPBHWzsJ7NMd9Pe5Hmto0M
         h6UFu1fpTLkx6o30OssQidiED5LGIyGRgU4+4B2Dhf6WKpYvcVZFv0Kk+WkaLBOUlnoc
         3Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=475Re6o4qrxmTY2+dJD1szR+aZ9ztNBAVJwVf2XomiQ=;
        b=IgPEElMhsrwOZyqBIF6X1X3A2GiUz8JltvaSiye4L5nlMNr7f9as3XlpC5ufxV/1W0
         FaHotqvrScV3VtyXf1BbeCL7VhpYjP1TF3TyFaYV+A+5earT0aRfy9uxOiRcebjbVxOS
         4n9DKpTzSoX0Li/UtMurY/LN3VAItmXF8CBmA7qBTO+xmwtRFbYGdBZiSg8SAWicPiY6
         1OpVGbf1r2fE3d3+LIMeRckJgDgLEMOgEQD9sDXRC/PFHzM1E6Qw6kILVWo/eXmH7fp6
         mYI0uZg9R8D6aCDvxsLu+9K7uAEpUhTV4OyXCEevBLydmmFfdnR5VJEdb2gDFBvOhV5w
         VUYg==
X-Gm-Message-State: AOAM533ML7IKXq8PPDxPeMFDiW+R0NPf0EQg+JY6HIe0qGkAADQEp7Ic
        +l3xuEaGLYnB8J7mCxLv/xE=
X-Google-Smtp-Source: ABdhPJyghkxvVhznkwLCfy/A1+7acBwkBZ1BlnfDfQwJqPCZvzndSaF4vpp9USN1uOTwz9n3zy27xQ==
X-Received: by 2002:a17:90a:460f:: with SMTP id w15mr9814786pjg.123.1642963241641;
        Sun, 23 Jan 2022 10:40:41 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id q9sm13712586pfk.137.2022.01.23.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:41 -0800 (PST)
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 17/54] gpu: drm: replace cpumask_weight with cpumask_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:48 -0800
Message-Id: <20220123183925.1052919-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915_pmu_cpu_online() calls cpumask_weight() to check if any bit of a
given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index ea655161793e..1894c876b31d 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1048,7 +1048,7 @@ static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 	GEM_BUG_ON(!pmu->base.event_init);
 
 	/* Select the first online CPU as a designated reader. */
-	if (!cpumask_weight(&i915_pmu_cpumask))
+	if (cpumask_empty(&i915_pmu_cpumask))
 		cpumask_set_cpu(cpu, &i915_pmu_cpumask);
 
 	return 0;
-- 
2.30.2

