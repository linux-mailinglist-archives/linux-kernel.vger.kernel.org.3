Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7352F4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353616AbiETVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353606AbiETVQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:16:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1A186E5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c22so8753253pgu.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QLKDkRDVEEGrLLKtQdSS38U6TUL0EcDbwYp3Or4BIw=;
        b=NYhrj7RyelVXOqRq9pojKSUdPKLFF1GIynVR/ldLf8JQqCX/3ntxNjQlV8L/A0DZMc
         vZ3c2YpPQjeoSfj1bIIeoFSY9OrsZKsihZwdZVL9hNitrGjSLb+nkpG3pDB8zJalWliK
         z7pCIOXi+JA7utglSAMGkRg9wmUgLkKmGLZ45dCi0HvrjH9NyUYg12kTdp+RiMT92spe
         5kAh9NdQ+7XItGxLIKc7LOvbW3UGvk3GT6Y2UnsuvKQVidxG9rsjG8OvEtzQi7RQ64/R
         vKvAj2RGL5JUkp3/a7pW0lPJ3ubI9yqBORm5hJxGErWGBNVxb5CSgIczrHxiy0pRnpBs
         0HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QLKDkRDVEEGrLLKtQdSS38U6TUL0EcDbwYp3Or4BIw=;
        b=aOHY9qlxDkh4I9ixQEMqNyF4/8UDVL/olVvPV5IJJwfAiqFKWbdZuqIL5ynV4u/13E
         xDt0d522Zi4eN/T72ObfSWKIR/eM53sOqGwn5t9PGywYsKX2Dzc6e6Brjbb4uXo9PcGe
         0kzOOTtaJgSiGE0CNeStjs4neABZ7/7YUHWaL7G9A7LpgSkXD6m6zOtfIf/yO5BCP0IW
         OaExYXTGAgyVOfS13NX0lzFcEToF2miFw2AbdMytvCehv/79bZNiK6FSRur1sAwY1HGK
         LSxt1gGfpky04rWSKdYU6Pi+sPKaXn40/fPh0RFIXw5T/JRyRlPWC2xMcRlZReQ/oh3+
         MQDw==
X-Gm-Message-State: AOAM533OcwedY/qMKbl6tpl8yxTiIHMsAa4X5WIBW9URunb5/nZPL7cx
        O9SG3zYlZzL2fWgXQ8zBL3c=
X-Google-Smtp-Source: ABdhPJzjqV91/dbDxBd+KTR/6WHbquHR0Y+DY4HXucFpGAZnlfdhBfKsWiMXYk3Dbuqk5G7NZrTGMQ==
X-Received: by 2002:a05:6a00:1251:b0:50d:f2c2:7f4e with SMTP id u17-20020a056a00125100b0050df2c27f4emr11912367pfi.72.1653081373606;
        Fri, 20 May 2022 14:16:13 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b0015e8d4eb2c2sm167620pll.268.2022.05.20.14.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 14:16:12 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mm: khugepaged: check THP flag in hugepage_vma_check()
Date:   Fri, 20 May 2022 14:15:59 -0700
Message-Id: <20220520211605.51473-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220520211605.51473-1-shy828301@gmail.com>
References: <20220520211605.51473-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the THP flag check in hugepage_vma_check() will fallthrough if
the flag is NEVER and VM_HUGEPAGE is set.  This is not a problem for now
since all the callers have the flag checked before or can't be invoked if
the flag is NEVER.

However, the following patch will call hugepage_vma_check() in more
places, for example, page fault, so this flag must be checked in
hugepge_vma_check().

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 637bfecd6bf5..92e91c08d96a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -458,6 +458,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
+	if (!khugepaged_enabled())
+		return false;
+
 	/* THP settings require madvise. */
 	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
 		return false;
-- 
2.26.3

