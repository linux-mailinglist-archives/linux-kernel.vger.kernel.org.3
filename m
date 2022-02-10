Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC04B0DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbiBJMhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiBJMhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB5DF5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:48 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x15so7547782pfr.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGvpK6UTEMeGdDCg9a68QTimGRB3Wg5V4hLO/H8ovOk=;
        b=8R2KQc0VHwfvgfFLuPp0xcs/i0bFi3ZpoOvzA4bg66nMtTPqQzqxTX+Hj1tWbZt+HU
         01u5lq16jDHas70gMpnZO5BBiMuTF+W5pva0r6kivMj+a2RM3QWGQAUXznhUqBxpKPkf
         Vv/Tu1P5u0Zi/cQioKebx7XyAGlUXUXMibP1SqIBSj3UGsVQaJUelPy5p4+rwTHdnNhy
         imoRrsXIOlM97bvi9gNvPrSM9JSeP4ZkPvsAYpxNIA9hXjYHh50pMLoZIGcA0ttGpuMA
         Y/Xsnao5EZKEuqby/5+bnXTVOdcLa1PFjq8mBuhVnryqOZu7iQRstCzev9b3DNb+X1dy
         uUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGvpK6UTEMeGdDCg9a68QTimGRB3Wg5V4hLO/H8ovOk=;
        b=I8gk0jyGWPahOJo5fSOK72IWtfoKYVLUeDjoaT5p6u5E/Y3ZAl0V+0N891Ukjkmudd
         mRByGzFkLm+m1oCyc4CGBZ97TTPD35a1pSdoEoHOl5PUKIhUX3ha35d8DEfONrtV4QSg
         4xqCAG/2af44cOrwo6WxhmoXWMEfG2jTA+NI4bYlQmYmwqeh+OxhIwiJNxFwPCt9DezB
         gtXMsYuR9QdmONLaiya4MEF6l8j3mFhanVvrs70NXR4dtObOAQmQ74+Eau50b+gf427h
         fH19UEkboW+mdINrCu1rXO6VyeBuXSgVX+C+nODwVQsJo7B86AuXMlo0wxv+oCg2Gcq6
         GNMA==
X-Gm-Message-State: AOAM530NmLw1DhSP/KRcTdw9EkWu+Y5RiKXtja00VMn+LdyFQDyJPyCG
        jy8OLnlPYP5pBPNWTkYropToJA==
X-Google-Smtp-Source: ABdhPJxuA+mcAk8N3GxFOFt4YcmS2sQMINZgJ8h6aEo3yg4idUSXIkOyJ07Dtpti42YAT/Z5DU8wrQ==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr6120150pgb.490.1644496668324;
        Thu, 10 Feb 2022 04:37:48 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:48 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 6/7] mm: userfaultfd: fix missing cache flush in mcopy_atomic_pte() and __mcopy_atomic()
Date:   Thu, 10 Feb 2022 20:30:57 +0800
Message-Id: <20220210123058.79206-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220210123058.79206-1-songmuchun@bytedance.com>
References: <20220210123058.79206-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userfaultfd calls mcopy_atomic_pte() and __mcopy_atomic() which do not
do any cache flushing for the target page.  Then the target page will be
mapped to the user space with a different address (user address), which might
have an alias issue with the kernel address used to copy the data from the
user to.  Fix this by insert flush_dcache_page() after copy_from_user()
succeeds.

Fixes: b6ebaedb4cb1 ("userfaultfd: avoid mmap_sem read recursion in mcopy_atomic")
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0780c2a57ff1..6ccc534d1c1c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -150,6 +150,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 			/* don't free the page */
 			goto out;
 		}
+
+		flush_dcache_page(page);
 	} else {
 		page = *pagep;
 		*pagep = NULL;
@@ -625,6 +627,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 				err = -EFAULT;
 				goto out;
 			}
+			flush_dcache_page(page);
 			goto retry;
 		} else
 			BUG_ON(page);
-- 
2.11.0

