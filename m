Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7B84B0DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiBJMhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiBJMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991E10A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z17so1694124plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKpVSiHHtaj87FMK/TeB9fab8FVNXtwv8Xc4GuIj/Kg=;
        b=fQy8vfqpU9cS9VF0UkKIV2NNCg0tQEdPXZgAQyveKt+IqZMhPhSLL2L91pt18Zg06N
         vNvRvBopSQe6m1BOl262fpfSHiT8PTxbkyLfR2s8UUCSsGqv6jhJr5tF046QxWGKPvQ4
         j1luq5AgDAl2iOiKPsSWugj44vi8gpSPdoJjaafW25tBKv8lpwq+uDQF3SBoV0mX0uWh
         oeE64v4w2/BhLSM2qEBvn2JtkZhtGWhP1r03BRWqGEilJv2WHtsOlbBI0BeMeSkYlft6
         BtL8Es/U26EonkHfhoxdHnW89rwm0do83Rj77+xgClJ16smYtj669p2PtIeIaa0K/Otd
         MINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKpVSiHHtaj87FMK/TeB9fab8FVNXtwv8Xc4GuIj/Kg=;
        b=yoVEf88DcTJ74cz4vt9x/l0d1MkyWPRwFuAnMKI8qb59kYUSSeMtP+fk/P32/or5TG
         eeYu7wMWDX8KXSUBg+2p66VWgcZ5XUKJzPuIysaqxwNpPCpqTs8QeEEb/hvV9xA7gQVL
         fqHSFe27jbB/dTNpiHlBWOLxcegKhQku/+aCu6xLL4LhwtEV9DrEMeMMrCvIaRKyC7ID
         Sq34f8vVywI1BV7IzYx6WfkSwqchPkW2/2H0c2lXve9jrrKcWSHsjM8MN5g3t/nNjTJp
         pryMSaR9fwYj07LxEvbU3fwp/yF9BO/iqD7nYOmzgQ3YpI8oNqr44NzvsRze3YPRUHBL
         MSWQ==
X-Gm-Message-State: AOAM533BI3X79YgxEATOWj2I7Wum7v749AFzWOTDZdT5ZsYy7e9mJcF4
        vaW9lxqfuOciOFxXBK1IOCgFFQ==
X-Google-Smtp-Source: ABdhPJyGp2GsZvSDMqpR5iLkDxZjE53dEk3dm5rB0VkaJA74+KantoyMJ9LJ6pDdNdp3d3NZ3dXk6A==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr2638965pjb.2.1644496663463;
        Thu, 10 Feb 2022 04:37:43 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:43 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 5/7] mm: shmem: fix missing cache flush in shmem_mfill_atomic_pte()
Date:   Thu, 10 Feb 2022 20:30:56 +0800
Message-Id: <20220210123058.79206-6-songmuchun@bytedance.com>
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

The userfaultfd calls shmem_mfill_atomic_pte() which does not do any
cache flushing for the target page.  Then the target page will be mapped
to the user space with a different address (user address), which might
have an alias issue with the kernel address used to copy the data from the
user to.  Insert flush_dcache_page() in non-zero-page case.  And replace
clear_highpage() with clear_user_highpage() which already considers
the cache maintenance.

Fixes: 8d1039634206 ("userfaultfd: shmem: add shmem_mfill_zeropage_pte for userfaultfd support")
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/shmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index eb0fd9001130..2e17ec9231a2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2371,8 +2371,10 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				/* don't free the page */
 				goto out_unacct_blocks;
 			}
+
+			flush_dcache_page(page);
 		} else {		/* ZEROPAGE */
-			clear_highpage(page);
+			clear_user_highpage(page, dst_addr);
 		}
 	} else {
 		page = *pagep;
-- 
2.11.0

