Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FC589443
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiHCWDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E9F5C9FA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659564213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Pg56FzwoyjSg3GyH/BFe7fw+AnDdom5pG01uC6nr8k=;
        b=A7EAZfma39ubx17u4G5WuBnHqlntIMLAlC4twvXJxyc0V98iIIjycOel1rYfwImBOpCt7c
        vhX/C2V+oQWpK70VT/KqVy0Ma/9It7miG+k0ooX41+4AIY8W1M372VLfO6oNCNk6EFjcT+
        C5SOJDmAtYtEsPlOzezK8EaMeRK/ob0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-P5GsASqZP5mEK4qtdtPoEA-1; Wed, 03 Aug 2022 18:03:32 -0400
X-MC-Unique: P5GsASqZP5mEK4qtdtPoEA-1
Received: by mail-qt1-f198.google.com with SMTP id v6-20020ac87486000000b0031ee0ae1400so11948011qtq.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 15:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Pg56FzwoyjSg3GyH/BFe7fw+AnDdom5pG01uC6nr8k=;
        b=ZvL+hRseNntC18J1Hm7tmPdTO6s52Iht8NIGmbDrUAa3+eNE8RK647LZkfKXKK6PW/
         v1r2Wl4Fwww3plPJujgaqziuJagRLb5leDosI2r2NGgxNZIhtXdKNGut1/PMbZ28zbKo
         4HDN/gUc5asY/rjTYZVRbFfzVrl2IAhX1Lb3wmlcik504PEk2tt5usuXoCYOAmX3LjiF
         F4AON3rjHtQNPJy6UhQWfK55S8MDypQxOzdk3O0I+d/VNg/Y8lhMDFqj41hMqB1pIrfz
         jkqXhtkwjUFMjAMwLFK0ORZ9njc0vywKpIP1TSKYHNnpoORu+Qb1SC4+fCkgYsbvsm/8
         RFNg==
X-Gm-Message-State: AJIora8JiI3YG3Q95YyUg7Pfxnxo+rggTWuq8JEUNSNI14TziUsvIqud
        Tt46HpXXDL9xPDV9JRVcfNp1XAEqobmQHWrJ7nlNyetx57rvhu2ugwiuoKV+tuZuilZGHGIqhnu
        RdVW7BIB26tx8DpysE1I75UALv/LuH5w06chtqnBRnxxmWIVPCj+yKfaLBm3l/SFkowKhWh0Zmg
        ==
X-Received: by 2002:ac8:7fcd:0:b0:31f:393a:7320 with SMTP id b13-20020ac87fcd000000b0031f393a7320mr24100646qtk.11.1659564211887;
        Wed, 03 Aug 2022 15:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFAhcA+0k626uPLuOPLEzIsTH3poxMxYEXMAQWRon6c0dxg1QwQiPtmHA90AdCiQ8qBd4agQ==
X-Received: by 2002:ac8:7fcd:0:b0:31f:393a:7320 with SMTP id b13-20020ac87fcd000000b0031f393a7320mr24100611qtk.11.1659564211595;
        Wed, 03 Aug 2022 15:03:31 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id dm40-20020a05620a1d6800b006a6ab259261sm3598994qkb.29.2022.08.03.15.03.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Aug 2022 15:03:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: [PATCH] mm/smaps: Don't access young/dirty bit if pte unpresent
Date:   Wed,  3 Aug 2022 18:03:29 -0400
Message-Id: <20220803220329.46299-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These bits should only be valid when the ptes are present.  Introducing two
booleans for it and set it to false when !pte_present().

Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries", 2012-05-31)
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9913f3be9fd2..482f91577f8c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
-	bool migration = false;
+	bool migration = false, young = false, dirty = false;
 
 	if (pte_present(*pte)) {
 		page = vm_normal_page(vma, addr, *pte);
+		young = pte_young(*pte);
+		dirty = pte_dirty(*pte);
 	} else if (is_swap_pte(*pte)) {
 		swp_entry_t swpent = pte_to_swp_entry(*pte);
 
@@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
-		      locked, migration);
+	smaps_account(mss, page, false, young, dirty, locked, migration);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.32.0

