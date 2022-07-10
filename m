Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA14156CC2C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGJBbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:31:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8981571B;
        Sat,  9 Jul 2022 18:31:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w1so3166563qtv.9;
        Sat, 09 Jul 2022 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aC7GGP+qFCMQoeeXhh1VdtEODIrDY2D68m8vGqMgwVk=;
        b=pzxwsWnPRf11xoL2BdQkapOV39kUt775xTzlfejy7qgi9E9i3Ss6WAreWb1q8+Bzb6
         nWOjHxXtp1Xed+F5dEmxmbW7JumDEpH+XiOMJWWR9Yvw4yUhXtKPCN9oVRuCOUnG+eyO
         wNqUTYPnyNCMuC2+d1vehuQlBjDX4dq0mdM4wMgcyT2ckWHzIcbHHflRMzKvVGnUtADN
         crasNtqi+2rLK6s0A59hsOwKRV0rfLBYwrFb+zsK2m+EIIi4+y5HW2Cll0DvaAnh7cID
         LXX1Tp4suPPdY6NagZ+WwVlaMjEsKwjBzG98XWTz1tiPcbfRIAEyrHaKE+GnCtPP9m/S
         23Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aC7GGP+qFCMQoeeXhh1VdtEODIrDY2D68m8vGqMgwVk=;
        b=WDm8avT4sTjdAnfPFHOIyT2ZpRqUTojoX56b7PA4svJblKoaFAZK927d5uf/TXqBkq
         v1L2g96Hoqr+p41gBoGV/IVjarSAnripT8QIW8ucDFGBiQFQSSF4DJZypm+O4BsNLEl7
         VUYDfPkqJLNs5RbyVg9p+uLijLmV3aUqs3Yd+4B5tOkHW2sRPbNGQvg3Azsz5v0a5b9g
         MIdhL8q6HyVcQcQQD5wSDjpYXFZF5+yZMb4z7jxQ8T8VH7Yu8vzJWxXrSXz7kiE28xe3
         6tv5x/GOUe1HxBly0BHHD4QV92Z2FGjUqe4QRXIke7vFc0oTHHy9YvPqTk/i5u3Z2nvu
         +6aA==
X-Gm-Message-State: AJIora+BP2ANqsuahLiY7Esk4VKsWJlDs+BoPyUXhH3Twk25wPiAvPD/
        IFa8tBaulLMruX823wzIDlB+zaxf+cc=
X-Google-Smtp-Source: AGRyM1tMbpDvLx6xpSoACU3E9xUNaIzUEEANxy+OO7t+nEOae8ZtBtEa4llESwG18BLV6LSth1/s5w==
X-Received: by 2002:ac8:5c47:0:b0:31e:a9b9:822a with SMTP id j7-20020ac85c47000000b0031ea9b9822amr6147870qtj.250.1657416693170;
        Sat, 09 Jul 2022 18:31:33 -0700 (PDT)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006b575a9775csm2137258qko.45.2022.07.09.18.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 18:31:32 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jic23@kernel.org, geert@linux-m68k.org
Cc:     peda@axentia.se, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] iio: test: rescale: add MODULE_* information
Date:   Sat,  9 Jul 2022 21:31:05 -0400
Message-Id: <20220710013109.3349104-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220710013109.3349104-1-liambeguin@gmail.com>
References: <20220710013109.3349104-1-liambeguin@gmail.com>
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

In preparation for module support, add missing MODULE_* information.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/test/iio-test-rescale.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index 0b6699bfd553..735e2f97af18 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -708,3 +708,7 @@ static struct kunit_suite iio_rescale_test_suite = {
 	.test_cases = iio_rescale_test_cases,
 };
 kunit_test_suite(iio_rescale_test_suite);
+
+MODULE_AUTHOR("Liam Beguin <liambeguin@gmail.com>");
+MODULE_DESCRIPTION("Test IIO rescale conversion functions");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1.4.g5d01301f2b86

