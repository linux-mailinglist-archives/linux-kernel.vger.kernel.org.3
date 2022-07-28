Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D05583771
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiG1DU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiG1DUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:20:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01C1CB17
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f11so490162pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQz/M8tT4ITIWP7n8va8EqELXMwHkMTimrkWQzSleco=;
        b=o2ixuxHbCasV6jO8/0Hjd2PEkwx00Mj2bUOQ6BwdjZgNa0WmbqtniIDKYetCej3x0p
         2Ia7fgL+4kO1cL4XcG7NfZytEDtDtufSe/q4booB/sBjoPCOPuBhBRZzqFELWp+WMIW4
         X7l4yA+lfUOLOMZGy7+0aqCnfvl8y2V+/uI7DqgTpDTA5fmKvdLUecgZhdPMY7qJ/HBN
         NKCxXIsaqL0wfFhuYITNvopaJUM91KA0j+emsWCBDFrBbbEoDisDJAcGlseQmpGdr9I1
         PCd7hIgG75PVYbihu3VNGDp4AmpvhBYSBgJCh26udzP25A7f+kdFA5ZlZe2jzqP6cC/9
         iLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQz/M8tT4ITIWP7n8va8EqELXMwHkMTimrkWQzSleco=;
        b=AhgY7Vp1cbfmG/F3Vo4yFUlYhe4pieVivdRLBa6jf5JkYlUEMokOMcIVF0kg9ME34m
         XRJ9uZbwsMK8nNYUJ4fwLBFdRXpxUXa9DLjHigCmYinWpN3nksmuDZcCf2yh2T6Jm8b5
         RIsHmefHqba2bz08AFdTPVco1GuFAruSuWiNztV9lTeCzGY7gGqp0MQWhynvQ33TaEnK
         GNpBBr6j1Hm3QpyGweoOoqQ8vZnAuvm6tkVucyN5Vbhm7HxYEwx6EyvhnjXdUASoIsmB
         XDOx9ORuw+5dQA6wlHbkV8HzJDyi4apy2xz6KwDqv2CgFAmWOxJSGmLrjJXUVtiCsPlr
         PVEQ==
X-Gm-Message-State: AJIora9/ZLeTdWWZCEyIjmxTprNmQYkmTZE/aBuPX78R1M1Is8GH9CR+
        tUvW0zaK/gM8Mb6iycsKIQ5t
X-Google-Smtp-Source: AGRyM1uaa77688WwY9H7Zljb7CwwO08Iio3/xMPnKaWjx7Jcs3YdkttOnndFQ19ei1v14+Uzw/T1Tg==
X-Received: by 2002:a63:1c24:0:b0:41b:40c5:f114 with SMTP id c36-20020a631c24000000b0041b40c5f114mr6547218pgc.3.1658978419699;
        Wed, 27 Jul 2022 20:20:19 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b0016d1b708729sm10991153plg.132.2022.07.27.20.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:20:19 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] vduse: Remove unnecessary spin lock protection
Date:   Thu, 28 Jul 2022 11:19:56 +0800
Message-Id: <20220728032000.127-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728032000.127-1-xieyongji@bytedance.com>
References: <20220728032000.127-1-xieyongji@bytedance.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
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

