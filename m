Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4E4BE0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356035AbiBULSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:18:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355944AbiBULPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:18 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFBB29
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x11so12577214pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0dsHEkkjYMDgDk/stCFwxaKiFUsmcZuEuqNP0XmmQ4=;
        b=KQWzIh6iHJeXbHTKWVjQ9D41ZTsqUYpa1zh7KmZnFyY8LTHgMsfbPldAhLtHRazhbF
         iyJ2tHidCoinbQysLDxGZ/K9/DSJmfxe+VR28huzDlGIgyZNW+M5fJNFDxTodOZuIoA7
         o7F6WpsjI5aJlu4Ixla5LTpCWx4oKE+SVEbaMjEJ5oCbRqmSAMywCddBpedDxZMcmznC
         SVjT2Eo3CdxQkHjEG5HCPm/iUKUF3BBORX0eRVMh+8DzOq+ZkzsconTuqcuubqDFfL+/
         jZ0iM1Zi/NHOm+Fds1x1RfGt0SNXPgriZU6gQGSCT6GfnJbKY/HC8BJLP00wkdC/Rl0g
         uHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0dsHEkkjYMDgDk/stCFwxaKiFUsmcZuEuqNP0XmmQ4=;
        b=IQH/uI2Zr4b2PSa/D23QtNSG321LHfEhp40CV+XjRYKgD+bRF7viI/2m+xPsg21WDY
         LPtrKl1zBHpbCMDsC/g6eVUYKmDhfTunu20CryUUkSvgxJJuB6482bV5puLnz0BB8aj/
         WSxffEBF4zExp29vnbkx6dzjPfpxypIWHUjGYgJjrEsQlaXLP3VqYoJHSZ533F1iUHb1
         GFhUjteH66pPe/ynf1LhnrfLvIfTd++B2Wqw5+8W9lNKDLrp5pBvTJZewqRQLSklo7Yp
         j0CkutvGxkgdTcKg48fjz71ZleDqc1Vyvx+T6BfoS+XpsFrtzs14UpJ31VOx8iNxbtzA
         FA/w==
X-Gm-Message-State: AOAM532JWxYDUWaxlmgvOqqLFKNMQSO84ngdyeNaTwN3jJJ5IL5x5OEQ
        XxNRsZVRBVfAtvdkjYwH05Q=
X-Google-Smtp-Source: ABdhPJykGrMP/3jkaSti52P2kS6FzFtdySBLx2jd5Kbdy9BLiESNB++I0iuWS6uFkrxzJj+Drnww5g==
X-Received: by 2002:a17:90b:1c83:b0:1b9:caa:8230 with SMTP id oo3-20020a17090b1c8300b001b90caa8230mr25247369pjb.26.1645440841051;
        Mon, 21 Feb 2022 02:54:01 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id u6sm2214725pfk.203.2022.02.21.02.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:54:00 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 2/5] mm/sl[auo]b: Do not export __ksize()
Date:   Mon, 21 Feb 2022 10:53:33 +0000
Message-Id: <20220221105336.522086-3-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220221105336.522086-1-42.hyeyoo@gmail.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not export __ksize(). Only kasan calls __ksize() directly.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab_common.c | 1 -
 mm/slob.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 488997db0d97..f2c021b57579 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1271,7 +1271,6 @@ size_t __ksize(const void *object)
 
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
-EXPORT_SYMBOL(__ksize);
 #endif
 
 /**
diff --git a/mm/slob.c b/mm/slob.c
index 60c5842215f1..d8af6c54f133 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -588,7 +588,6 @@ size_t __ksize(const void *block)
 	m = (unsigned int *)(block - align);
 	return SLOB_UNITS(*m) * SLOB_UNIT;
 }
-EXPORT_SYMBOL(__ksize);
 
 int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 {
-- 
2.33.1

