Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241457B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGTG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiGTG6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:58:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6054ACE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:58:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f65so15566148pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF+KtcQcuFeKsfB6J6qxSptBOPPY8MNLklD1mjEET1o=;
        b=VRCq53cYNSDyBLSgveHJIkDyFrcNcVtzhsy5iMjhubVqaq4jcpMqJ9oYTP+MzSbY82
         UAbEyfZ4oPvv4q1iADvhggNOfrn1oSl4zSZYn1/+cfBl27yU4jZcpC9AZHk4Kh3ulHzv
         iJGqmnB4CG/wFSwt09/Vtf/b8l3p0/9JDcH5b+aM4EwjMIh4XfBqeaxBVlll4t/El0x6
         WS0RtSy5CAZ/WFSCD247Lfog/EShj7J3FlBVY22x03rrq25NRE7CPdpp59ih6+NIHhup
         q/b5BewK7+XUA4ltxxWf0kUy4AlUcjp/71y3CG2lxQtsUYOb+9HKFagxu6s+mp+DPC78
         4Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AF+KtcQcuFeKsfB6J6qxSptBOPPY8MNLklD1mjEET1o=;
        b=j6qRU1dP5X3OLFQ6ijiKVEYRfQVGLL37TEkDa8sfkJw1xa1j+6+KxWOsYoNI4mTtUa
         +iH0A7evN5GnMINcI9dQtv93AR01cdbTikh8YnRwC79AgM4wrXduRvlPhDtzTl7vShhs
         uhJyh3L15rzDwicT+0k5eTbeH9rH3x5isWnAPe3vbtlSaFVcwIuVYT4OHgzENYDkTx3a
         OR25tQEIoqMGMQ4rWpmr2oXDAaHsAYtnKkGCkVW7BliBGtZOvKitEac8pcAGrSVhNbsW
         GtdehupRvg8KH1cjGVoukL5jQpOYRKzd5wEwTEgrHf+UwPBGZFPC5nTKytxHZtvsWeVH
         B4Xg==
X-Gm-Message-State: AJIora9PbWK/OxvDj1fI2M7mXTRHHZuo16x8ZnXIZRSX3gazwctCYCuH
        NU+ho4lrU6JbGMgl857B4yE=
X-Google-Smtp-Source: AGRyM1ttMlhZniegm1mHRwgoJ8M+tVlGTnaE3XuxDhaTCJ3hXSgnasW42hbWPv7tAuZTaVQQPmdYbQ==
X-Received: by 2002:a05:6a00:793:b0:52a:b261:f8e7 with SMTP id g19-20020a056a00079300b0052ab261f8e7mr37269509pfu.20.1658300300172;
        Tue, 19 Jul 2022 23:58:20 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b0040d75537824sm11201782pgj.86.2022.07.19.23.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:58:19 -0700 (PDT)
From:   zengjx95@gmail.com
To:     vitaly.wool@konsulko.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] mm/z3fold: do not unlock in z3fold_page_putback()
Date:   Wed, 20 Jul 2022 14:57:44 +0800
Message-Id: <20220720065744.1006305-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

z3fold_page_lock() will lock zhdr->page_lock
1630	z3fold_page_lock(zhdr);

return without unlocking zhdr->page_lock
1634	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
1635		return;

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 mm/z3fold.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f41f8b0d9e9a..03785832ad47 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1632,13 +1632,14 @@ static void z3fold_page_putback(struct page *page)
 		list_del_init(&zhdr->buddy);
 	INIT_LIST_HEAD(&page->lru);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
-		return;
+		goto ret;
 	spin_lock(&pool->lock);
 	list_add(&page->lru, &pool->lru);
 	spin_unlock(&pool->lock);
 	if (list_empty(&zhdr->buddy))
 		add_to_unbuddied(pool, zhdr);
 	clear_bit(PAGE_CLAIMED, &page->private);
+ret:
 	z3fold_page_unlock(zhdr);
 }
 
-- 
2.27.0

