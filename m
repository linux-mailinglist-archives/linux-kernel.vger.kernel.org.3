Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A551FCE7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiEIMgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiEIMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97E70284929
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652099558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YyVeP8FyL2hyCQ2N083n40aBu6xoSDc160MDLkcNums=;
        b=D2thnBq4I5ldVx9ixN6WngV4/0NSuy7DLBvTOONjforAiymfCBcWDxYit2EYKnzRx43muF
        zjfvIIMbsz6xeeHvSdWs5pJXe8IDkNgRqrPLWBZLF9qvQjnhxUipu2MO6WCKbyAM6b4y4f
        W0Ndq/+aZ9X9C4yGKwnfBtLHDZjzhVg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-P7URrcIxP8mcowMcXOp81w-1; Mon, 09 May 2022 08:32:37 -0400
X-MC-Unique: P7URrcIxP8mcowMcXOp81w-1
Received: by mail-qt1-f199.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso11943549qtm.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 05:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyVeP8FyL2hyCQ2N083n40aBu6xoSDc160MDLkcNums=;
        b=DuFtbngAGdw8nbrDROjiXNglF8MraQxZcSF7nUS3dvPzr2uv+7cwIfaRURwFnvYg+9
         XBqXshVQ4zHm+gR399sikBtTDM1jzOnuPiG51nrVjEXySW5wrKL1LQtL80+s646wK2WE
         B0omgl2/RVfyyC1iCcENQs6MhIgwQii1iF9qcUCOHsU3OME05qxyr1wqyB0+DqU9oAlK
         ZFaoHZKUgBGvoTPpzDp/x8er8W/NIm0Y/NN+uB7Nv+E7aIfjFhnTYxWY6ebfH3UZpOSC
         zAoYcCCcYgcnpFNuGn0FTZzz1KvaA+PF+PRxK1TUIe4CUCtTOQOl9CMUeA5DyUW17hvt
         R8dQ==
X-Gm-Message-State: AOAM5304D4VsRXNra37+aX5dFg+zozyC6/yPGLcJ8vn1IV+4isYVHPSx
        V16GJ9KL1BM5PUqa+rRdzyaGWEUp6+FWlAQU4jh5iZOzrp9Bm04mF5YC7DSQPpdGUNzUmtoQmLo
        9FpvY3+EwUbISewFyLbByLgqD
X-Received: by 2002:a05:6214:3012:b0:45a:afde:568b with SMTP id ke18-20020a056214301200b0045aafde568bmr12922421qvb.2.1652099556892;
        Mon, 09 May 2022 05:32:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR0DnU583XohtUlCS3huesd3t60jnAeqmFyQSwk+kv9UkI5PNlzULAHfpsImS/2Qvu9b+YRQ==
X-Received: by 2002:a05:6214:3012:b0:45a:afde:568b with SMTP id ke18-20020a056214301200b0045aafde568bmr12922403qvb.2.1652099556686;
        Mon, 09 May 2022 05:32:36 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t134-20020a37aa8c000000b0069fc13ce23bsm6818499qke.108.2022.05.09.05.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:32:36 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hughd@google.com, akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mm/shmem: restore setting of page variable
Date:   Mon,  9 May 2022 08:32:32 -0400
Message-Id: <20220509123232.3428667-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang build fails with
mm/shmem.c:2337:8: error: variable 'page' is uninitialized when used here [-Werror,-Wuninitialized]
  if (!page)
       ^~~~

In the commit listed in the fixes, there was a change to the
from
  page = shmem_alloc_page(..);
to
  page = &shmem_alloc_folio(..)->page;
But in this case, instead of replacing, the setting of page was
deleted.  So restore page with its new api.

Fixes: b0bb08b2d5f3 ("mm/shmem: turn shmem_alloc_page() into shmem_alloc_folio()")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7faaa61ff7fa..a2234f19b711 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2334,6 +2334,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 
 	if (!*pagep) {
 		ret = -ENOMEM;
+		page = &shmem_alloc_folio(gfp, info, pgoff)->page;
 		if (!page)
 			goto out_unacct_blocks;
 
-- 
2.27.0

