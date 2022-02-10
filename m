Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362264B1A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbiBKALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:11:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbiBKALU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:11:20 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584926FC;
        Thu, 10 Feb 2022 16:11:21 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id c12so5089696ilm.8;
        Thu, 10 Feb 2022 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4h1t/bTC+qDJEJPFRFVcOK5rGe+GH/iRxYkyQH+GgIE=;
        b=ZbhAJACxr48oNEwePgKFllHTK19fvAQq+syugIWiNbjTIbpMhXabd524NdFk43VC0r
         B2hb9BmF99mJk9SLhcktegNw7uf/aZput7dd0Caq9kW8BhlfTyrh9FLvqip34hJAYxU3
         yJu6/fI770DnT1KmaXY2hB6gXMtWmcQIO+/NoeGJqB+FEUOjjrueHwo997wTI6Qa+u1e
         dsTSd8IexTLJdmTz03InYWBbE5FetCdiNbfdUBuMl6uoDH/GyCJ9Qhd/tIcnOq5AYY+d
         H0vKrvtzn6zHqEpnQBzqdN7cZHZ8BYNcBACZth46mq4/qK0PuxkQEQPP7ihi6PQFbdbL
         B9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4h1t/bTC+qDJEJPFRFVcOK5rGe+GH/iRxYkyQH+GgIE=;
        b=KGBeVlX0Ps418O1UhTg9XwpVhFXaXMYTHLm7eGZsi0IhLSvsScgB7GTB9akiTXe9IF
         8QIODYg7L4RR1fghX6Mo3jINoCAjxEXamiufs8nrse0zvxfAjzV4Touq5q4wrsNayu2M
         R6pW+uLV0nB5Ln2k4Cpy578iAhplWc8szXNQhv8nALb5wZ7GSkeyMzj1TMihzLjw6NfE
         R7RoCPgxJmUxYwZUImpkrgGULuY/h6bCOoqwmvq/YyTvPfdKxnMDOQPK8/VbvgZqTFuf
         hQ75AqSQQGj9gXrwR7W57bMAXiQsIH2nj8Qusn+W/I8dkrr0FWjo2K7B3+QUo0XijjPs
         MayQ==
X-Gm-Message-State: AOAM531FqPf0sWkrSmimMtl7NTB5BRH0RbreHSFCPgZ/7G2O6a+Vrg6P
        NyWxYdWeHSNCI/kxVlRa/tM=
X-Google-Smtp-Source: ABdhPJxnKGWWX+h3tns0z9BdoPa/Tdtk5KLlu3v4Oxuh6/KxSgi5Su/RU6jC7/E8reyvrJ26b1xJ6Q==
X-Received: by 2002:a05:6e02:1e08:: with SMTP id g8mr5702300ila.22.1644538280448;
        Thu, 10 Feb 2022 16:11:20 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id u26sm12191990ior.52.2022.02.10.16.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:11:20 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [PATCH 36/49] arch/ia64: replace cpumask_weight with cpumask_weight_eq in mm/tlb.c
Date:   Thu, 10 Feb 2022 14:49:20 -0800
Message-Id: <20220210224933.379149-37-yury.norov@gmail.com>
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

__flush_tlb_range() code calls cpumask_weight() to compare the
weight of cpumask with a given number. We can do it more efficiently with
cpumask_weight_eq because conditional cpumask_weight may stop traversing
the cpumask earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/ia64/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 135b5135cace..a5bce13ab047 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -332,7 +332,7 @@ __flush_tlb_range (struct vm_area_struct *vma, unsigned long start,
 
 	preempt_disable();
 #ifdef CONFIG_SMP
-	if (mm != current->active_mm || cpumask_weight(mm_cpumask(mm)) != 1) {
+	if (mm != current->active_mm || !cpumask_weight_eq(mm_cpumask(mm), 1)) {
 		ia64_global_tlb_purge(mm, start, end, nbits);
 		preempt_enable();
 		return;
-- 
2.32.0

