Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5455B086
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiFZJE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiFZJE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5930EE04
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656234266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BDlJSvL5c9sGGH6DwvX91lv4XDSfx7zrwjCuBKzHmvA=;
        b=UCJl+WPswaRJ2KRdkxlzwY6JbcN/TCjrhj2GQ6yBzN6znyk+iUeX5pNmcZkeOOpOEjN/7y
        Dt1IKqRaZhkfWm7tPLZN6naugz5zUR6IbA3REFkrl17YzhZoDxvhdIcfnU8bqRvtDMDzl9
        PkoiDpMDr3TovP5hbTZy2bpA3rRsL1U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-86mExzyhPzugylgvlouIew-1; Sun, 26 Jun 2022 05:04:22 -0400
X-MC-Unique: 86mExzyhPzugylgvlouIew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A28A41C05EB0;
        Sun, 26 Jun 2022 09:04:22 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD6009D54;
        Sun, 26 Jun 2022 09:04:19 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] vdpa: Do not count the pages that were already pinned in the vhost-vDPA
Date:   Sun, 26 Jun 2022 17:04:09 +0800
Message-Id: <20220626090409.1011144-2-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we add a tree vdpa_mem_tree to save the page that counted.
we will not count it again if the address already in this tree.
Here is the process that we count the newly add/del mem
1.remove all the node have overlap address from this tree.
2.if this range is newly added then add the new node(ref=1) to the tree,
  if this range is already in the tree, then change the ref to ref+1
   and add back to the tree(split the node if needed)
3. Counted the size newly add to the tree.
Del the address is the same process

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 467 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 456 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5ad2596c6e8a..e9de24c437ff 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -24,6 +24,9 @@
 #include <linux/vhost.h>
 
 #include "vhost.h"
+#include <linux/rbtree.h>
+#include <linux/interval_tree.h>
+#include <linux/interval_tree_generic.h>
 
 enum {
 	VHOST_VDPA_BACKEND_FEATURES =
@@ -65,6 +68,12 @@ static DEFINE_IDA(vhost_vdpa_ida);
 
 static dev_t vhost_vdpa_major;
 
+struct vdpa_tree_node {
+	struct interval_tree_node tree_node;
+	struct list_head list_node;
+	u64 ref;
+};
+
 static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
 {
 	struct vhost_vdpa_as *as = container_of(iotlb, struct
@@ -470,6 +479,430 @@ static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user *argp)
 	return 0;
 }
 
+int vhost_vdpa_add_node(struct rb_root_cached *root, u64 start, u64 last,
+			u64 ref)
+{
+	struct interval_tree_node *new_node;
+	struct vdpa_tree_node *vdpa_node;
+
+	if (last < start)
+		return -EFAULT;
+
+	/* If the range being mapped is [0, ULONG_MAX], split it into two entries
+	 * otherwise its size would overflow u64.
+	 */
+	if (start == 0 && last == ULONG_MAX) {
+		u64 mid = last / 2;
+
+		vhost_vdpa_add_node(root, start, mid, ref);
+		start = mid + 1;
+	}
+	vdpa_node = kmalloc(sizeof(struct vdpa_tree_node), GFP_ATOMIC);
+	if (!vdpa_node)
+		return -ENOMEM;
+
+	new_node = &vdpa_node->tree_node;
+
+	new_node->start = start;
+	new_node->last = last;
+	vdpa_node->ref = ref;
+
+	interval_tree_insert(new_node, root);
+
+	return 0;
+}
+
+/**
+ * vhost_vdpa_range_ref_add()
+ * the main process is
+ * 1. if the range not in the tree, add the new tree_node and make the ref =1
+ * 2. if a part of the rang in the tree_node, splt the tree_node, count the ref
+ * @root:	the rb_root for this tree, this tree saved the range of address that used
+ * @start:	starting  address
+ * @last:	the end  address
+ * @list_node_head: the list of the node that have overlaped with the range
+ *
+ * @size_count : this size is the newly added/del size, if the address
+ * range already in the vdpa_tree then we will not count it again
+ */
+
+int vhost_vdpa_range_ref_add(struct rb_root_cached *root,
+			     struct list_head *list_node_head, int node_number,
+			     u64 start, u64 last, u64 *size_count)
+
+{
+	int i, ret = 0;
+	u64 size = 0;
+	u64 ref;
+	u64 node_start, node_last, range_start, range_last;
+	int range_size;
+	struct list_head *list_node;
+	struct vdpa_tree_node *vdpa_node = NULL;
+	struct interval_tree_node *node = NULL;
+
+	if (node_number == 0) {
+		ret = vhost_vdpa_add_node(root, start, last, 1);
+
+		size = last - start + 1;
+		*size_count = size;
+		return ret;
+	}
+
+	list_node = list_node_head;
+	range_start = start;
+	range_last = last;
+
+	for (i = 0; i < node_number; i++) {
+		vdpa_node = container_of(list_node, struct vdpa_tree_node,
+					 list_node);
+
+		node = &vdpa_node->tree_node;
+		ref = vdpa_node->ref;
+		node_start = node->start;
+		node_last = node->last;
+
+		list_node = list_node->next;
+
+		/* checking the size and count ref */
+		/* 1: all these nodes are removed from the tree*/
+		/* 2: all these nodes are sorted in ascending order*/
+		/* 3: in this is loop the largest address we work in will be the node_last */
+		/* 4: if the range_last larger the node last, will work in next node*/
+		/* 5: the range_start in next loop will be node_last+1*/
+
+		if (range_start == node_start) {
+			if (node_last <= range_last) {
+				/* this comment the layout of the range and node in this loop*/
+
+				/* range_start= =node_start---node_last--range_last*/
+				ret = vhost_vdpa_add_node(root, node_start,
+							  node_last, ref + 1);
+				/*node_last+1--range_last will count in next loop */
+			} else {
+				/* range_start== node_start---range_last---node_last*/
+				ret = vhost_vdpa_add_node(root, node_start,
+							  range_last, ref + 1);
+				ret += vhost_vdpa_add_node(root, range_last + 1,
+							   node_last, ref);
+			}
+		} else if (node_start < range_start) {
+			if (range_last < node_last) {
+				/* node_start---range_last---range_last---node_last*/
+				ret = vhost_vdpa_add_node(root, node_start,
+							  range_start - 1, ref);
+				ret += vhost_vdpa_add_node(root, range_start,
+							   range_last, ref + 1);
+				ret += vhost_vdpa_add_node(root, range_last + 1,
+							   node_last, ref);
+
+			} else {
+				/* node_start---range_last---node_last= =range_last*/
+				ret = vhost_vdpa_add_node(root, node_start,
+							  range_start - 1, ref);
+				ret += vhost_vdpa_add_node(root, range_start,
+							   node_last, ref + 1);
+			}
+		} else {
+			if (node_last <= range_last) {
+				/* range_start---node_start---node_last ----range_last  */
+
+				ret = vhost_vdpa_add_node(root, range_start,
+							  node_start - 1, 1);
+				ret += vhost_vdpa_add_node(root, node_start,
+							   node_last, ref + 1);
+				size += ((node_start - 1) - range_start) + 1;
+			} else {
+				/* range_start---node_start---range_last --node_last*/
+				ret = vhost_vdpa_add_node(root, range_start,
+							  node_start - 1, 1);
+				ret += vhost_vdpa_add_node(root, node_start,
+							   range_last, ref + 1);
+				ret += vhost_vdpa_add_node(root, range_last + 1,
+							   node_last, ref);
+				size += ((node_start - 1) - range_start) + 1;
+			}
+		}
+
+		/* move range_start to next node*/
+		range_start = node_last + 1;
+		if ((range_start > range_last) || (ret != 0))
+			break;
+	}
+
+	range_size = range_last - range_start;
+	/* last round and but still some range left */
+	/*start with node_last+1 end with range_last*/
+
+	if (node_number == i + 1) {
+		if ((range_size >= 0) && (range_start >= node_last)) {
+			ret = vhost_vdpa_add_node(root, range_start, range_last,
+						  1);
+			size = size + (range_last - range_start) + 1;
+
+			*size_count = size;
+
+			return ret;
+
+		} else if (range_size == -1) {
+			/*this means the node_last ==range_last in final loop */
+			*size_count = size;
+
+			return ret;
+		}
+	}
+
+	return -EFAULT;
+}
+/**
+ * vhost_vdpa_range_ref_del()
+ * the main process is
+ * 1. if the range not in the tree, return -1
+ * 2. if a part of the rang in the tree_node, splt the tree_node, count the ref
+ *
+ * @root:	the rb_root for this tree, this tree saved the range of address that used
+ * @start:	starting  address
+ * @last:	the end  address
+ * @list_node_head: the list of the node that have overlaped with the range
+ *
+ * OUT @size_count : this size is the newly added/del size
+ */
+
+int vhost_vdpa_range_ref_del(struct rb_root_cached *root,
+			     struct list_head *list_node_head, int node_number,
+			     u64 start, u64 last, u64 *size_count)
+{
+	int i, ret = 0;
+	u64 size = 0;
+	u64 ref;
+	u64 node_start, node_last, range_start, range_last;
+	int range_size;
+	struct list_head *list_node;
+	struct vdpa_tree_node *vdpa_node = NULL;
+	struct interval_tree_node *node = NULL;
+
+	if (node_number == 0) {
+		/* the address range not in the tree */
+		*size_count = 0;
+		return -EFAULT;
+	}
+
+	list_node = list_node_head;
+
+	range_start = start;
+	range_last = last;
+
+	for (i = 0; i < node_number; i++) {
+		vdpa_node = container_of(list_node, struct vdpa_tree_node,
+					 list_node);
+
+		node = &vdpa_node->tree_node;
+		ref = vdpa_node->ref;
+		node_start = node->start;
+		node_last = node->last;
+		list_node = list_node->next;
+
+		/* checking the size and count ref, here are some note here */
+		/* 1: these nodes are removed from tree, we just need to check ref and add it back*/
+		/* 2: all these nodes are sorted in ascending order*/
+		/* 3: in this is loop the largest address we work in will be the node_last */
+		/* 4: if the range_last larger the node last, will work in next node*/
+
+		if (range_start == node_start) {
+			if (node_last < range_last) {
+				/*this comment is the layout for this memory*/
+				/*range_start==node_start---node_last----range_last*/
+				if (ref > 1) {
+					ret = vhost_vdpa_add_node(root,
+								  node_start,
+								  node_last,
+								  ref - 1);
+				} else {
+					/*new ref ==0, don't need add it back, count the size*/
+					size += (node_last - node_start) + 1;
+				}
+
+			} else if (node_last > range_last) {
+				/*range_start== node_start--range_last---node_last*/
+
+				if (ref > 1) {
+					ret = vhost_vdpa_add_node(root,
+								  node_start,
+								  range_last,
+								  ref - 1);
+				} else {
+					/*new ref ==0, don't need add it back, count the size*/
+					size += (range_last - node_start) + 1;
+				}
+				ret = vhost_vdpa_add_node(root, range_last + 1,
+							  node_last, ref);
+			} else {
+				/*range_start== node_start---range_last = =node_last*/
+
+				if (ref > 1) {
+					ret = vhost_vdpa_add_node(root,
+								  node_start,
+								  range_last,
+								  ref - 1);
+				} else {
+					size += (range_last - node_start) + 1;
+				}
+			}
+		} else if (node_start < range_start) {
+			if (range_last < node_last) {
+				/* node_start--range_start--range_last--node_last*/
+				ret = vhost_vdpa_add_node(root, node_start,
+							  range_start - 1, ref);
+				if (ref > 1) {
+					ret += vhost_vdpa_add_node(root,
+								   range_start,
+								   range_last,
+								   ref - 1);
+				} else {
+					size += (range_last - range_start) + 1;
+				}
+				ret += vhost_vdpa_add_node(root, range_last + 1,
+							   node_last, ref);
+
+			} else if (range_last > node_last) {
+				/*node_start--range_start--node_last--range_last*/
+
+				ret = vhost_vdpa_add_node(root, node_start,
+							  range_start - 1, ref);
+				if (ref > 1) {
+					ret = vhost_vdpa_add_node(root,
+								  range_start,
+								  node_last,
+								  ref - 1);
+				} else {
+					size += (node_last - range_start) + 1;
+				}
+			} else {
+				/*node_start---range_start---node_last==range_last*/
+				ret = vhost_vdpa_add_node(root, node_start,
+							  range_start - 1, ref);
+				if (ref > 1) {
+					ret = vhost_vdpa_add_node(root,
+								  range_start,
+								  range_last,
+								  ref - 1);
+				} else {
+					size += (range_last - range_start) + 1;
+				}
+			}
+		} else {
+			/* some range not in the node, should not happened*/
+			*size_count = size;
+			return -EFAULT;
+		}
+
+		range_start = node_last + 1;
+		if ((range_start > range_last) || (ret != 0))
+			break;
+	}
+
+	range_size = range_last - range_start;
+
+	/* last round and still some range, this should not happened*/
+
+	if ((range_size > 0) && (node_number == i + 1))
+		return -EFAULT;
+
+	*size_count = size;
+	return ret;
+}
+/**
+ * vhost_vdpa_range_ops()
+ * @root:	the rb_root for this tree, this tree saved the range of address that used
+ * @start:	starting  address
+ * @last:	the end  address
+ * @ops:	the opreater for this BOOL true means to add the range of address
+ *      FALSE means to del the range address
+ * OUTPUT@size_count : this size is the SIZE newly added/del,
+ * if the address range already in the vdpa_tree, will not count it again
+ */
+int vhost_vdpa_range_ops(struct rb_root_cached *root, u64 start, u64 last,
+			 bool ops, u64 *size_count)
+{
+	struct interval_tree_node *node = NULL;
+	struct vdpa_tree_node *vdpa_node;
+	struct list_head *list_node = NULL;
+	struct vdpa_tree_node dummyHead = { 0 };
+	int node_number = 0;
+	int i = 0;
+	int ret;
+
+	INIT_LIST_HEAD(&dummyHead.list_node);
+
+	/*search the rang overlaped, and del from the tree*/
+	while ((node = interval_tree_iter_first(root, start, last)) != NULL) {
+		node_number++;
+		vdpa_node =
+			container_of(node, struct vdpa_tree_node, tree_node);
+
+		list_node = &vdpa_node->list_node;
+
+		/* Remove the node overlaped with the range from the tree*/
+		/* otherwish it will count again in a loop */
+		interval_tree_remove(node, root);
+		list_add_tail(list_node, &dummyHead.list_node);
+	}
+
+	list_node = (&dummyHead.list_node)->next;
+
+	/* check the ref and add/del to tree*/
+	if (ops == true) {
+		ret = vhost_vdpa_range_ref_add(root, list_node, node_number,
+					       start, last, size_count);
+	} else {
+		ret = vhost_vdpa_range_ref_del(root, list_node, node_number,
+					       start, last, size_count);
+	}
+
+	/*free all the node overlaped with the range*/
+	for (i = 0; i < node_number; i++) {
+		vdpa_node = container_of(list_node, struct vdpa_tree_node,
+					 list_node);
+
+		list_node = list_node->next;
+		kfree(vdpa_node);
+	}
+
+	return ret;
+}
+int vhost_vdpa_range_add(struct vhost_vdpa *v, u64 start, u64 last,
+			 u64 *size_count)
+
+{
+	int r;
+	struct vhost_dev *dev = &v->vdev;
+
+	r = vhost_vdpa_range_ops(dev->vdpa_mem_tree, start, last, true,
+				 size_count);
+	if (unlikely(r))
+		dev_info(&v->dev,
+			 "vhost vdpa range add fail start %lld last %lld %lld",
+			 start, last, *size_count);
+
+	return r;
+}
+
+int vhost_vdpa_range_del(struct vhost_vdpa *v, u64 start, u64 last,
+			 u64 *size_count)
+
+{
+	int r;
+	struct vhost_dev *dev = &v->vdev;
+
+	r = vhost_vdpa_range_ops(dev->vdpa_mem_tree, start, last, false,
+				 size_count);
+	if (unlikely(r))
+		dev_info(&v->dev,
+			 "vhost vdpa range del fail start %lld last %lld %lld",
+			 start, last, *size_count);
+
+	return r;
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -658,6 +1091,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
 	struct vhost_dev *dev = &v->vdev;
 	struct vhost_iotlb_map *map;
 	struct page *page;
+	u64 size;
 	unsigned long pfn, pinned;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
@@ -669,7 +1103,10 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
 				set_page_dirty_lock(page);
 			unpin_user_page(page);
 		}
-		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
+
+		vhost_vdpa_range_del(v, map->start, map->start + map->size - 1,
+				     &size);
+		atomic64_sub(PFN_DOWN(size), &dev->mm->pinned_vm);
 		vhost_iotlb_map_free(iotlb, map);
 	}
 }
@@ -731,6 +1168,20 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u32 asid = iotlb_to_asid(iotlb);
 	int r = 0;
+	u64 size_count;
+	unsigned long lock_limit;
+
+	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+	if (!vdpa->use_va) {
+		r = vhost_vdpa_range_add(v, iova, iova + size - 1, &size_count);
+
+		if (size_count + atomic64_read(&dev->mm->pinned_vm) >
+		    lock_limit) {
+			r = vhost_vdpa_range_del(v, iova, iova + size - 1,
+						 &size_count);
+			return -ENOMEM;
+		}
+	}
 
 	r = vhost_iotlb_add_range_ctx(iotlb, iova, iova + size - 1,
 				      pa, perm, opaque);
@@ -748,11 +1199,11 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
+		r = vhost_vdpa_range_del(v, iova, iova + size - 1, &size_count);
 		return r;
 	}
-
 	if (!vdpa->use_va)
-		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
+		atomic64_add(PFN_DOWN(size_count), &dev->mm->pinned_vm);
 
 	return 0;
 }
@@ -843,7 +1294,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long sz2pin, nchunks, i;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -864,12 +1315,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	mmap_read_lock(dev->mm);
 
-	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
-	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
 	nchunks = 0;
@@ -951,7 +1396,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 		}
 		vhost_vdpa_unmap(v, iotlb, start, size);
 	}
-unlock:
+
 	mmap_read_unlock(dev->mm);
 free:
 	free_page((unsigned long)page_list);
-- 
2.34.3

