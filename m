Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D055FA79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiF2I0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiF2I0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:26:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C663C719
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so15287410pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6/JsOlJwlIJxWGuLjrTTVjd1qaroq7QICLqgjCEkQg=;
        b=BQxZAPEsUTOsevnZ2qtQ/POkvQe13iwMNPWicBBi7Sc+xjoJgu03cP4ZULbZPh+cSw
         utjeGZbDhsHNYonMe7DE7v/tOGQgdApejCUzT2lqlmL7bUnBqqGBgK9K0eBtBgKO4IkQ
         JDqwozlaN38PQAmxtjwSqmdoTnu7tRQHZR4m+GR4dOm25fh3mG5knrHKkYJq/m0DHhBy
         wvTsRpkuDo8v9trgFq1312fRS24fSoHxUQJEPkWNW4+grEt8fkd96uGl1mDpkdnmx+qH
         J2l2B5gyl2ynAQuXvsywKcLK7LAk/B5/MJYIVceLmF2HsdTvmXK8MOCvUBlzD2KkWg2X
         6H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6/JsOlJwlIJxWGuLjrTTVjd1qaroq7QICLqgjCEkQg=;
        b=p1lHrKYL1h3JHtbk00/whooGzzwgXJDzofDTPxxJnKKIngI6msQgHO/pQtHs9aRHyq
         fBi1BnK6eXfcwzHsK4B5o3SFniXTeG86JkdmG8iatZbEQie8ukJmku8o7aGacjLDaKmD
         A+d3lnHfBeo2p5nI8O0lsTHx6YJYP0thaj2dFS2EKGzMoBKPC9HZdSmTbNpcnbJTWc5+
         iFfGKOAxmByWqfQgejBJLjOhC12mBnQ781MvfsrHkCo5XVBUTvSm57fgzk75xnwd1v5I
         WmAjIzKWXODCHXDI1Z8HemUr4dbjucdSQby97Sm4MAebkpDzNaRMYLtQ9FYGR6daNRHH
         6KAw==
X-Gm-Message-State: AJIora9AOUx/JqdsLblwhAB3QGW/z0HtPdb8bGnVhFtTbFqZpHoxzmmF
        rkVBTnxldrLeMYBWpKXkv8k1
X-Google-Smtp-Source: AGRyM1t4B4SJDtI0aOEnpUHZ8Q3cRDCYM+PZRdrptvDzUinyX5e0PB+CSUQBz0k5seC5OIP6mck+Ww==
X-Received: by 2002:a17:902:ab12:b0:16b:97b5:bb19 with SMTP id ik18-20020a170902ab1200b0016b97b5bb19mr5313871plb.107.1656491194407;
        Wed, 29 Jun 2022 01:26:34 -0700 (PDT)
Received: from localhost ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id ne20-20020a17090b375400b001e2f892b352sm1388907pjb.45.2022.06.29.01.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:26:33 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] vduse: Remove unnecessary spin lock protection
Date:   Wed, 29 Jun 2022 16:25:36 +0800
Message-Id: <20220629082541.118-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taking iotlb lock to access bounce page in page fault
handler is meaningless since vduse_domain_free_bounce_pages()
would only be called during file release.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 6daa3978d290..bca1f0b8850c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -211,17 +211,14 @@ static struct page *
 vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 {
 	struct vduse_bounce_map *map;
-	struct page *page = NULL;
+	struct page *page;
 
-	spin_lock(&domain->iotlb_lock);
 	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
 	if (!map->bounce_page)
-		goto out;
+		return NULL;
 
 	page = map->bounce_page;
 	get_page(page);
-out:
-	spin_unlock(&domain->iotlb_lock);
 
 	return page;
 }
-- 
2.20.1

