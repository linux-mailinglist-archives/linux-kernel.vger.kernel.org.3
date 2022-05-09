Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3151FCEF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiEIMfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiEIMf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45A792272D5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652099493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gEOVNDDSpKASfNP7Ge49MOGYJd/s6CThQbdN++TPQOc=;
        b=JV63pFwvlWq75hR4cQ+2Dplc+kc+vpmaMp80blhV8/CXGdIzPjtngs8Y9b900GVxxvY/jl
        JxYf+ZTrGbcls0V/FynJ45A1jZGSkn/1znhfvMUmDmWFE7A7ugjG4l4susr6+w5CqwFrYu
        dGNjgZqnC7sW3v1JLtw3zDrGJ5npHD4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-Iw6AIhJRPJOU1dsfsik8cg-1; Mon, 09 May 2022 08:31:32 -0400
X-MC-Unique: Iw6AIhJRPJOU1dsfsik8cg-1
Received: by mail-qv1-f69.google.com with SMTP id da15-20020a05621408cf00b0045b00b9eab4so3711922qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 05:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEOVNDDSpKASfNP7Ge49MOGYJd/s6CThQbdN++TPQOc=;
        b=ylvrf6LkHX8R9ykNEtZYJGP5njW09Hgtq7w3n8T/f4chRunw2S8JcFv9lEfPlGZL0W
         O0EHosxBZbITBm9j/aKiiV8ulWWxiirRwrXFpAzB6vKeL4CPlYVt6LOrWf6v6aPIm2jL
         Wx6NiPabDxCMsYLkuWQGzzkw51mhfe4PQ7B3yvquPmsM1V8XnVUBiD3bRwbCBQJeqwJf
         7c/i6J7Kgqf2Z+v9AbFscllF/bMjD9Ce8uhJqguSVmI+MkS1vwHvHfx98mEpwUUVsNwZ
         P2fC/ja3bjASD56sAaJ9ynfFxSPsWQhwJUH4JvZxuaquv47eX0k4ouBvof04TcyDXhjc
         fDJw==
X-Gm-Message-State: AOAM530Y0zvtgLo6TDjL7X5AbpjOo1ApzRVgtOo2+yR9a30vwimEQPau
        3ypVWUYAccu3S4KAGAX9hnx95G2kKbfjEWE7I3NP3tUCnwS/6zwDx3z5Lsmjm5VmAFa3ik4UDAV
        Uy85Qaq5NFtccX5N+cTLLZ+Vd
X-Received: by 2002:ac8:5954:0:b0:2f3:7d71:869e with SMTP id 20-20020ac85954000000b002f37d71869emr14705070qtz.183.1652099491278;
        Mon, 09 May 2022 05:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxHsEqi5MAo7TiJ6W+7CBlLKlZqhZAzL8aK4UMWuppI0cXur/TKjXyNde7+COugsYcZctc+w==
X-Received: by 2002:ac8:5954:0:b0:2f3:7d71:869e with SMTP id 20-20020ac85954000000b002f37d71869emr14705046qtz.183.1652099491002;
        Mon, 09 May 2022 05:31:31 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o27-20020a05620a15db00b0069fc13ce203sm6736097qkm.52.2022.05.09.05.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:31:30 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hughd@google.com, akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mm/shmem: initialize folio to NULL
Date:   Mon,  9 May 2022 08:31:16 -0400
Message-Id: <20220509123116.3169267-1-trix@redhat.com>
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
mm/shmem.c:1704:7: error: variable 'folio' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  if (!page) {
       ^~~~~
The error handler for !page jumps to an if-check for an unset folio.
So initialize folio to NULL.

Fixes: 2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
Signed-off-by: Tom Rix <trix@redhat.com>
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
2.27.0

