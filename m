Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015CA4B1A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbiBKAfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:35:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbiBKAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:35:43 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D685F66
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:35:43 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o3so7353855qtm.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OWAdmxyB++0+PrjBMyb2j1q4M+ZTDvPBI87BwMKOTA4=;
        b=px25tVfseTRg17nKrinckLpm5Os6T2EDwYc8LKgshVBbe8wsdoAH40zqblIKerCD/M
         9FOLPx46bt7sHkinZB7cbxFBdikM66T7mIE2f+XeWCQEEWgZ6+Fj8c60iMtssJ2j4Ax5
         ywQwibJ3q+gTnIvO+B0epbOGU2k7wcFwtAmB2Ekl9ZcADK2LwleSSxyJRs3DD/O5DZ2q
         3TtJYkbVmKfY7d2ve4Ep5xreuUGke1oZrOtsnTBOvbkyt9qrnwapvEabYRk+An2u5fDB
         srQ7MLPu2N9T8Fk0fsc3+eu95bT6srOmeEd1PY3YKp7ljCULaG+YIorAkRi025pE/HtS
         At7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWAdmxyB++0+PrjBMyb2j1q4M+ZTDvPBI87BwMKOTA4=;
        b=Nqair/vDeS2BUuKINeYHkwBe78SI351hrXzh/AMoNbldp6hcS9CA8MWJ3vOOe0Tegp
         rrUk0+sWHcPXBmCaWv1VrQnLaz1sE9Bqes5TT8gug6T4GGSnq0D3M4WakkHIEpIEDTmz
         jawHYWnCQF0c+ZuqCBOwjxx1gSLa37Q7ZIOuWtI9daXZqD7GbBHgHHQuQFBSkUDaNKOV
         zDWMwMXtcpxaOrd3qTaQWZChzEW2qtRfoqF9FooSqy9AuwxWkuQB6QDZ76HDVYOl/whZ
         ZCJWOMe3no0XTQZGaNlnpAIcgLn0hXBFloQEAIt3z1Tsv4NOilhpg0pufYSmu7YaTmLL
         mfNQ==
X-Gm-Message-State: AOAM533zG5zuN1evAY5B2mKOsLNkeaT/1CfjbK4NV05k46qH7zAf1OUW
        Blq0NAv1vKoz6myCjSVeko4=
X-Google-Smtp-Source: ABdhPJwKE/7L+78ImyHSzKItwQ+7D0kCNRZ6HRgstwY/P0UGJdT1+mnItTy7cbAEdrMnsxIjkAmO9Q==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr6794649qtx.95.1644539742833;
        Thu, 10 Feb 2022 16:35:42 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id k13sm11581386qko.45.2022.02.10.16.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:35:42 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 47/49] nodemask: add num_node_state_eq()
Date:   Thu, 10 Feb 2022 14:49:31 -0800
Message-Id: <20220210224933.379149-48-yury.norov@gmail.com>
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

Page allocator uses num_node_state() to compare number of nodes with a
given number. The underlying code calls bitmap_weight(), and we can do
it more efficiently with num_node_state_eq because conditional nodes_weight
may stop traversing the nodemask earlier, as soon as condition is (or is
not) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/nodemask.h | 5 +++++
 mm/page_alloc.c          | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 197598e075e9..c5014dbf3cce 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -466,6 +466,11 @@ static inline int num_node_state(enum node_states state)
 	return nodes_weight(node_states[state]);
 }
 
+static inline int num_node_state_eq(enum node_states state, int num)
+{
+	return nodes_weight_eq(node_states[state], num);
+}
+
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cface1d38093..897e64b66ca4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8434,7 +8434,7 @@ void __init page_alloc_init(void)
 	int ret;
 
 #ifdef CONFIG_NUMA
-	if (num_node_state(N_MEMORY) == 1)
+	if (num_node_state_eq(N_MEMORY, 1))
 		hashdist = 0;
 #endif
 
-- 
2.32.0

