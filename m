Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53484B1A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346443AbiBKAkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:40:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbiBKAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:40:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962F5F6E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:40:09 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p63so9520899iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vmCRi5YEMF1V/cao58AWdP9eCW6N73MpNoaksw6efrg=;
        b=kOleynCii1sTUECOg708u4XojrBU9aS21lN3USq2R+X5/ZO33qGfpqSNvnne6+Tbb7
         w1a5Q82784qwC6s2+tfAJ08cVm+lekZz2Ht7m8pT16vUPtp9HbSuprSDBx8z1Z82vSp6
         Lg3sLP3tU5/bASf45WQF9dsmCstphPdp2diEHkM1mHagQsCK1/DuYY/mlwKWTclZubrA
         UHaoSXaZZ+qrSb8fTEnXC8HD+988Lag0y2tBy/61FrGOBdUeNpOgKYdud9iIuAtqxZuz
         oSTg9go8Mp2nmp2P4xSC2IaULA7ZdycJf2oeREtRb1akdVemUo6v0PMgDbnpi83Lg4Vi
         /SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmCRi5YEMF1V/cao58AWdP9eCW6N73MpNoaksw6efrg=;
        b=xdUuIeMyxTXyU6SQ1Kfvlw/83TNb0bkALETzaSGSJ5q5QpEy7LXygdnEhCrRk8Y7Hu
         1WWVHxSqP5jRF8xDDR6FS3teqNTbkDcgaiSJiBfCU2D0o/MTep0V7YtF408cZVQgzhvR
         EH24MW7XlqxmVSNhWirIHW9MI5x1yfSPm1WAar9HsxDRORT3dB45EBSVA7K2IvG+1ABQ
         s2x0D7oN9Ic3bsW9oQ5rdGa3mrEC+ajB2pVCbnOoA/lSVPPo9wTn4zqOX69UY+B7Aana
         LdI3oM+3yk2Qnzd3Vx5mDiOV6xO6WW8IcHB9WtBMS4Kne6WbDRnFww6wkRug9zSZI2s8
         cSiQ==
X-Gm-Message-State: AOAM530Lbsot5VWNb7eYt1UCNOUq+Wp7wjSeH/BFAvCI82c39Ripba4I
        cUgGWjo5cln0bg7GNGeN88Q=
X-Google-Smtp-Source: ABdhPJxoFCWN5x2mN0KD5UIrwsWX5nqLJ2PSiQsS/yLSfalb2eKudKYngjMmUEcyHIIzios3XdvRdQ==
X-Received: by 2002:a05:6638:13d1:: with SMTP id i17mr5558325jaj.182.1644540008959;
        Thu, 10 Feb 2022 16:40:08 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id c9sm668312ile.38.2022.02.10.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:40:08 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 49/49] MAINTAINERS: add cpumask and nodemask files to BITMAP_API
Date:   Thu, 10 Feb 2022 14:49:33 -0800
Message-Id: <20220210224933.379149-50-yury.norov@gmail.com>
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

cpumask and nodemask APIs are thin wrappers around basic bitmap API, and
corresponding files are not formally maintained. This patch adds them to
BITMAP_API section, so that bitmap folks would have closer look at it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc32519e5c02..718ed3b81c8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3434,10 +3434,14 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
 F:	include/linux/bitmap.h
+F:	include/linux/cpumask.h
 F:	include/linux/find.h
+F:	include/linux/nodemask.h
 F:	lib/bitmap.c
+F:	lib/cpumask.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
+F:	lib/nodemask.c
 F:	lib/test_bitmap.c
 F:	tools/include/linux/bitmap.h
 F:	tools/include/linux/find.h
-- 
2.32.0

