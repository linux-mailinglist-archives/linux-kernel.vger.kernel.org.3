Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102D4E8CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 06:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiC1ECt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 00:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiC1ECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 00:02:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9245AE8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:00:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so109230867b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gHJvarCfp4ST6T1lM9CDothUo5XPZ3G7QA7kcqYT4UM=;
        b=rk7Aw20EbcDIa69NL5ydL8E8TGDtoB37mocxbMh5cM0dpkp5zMFrZrXTdSQO8bain0
         qEqEz+noYjXXMXqMhPh3vXla3wNJb2iDucR4F40tEw2zYNiP+fkOInbx+h1Uww4YxJUg
         jE7gK7iBAfvfre7Xwu9cw8ZKPDj0yoDCy2XJpnC1y/kQ0LtiRxdcYKYVlqxQeBv1Qz5s
         l9kcMdp84H8INqnApIC1mSNJyZ9QgS4y2eDXIZuTriD0Tou4ermKhfdxVEUpcRXAUg0q
         d6US+J1fYIJRIRD4iiaWtvVnQgMkNGh66HLN6QFNyNmkEjr8K7J/+IW0uWfHmLsX8rMO
         /QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gHJvarCfp4ST6T1lM9CDothUo5XPZ3G7QA7kcqYT4UM=;
        b=KhWMCk9o5Jp/nBM8Or93vG3kgcjsptJmVUZb2tEDHoVqNYpIMyKnqHpCY2dlVcRboy
         Mx6jfbu7s5m7TZYUHsSsxEm9dCM++8iR8JYH50Y4s9RIdFTaWQk0hfuZtgaYr6nPtzNr
         STnRX3W+559rJyeJwU/m/pUiKILNA1Q2Lv66UIq+r8PDDYfzt7g6Y2TCFZ1OQxSiRsLY
         kwXhy1c/RblUGcC7D6NezJrcIPB7Mjd+SPdzYXiPLnSU31LVlvtPHjxjDvpCTjefVCgt
         8sNU/C8FiRC2jkcbiyzCSqK2+syDqxlR7Jj3UeXh8TSN/xO6yW1syBuJJ1Byv162m0X7
         AMVw==
X-Gm-Message-State: AOAM533GR14L+9igpOfXNd9DkG5KPMjc6YegAajGzAxFnwfyyIgHN0C5
        quhCtSAf2rFhoR4rNeb3SFjyTQHja735pP4=
X-Google-Smtp-Source: ABdhPJz+EpQpQ5sgGGlfLlv7TaYkgUMInl07aYgCXBfnJIUTEvZlVfooINmL6H3ETtCw093EcBxaIowsGvRw1ME=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a25:4dd7:0:b0:621:a740:3988 with SMTP id
 a206-20020a254dd7000000b00621a7403988mr20517183ybb.58.1648440011816; Sun, 27
 Mar 2022 21:00:11 -0700 (PDT)
Date:   Mon, 28 Mar 2022 03:59:44 +0000
In-Reply-To: <20220328035951.1817417-1-tjmercier@google.com>
Message-Id: <20220328035951.1817417-6-tjmercier@google.com>
Mime-Version: 1.0
References: <20220328035951.1817417-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [RFC v4 5/8] dmabuf: Add gpu cgroup charge transfer function
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
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

From: Hridya Valsaraju <hridya@google.com>

The dma_buf_charge_transfer function provides a way for processes to
transfer charge of a buffer to a different process. This is essential
for the cases where a central allocator process does allocations for
various subsystems, hands over the fd to the client who requested the
memory and drops all references to the allocated memory.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v4 changes
Adjust ordering of charge/uncharge during transfer to avoid potentially
hitting cgroup limit per Michal Koutn=C3=BD.

v3 changes
Use more common dual author commit message format per John Stultz.

v2 changes
Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.
---
 drivers/dma-buf/dma-buf.c  | 49 +++++++++++++++++++++++++++++++
 include/linux/cgroup_gpu.h | 12 ++++++++
 include/linux/dma-buf.h    |  2 ++
 kernel/cgroup/gpu.c        | 59 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 1ee5c60d3d6d..7748c3453b91 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1380,6 +1380,55 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct d=
ma_buf_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap, DMA_BUF);
=20
+/**
+ * dma_buf_transfer_charge - Change the GPU cgroup to which the provided d=
ma_buf is charged.
+ * @dmabuf:	[in]	buffer whose charge will be migrated to a different GPU c=
group
+ * @gpucg:	[in]	the destination GPU cgroup for dmabuf's charge
+ *
+ * Only tasks that belong to the same cgroup the buffer is currently charg=
ed to
+ * may call this function, otherwise it will return -EPERM.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct gpucg *gpucg)
+{
+#ifdef CONFIG_CGROUP_GPU
+	struct gpucg *current_gpucg;
+	int ret;
+
+	/* If the source and destination cgroups are the same, don't do anything.=
 */
+	current_gpucg =3D gpucg_get(current);
+	if (current_gpucg =3D=3D gpucg) {
+		ret =3D 0;
+		goto skip_transfer;
+	}
+
+	/*
+	 * Verify that the cgroup of the process requesting the transfer is the
+	 * same as the one the buffer is currently charged to.
+	 */
+	current_gpucg =3D gpucg_get(current);
+	mutex_lock(&dmabuf->lock);
+	if (current_gpucg !=3D dmabuf->gpucg) {
+		ret =3D -EPERM;
+		goto err;
+	}
+
+	ret =3D gpucg_transfer_charge(current_gpucg, gpucg, dmabuf->gpucg_dev, dm=
abuf->size);
+	if (ret)
+		goto err;
+	dmabuf->gpucg =3D gpucg;
+err:
+	mutex_unlock(&dmabuf->lock);
+skip_transfer:
+	gpucg_put(current_gpucg);
+	return ret;
+#else
+	return 0;
+#endif /* CONFIG_CGROUP_GPU */
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_transfer_charge, DMA_BUF);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/cgroup_gpu.h b/include/linux/cgroup_gpu.h
index c90069719022..e30f15d5e9be 100644
--- a/include/linux/cgroup_gpu.h
+++ b/include/linux/cgroup_gpu.h
@@ -87,6 +87,10 @@ static inline struct gpucg *gpucg_parent(struct gpucg *c=
g)
=20
 int gpucg_try_charge(struct gpucg *gpucg, struct gpucg_device *device, u64=
 usage);
 void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_device *device, u64 =
usage);
+int gpucg_transfer_charge(struct gpucg *source,
+			  struct gpucg *dest,
+			  struct gpucg_device *device,
+			  u64 usage);
 void gpucg_register_device(struct gpucg_device *gpucg_dev, const char *nam=
e);
 #else /* CONFIG_CGROUP_GPU */
=20
@@ -121,6 +125,14 @@ static inline void gpucg_uncharge(struct gpucg *gpucg,
 				  struct gpucg_device *device,
 				  u64 usage) {}
=20
+static inline int gpucg_transfer_charge(struct gpucg *source,
+					struct gpucg *dest,
+					struct gpucg_device *device,
+					u64 usage)
+{
+	return 0;
+}
+
 static inline void gpucg_register_device(struct gpucg_device *gpucg_dev,
 					 const char *name) {}
 #endif /* CONFIG_CGROUP_GPU */
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 742f29c3daaf..646827156213 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -646,4 +646,6 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struc=
t *,
 		 unsigned long);
 int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
+
+int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct gpucg *gpucg);
 #endif /* __DMA_BUF_H__ */
diff --git a/kernel/cgroup/gpu.c b/kernel/cgroup/gpu.c
index ac4c470914b5..40531323d6da 100644
--- a/kernel/cgroup/gpu.c
+++ b/kernel/cgroup/gpu.c
@@ -247,6 +247,65 @@ void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_=
device *device, u64 usage)
 	css_put_many(&gpucg->css, nr_pages);
 }
=20
+/**
+ * gpucg_transfer_charge - Transfer a GPU charge from one cgroup to anothe=
r.
+ * @source:	[in]	The GPU cgroup the charge will be transferred from.
+ * @dest:	[in]	The GPU cgroup the charge will be transferred to.
+ * @device:	[in]	The GPU cgroup device corresponding to the charge.
+ * @usage:	[in]	The size of the memory in bytes.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int gpucg_transfer_charge(struct gpucg *source,
+			  struct gpucg *dest,
+			  struct gpucg_device *device,
+			  u64 usage)
+{
+	struct page_counter *counter;
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp_source, *rp_dest;
+	int ret =3D 0;
+
+	nr_pages =3D PAGE_ALIGN(usage) >> PAGE_SHIFT;
+
+	mutex_lock(&gpucg_mutex);
+	rp_source =3D find_cg_rpool_locked(source, device);
+	if (unlikely(!rp_source)) {
+		ret =3D -ENOENT;
+		goto exit_early;
+	}
+
+	rp_dest =3D get_cg_rpool_locked(dest, device);
+	if (IS_ERR(rp_dest)) {
+		ret =3D PTR_ERR(rp_dest);
+		goto exit_early;
+	}
+
+	/*
+	 * First uncharge from the pool it's currently charged to. This ordering =
avoids double
+	 * charging while the transfer is in progress, which could cause us to hi=
t a limit.
+	 * If the try_charge fails for this transfer, we need to be able to rever=
se this uncharge,
+	 * so we continue to hold the gpucg_mutex here.
+	 */
+	page_counter_uncharge(&rp_source->total, nr_pages);
+	css_put_many(&source->css, nr_pages);
+
+	/* Now attempt the new charge */
+	if (page_counter_try_charge(&rp_dest->total, nr_pages, &counter)) {
+		css_get_many(&dest->css, nr_pages);
+	} else {
+		/*
+		 * The new charge failed, so reverse the uncharge from above. This shoul=
d always
+		 * succeed since charges on source are blocked by gpucg_mutex.
+		 */
+		WARN_ON(!page_counter_try_charge(&rp_source->total, nr_pages, &counter))=
;
+		css_get_many(&source->css, nr_pages);
+	}
+exit_early:
+	mutex_unlock(&gpucg_mutex);
+	return ret;
+}
+
 /**
  * gpucg_register_device - Registers a device for memory accounting using =
the
  * GPU cgroup controller.
--=20
2.35.1.1021.g381101b075-goog

