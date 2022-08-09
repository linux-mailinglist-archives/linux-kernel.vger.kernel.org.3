Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96558DEFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbiHIS27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346382AbiHIS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:26:17 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB8432D9D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:09:19 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id A277A308D10;
        Tue,  9 Aug 2022 20:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660068555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3m07txKng1vpbWIJJPy25Mf2SLdeY05UMdJjSdJApCc=;
        b=2m/EP95ykBiHIgix3Nt/sfeJCQS/hizgx6WCAvSmSmSMflsDaBHMsZMFZMU01DAGxQrELZ
        K+Ng17iAAMfJSPea0UId2d4pWcCyRZmEIrOaWQMoHIi1V1NPg1jrP4v4XEBn4dWw0vQU8Y
        f22EkqCGyzv0yV5o1w1ltzI0ykbsiRgfB1gsn3ANmlHH+Low2/wcXVNjkc13ffrDAY09Wh
        n3pngZf0GqYA4D8fzeg0cpiGUsFRyMP4muERy7v5LyDvmmaPNxpJPnMtYb7+ozVof8Y+E6
        gP2XOH/dzQiQRYkyiQ1evprgntQSpc7rUAMR3zsnG5b/aU5GG2bFNr4QHTVKcA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        David Gow <davidgow@google.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 1/5] lib/test_cpumask: drop cpu_possible_mask full test
Date:   Tue,  9 Aug 2022 20:08:51 +0200
Message-Id: <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660068429.git.sander@svanheule.net>
References: <cover.1660068429.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_possible_mask is not necessarily completely filled.  That means
running a check on cpumask_full() doesn't make sense, so drop the test.

Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
Reported-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Cc: David Gow <davidgow@google.com>
---
 lib/test_cpumask.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
index a31a1622f1f6..4ebf9f5805f3 100644
--- a/lib/test_cpumask.c
+++ b/lib/test_cpumask.c
@@ -54,7 +54,6 @@ static cpumask_t mask_all;
 static void test_cpumask_weight(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
-	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
 	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
 
 	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
-- 
2.37.1

