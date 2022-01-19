Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7005549323E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350631AbiASBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350625AbiASBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:21:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CDEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:21:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a5so996649pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OvyGOIk3qoZc/SMHBDXTbJ3GLngZKOnDGVStpr5hHTo=;
        b=k5sSR4jfneG9GyQNvw3gViTRq7zruzJwjGwN9dPWvF6JxApZsVZdIs4xJKGBMzs9zE
         VT90XUSyDqNF2duMambNQoML34MfdJYJEsIdcfaTFLNKpOyxg2PAugKv6DoBFGJPOs/C
         3WRCzywJqNRAXecxI8xlixNzAtVHNEm0mFhtjL6NKmhRuHIaVtjuB5CfW25tKNXtWuGc
         4ZNUWmAqeUwx24d5hUU5hAWSgMKioAFRCMcA9Ahc26sUTp1VnRYD/UjNp2gYm4UaZsrD
         35O3tnw2z7hRs9tjZEsuMoXQenhaVZEO9Dw7X7pyBExsjUk46AFMM2aoJVV7ysDVScb1
         Ivyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OvyGOIk3qoZc/SMHBDXTbJ3GLngZKOnDGVStpr5hHTo=;
        b=GwofcH/yevEZd0OF7KAAeGhsr2raeISb2V3Y+8ABrtN1eEDIJf5L804KFnz/Yn5tdw
         qnHIaEi9Vt1Y4pHhdsClW04R+tNrFiPbpJcdTed9XgdllOPd3ZI12RzLPeuCRKxJCc16
         BGBWlsUoyPYThpabnVF00/Xuwm6dyB8Kl1k7yjhx5KC4bxvocM1I8DFQVS5/EWScJCtf
         e8ntDx+IYw87HlKxTVtE+RMH9KMYlT18npd8h6nZgetJ0kAmN6wuFg7m11RaPijQUuIK
         MjP+FvTG88sFVpb82hGOaNVoHX9ARnKQvxiyQNsejiamDOCd47G9GMYq8Cqcjayo7pno
         op6A==
X-Gm-Message-State: AOAM531mkNbxqS/BeCogGP6Y8XH/kk40E73Ui9yQeWSyW5rGmmMyKzwg
        lC/f8arz0lfW0ZvB1lQWZLw=
X-Google-Smtp-Source: ABdhPJwlgOaGkDW/htbDV7Ii8N1D21oQGFHjKAzpx671/y8exjCTt4K+oFxMvz6rzbReXfPm4j6eNQ==
X-Received: by 2002:a05:6a00:21c2:b0:4bc:fb2d:4b6f with SMTP id t2-20020a056a0021c200b004bcfb2d4b6fmr28112341pfj.62.1642555274457;
        Tue, 18 Jan 2022 17:21:14 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f185sm12462961pfg.159.2022.01.18.17.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:21:13 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2] vmap(): don't allow invalid pages
Date:   Tue, 18 Jan 2022 17:21:09 -0800
Message-Id: <20220119012109.551931-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap() takes struct page *pages as one of arguments, and user may provide
an invalid pointer which would lead to data abort at address translation
later.

Currently, kernel checks the pages against NULL. In my case, however, the
address was not NULL, and was big enough so that the hardware generated
Address Size Abort on arm64.

Interestingly, this abort happens even if copy_from_kernel_nofault() is
used, which is quite inconvenient for debugging purposes. 

This patch adds a pfn_valid() check into vmap() path, so that invalid
mapping will not be created.

RFC: https://lkml.org/lkml/2022/1/18/815
v1:  https://lkml.org/lkml/2022/1/18/1026
v2:  Patch description changed.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..a4134ee56b10 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			return -EBUSY;
 		if (WARN_ON(!page))
 			return -ENOMEM;
+		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
+			return -EINVAL;
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
-- 
2.30.2

