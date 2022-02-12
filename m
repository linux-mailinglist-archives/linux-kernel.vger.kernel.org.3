Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965D14B3389
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 08:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiBLHLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 02:11:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiBLHLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 02:11:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80572716D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 23:11:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso14057278pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 23:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJWv4+1FQbvdMw4wXNISW5YNlFR3GL+Z3R6+p6cC0cc=;
        b=lBgkmU2opob3nAv4YJBAi7Ijhve5HmiVL/lIxW0/7P6OzFU0/Mh7ex2JlOG8luGs9H
         vpjykZkjt7W94Ni7KqUspWHtN0L5VfYJUQ6phxdGKl9TOmkLonCs/8g3SxsKgxnXkgg/
         98AuFJIy06P4vmrsYPVECQD6zZr2m0qsGsckeq7Gm07FVolyL+RUyS+S7sZO//Mogi0I
         c7NLtPpNMxJPNtdtESHGMhmKK1WUwjRkY+w+bo3Muco4+Uqmh5sgxfbAqEVlDOKbhPHq
         un2XdxIQXPyIezyPpk0phRyLImFAy8rDceBn5Mzvr3Hk1YuuCGpDpNYxuxOi5/HeyHDR
         vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJWv4+1FQbvdMw4wXNISW5YNlFR3GL+Z3R6+p6cC0cc=;
        b=Fk67viQ2vSaorYImRLXEhu9e/JgtPU78xtgqMTWsu2J6CkkdP4EWPuAtrZEneHK7Fm
         Pv6KAKPyfzu7Ri2KTrX7sgbN2Hx2JUwz6gwg4xgOJxos7/athv7rXsU8Xy0TQd2Te6gb
         qpPdp9Bo3DJRYZTHJHiw1PqevSK8rnTpbZeWfkwsKQ32kpod7j5MlE8caqz1zfdQI31y
         /azlOMK9U27ACq/l6k0nf8lpU5uuhY0pS26h6T8plHZgOwQUs/B5dlTzDs4WkwPwD2XP
         nJmeMfqnLj1Zfa5Ys34slq9pMMqRJ3C+GEcBLg/WZ03Yd2CFmIUI/CXdF9HXmILsv7Z9
         ucMg==
X-Gm-Message-State: AOAM533O2AfYO5S7QX60hVgMDabcw+pxHPSwLX7CGPPpIGJD+zsrpC/I
        C7PSmYjWp0ixbWt0L1tqAXE=
X-Google-Smtp-Source: ABdhPJwTA48YczQpfo6bhiUx1wcqZqvTgPvQut2lcZVm/LMuAOj6LdjJVrgHXf106G9P5rpFlGKCZQ==
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr4015192pjb.62.1644649895097;
        Fri, 11 Feb 2022 23:11:35 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id l14sm7773309pjf.1.2022.02.11.23.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 23:11:34 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] dax: make sure inodes are flushed before destroy cache
Date:   Fri, 11 Feb 2022 23:11:11 -0800
Message-Id: <20220212071111.148575-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
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

A bug can be triggered by following command

$ modprobe nd_pmem && modprobe -r nd_pmem

[   10.060014] BUG dax_cache (Not tainted): Objects remaining in dax_cache on __kmem_cache_shutdown()
[   10.060938] Slab 0x0000000085b729ac objects=9 used=1 fp=0x000000004f5ae469 flags=0x200000000010200(slab|head|node)
[   10.062433] Call Trace:
[   10.062673]  dump_stack_lvl+0x34/0x44
[   10.062865]  slab_err+0x90/0xd0
[   10.063619]  __kmem_cache_shutdown+0x13b/0x2f0
[   10.063848]  kmem_cache_destroy+0x4a/0x110
[   10.064058]  __x64_sys_delete_module+0x265/0x300

This is caused by dax_fs_exit() not flushing inodes before destroy cache.
To fix this issue, call rcu_barrier() before destroy cache.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/dax/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e3029389d809..6bd565fe2e63 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -476,6 +476,7 @@ static int dax_fs_init(void)
 static void dax_fs_exit(void)
 {
 	kern_unmount(dax_mnt);
+	rcu_barrier();
 	kmem_cache_destroy(dax_cache);
 }
 
-- 
2.25.1

