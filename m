Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7C51A0D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbiEDN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiEDN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:26:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99E45510;
        Wed,  4 May 2022 06:21:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso1199159wmq.1;
        Wed, 04 May 2022 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bIzJlgmOg9YiKbOpYW/F57m78adXKAVkRe+KXRci2bg=;
        b=j3V/s2IRf9hFGeuzK9juEkMCXHJ1cbZDrP7Ql2RiQJeM8R0ebx1Yr8EC7SHGJNp13J
         JfwmCunK/UWZdcN1W6CibqOX9t1P6GPh9LbrYQzvMO8HpQZqJ/ZdTXMs5wOd4353Q7+5
         5w/AqtUqsoEgevgEh6zxncr0OMzKE1wBm+HoWj6XU82kYnvMIOaCHpTWx8pWs4+rW5pV
         Jn4oaGewWU51/7QX0FtxVGnTfxqfhHd5eGaJE4NUSGA9Gm+J7/tifdqBSxlNDzT+DFUC
         uYBvMfRM8UMxg8qaTexzL3Sj+Tv2eh0XXfq1SAbHJld0IjuMMYjb6799gDAKZkiv7LMz
         b6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bIzJlgmOg9YiKbOpYW/F57m78adXKAVkRe+KXRci2bg=;
        b=piENUAoFPGbUOUJTycIvszIRW2iQA7wgXxAR/pm/Iu3MpCVySIqu0UvIpeOIzLffk/
         oKtszS8GjIL+g29itfKgKkaCfRVjJEuEF9YdDs1fiitWF8Z+ZlyhX66ex1qrL9qPUre0
         Vm4N2MxNt4E42rMdXuHXw9vSU7+OcZ5YgEdSILL2DDRhLVuJ5SIkkpAaN6sCrbkOm2a0
         A3FjfEh+aFkusYqSbRlnay9rOjdah2Ewf/slcqlun7X9X8ImsduaVqfS9S+ML1jlKb9A
         mXvoZ8OBiuERfo84bkwqRwXKnkoRiE5qFAZ/EFbtrlqHK7kZDfcJvThvxd6HTmM8kORu
         hQPg==
X-Gm-Message-State: AOAM5339ArE2yopuE8RGsTlWVUSj3Hkrok6tA+fquAbyi/3TuKGjUXhP
        gG0UW215E9/wWqy7xzoKOK4=
X-Google-Smtp-Source: ABdhPJzJN6G23D8uMob63DnbbeBf1pop4Zafvwcca/FweJhoFEf7s5Blf1jwse+83kfTgVRfuwAysw==
X-Received: by 2002:a7b:c186:0:b0:394:bed:e0cf with SMTP id y6-20020a7bc186000000b003940bede0cfmr7578863wmi.162.1651670497066;
        Wed, 04 May 2022 06:21:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b00394615cf468sm369401wml.28.2022.05.04.06.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:21:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH][next] mm/shmem: Fix check on uninitialized pointer 'folio'
Date:   Wed,  4 May 2022 14:21:35 +0100
Message-Id: <20220504132135.229601-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

In the case where shmem_swapin returns null, the jump to the error return
path via label 'failed' will end up with the uninitialized pointer folio
being null checked a few statements later. Fix this by ensuring folio is
initialized to null.

Detected by clang scan:
mm/shmem.c:1704:7: warning: variable 'folio' is used uninitialized
whenever 'if' condition is true [-Wsometimes-uninitialized]

Fixes: 2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 107f1e4dd0aa..7faaa61ff7fa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1682,7 +1682,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct page *page;
-	struct folio *folio;
+	struct folio *folio = NULL;
 	swp_entry_t swap;
 	int error;
 
-- 
2.35.1

