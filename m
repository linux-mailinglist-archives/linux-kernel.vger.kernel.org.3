Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC24B58DEFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiHIS3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346500AbiHIS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:26:21 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A73E32DA7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:09:21 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 498DE308D11;
        Tue,  9 Aug 2022 20:09:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660068556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RaM4fqJuh1bdAcPxbCOWOjg++5wy11STNZgGQX7FNYo=;
        b=cM1KDrLs+m0j2hm5omOKL3w+DObs4NtTDU/t2EXApylqA5NPaWs9Tw6vCCD3kYgjJv+oXQ
        F+V2tGsJg+sWWYoNtj2G0eTh2DCem/uoitCf5w35bHQ+9uiv+xovtFgHIRisfiCkqcNeYm
        +JvBwcoa/fhN4IdsUq6JI+dRXKu+YD98ta9PuQRTxpt/pI6kFM/F6OfhVQ4TqYaXRzy3ab
        uSQXhQQ4g7fwfPiHt0hPqb1CbTnLUniIbgpmDWepLIZneEAWAfIt5m3gN2PeMizHfLjX0m
        hS2AlK9gKSB+gRQ+hnfaSsVc5gJmCceR+/W4mAzJyx5tOhXBTLTIwGOWUji6hA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        David Gow <davidgow@google.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 2/5] lib/test_cpumask: fix cpu_possible_mask last test
Date:   Tue,  9 Aug 2022 20:08:52 +0200
Message-Id: <01cf5f4ee3a2d2ef56b19a91056496fd4d648cb1.1660068429.git.sander@svanheule.net>
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

Since cpumask_first() on the cpu_possible_mask must return at most
nr_cpu_ids - 1 for a valid result, cpumask_last() cannot return anything
larger than this value.  As test_cpumask_weight() also verifies that the
total weight of cpu_possible_mask must equal nr_cpu_ids, the last bit
set in this mask must be at nr_cpu_ids - 1.

Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
Reported-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Cc: David Gow <davidgow@google.com>
---
 lib/test_cpumask.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
index 4ebf9f5805f3..4d353614d853 100644
--- a/lib/test_cpumask.c
+++ b/lib/test_cpumask.c
@@ -73,7 +73,7 @@ static void test_cpumask_first(struct kunit *test)
 static void test_cpumask_last(struct kunit *test)
 {
 	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
-	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
+	KUNIT_EXPECT_EQ(test, nr_cpu_ids - 1, cpumask_last(cpu_possible_mask));
 }
 
 static void test_cpumask_next(struct kunit *test)
-- 
2.37.1

