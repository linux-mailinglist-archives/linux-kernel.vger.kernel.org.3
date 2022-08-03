Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7021D5886AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiHCEzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiHCEzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:55:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F631EACE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:55:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q16so14142478pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aQz/M8tT4ITIWP7n8va8EqELXMwHkMTimrkWQzSleco=;
        b=SVlgNrg4/kGKXTGYEOKuXp5TC1Hw/P8yfw2ljqCMY9bXi3pSwX+NjDKBmji/1BEsov
         Tb5lISKewmwcd4R8Ld4cAOh2P+bL+Bt6k4cG+HRV6UtHEMrN6z4vfNsRcsXgHCrszmUI
         9KeMm/4elOXpaP4YW29ITN6emt1ov47lKa05DrgyjQLMB+yJnahjoDsSCl/rMQtwkOgr
         HjDXfki4blDdEVBSltMo6gPiG04M7RtzK5cYBMAa/PvqoQUJHSXA/Rgvt1Ch8Mc95w8z
         aKK/SJQqjJlBTfn59N+JBf0wNTvR/vKuD9T/bA/IO5IJQ8sJtbQ6hEIHxEttUT6NDQ0z
         Ncdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aQz/M8tT4ITIWP7n8va8EqELXMwHkMTimrkWQzSleco=;
        b=KVhJVGmEG4Ust2MWBjcPEnHPitLTuBPezJ640ltZHjtRoJlrCu1US/MhUFtzgqrrOz
         5oaQRHcrZ3Zuc7MgvEbk/Ueckkm5HcnSuYta+nI3CzMvvM+KDcYUYI4poSChZYKLasd+
         hu4hAqBEk49KnL7viv/XwqOtsuw8jyWTkgwhutXltIz9B77igovkkRYdGOC0ZdEqooZA
         Xk0+41Nf2GPK1GPT0CKjNivl1XopQKxHmMCrm8ReeL398Hkwce1BMVF/5oz2N5f+A470
         ARl2I57GgqlBkrJRuAizDXZuk9AQ/eelcQt7GxzYCLhF9x5pc66T+NvJRr5832htMSfQ
         V1KQ==
X-Gm-Message-State: AJIora/VgSC9uC/hYmxr0i/5fNEzj/goKt9DG/B2sva8aIiiEVsSPXPU
        AZuFpNsE1xrVCcqI7w1ozRFI
X-Google-Smtp-Source: AGRyM1sm1hZhHEOKhFmN2Owzi4pmQxn18t30at/hyqEvfS7Uof0a0m6qTR5t5WgDU5kLFPT6AL0qvw==
X-Received: by 2002:a63:c5:0:b0:40d:d290:24ef with SMTP id 188-20020a6300c5000000b0040dd29024efmr19901354pga.141.1659502540046;
        Tue, 02 Aug 2022 21:55:40 -0700 (PDT)
Received: from localhost ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b0016d10267927sm636091plk.203.2022.08.02.21.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:55:38 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     jasowang@redhat.com, mst@redhat.com, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v5 1/5] vduse: Remove unnecessary spin lock protection
Date:   Wed,  3 Aug 2022 12:55:19 +0800
Message-Id: <20220803045523.23851-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220803045523.23851-1-xieyongji@bytedance.com>
References: <20220803045523.23851-1-xieyongji@bytedance.com>
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

