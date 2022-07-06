Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFFE567D98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 07:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGFFGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 01:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGFFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:05:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27B1F61D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:05:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ju17so9054208pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6/JsOlJwlIJxWGuLjrTTVjd1qaroq7QICLqgjCEkQg=;
        b=ZOBwMLDCW8TQOuiBDT7xIpALiB5pwsgp+tumUSis4KgrjYMS4v3Q4hxudiuYpj1YWE
         eHiraxIGGwWSFE03924fxggxMsWhGp7NSTKj65Uk5BGb55uIYYX36CIPIYdD+uvNsXh7
         PNPJ5D4wd18CslZctrEDT/jlrWxWfcvTsLYxnNg+5ljxBuL3M9Gha0gGKraCAwnlIvEb
         oFueA6fVfE37MzegZkf9hgb5galoCgflHXM4g1Auf8kUZfTKIICEyxfyxH9QXpqABKqA
         /wydchhLnUAUmSf4qOjD6+vJB8nmtnQ98Ol6Xhm3kqQDY3m+3sDocfrSAMloPAH6qw0u
         txDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6/JsOlJwlIJxWGuLjrTTVjd1qaroq7QICLqgjCEkQg=;
        b=wem+6slRPwkkokFBoKsPT2iey3DsJEYPKwRn9QWfD2yc/klm8m6fMnfCjuxIDm0czU
         R7RPKWl14Z6z+pVtgzd+O3E6f8T0gRtdQHKWrK1IOpra4ktXRxuX9spii0/cmJP9aSMI
         uU6lZVZ3cZV4tW6T9JqwLJ+J69qdyQ/3vQT2YJJF8ZE2tMvFIRa2gweWE2ad2tXI13U4
         kTzLvzGrjSZFhF5IgOeAueF47yk0WTamBB1DAXiS7m3vjs9lVVKSdtFFWxD565BXPLxu
         oBjWZeLkKZX1pyVz3rWU3etnszoOYpDWNqKc/PdS3LY4FeE9ElFXKu6lFTzUEWJecrk2
         j5hw==
X-Gm-Message-State: AJIora+NumgWAumhVRhFACBKXaQPHewE2Ev677VmfkHOKFvhGDc8C1sH
        Lh96s+KXNc53k8Eo5KYrIZhk
X-Google-Smtp-Source: AGRyM1sogqpRRtujxKDNjXnDQqRwcoIPbG3B3VsEgpuMRhEhFZp0hIBA6KGw047PaJPkEk+35aii0g==
X-Received: by 2002:a17:902:9693:b0:16b:d0d1:e16b with SMTP id n19-20020a170902969300b0016bd0d1e16bmr22773753plp.69.1657083953122;
        Tue, 05 Jul 2022 22:05:53 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id ay21-20020a17090b031500b001efaae21663sm785478pjb.28.2022.07.05.22.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 22:05:52 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] vduse: Remove unnecessary spin lock protection
Date:   Wed,  6 Jul 2022 13:04:59 +0800
Message-Id: <20220706050503.171-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706050503.171-1-xieyongji@bytedance.com>
References: <20220706050503.171-1-xieyongji@bytedance.com>
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

