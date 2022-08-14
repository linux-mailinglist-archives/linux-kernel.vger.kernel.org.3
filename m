Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CDA591E84
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiHNFuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHNFuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:50:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C38C52
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:50:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r141so269736iod.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YBGvaVNrmSK2tj7lGapunjUsxNRcm9+XAgiS0yNfu2w=;
        b=jd0o1BNnm1/fZHxWpKBRkvtpcwVhSYnC2WR00sUjHjmuUgVKeA/00kYeP0DofHygQ3
         tXkuirh8kHb6ohu0bttDUSAbz4V8ZmkL4FnJLWsBm6hCmHvi28L5AOzKyQ1I2NIkSpVd
         aoBmIsLCfKvLi92Spk/RspKU8SmrIPw2mjycFyBadfxD2sPM8kLmeIgeUY6g8NymhdmQ
         w4wmkW2sX5GTPnLu6zJ5eRLLrawe1QmIBw5rWV/zPIFUECla8A+ijYDBL7BkBPHZBDIN
         KJNeBDMW7rl93RU3MErVgR9qp3w7Lf6H/VK2rEujU++x3EQx68uzZHJ4bpDr5iZn7Sjx
         popQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YBGvaVNrmSK2tj7lGapunjUsxNRcm9+XAgiS0yNfu2w=;
        b=ZGFpMxT+PYMZ+DzD4WVqQZHvZzgJUDL6APRHwojP9o+pkhrRM9G5XXcyIPbhVYylKF
         uJD7A91TzgFIq9GLil9/PTU2YVD1C/xlDRZGos6WM7sCLSywiu1YcN41visQ77/EiIg0
         94BK0gkiqDtuFpVtY8Dp5mMwUcNU6lvkRnRCBEoGyCAEsElWEwNuxNGQVn2uG5TcAtk+
         GBpNl6f6j0NKf3jxPzAEZSRAtWL/JAFdG43MjnigXXUgZkeGfGsjZGflwLuW8KRPxyML
         SAegljiP0c93hi768Wv6Wd7CJQFns64rM2BEYOAmmJB2G/jChiQhCQNZ7jZD+LMKs32b
         HaDQ==
X-Gm-Message-State: ACgBeo3X7Q6kDy6lOtP7LB1GZ5fEEHqXY89mVNplZrreUt3v0ImyC1xk
        JFKxprRbQuJGWgg+CAQtoEk=
X-Google-Smtp-Source: AA6agR7blM9G9O6NfLeERcyeIPwliQma41mK9K67DVGfIyv9itOeVf4OETsVsOZjVr11RBD/oQHURQ==
X-Received: by 2002:a6b:ba43:0:b0:688:d19:4e8f with SMTP id k64-20020a6bba43000000b006880d194e8fmr901064iof.59.1660456232382;
        Sat, 13 Aug 2022 22:50:32 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id l3-20020a92d8c3000000b002de2ea2f78csm2623361ilo.23.2022.08.13.22.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:50:32 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/2] memblock tests: add command line help option
Date:   Sun, 14 Aug 2022 00:50:19 -0500
Message-Id: <0f3b93a79de78c0da1ca90f74fe35e9a85c7cf93.1660451025.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660451025.git.remckee0@gmail.com>
References: <cover.1660451025.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a help command line option to the help message. Add the help option
to the short and long options so it will be recognized as a valid
option.

Usage:
    $ ./main -h

    Or:
    $ ./main --help

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index e43b2676af81..76a8ad818f3a 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -14,14 +14,16 @@ static struct test_memory memory_block;
 static const char __maybe_unused *prefixes[PREFIXES_MAX];
 static int __maybe_unused nr_prefixes;
 
-static const char *short_opts = "mv";
+static const char *short_opts = "hmv";
 static const struct option long_opts[] = {
+	{"help", 0, NULL, 'h'},
 	{"movable-node", 0, NULL, 'm'},
 	{"verbose", 0, NULL, 'v'},
 	{NULL, 0, NULL, 0}
 };
 
 static const char * const help_opts[] = {
+	"display this help message and exit",
 	"disallow allocations from regions marked as hotplugged\n\t\t\t"
 		"by simulating enabling the \"movable_node\" kernel\n\t\t\t"
 		"parameter",
-- 
2.25.1

