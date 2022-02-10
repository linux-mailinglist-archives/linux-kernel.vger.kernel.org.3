Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303C74B1988
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiBJXbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:31:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiBJXbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:31:38 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BCF55AD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:31:39 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h11so5643990ilq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBa2U3XOOVlsojEDVXj/o83IuBw5ETmXBNJi4yT/mck=;
        b=jHSBDPHH5F/Vu7vkrUGPef+o7tUEfAEhl2PoRlxgkCIVVBSidmw9uoJm5ymTT6uz7U
         3pffuiDZNdBK94zTP95WUpBGuA4KamvVVf+MC7XSjB2nZG+dK2TvwXlQ6Bckx4CEO+Yo
         e0MBSfMLtj2iby5Q2GF35xLHWDBso6GFt1XjoBnPxNu86jWo1lCR2vG4HtD5+tH/9aJP
         OAruOIYwdHx6XDS8/GY+DdK51p13TeK26Uf/QDWOoZldYjOXc5rWsvHHoTuWsRjT3/AS
         10ubpI+g8KCocxoIO6IF2muT6+nBFRdueT1NFzZW82akR34riORhlm6VJ3wgO4FgV413
         BSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBa2U3XOOVlsojEDVXj/o83IuBw5ETmXBNJi4yT/mck=;
        b=zquFIBEOb2WeNy7b5INI8vuNexyM8BkJ9d4OfdwsSqX5CGcmYxA7IwV47x09PXBv5P
         v4aFfG5akTPOMehLA5DkRtElJzNK8NT9YED46HrRJ1OP6sto4w9PxcKYqqcJbiBCXy3T
         rj6AHpDf778V4ttb14P2/TLNoP0cnQKkNtrhsbM0ABZLnJMAIHuyhLnXH2z+xHpLQRbt
         82SOMPq7LehTuvGuGP3Q0EGkrrEvlmdzfyn0ZIRjMhIxJQNVlGL8aggGAupLGVlmeLQ3
         0CS/I5JE+q/dhiFgFm3R/oiRUbmDqVoUXHaIBeG+uMH2W+RCVcOMt8J3NJ5hhlw3pSM6
         1Qmg==
X-Gm-Message-State: AOAM5334VhWz2CyeAG0f2pgX2xlXHRcZctO0k8sWtg2ThQd1UVYiF558
        wk+ODqHvj6eo1xYMQvC5FKA=
X-Google-Smtp-Source: ABdhPJy8lL1944IEHiv7kjDJbzucordqvuC8LbtZQRP1RQFcCYSZIqSbwhqVBTtPLxpQaswpU1x/lA==
X-Received: by 2002:a05:6e02:148:: with SMTP id j8mr4737390ilr.218.1644535898397;
        Thu, 10 Feb 2022 15:31:38 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id l6sm7395096ilt.16.2022.02.10.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:31:38 -0800 (PST)
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
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 18/49] drm/i915/pmu: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:02 -0800
Message-Id: <20220210224933.379149-19-yury.norov@gmail.com>
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

i915_pmu_cpu_online() calls cpumask_weight() to check if any bit of a
given cpumask is set. We can do it more efficiently with cpumask_empty()
because cpumask_empty() stops traversing the cpumask as soon as it finds
first set bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index cfc21042499d..7299ed9937dd 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1050,7 +1050,7 @@ static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 	GEM_BUG_ON(!pmu->base.event_init);
 
 	/* Select the first online CPU as a designated reader. */
-	if (!cpumask_weight(&i915_pmu_cpumask))
+	if (cpumask_empty(&i915_pmu_cpumask))
 		cpumask_set_cpu(cpu, &i915_pmu_cpumask);
 
 	return 0;
-- 
2.32.0

