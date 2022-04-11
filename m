Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF574FBEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiDKOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347389AbiDKORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF41400A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ASljIUWIHiTXYjmM17qEdn1C3LcLuyAvAktAU946bZI=; b=tUiqn6/T8fn5C2z8lNgbfJaYxQ
        3Xq65LwI9iUTRtoQXB2u3JuHreDjWlRYkAgDYwIJE7/42viYCioc7mwQBzOLpp46r4OtVdWaRG0Mu
        m/mxBSCHmrORIqaHLn9PMgozxY+8vGp0CkQKYcnWIZNmrH/FT7r66EBVLYXKewLO0dHQSAUKZOyOG
        si12UWdomEIH2AaLBiDYxO+1tWnfh8G3cmP5LaY/IGjq0dLT230hiX3ag4VINaTqUGZ+232Zj4EMX
        2kEl6t44utQxp/m7iN21xNeHjm43lzM3RXVQm+PzddakE+pWum5IWl6SfaLrz0YKgD9rywNC7CqJb
        Lwin9ZBg==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndupE-009Kuh-DO; Mon, 11 Apr 2022 14:15:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/34] drm/i915/gvt: remove kvmgt_guest_{init,exit}
Date:   Mon, 11 Apr 2022 16:13:56 +0200
Message-Id: <20220411141403.86980-28-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge these into their only callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 129 ++++++++++++++-----------------
 1 file changed, 60 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 5db74b6fe5137..38629ab4c9bf2 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -100,6 +100,13 @@ struct gvt_dma {
 	struct kref ref;
 };
 
+static void kvmgt_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,
+		const u8 *val, int len,
+		struct kvm_page_track_notifier_node *node);
+static void kvmgt_page_track_flush_slot(struct kvm *kvm,
+		struct kvm_memory_slot *slot,
+		struct kvm_page_track_notifier_node *node);
+
 static ssize_t available_instances_show(struct mdev_type *mtype,
 					struct mdev_type_attribute *attr,
 					char *buf)
@@ -213,9 +220,7 @@ void intel_gvt_cleanup_vgpu_type_groups(struct intel_gvt *gvt)
 	}
 }
 
-static int kvmgt_guest_init(struct mdev_device *mdev);
 static void intel_vgpu_release_work(struct work_struct *work);
-static bool kvmgt_guest_exit(struct intel_vgpu *info);
 
 static void gvt_unpin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		unsigned long size)
@@ -803,6 +808,27 @@ static int intel_vgpu_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu)
+{
+	struct intel_vgpu *itr;
+	int id;
+	bool ret = false;
+
+	mutex_lock(&vgpu->gvt->lock);
+	for_each_active_vgpu(vgpu->gvt, itr, id) {
+		if (!itr->attached)
+			continue;
+
+		if (vgpu->kvm == itr->kvm) {
+			ret = true;
+			goto out;
+		}
+	}
+out:
+	mutex_unlock(&vgpu->gvt->lock);
+	return ret;
+}
+
 static int intel_vgpu_open_device(struct mdev_device *mdev)
 {
 	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
@@ -847,14 +873,37 @@ static int intel_vgpu_open_device(struct mdev_device *mdev)
 		goto undo_group;
 	}
 
-	ret = kvmgt_guest_init(mdev);
-	if (ret)
+	ret = -EEXIST;
+	if (vgpu->attached)
+		goto undo_group;
+
+	ret = -ESRCH;
+	if (!vgpu->kvm || vgpu->kvm->mm != current->mm) {
+		gvt_vgpu_err("KVM is required to use Intel vGPU\n");
+		goto undo_group;
+	}
+
+	ret = -EEXIST;
+	if (__kvmgt_vgpu_exist(vgpu))
 		goto undo_group;
 
+	vgpu->attached = true;
+	kvm_get_kvm(vgpu->kvm);
+
+	kvmgt_protect_table_init(vgpu);
+	gvt_cache_init(vgpu);
+
+	vgpu->track_node.track_write = kvmgt_page_track_write;
+	vgpu->track_node.track_flush_slot = kvmgt_page_track_flush_slot;
+	kvm_page_track_register_notifier(vgpu->kvm, &vgpu->track_node);
+
+	debugfs_create_ulong(KVMGT_DEBUGFS_FILENAME, 0444, vgpu->debugfs,
+			     &vgpu->nr_cache_entries);
+
 	intel_gvt_activate_vgpu(vgpu);
 
 	atomic_set(&vgpu->released, 0);
-	return ret;
+	return 0;
 
 undo_group:
 	vfio_group_put_external_user(vgpu->vfio_group);
@@ -908,7 +957,12 @@ static void __intel_vgpu_release(struct intel_vgpu *vgpu)
 	/* dereference module reference taken at open */
 	module_put(THIS_MODULE);
 
-	kvmgt_guest_exit(vgpu);
+	debugfs_remove(debugfs_lookup(KVMGT_DEBUGFS_FILENAME, vgpu->debugfs));
+
+	kvm_page_track_unregister_notifier(vgpu->kvm, &vgpu->track_node);
+	kvm_put_kvm(vgpu->kvm);
+	kvmgt_protect_table_destroy(vgpu);
+	gvt_cache_destroy(vgpu);
 
 	intel_vgpu_release_msi_eventfd_ctx(vgpu);
 	vfio_group_put_external_user(vgpu->vfio_group);
@@ -1763,69 +1817,6 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 	write_unlock(&kvm->mmu_lock);
 }
 
-static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu, struct kvm *kvm)
-{
-	struct intel_vgpu *itr;
-	int id;
-	bool ret = false;
-
-	mutex_lock(&vgpu->gvt->lock);
-	for_each_active_vgpu(vgpu->gvt, itr, id) {
-		if (!itr->attached)
-			continue;
-
-		if (kvm && kvm == itr->kvm) {
-			ret = true;
-			goto out;
-		}
-	}
-out:
-	mutex_unlock(&vgpu->gvt->lock);
-	return ret;
-}
-
-static int kvmgt_guest_init(struct mdev_device *mdev)
-{
-	struct intel_vgpu *vgpu = mdev_get_drvdata(mdev);
-	struct kvm *kvm = vgpu->kvm;
-
-	if (vgpu->attached)
-		return -EEXIST;
-
-	if (!kvm || kvm->mm != current->mm) {
-		gvt_vgpu_err("KVM is required to use Intel vGPU\n");
-		return -ESRCH;
-	}
-
-	if (__kvmgt_vgpu_exist(vgpu, kvm))
-		return -EEXIST;
-
-	vgpu->attached = true;
-	kvm_get_kvm(vgpu->kvm);
-
-	kvmgt_protect_table_init(vgpu);
-	gvt_cache_init(vgpu);
-
-	vgpu->track_node.track_write = kvmgt_page_track_write;
-	vgpu->track_node.track_flush_slot = kvmgt_page_track_flush_slot;
-	kvm_page_track_register_notifier(kvm, &vgpu->track_node);
-
-	debugfs_create_ulong(KVMGT_DEBUGFS_FILENAME, 0444, vgpu->debugfs,
-			     &vgpu->nr_cache_entries);
-	return 0;
-}
-
-static bool kvmgt_guest_exit(struct intel_vgpu *info)
-{
-	debugfs_remove(debugfs_lookup(KVMGT_DEBUGFS_FILENAME, info->debugfs));
-
-	kvm_page_track_unregister_notifier(info->kvm, &info->track_node);
-	kvm_put_kvm(info->kvm);
-	kvmgt_protect_table_destroy(info);
-	gvt_cache_destroy(info);
-	return true;
-}
-
 void intel_vgpu_detach_regions(struct intel_vgpu *vgpu)
 {
 	int i;
-- 
2.30.2

