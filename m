Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F484B19E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbiBJXz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:55:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbiBJXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:55:55 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE65F83;
        Thu, 10 Feb 2022 15:55:55 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c188so9475771iof.6;
        Thu, 10 Feb 2022 15:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Poe1QU0FyqYAnHH8Q+q/1vr6hVBL5HGB2D6185D4Dc=;
        b=g31QJrIdHnrArxOcj+UtssUsmwnWEpH4lQAi2PZOos3OiL1YRpDRz8LhpX0UqO019M
         VbAjG0CpxRcTaZ9F2Z5FfMfKvoymkuIxkojwKOyOspqzdoQuZuukn/CD6iH4hXlMql6a
         y1emREWzbvfX8nKyVV+eNehAExdOMASWVGrEC5hJRbX6TlrY29oEs7aIlM/9mRm9xHgV
         Rre3uyOgzPJZl799rdCZyxHLg7qjtxkKfJHCwnLgkd0TTvy57u4IHey9pRNlwJqKLpgN
         dNTv5O/2hn7LRQQh2QoZ7blZYoTLIx3M6TjJwkeAUSxg/+K3RWUmOxa+YMxKXRQeSygm
         6arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Poe1QU0FyqYAnHH8Q+q/1vr6hVBL5HGB2D6185D4Dc=;
        b=7QpP4semKo/wDBdvWxzR+iiha9Fp1mX2js8qSXiO9q8pqSXEI+wFFfpYV4clqmtvaj
         D5wJksbwKiVkbF6fklMbBbm+TAWm4c0pUOwEKsd3lL8krXad5h7P6yvm72hPckWh6lsB
         zrKqEfRAKG2ubY9kTAuxmU81gzSJg83l3rFy8gSD9V3OyWCJY2RfWI0pZfhxb1bkt/YV
         1M4HBsl69teBu8oZr2oAJfMxy23Ta3PMUSik8AoImZen2rAI1kpNzebkLeo7CKd0xfFg
         E//hyTANlhDr141vnD0GD4ULM9VfsbIjJq6upoz+LrqkdUciQLUYio5MpoyRhV6k2yW8
         9A+w==
X-Gm-Message-State: AOAM531l6+DnVytj+ykAv+cLciKRlvygdPhW2ylInC1ydFfLcpvUHF1j
        OevOTrBeFD4YpgmmiTHK3bw=
X-Google-Smtp-Source: ABdhPJxH+VGiGx9FUazjFDcnU7odGVOPzznh3sg75Vp+ADEFdLGkzCpLhCud0L3DRIIA/OcM2o86vA==
X-Received: by 2002:a02:3f42:: with SMTP id c2mr5403680jaf.161.1644537354570;
        Thu, 10 Feb 2022 15:55:54 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id e20sm6388176ioc.35.2022.02.10.15.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:55:54 -0800 (PST)
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
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        linux-mmc@vger.kernel.org
Cc:     Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
Subject: [PATCH 29/49] memstick: replace bitmap_weight with bitmap_weight_eq where appropriate
Date:   Thu, 10 Feb 2022 14:49:13 -0800
Message-Id: <20220210224933.379149-30-yury.norov@gmail.com>
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

msb_validate_used_block_bitmap() calls bitmap_weight() to compare the
weight of bitmap with a given number. We can do it more efficiently with
bitmap_weight_eq because conditional bitmap_weight may stop traversing the
bitmap earlier, as soon as condition is (or can't be) met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
---
 drivers/memstick/core/ms_block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 0cda6c6baefc..5cdd987e78f7 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -155,8 +155,8 @@ static int msb_validate_used_block_bitmap(struct msb_data *msb)
 	for (i = 0; i < msb->zone_count; i++)
 		total_free_blocks += msb->free_block_count[i];
 
-	if (msb->block_count - bitmap_weight(msb->used_blocks_bitmap,
-					msb->block_count) == total_free_blocks)
+	if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
+				msb->block_count - total_free_blocks))
 		return 0;
 
 	pr_err("BUG: free block counts don't match the bitmap");
-- 
2.32.0

