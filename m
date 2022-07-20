Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505457B015
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiGTEmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiGTEmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:42:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BA4D826
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso923416pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 21:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6PUXTFpSe4hiCUpV3CY8funZOBFDw7H3e5Gt/0oRi8=;
        b=IiA+Q3w7zcBZOjHNflXfuaDtcS0ofGYGJgJWsq4Cf7CP0tR6FSimksTaqsZ9RVrCvo
         hVQl0Sxm4Qmk/1Wh+8uoKT2FQfORQnp3GvzPZL4n4zE6VpagMTb7V5Wh0Qouy9+dsKRb
         pdIqK2s6JusvHaXj6WCdei7BHZbhFbNhZcdZV4BgLbv8rkJwTaBgmKqfL8ati8gMD/hz
         0fwQghDnWZbUKuL6JStZQEaPokRjdWQI/PXd+/aCan+fkymViXTxaCvTjO57CcU5HkuS
         OvRcoq6NbtIvCJD3fSA967WLAIYtbsHHkAI2Z8OgBhg5X0oaw5jQS0xkU5ruzaZLWIT2
         zvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6PUXTFpSe4hiCUpV3CY8funZOBFDw7H3e5Gt/0oRi8=;
        b=ti+O8qcsBUHfcLqGG+X4ukakL0xNPJRRFIiXysD+s6WIaRENcizB7oHS5MsVO9v81y
         yYyZOSjh7IKJQaazyikTfu57VuH7o4xAuTcH56+FaLJ87KZ3aEKmGnVMV6QYYwCqW5CR
         LmtOLtl9ikiKBEsGgF+O0KKtkWTvVDaeI92DCJe/eAI6v/MK3PCtWz1mBmKKpbLyc7yM
         RvE0siJcRi8ta7BkAHxhknfgkVNlHgdxh4z1EA2NwMhRSvrBJH1rebkLHbepTiGwAwLr
         t+TsRYUJLY2l/2nluXiXEorl1IcGx7s+NeVElTXcDdt2CE3J8Z2ovybzaMYR0xAXrh1U
         5JCg==
X-Gm-Message-State: AJIora/CjAUBbRuteOo+XC7f9HUG9UgpUuOi3eZf7ThvZUoeGXv/XFbW
        Ynue+ZBB0flPjBv+2TGOKMQA
X-Google-Smtp-Source: AGRyM1tt91KBDyuERAEmvcgNVxEzq6JDq55QvVpRznWDCgI3BajGSlbzGAniss0JVswRpX8Scw0Pmg==
X-Received: by 2002:a17:90b:3c0c:b0:1ef:e647:ff48 with SMTP id pb12-20020a17090b3c0c00b001efe647ff48mr3189743pjb.173.1658292128063;
        Tue, 19 Jul 2022 21:42:08 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id r16-20020aa79890000000b005254e44b748sm12303495pfl.84.2022.07.19.21.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:42:07 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] vduse: Remove unnecessary spin lock protection
Date:   Wed, 20 Jul 2022 12:41:40 +0800
Message-Id: <20220720044144.90-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720044144.90-1-xieyongji@bytedance.com>
References: <20220720044144.90-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we use domain->iotlb_lock to protect two different
variables: domain->bounce_maps->bounce_page and
domain->iotlb. But for domain->bounce_maps->bounce_page,
we actually don't need any synchronization between
vduse_domain_get_bounce_page() and vduse_domain_free_bounce_pages()
since vduse_domain_get_bounce_page() will only be called in
page fault handler and vduse_domain_free_bounce_pages() will
be called during file release.

So let's remove the unnecessary spin lock protection in
vduse_domain_get_bounce_page(). Then the usage of
domain->iotlb_lock could be more clear: the lock will be
only used to protect the domain->iotlb.

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

