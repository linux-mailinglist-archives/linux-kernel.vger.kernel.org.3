Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B997C528BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbiEPRNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbiEPRNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:13:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A6832044
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:13:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t14-20020a1709028c8e00b0015cf7e541feso8327433plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=BkxFs5g1qHthSeWFrePkH1QG+J6aKzpMAVQJiVuFFy0=;
        b=Ux8p5mjSfdEF8/qXvqToIgfPYTMGeSNmiUns1+Eb0yBZkxK6/QPlxdqgH4zKeg3wsG
         f7OZb33FwyhkU0V7zTKU4LSwif+XVlKDtHIpoTGwrzVGsr+248pDzVPlDoQ3Q7S8ssQ7
         lou9e8Ztd/VwVlEOBXk/QR8CVl3Q43/Zei/zHQoF1JrOcBTf13eqa4gMu6k9UxP97uKg
         eozshW0N0nAH+pO71/tmIjfCjIwKLyyLgmrxBTwpPvJQ+WBfYT4cRnlbWwgGEkDLENkZ
         e2kXNTYxtJPFnB1etcyG3sgm1ExkbhOw5urHMR0khU1dgVNFr9uQvoQOZmgs9RmO6dlH
         l1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=BkxFs5g1qHthSeWFrePkH1QG+J6aKzpMAVQJiVuFFy0=;
        b=N6vJZRdwAo+eVJ3WOGvcZ+WBMjqsx0HjcJ0bGaQNQIhV3EqpYS9RzYaw+Cxhcbgwqm
         3Jl+wSYXLngKLea1s+5iIBP1nrd5GhH0MtE/MS2Z51izBdzU2jGR/wQiWq8H5Ap+5x4Z
         G7FCBLKQ2fTcoKQ1Psg/csVt42IyNdVDiHExl7wvXCSXVEdyjRF4H49eDBP3gVQhsyRU
         pNBwBdz+8+gLscnmRhicpeCb5GOe7YuIJM7rE8r22At15BF0/XZVE/gjDnbPjnlNYmOr
         GILFuYwy6gaoC9Yg478zISNaJ1bvSrg3FtguoPboVn9lbpA4Y2c2VNe8njBMdlge2ryu
         c/Rg==
X-Gm-Message-State: AOAM531XIjAQwNdM348/KQiJYmWQWzYXE8P6bfVx1754Ina4NpAXEWKm
        n92l3sHTDP2r64oJPnWfMAUSRhQEHp5eCo4=
X-Google-Smtp-Source: ABdhPJyPjKo1eQFHBLHJH6P4Mxk85QYIhhyhsHtKoWV418NVqX0hkw6JvORFy5M+l/4akC4PG6mHy3tzQZlSKeY=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a17:90b:38c4:b0:1dc:6b64:3171 with SMTP
 id nn4-20020a17090b38c400b001dc6b643171mr32420547pjb.168.1652721201871; Mon,
 16 May 2022 10:13:21 -0700 (PDT)
Date:   Mon, 16 May 2022 17:13:15 +0000
Message-Id: <20220516171315.2400578-1-tjmercier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2] dma-buf: Move sysfs work out of DMA-BUF export path
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, surenb@google.com, kaleshsingh@google.com,
        minchan@google.com, gregkh@google.com, jstultz@google.com,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-team@android.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, we noticed an issue where a process went into direct reclaim
while holding the kernfs rw semaphore for sysfs in write (exclusive)
mode. This caused processes who were doing DMA-BUF exports and releases
to go into uninterruptible sleep since they needed to acquire the same
semaphore for the DMA-BUF sysfs entry creation/deletion. In order to avoid
blocking DMA-BUF export for an indeterminate amount of time while
another process is holding the sysfs rw semaphore in exclusive mode,
this patch moves the per-buffer sysfs file creation to the default work
queue. Note that this can lead to a short-term inaccuracy in the dmabuf
sysfs statistics, but this is a tradeoff to prevent the hot path from
being blocked. A work_struct is added to dma_buf to achieve this, but as
it is unioned with the kobject in the sysfs_entry, dma_buf does not
increase in size.

Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF stats in=
 sysfs")
Originally-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
See the originally submitted patch by Hridya Valsaraju here:
https://lkml.org/lkml/2022/1/4/1066

v2 changes:
- Defer only sysfs creation instead of creation and teardown per
Christian K=C3=B6nig

- Use a work queue instead of a kthread for deferred work per
Christian K=C3=B6nig
---
 drivers/dma-buf/dma-buf-sysfs-stats.c | 56 ++++++++++++++++++++-------
 include/linux/dma-buf.h               | 14 ++++++-
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-bu=
f-sysfs-stats.c
index 2bba0babcb62..67b0a298291c 100644
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
@@ -11,6 +11,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/workqueue.h>
=20
 #include "dma-buf-sysfs-stats.h"
=20
@@ -168,10 +169,46 @@ void dma_buf_uninit_sysfs_statistics(void)
 	kset_unregister(dma_buf_stats_kset);
 }
=20
+static void sysfs_add_workfn(struct work_struct *work)
+{
+	struct dma_buf_sysfs_entry *sysfs_entry =3D
+		container_of(work, struct dma_buf_sysfs_entry, sysfs_add_work);
+	struct dma_buf *dmabuf =3D sysfs_entry->dmabuf;
+
+	/*
+	 * A dmabuf is ref-counted via its file member. If this handler holds the=
 only
+	 * reference to the dmabuf, there is no need for sysfs kobject creation. =
This is an
+	 * optimization and a race; when the reference count drops to 1 immediate=
ly after
+	 * this check it is not harmful as the sysfs entry will still get cleaned=
 up in
+	 * dma_buf_stats_teardown, which won't get called until the final dmabuf =
reference
+	 * is released, and that can't happen until the end of this function.
+	 */
+	if (file_count(dmabuf->file) > 1) {
+		/*
+		 * kobject_init_and_add expects kobject to be zero-filled, but we have p=
opulated it
+		 * (the sysfs_add_work union member) to trigger this work function.
+		 */
+		memset(&dmabuf->sysfs_entry->kobj, 0, sizeof(dmabuf->sysfs_entry->kobj))=
;
+		dmabuf->sysfs_entry->kobj.kset =3D dma_buf_per_buffer_stats_kset;
+		if (kobject_init_and_add(&dmabuf->sysfs_entry->kobj, &dma_buf_ktype, NUL=
L,
+						"%lu", file_inode(dmabuf->file)->i_ino)) {
+			kobject_put(&dmabuf->sysfs_entry->kobj);
+			dmabuf->sysfs_entry =3D NULL;
+		}
+	} else {
+		/*
+		 * Free the sysfs_entry and reset the pointer so dma_buf_stats_teardown =
doesn't
+		 * attempt to operate on it.
+		 */
+		kfree(dmabuf->sysfs_entry);
+		dmabuf->sysfs_entry =3D NULL;
+	}
+	dma_buf_put(dmabuf);
+}
+
 int dma_buf_stats_setup(struct dma_buf *dmabuf)
 {
 	struct dma_buf_sysfs_entry *sysfs_entry;
-	int ret;
=20
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
@@ -181,25 +218,16 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
 		return -EINVAL;
 	}
=20
-	sysfs_entry =3D kzalloc(sizeof(struct dma_buf_sysfs_entry), GFP_KERNEL);
+	sysfs_entry =3D kmalloc(sizeof(struct dma_buf_sysfs_entry), GFP_KERNEL);
 	if (!sysfs_entry)
 		return -ENOMEM;
=20
-	sysfs_entry->kobj.kset =3D dma_buf_per_buffer_stats_kset;
 	sysfs_entry->dmabuf =3D dmabuf;
-
 	dmabuf->sysfs_entry =3D sysfs_entry;
=20
-	/* create the directory for buffer stats */
-	ret =3D kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, NULL,
-				   "%lu", file_inode(dmabuf->file)->i_ino);
-	if (ret)
-		goto err_sysfs_dmabuf;
+	INIT_WORK(&dmabuf->sysfs_entry->sysfs_add_work, sysfs_add_workfn);
+	get_dma_buf(dmabuf); /* This reference will be dropped in sysfs_add_workf=
n. */
+	schedule_work(&dmabuf->sysfs_entry->sysfs_add_work);
=20
 	return 0;
-
-err_sysfs_dmabuf:
-	kobject_put(&sysfs_entry->kobj);
-	dmabuf->sysfs_entry =3D NULL;
-	return ret;
 }
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 2097760e8e95..0200caa3c515 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
=20
 struct device;
 struct dma_buf;
@@ -365,7 +366,7 @@ struct dma_buf {
 	 */
 	const char *name;
=20
-	/** @name_lock: Spinlock to protect name acces for read access. */
+	/** @name_lock: Spinlock to protect name access for read access. */
 	spinlock_t name_lock;
=20
 	/**
@@ -441,6 +442,7 @@ struct dma_buf {
=20
 		__poll_t active;
 	} cb_in, cb_out;
+
 #ifdef CONFIG_DMABUF_SYSFS_STATS
 	/**
 	 * @sysfs_entry:
@@ -449,7 +451,15 @@ struct dma_buf {
 	 * `DMA-BUF statistics`_ for the uapi this enables.
 	 */
 	struct dma_buf_sysfs_entry {
-		struct kobject kobj;
+		union {
+			struct kobject kobj;
+
+			/** @sysfs_add_work:
+			 *
+			 * For deferred sysfs kobject creation using a workqueue.
+			 */
+			struct work_struct sysfs_add_work;
+		};
 		struct dma_buf *dmabuf;
 	} *sysfs_entry;
 #endif
--=20
2.36.0.550.gb090851708-goog

