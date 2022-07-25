Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13857F9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiGYGyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiGYGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:23 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C2111144
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:16 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220725065312epoutp04d368d39e18fe6234d7e3929d47323a73~E--WESeDb0752507525epoutp04W
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220725065312epoutp04d368d39e18fe6234d7e3929d47323a73~E--WESeDb0752507525epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731992;
        bh=2fxJHc+vxaO6CM41DOkUvqHgCYSieTOaQX16nc3gbQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I33Y57/iaDSC0Bk2d5yyl1zp5JVo8mMqffyVl6HQpOw3zMbksd09dcU9lezXnTjmd
         fOYXlTSzjNse4iZbx27K7ZtUM2FFMwNBf3WdEK3pMR0v9NsZqEdFyX0QITR+Yq/4RH
         tlAR83Qze4o1hu8t675/Ur3nsRChnAOEJu28C7u8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220725065312epcas1p360b42644b0e5ec8e0f76fc4765b0964e~E--VyfstG1952219522epcas1p3Y;
        Mon, 25 Jul 2022 06:53:12 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.145]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LrrN723Tcz4x9Pv; Mon, 25 Jul
        2022 06:53:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.29.09657.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220725065310epcas1p3688f336bfd5c732145575524f3365a0f~E--TkcegO2790327903epcas1p3d;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065310epsmtrp298dd2333368529c406f390f02e37110d~E--TjuIpB0769507695epsmtrp2t;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
X-AuditID: b6c32a35-733ff700000025b9-c9-62de3dd6d7af
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.C2.08905.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epsmtip2096dcc7d59217af5167b3ccbe020cba6~E--TOFB7y2484924849epsmtip2l;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 6/9] trinity: Add pm and ioctl feature
Date:   Mon, 25 Jul 2022 15:53:05 +0900
Message-Id: <20220725065308.2457024-7-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmvu4123tJBrf3iVv8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzrjQtoatYMFb
        poq2EytZGhi/rmDqYuTkkBAwkXgz9Sh7FyMXh5DADkaJbWsOMUI4nxglFk/6zAbhfGOUuNq8
        lQWmZfnGAywQib2MErcurmKCcD4zSsyYOJsdpIpNQFVi5ow1YLaIgLfE/NYuoCIODmaBSIlr
        K6pAwsICZhKTv5xhBbFZgMqPzFjCCGLzClhLNM/YygZicwrYSCz4sZsZIi4ocXLmE7AjmAXk
        JZq3zmYG2SshcI5d4vXVLkaI61wkTl1phbpUWOLV8S3sELaUxOd3e9kg7GyJKR2LoGoKJM49
        38oMcpuEgLHExRUpEGdqSqzfpQ9RoSix8/dcRoi1fBLvvvawQlTzSnS0CUGUKEks+XMYapGE
        xNQZ36Ch6yGxvHkaNHT6GSWONZxin8AoPwvJN7OQfDMLYfMCRuZVjGKpBcW56anFhgWG8GhN
        zs/dxAhOgVqmOxgnvv2gd4iRiYPxEKMEB7OSCG9X2u0kId6UxMqq1KL8+KLSnNTiQ4ymwPCd
        yCwlmpwPTMJ5JfGGJpYGJmZGxiYWhmaGSuK8q6adThQSSE8sSc1OTS1ILYLpY+LglGpgWv5g
        Nadr0PNXk4/+mc3/pEHJVOt42RVj52X/VU9PdDrJUzjzNMvjMw8i/P+cfBocmhmZqCUrzbWr
        ZH5vr4nSMa3WxDv+E35U/1ZZdy47z0blnZyvwbnjRWcunPdVrAmzUhA22KmzNvx12/cLoX+7
        Wlck11Tuu7FV08hdfsc/P+ls97+P3+5VmhAkqfg0P/mS486ncde2xrTP+5p6989vzt8/3G4L
        vrHQyi67mpPTuLZcB2hNp4CFQ3NIHK/C30Wshuf3ZU60XuSjPSFtbY/F2ZcfTgvm3957VURC
        8tudl3Mb8/lCHGbO+H+lseOiWekKuVAG4Q3vuJ9zLTrb9D1/m8OPl1WM0/5sK70ccXS3Ektx
        RqKhFnNRcSIApucsKAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO5V23tJBh03zCz+TjrGbtG8eD2b
        xfvu3cwWl3fNYbO43biCzeL5tOssDmwev39NYvTYP3cNu0ffllWMHp83yQWwRHHZpKTmZJal
        FunbJXBlXGhbw1aw4C1TRduJlSwNjF9XMHUxcnJICJhILN94gKWLkYtDSGA3o8Sba5sYIRIS
        EpvuLWfuYuQAsoUlDh8uhqj5yCixZNNxsBo2AVWJmTPWsIPYIgL+En8/HWMFsZkFoiVWb7vP
        AmILC5hJTP5yBizOAlR/ZMYSsF5eAWuJ5hlb2UBsTgEbiQU/djOD2EJA8f6uE6wQNYISJ2c+
        YYGYKS/RvHU28wRG/llIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgO
        Vi3NHYzbV33QO8TIxMF4iFGCg1lJhLcr7XaSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfj
        hQTSE0tSs1NTC1KLYLJMHJxSDUyy9gtPB6kZlP6eZ6DiHMWoYdOlXPj9aqDLt/V/S6TLxQyd
        8i1V1BZnJ138JrLd/uezFWx3GyN/cEZxzOlekOq0Yqrn7ryyev+5EhFH1d5sYjafz9hn78Sx
        oXLqpmxTJtHst1PeTosqm6e5/Mbr5PQLxVI+O2Uf5AVZTBNTXx2fL/F828t/HS7Ceb53jv16
        p/HiTqSxlA2r39T3psmuE18duHpWf2Za2/79vPx7s2ay8B9oTLX/nuKyjqGEJ+B3dfxuBs/D
        wSYPXxUnWKmub7313Dgta1fpzW9HbNOleSe+/7NfoDnkQ8Vl0xnP3n9bXWHdOX1pPX/wAoFM
        pl5u6ce7A2OYzljKC/VfZrKoV2Ipzkg01GIuKk4EAEkNdAvFAgAA
X-CMS-MailID: 20220725065310epcas1p3688f336bfd5c732145575524f3365a0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065310epcas1p3688f336bfd5c732145575524f3365a0f
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065310epcas1p3688f336bfd5c732145575524f3365a0f@epcas1p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements power management and ioctl behaviors.

Currently, power management operations check it can change to
suspend mode using pm_runtime_allow and pm_runtime_forbid.

The ioctl routines are also added to give controls to the user
library. TRINITY_IOCTL_HWMEM_ALLOC/DEALLOC is for memory
allocation for the model load, RUN/STOP operations are
provided to control NPU works. And several STAT controls can
provide statistics of the NPU, it gives an inspection
feature to the user space.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile              |   1 +
 drivers/misc/trinity/trinity.c             | 690 ++++++++++++++++++++-
 drivers/misc/trinity/trinity_common.h      |  23 +-
 drivers/misc/trinity/trinity_pm.c          |  76 +++
 drivers/misc/trinity/trinity_vision2_drv.c | 563 ++++++++++++++++-
 5 files changed, 1344 insertions(+), 9 deletions(-)
 create mode 100644 drivers/misc/trinity/trinity_pm.c

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index ce3539affbf2..22141e2233e8 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 trinity-y := trinity.o
 trinity-y += trinity_resv_mem.o trinity_hwmem.o
 trinity-y += sched/core.o sched/priority.o
+trinity-y += trinity_pm.o
 trinity-y += trinity_debug.o
 trinity-y += trinity_sysfs.o trinity_stat.o
 
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 8f8ade0aff89..08d15f08da39 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -34,6 +34,7 @@
 
 #include "trinity_common.h"
 #include "trinity_resv_mem.h"
+#include "trinity_stat.h"
 
 #define BASE_DEV_NAME "trinity"
 
@@ -50,6 +51,9 @@ static DEFINE_SPINLOCK(trinity_lock);
 /* A bitmap to keep track of active Trinity devices */
 static unsigned long dev_bitmap[TRINITY_DEV_END];
 
+static void trinity_model_get(struct trinity_model *model);
+static void trinity_model_put(struct trinity_model *model);
+
 phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr)
 {
 	if (domain)
@@ -58,6 +62,16 @@ phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr)
 	return TRINITY_PADDR_BASE + daddr;
 }
 
+void trinity_finish_req(struct trinity_driver *drv, struct trinity_req *req)
+{
+	if (drv->desc->check_profile(drv, req) < 0)
+		dev_warn(drv_to_dev_ptr(drv),
+			 "Unable to get profile data from NPU\n");
+	trinity_hwmem_import_dmabuf_end(&req->input.import_info);
+	trinity_stat_finish_req(drv, req);
+	trinity_model_put(req->model);
+}
+
 static uint64_t trinity_gen_model_id(int32_t dbuf_fd)
 {
 	static uint32_t id;
@@ -101,6 +115,630 @@ void trinity_init_model_htable(const struct trinity_driver *drv,
 	ht->hash_bits = TRINITY_MODEL_HASH_BITS;
 }
 
+static struct trinity_model *
+trinity_get_model_by_id(const struct trinity_driver *drv, const uint64_t id)
+{
+	struct trinity_model_htable ht;
+	struct hlist_bl_node *hn;
+	struct trinity_model *hm;
+	unsigned long key;
+	int32_t dbuf_fd;
+	bool found = false;
+
+	trinity_init_model_htable(drv, &ht);
+
+	dbuf_fd = trinity_model_id_to_dbuf_fd(id);
+	key = hash_long(dbuf_fd, ht.hash_bits);
+	hm = NULL;
+
+	hlist_bl_lock(&(ht.ht_heads[key]));
+	hlist_bl_for_each_entry(hm, hn, &(ht.ht_heads[key]), hnode) {
+		if (hm->config.id == id) {
+			found = true;
+			break;
+		}
+	}
+	hlist_bl_unlock(&(ht.ht_heads[key]));
+
+	return found ? hm : NULL;
+}
+
+/**
+ * trinity_register_model() - Registers a model to the internal hashtable. Note
+ *		that the device is responsible for the hashtable maintenance.
+ *
+ * @drv: An instance of the trinity driver
+ * @model: Model information to be registered
+ *
+ * Returns 0 and sets model->id with a valid value, which is unique system-wide,
+ * on success. Otherwise, returns negative error.
+ */
+int32_t trinity_register_model(struct trinity_driver *drv,
+			       struct trinity_model *model)
+{
+	struct trinity_model_htable ht;
+	unsigned long key;
+	int32_t ret;
+
+	ret = trinity_hwmem_import_dmabuf_begin(drv_to_dev_ptr(drv),
+						model->config.dbuf_fd,
+						&model->import_info);
+	if (ret)
+		return ret;
+
+#ifdef ARM
+	/* sync model program data */
+	__cpuc_flush_dcache_area(model->import_info.addr,
+				 model->import_info.buf->size);
+#endif
+
+	model->config.id = trinity_gen_model_id(model->config.dbuf_fd);
+	model->owner_id = trinity_get_app_id();
+
+	INIT_HLIST_BL_NODE(&model->hnode);
+
+	trinity_init_model_htable(drv, &ht);
+
+	key = hash_long(model->config.dbuf_fd, ht.hash_bits);
+
+	hlist_bl_lock(&(ht.ht_heads[key]));
+	hlist_bl_add_head(&model->hnode, &ht.ht_heads[key]);
+	hlist_bl_unlock(&(ht.ht_heads[key]));
+
+	kref_init(&model->refcnt);
+
+	return 0;
+}
+
+static void trinity_destroy_model(struct kref *refcnt)
+{
+	struct trinity_model *model =
+		container_of(refcnt, struct trinity_model, refcnt);
+
+	trinity_hwmem_import_dmabuf_end(&model->import_info);
+	kfree(model);
+}
+
+static void trinity_model_get(struct trinity_model *model)
+{
+	if (!model)
+		return;
+
+	kref_get(&model->refcnt);
+}
+
+static void trinity_model_put(struct trinity_model *model)
+{
+	if (!model)
+		return;
+
+	kref_put(&model->refcnt, trinity_destroy_model);
+}
+
+/**
+ * trinity_deregister_model() - Deregisters the model with a given id from the
+ *		table
+ *
+ * @drv: An instance of the trinity driver
+ * @id: An id of the model to be deregistered
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int32_t trinity_deregister_model(const struct trinity_driver *drv,
+				 const uint64_t id)
+{
+	int32_t dbuf_fd = trinity_model_id_to_dbuf_fd(id);
+	struct trinity_model_htable ht;
+	unsigned long key;
+	struct hlist_bl_node *hn;
+	struct trinity_model *hm = NULL;
+
+	trinity_init_model_htable(drv, &ht);
+
+	key = hash_long(dbuf_fd, ht.hash_bits);
+	hlist_bl_lock(&(ht.ht_heads[key]));
+	hlist_bl_for_each_entry(hm, hn, &(ht.ht_heads[key]), hnode) {
+		if (hm->config.id == id) {
+			hlist_bl_del_init(&hm->hnode);
+			break;
+		}
+	}
+	hlist_bl_unlock(&(ht.ht_heads[key]));
+
+	if (!hm)
+		return -ENOENT;
+
+	trinity_model_put(hm);
+
+	return 0;
+}
+
+/**
+ * trinity_deregister_models_owned() - Deregisters models owned
+ *
+ * @drv: An instance of the trinity driver
+ */
+void trinity_deregister_models_owned(struct trinity_driver *drv)
+{
+	struct trinity_model_htable ht;
+	struct trinity_model *hm;
+	struct hlist_bl_node *hn;
+	int i = 0, app_id = trinity_get_app_id();
+
+	trinity_init_model_htable(drv, &ht);
+
+retry:
+	for (; i < TRINITY_MODEL_HASH_SIZE; i++) {
+		hlist_bl_lock(&(ht.ht_heads[i]));
+		hlist_bl_for_each_entry(hm, hn, &(ht.ht_heads[i]), hnode) {
+			if (hm->owner_id == app_id) {
+				hlist_bl_del_init(&hm->hnode);
+				hlist_bl_unlock(&(ht.ht_heads[i]));
+
+				trinity_model_put(hm);
+
+				goto retry;
+			}
+		}
+		hlist_bl_unlock(&(ht.ht_heads[i]));
+	}
+}
+
+/**
+ * get_trinity_sched() - Get scheduler for the request
+ *
+ * @drv: An instance of the trinity driver
+ */
+struct trinity_sched_desc *get_trinity_sched(struct trinity_req *req)
+{
+	return trinity_sched_find(SCHED_PRI);
+}
+
+static int32_t trinity_submit_req(struct trinity_driver *drv,
+				  struct trinity_req *req)
+{
+	struct trinity_sched_desc *sched;
+	struct device *dev;
+	wait_queue_head_t wq;
+	unsigned long timeout, timeout_ms;
+	unsigned long retry, max_retry = 10;
+	int ret = 0;
+
+	dev = drv_to_dev_ptr(drv);
+	sched = get_trinity_sched(req);
+	if (!sched) {
+		dev_err(dev, "Unable to find the target scheduler");
+		return -EINVAL;
+	}
+
+	/* optional req setup before submission */
+	if (drv->desc->prepare_req) {
+		ret = drv->desc->prepare_req(drv, req);
+		if (ret < 0) {
+			dev_err(dev, "Unable to prepare req submission: %d",
+				ret);
+			return ret;
+		}
+	}
+
+	req->submit_retry = 0;
+	timeout_ms = req->input.config.timeout_ms;
+	/* use the default timeout if a user didn't set */
+	if (timeout_ms == 0)
+		timeout_ms = TRINITY_RUN_TIMEOUT_MSEC;
+
+	retry = 0;
+	init_waitqueue_head(&wq);
+	init_completion(&req->complete);
+
+	timeout = msecs_to_jiffies(timeout_ms);
+	while (wait_event_interruptible_timeout(wq, sched->ready(),
+						timeout / 10) == 0) {
+		if (retry == max_retry) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		retry++;
+	}
+
+	if (ret == 0) {
+		ret = trinity_stat_append_req(drv, req);
+		if (ret < 0) {
+			dev_err(dev, "Unable to append request stat: %d", ret);
+			return ret;
+		}
+
+		ret = sched->submit(req);
+		if (ret < 0)
+			trinity_stat_remove_req(drv, req, true);
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "Unable to submit req to scheduler: %d", ret);
+		return ret;
+	}
+
+	if (req->input.config.output_mode != TRINITY_OUTPUT_HW) {
+		timeout = wait_for_completion_timeout(&req->complete, timeout);
+		/* Check and handle the timeout if its handler exists */
+		if (timeout == 0) {
+			bool canceled = false;
+
+			dev_warn(dev, "The request timeout reached: %lu ms",
+				 timeout_ms);
+
+			if (sched->cancel) {
+				canceled = sched->cancel(req);
+				if (!canceled)
+					dev_warn(dev, "Unable to cancel req");
+			}
+
+			if (!canceled)
+				drv->desc->handle_timeout(drv, req);
+
+			req->stat->status = TRINITY_REQ_STATUS_ERROR;
+			ret = -ECANCELED;
+		} else if (req->stat->status == TRINITY_REQ_STATUS_ERROR) {
+			ret = -ECANCELED;
+		} else if (drv->verbose) {
+			dev_info(dev,
+				 "Execution Cycles: %u, Elapsed Time (us): %u",
+				 req->stat->prev_cycles, req->stat->prev_time);
+		}
+		trinity_finish_req(drv, req);
+	}
+
+	return ret;
+}
+
+static int32_t trinity_run_input(struct trinity_driver *drv,
+				 struct trinity_input *input,
+				 struct trinity_req *req)
+{
+	struct trinity_model *model;
+	int32_t err;
+
+	model = trinity_get_model_by_id(drv, input->config.model_id);
+	if (!model) {
+		dev_info(drv_to_dev_ptr(drv), "Unable to find the model");
+		return -EINVAL;
+	}
+
+	/* skip to submit this req */
+	if (model->config.program_size == 0 &&
+	    input->config.output_mode != TRINITY_OUTPUT_HW)
+		return 0;
+
+	trinity_model_get(model);
+
+	err = trinity_hwmem_import_dmabuf_begin(drv_to_dev_ptr(drv),
+						input->config.dbuf_fd,
+						&input->import_info);
+	if (err < 0)
+		return err;
+
+	req->model = model;
+	err = trinity_submit_req(drv, req);
+	if (err == 0)
+		return 0;
+
+	if (err != -ECANCELED)
+		trinity_hwmem_import_dmabuf_end(&input->import_info);
+	return err;
+}
+
+/**
+ * trinity_ioctl() - A common callback for unlocked_ioctl() in file_operations for
+ *		a Trinity device node.
+ *
+ * @f: A file instance of the opened device node
+ * @cmd: The target IOCTL command to be handled
+ * @arg: A user argument
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct trinity_driver *drv = f->private_data;
+	const struct trinity_desc *desc = drv->desc;
+	ssize_t err = 0L;
+
+	switch (cmd) {
+	case TRINITY_IOCTL_GET_VERSION: {
+		if (copy_to_user((uint32_t __user *)arg, &(desc->ver),
+				 sizeof((desc->ver))))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_GET_API_LEVEL: {
+		uint32_t api_level = TRINITY_API_LEVEL;
+
+		if (copy_to_user((uint32_t __user *)arg, &api_level,
+				 sizeof(api_level)))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_GET_STATE: {
+		enum trinity_state ready;
+
+		ready = drv->desc->get_state(drv);
+		if (copy_to_user((enum trinity_state __user *)arg, &ready,
+				 sizeof(ready)))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_GET_TOPS: {
+		if (copy_to_user((uint32_t __user *)arg, &(drv->tops),
+				 sizeof((drv->tops))))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_GET_DSPM: {
+		if (copy_to_user((uint32_t __user *)arg, &(drv->dspm),
+				 sizeof((drv->dspm))))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_GET_NEXT_REQUEST: {
+		int32_t req_id = atomic_inc_return(&drv->global_req_id);
+
+		if (copy_to_user((int32_t __user *)arg, &req_id,
+				 sizeof(req_id)))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_HWMEM_ALLOC: {
+		struct trinity_ioctl_hwmem hwmem;
+
+		if (copy_from_user(&hwmem, (size_t __user *)arg, sizeof(hwmem)))
+			return -EFAULT;
+
+		err = trinity_hwmem_alloc(drv_to_dev_ptr(drv), hwmem.size,
+					  hwmem.type);
+		if (err >= 0)
+			trinity_stat_app_total_alloc(drv, hwmem.size);
+		break;
+	}
+	case TRINITY_IOCTL_HWMEM_DEALLOC: {
+		struct trinity_ioctl_hwmem hwmem;
+		struct dma_buf *dbuf;
+
+		if (copy_from_user(&hwmem, (size_t __user *)arg, sizeof(hwmem)))
+			return -EFAULT;
+
+		dbuf = dma_buf_get(hwmem.dbuf_fd);
+		if (IS_ERR(dbuf))
+			return PTR_ERR(dbuf);
+
+		err = trinity_hwmem_free(drv_to_dev_ptr(drv), hwmem.dbuf_fd);
+		if (err == 0)
+			trinity_stat_app_total_freed(drv, dbuf->size);
+		break;
+	}
+	case TRINITY_IOCTL_REGISTER_MODEL: {
+		struct trinity_model *model =
+			kzalloc(sizeof(struct trinity_model), GFP_KERNEL);
+
+		if (IS_ERR_OR_NULL(model))
+			return -ENOMEM;
+
+		if (copy_from_user(&model->config,
+				   (struct trinity_model __user *)arg,
+				   sizeof(model->config))) {
+			kfree(model);
+			return -EFAULT;
+		}
+
+		err = trinity_register_model(drv, model);
+		if (err < 0)
+			break;
+
+		if (copy_to_user((struct trinity_model __user *)arg,
+				 &model->config, sizeof(model->config)))
+			return -EFAULT;
+		break;
+	}
+	case TRINITY_IOCTL_DEREGISTER_MODEL: {
+		uint64_t id;
+
+		if (copy_from_user(&id, (uint64_t __user *)arg, sizeof(id)))
+			return -EFAULT;
+
+		err = trinity_deregister_model(drv, id);
+		break;
+	}
+	case TRINITY_IOCTL_RUN_INPUT: {
+		struct trinity_req *req;
+		struct trinity_input *input;
+
+		req = drv->desc->alloc_req(drv);
+		if (!req)
+			return -ENOMEM;
+		req->drv = drv;
+		req->time_started = ktime_get();
+
+		input = &(req->input);
+		/** run input based on config received from the user */
+		if (copy_from_user(&input->config,
+				   (struct trinity_input __user *)arg,
+				   sizeof(input->config))) {
+			drv->desc->dealloc_req(drv, req);
+			return -EACCES;
+		}
+
+		err = trinity_run_input(drv, input, req);
+		if (err < 0) {
+			drv->desc->dealloc_req(drv, req);
+			return err;
+		}
+
+		if (copy_to_user((struct trinity_input __user *)arg,
+				 &input->config, sizeof(input->config))) {
+			drv->desc->dealloc_req(drv, req);
+			return -EACCES;
+		}
+
+		/* this will be freed when stop request is called */
+		if (!req->is_kernel)
+			drv->desc->dealloc_req(drv, req);
+
+		break;
+	}
+	case TRINITY_IOCTL_STOP_REQUESTS: {
+		if (drv->desc->stop_reqs)
+			schedule_work(&drv->work_stop);
+		break;
+	}
+	case TRINITY_IOCTL_STAT_CURRENT_APP: {
+		struct trinity_ioctl_stat_app ioctl_stat_app;
+
+		if (copy_from_user(&ioctl_stat_app,
+				   (struct trinity_ioctl_stat_app __user *)arg,
+				   sizeof(ioctl_stat_app)))
+			return -EACCES;
+
+		trinity_stat_app_copy_ioctl(drv, &ioctl_stat_app);
+
+		if (copy_to_user((struct trinity_ioctl_stat_app __user *)arg,
+				 &ioctl_stat_app, sizeof(ioctl_stat_app)))
+			return -EACCES;
+		break;
+	}
+	case TRINITY_IOCTL_STAT_APPS: {
+		struct trinity_ioctl_stat_apps ioctl_stat_apps;
+
+		if (copy_from_user(&ioctl_stat_apps,
+				   (struct trinity_ioctl_stat_apps __user *)arg,
+				   sizeof(ioctl_stat_apps)))
+			return -EACCES;
+
+		trinity_stat_apps_copy_ioctl(drv, &ioctl_stat_apps);
+
+		if (copy_to_user((struct trinity_ioctl_stat_apps __user *)arg,
+				 &ioctl_stat_apps, sizeof(ioctl_stat_apps)))
+			return -EACCES;
+		break;
+	}
+	case TRINITY_IOCTL_STAT_REQS: {
+		struct trinity_ioctl_stat_reqs ioctl_stat_reqs;
+
+		if (copy_from_user(&ioctl_stat_reqs,
+				   (struct trinity_ioctl_stat_reqs __user *)arg,
+				   sizeof(ioctl_stat_reqs)))
+			return -EACCES;
+
+		if (ioctl_stat_reqs.app_id == 0)
+			ioctl_stat_reqs.app_id = trinity_get_app_id();
+
+		trinity_stat_reqs_copy_ioctl(drv, &ioctl_stat_reqs);
+
+		if (copy_to_user((struct trinity_ioctl_stat_reqs __user *)arg,
+				 &ioctl_stat_reqs, sizeof(ioctl_stat_reqs)))
+			return -EACCES;
+		break;
+	}
+	case TRINITY_IOCTL_GET_PROFILE_META: {
+		struct trinity_ioctl_profile_meta profile;
+
+		if (copy_from_user(
+			    &profile,
+			    (struct trinity_ioctl_profile_meta __user *)arg,
+			    sizeof(profile)))
+			return -EACCES;
+
+		if (drv->desc->get_profile_meta) {
+			err = drv->desc->get_profile_meta(drv, &profile);
+		} else {
+			profile.total_cycles = -1;
+			profile.total_ops = 0;
+			profile.profile_size = 0;
+			profile.input_footprint = -1;
+			profile.output_footprint = -1;
+		}
+
+		if (copy_to_user((struct trinity_ioctl_profile_meta __user *)arg,
+				 &profile, sizeof(profile)))
+			return -EACCES;
+		break;
+	}
+	case TRINITY_IOCTL_GET_PROFILE_BUFF: {
+		struct trinity_ioctl_profile_buff profile;
+
+		if (copy_from_user(
+			    &profile,
+			    (struct trinity_ioctl_profile_buff __user *)arg,
+			    sizeof(profile)))
+			return -EACCES;
+
+		if (drv->desc->get_profile_buff)
+			err = drv->desc->get_profile_buff(drv, &profile);
+
+		if (copy_to_user((struct trinity_ioctl_profile_buff __user *)arg,
+				 &profile, sizeof(profile)))
+			return -EACCES;
+
+		break;
+	}
+	case TRINITY_IOCTL_FPGA_MEMCPY: {
+		struct trinity_ioctl_fpga_memcpy fpga;
+		struct trinity_hwmem_import import_info;
+		struct iommu_domain *domain;
+		phys_addr_t paddr;
+		void __iomem *vaddr;
+		uint32_t val;
+		uint64_t i;
+
+		if (copy_from_user(
+			    &fpga,
+			    (struct trinity_ioctl_fpga_memcpy __user *)arg,
+			    sizeof(fpga)))
+			return -EFAULT;
+
+		/* make sure that dbuf_off is PAGE_SIZE aligned */
+		if (!IS_ALIGNED(fpga.dbuf_off, PAGE_SIZE)) {
+			dev_err(drv->dev, "Unaligned dmabuf offset: 0x%x\n",
+				fpga.dbuf_off);
+			return -EINVAL;
+		}
+
+		err = trinity_hwmem_import_dmabuf_begin(
+			drv_to_dev_ptr(drv), fpga.dbuf_fd, &import_info);
+		if (err)
+			return err;
+
+		domain = iommu_get_domain_for_dev(drv->dev);
+		paddr = trinity_get_paddr(domain, import_info.dma_addr);
+
+		trinity_hwmem_import_dmabuf_end(&import_info);
+
+		vaddr = ioremap(paddr + fpga.dbuf_off,
+				PAGE_ALIGN(fpga.user_size));
+		if (vaddr == NULL) {
+			dev_err(drv->dev, "Unable to ioremap %lx",
+				(unsigned long)paddr);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < fpga.user_size; i += sizeof(uint32_t)) {
+			val = ioread32((char *)vaddr + i);
+			if (copy_to_user(((char __user *)fpga.user_addr) + i,
+					 &val, sizeof(uint32_t))) {
+				err = -EFAULT;
+				break;
+			}
+		}
+
+		iounmap(vaddr);
+
+		break;
+	}
+	default:
+		return -ENOTTY;
+	}
+
+	return err;
+}
+
 /**
  * trinity_release() - A common callback for close() in file_operations for a
  *		Trinity	device node. If there are device-specific data to be
@@ -121,14 +759,24 @@ int trinity_release(struct inode *inode, struct file *file)
 	if (drv->verbose)
 		dev_info(drv_to_dev_ptr(drv), "%s\n", "Device closed");
 
+	trinity_stat_app_set_status(drv, TRINITY_APP_STATUS_TERMINATED);
+
 	mutex_lock(&drv->lock);
 	drv->opened = drv->opened - 1;
 	if (drv->opened == 0) {
+		/* block newly incoming requests */
+		trinity_sched_suspend();
+
 		/* wait already submitted requests */
 		if (drv->desc->drain_reqs)
 			drv->desc->drain_reqs(drv);
 
+		/* deregister models owned by this device handle */
+		trinity_deregister_models_owned(drv);
+
 		drv->desc->set_state(drv, TRINITY_STATE_PAUSE);
+
+		trinity_sched_resume();
 	}
 	mutex_unlock(&drv->lock);
 
@@ -216,6 +864,8 @@ int trinity_open(struct inode *inode, struct file *f)
 	if (drv->verbose)
 		dev_info(drv_to_dev_ptr(drv), "%s\n", "Device opened");
 
+	trinity_stat_app_set_status(drv, TRINITY_APP_STATUS_STARTED);
+
 out:
 	mutex_unlock(&drv->lock);
 
@@ -301,10 +951,20 @@ static void trinity_common_init(struct device *dev)
 	if (!trinity_is_empty())
 		return;
 
+	trinity_reset_device(dev, true);
+	trinity_model_htable_init();
+
+	if (trinity_pm_runtime_init(dev) < 0)
+		dev_warn(dev, "Unable to initialize runtime pm\n");
+
+	if (trinity_debug_init() < 0)
+		dev_warn(dev, "Unable to initialize debugfs\n");
+
+	if (trinity_sched_init(dev) < 0)
+		dev_warn(dev, "Unable to initialize scheduler\n");
+
 	if (trinity_declare_dma_memory(dev) < 0)
 		dev_warn(dev, "Failed to declare DMA memory\n");
-
-	/* Common init codes */
 }
 
 static void trinity_common_exit(void)
@@ -313,7 +973,8 @@ static void trinity_common_exit(void)
 		return;
 
 	trinity_release_dma_memory();
-	/* Common deinit codes */
+	trinity_debug_exit();
+	trinity_sched_exit();
 }
 
 static int trinity_set_device_id(struct trinity_driver *drv)
@@ -454,6 +1115,7 @@ int trinity_probe(struct platform_device *pdev, const struct trinity_desc *desc)
 		dev_err(dev, "IRQ is not supported");
 		return irq_out;
 	}
+	trinity_set_irq_affinity(irq_out);
 
 	/* get the IRQ number from DT and set handlers for it */
 	err = devm_request_irq(dev, irq_out, desc->handle_irq,
@@ -478,8 +1140,26 @@ int trinity_probe(struct platform_device *pdev, const struct trinity_desc *desc)
 		goto err_cleanup;
 	}
 
+	err = trinity_sysfs_init(drv);
+	if (err < 0) {
+		dev_err(dev, "failed to initialize sysfs for a trinity device");
+		goto err_cleanup;
+	}
+
+	err = trinity_debug_add(drv);
+	if (err < 0) {
+		dev_err(dev,
+			"failed to add a debugging feature to the trinity device");
+		goto err_cleanup_sysfs;
+	}
+
+	trinity_stat_init(drv);
+
 	return 0;
 
+err_cleanup_sysfs:
+	trinity_sysfs_cleanup(drv);
+
 err_cleanup:
 	spin_lock(&trinity_lock);
 	clear_bit(drv->dev_id, &dev_bitmap[dev->id]);
@@ -508,6 +1188,10 @@ int trinity_remove(struct platform_device *pdev,
 	drv = (struct trinity_driver *)platform_get_drvdata(pdev);
 	dev = drv_to_dev_ptr(drv);
 
+	trinity_stat_fini(drv);
+	trinity_debug_remove(drv);
+	trinity_sysfs_cleanup(drv);
+
 	spin_lock(&trinity_lock);
 	clear_bit(drv->dev_id, &dev_bitmap[dev->id]);
 	spin_unlock(&trinity_lock);
diff --git a/drivers/misc/trinity/trinity_common.h b/drivers/misc/trinity/trinity_common.h
index c70f66722391..461abca88c96 100644
--- a/drivers/misc/trinity/trinity_common.h
+++ b/drivers/misc/trinity/trinity_common.h
@@ -27,6 +27,9 @@
 #include <linux/types.h>
 #include <uapi/misc/trinity.h>
 
+#include "sched/sched.h"
+#include "trinity_hwmem.h"
+
 /** Default timeout to wait for opening device in jiffies */
 #define TRINITY_DEV_TIMEOUT_MSEC (3000)
 #define TRINITY_DEV_TIMEOUT (msecs_to_jiffies(TRINITY_DEV_TIMEOUT_MSEC))
@@ -289,6 +292,7 @@ struct trinity_driver {
  */
 struct trinity_model {
 	struct trinity_ioctl_model config;
+	struct trinity_hwmem_import import_info;
 	struct hlist_bl_node hnode;
 	int32_t owner_id;
 	struct kref refcnt;
@@ -301,6 +305,7 @@ struct trinity_model {
  */
 struct trinity_input {
 	struct trinity_ioctl_input config;
+	struct trinity_hwmem_import import_info;
 } __packed;
 
 /**
@@ -377,14 +382,19 @@ static inline int32_t trinity_get_app_id(void)
  */
 int trinity_create_node(struct trinity_driver *drv);
 void trinity_destroy_node(struct trinity_driver *drv);
-int trinity_wait_ready(struct trinity_driver *drv);
+int trinity_idu_load(struct trinity_driver *drv, const char *dirpath);
 void trinity_init_model_htable(const struct trinity_driver *drv,
 			       struct trinity_model_htable *ht);
+int32_t trinity_get_app_id(void);
+void trinity_finish_req(struct trinity_driver *drv, struct trinity_req *req);
 phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr);
+struct trinity_sched_desc *get_trinity_sched(struct trinity_req *req);
+int trinity_wait_ready(struct trinity_driver *drv);
 
 /* File operations */
 int trinity_open(struct inode *inode, struct file *f);
 int trinity_release(struct inode *inode, struct file *f);
+long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
 
 /* Device probing and removing */
 int trinity_probe(struct platform_device *pdev,
@@ -399,7 +409,6 @@ int trinity_sysfs_cleanup(struct trinity_driver *drv);
 /* debugfs operations */
 int trinity_debug_init(void);
 void trinity_debug_exit(void);
-
 int trinity_debug_add(struct trinity_driver *drv);
 void trinity_debug_remove(struct trinity_driver *drv);
 void trinity_debug_clear(struct trinity_driver *drv, unsigned long msg_max);
@@ -412,4 +421,14 @@ void trinity_debug_dump_input(struct trinity_driver *drv,
 			      const struct trinity_input *input,
 			      const char *fmt, ...);
 
+/* pm operations */
+int trinity_pm_runtime_init(struct device *dev);
+int trinity_pm_runtime_forbid(struct device *dev);
+void trinity_pm_runtime_allow(struct device *dev);
+void trinity_pm_runtime_attach(struct device *dev);
+
+void trinity_reset_device(struct device *dev, bool do_test);
+void trinity_set_irq_affinity(int irq);
+void trinity_monitor_invalid_access(void);
+
 #endif /* __TRINITY_COMMON_H__ */
diff --git a/drivers/misc/trinity/trinity_pm.c b/drivers/misc/trinity/trinity_pm.c
new file mode 100644
index 000000000000..bf292e168422
--- /dev/null
+++ b/drivers/misc/trinity/trinity_pm.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Power Management Controls
+ *
+ * Copyright (C) 2022 Samsung Electronics
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+
+/**
+ * trinity_pm_runtime_init() - Initialize runtime power management
+ *
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_pm_runtime_init(struct device *dev)
+{
+	return 0;
+}
+
+/**
+ * trinity_pm_runtime_forbid() - Block runtime power management
+ *
+ * @dev: device structure
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_pm_runtime_forbid(struct device *dev)
+{
+	pm_runtime_forbid(dev);
+	return 0;
+}
+
+/**
+ * trinity_pm_runtime_allow() - Allow runtime power management
+ *
+ * @dev: device structure
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+void trinity_pm_runtime_allow(struct device *dev)
+{
+	pm_runtime_allow(dev);
+}
+
+/**
+ * trinity_pm_runtime_allow() - Attach runtime power management
+ *
+ * @drv: An instance of the trinity driver
+ */
+void trinity_pm_runtime_attach(struct device *drv)
+{
+}
+
+/**
+ * trinity_mmap_from_resv_mem() - Reset device
+ *
+ * @dev: device structure
+ * @do_test: test reset
+ */
+void trinity_reset_device(struct device *dev, bool do_test)
+{
+}
+
+/**
+ * trinity_set_irq_affinity() - Set affinity for the IRQ
+ *
+ * @irq: IRQ number
+ */
+void trinity_set_irq_affinity(int irq)
+{
+}
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index 9e616466c57b..ddc1739afdd8 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -162,13 +162,48 @@ struct triv2_pdata {
 
 	/* back buffer for context switching */
 	struct trinity_resv_mem back_buf;
+
+	/* profiling */
+	struct trinity_resv_mem prof_buf;
+	struct mutex prof_lock;
+	DECLARE_HASHTABLE(prof_htable, TRIV2_PROFILE_HASH_BITS);
 };
 
+static void triv2_handle_cmd_done(struct trinity_driver *drv,
+				  struct triv2_cmd *cmd, bool timeout);
 static void triv2_setup_buffers(struct trinity_driver *drv);
 static int triv2_idu_load(struct trinity_driver *drv, const char *dirpath,
 			  bool load_files);
 
 static LIST_HEAD(triv2_driver_list);
+static struct hlist_bl_head triv2_model_node_hlist[TRIV2_MODEL_HASH_SIZE];
+
+static struct triv2_profile *
+triv2_find_profile(const struct trinity_driver *drv, int req_id)
+{
+	/* find profile */
+
+	return NULL;
+}
+
+static void triv2_fini_profile(struct trinity_resv_mem *prof_buf)
+{
+	/* finish profile */
+}
+
+static void triv2_init_profile(struct trinity_driver *drv,
+			       unsigned long profile_size)
+{
+	/* init profile */
+}
+
+static int32_t triv2_check_profile(struct trinity_driver *drv,
+				   struct trinity_req *req)
+{
+	/* check profile */
+
+	return 0;
+}
 
 /**
  * triv2_get_state() - Get state (TRINITY_STATE_READY/TRINITY_STATE_PAUSE) of the device.
@@ -230,6 +265,31 @@ static void triv2_set_state(const struct trinity_driver *drv,
 	}
 }
 
+/**
+ * triv2_sync_segt_entries() - synchronize the segment table entries
+ */
+static int triv2_sync_segt_entries(const struct trinity_driver *drv,
+				   struct triv2_req *req)
+{
+#ifdef ARM
+	struct trinity_input *input = &(req->req.input);
+	int i;
+
+	/* flush all caches for heavy models */
+	if (req->total_segment_size > TRIV2_CACHE_FLUSH_THRESHOLD ||
+	    /* cannot handle external segments for kernel requests */
+	    req->kernel != NULL) {
+		flush_cache_all();
+		return 0;
+	}
+
+	for (i = 0; i < input->config.num_segments; ++i)
+		__cpuc_flush_dcache_area(req->seg_import[i].addr,
+					 req->seg_import[i].buf->size);
+#endif
+	return 0;
+}
+
 static void triv2_wakeup_cp(const struct trinity_driver *drv)
 {
 	void *addr =
@@ -241,18 +301,55 @@ static void triv2_wakeup_cp(const struct trinity_driver *drv)
 static void triv2_cancel_reqs(struct trinity_driver *drv)
 {
 	struct triv2_cmd_info *info;
+	struct triv2_cmd *cmd;
 	unsigned long flags;
+	int slot;
 
 	info = TRIV2_DRV_GET_CMD_INFO(drv);
 	spin_lock_irqsave(&info->lock, flags);
 
-	/* set command done */
+	slot = find_first_bit(info->bitmap, TRIV2_MAX_CMDSLOTS);
+	while (slot < TRIV2_MAX_CMDSLOTS) {
+		cmd = TRIV2_GET_CMD_FROM_SLOT(info, slot);
+		triv2_handle_cmd_done(drv, cmd, true);
+		slot = find_next_bit(info->bitmap, TRIV2_MAX_CMDSLOTS,
+				     slot + 1);
+	}
+
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
+static void triv2_drain_reqs(struct trinity_driver *drv)
+{
+	struct triv2_cmd_info *info;
+	unsigned long flags;
+	int cur_retries, max_retries = 1000; /* 1-sec */
+	int slot;
+
+	cur_retries = 0;
+	info = TRIV2_DRV_GET_CMD_INFO(drv);
+retry:
+	spin_lock_irqsave(&info->lock, flags);
+
+	/* wait until all bits are unset */
+	slot = find_first_bit(info->bitmap, TRIV2_MAX_CMDSLOTS);
+	if (slot < TRIV2_MAX_CMDSLOTS) {
+		spin_unlock_irqrestore(&info->lock, flags);
+
+		usleep_range(900, 1100);
+		if (cur_retries++ < max_retries)
+			goto retry;
+
+		spin_lock_irqsave(&info->lock, flags);
+	}
 
 	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void triv2_reset_devices(struct trinity_driver *drv, bool do_test)
 {
+	trinity_reset_device(drv_to_dev_ptr(drv), do_test);
+
 	triv2_setup_buffers(drv);
 	triv2_idu_load(drv, NULL, false);
 }
@@ -270,6 +367,12 @@ static void triv2_reset(struct trinity_driver *drv)
 
 	dev_err(dev, "NPU HW reset started");
 
+	/* block runtime pm suspend */
+	trinity_pm_runtime_forbid(dev);
+
+	/* block new incoming requests first */
+	trinity_sched_suspend();
+
 	/* cancel all requests by force */
 	list_for_each_entry(pdata, &triv2_driver_list, list)
 		triv2_cancel_reqs(pdata->drv);
@@ -286,22 +389,331 @@ static void triv2_reset(struct trinity_driver *drv)
 		do_test = false;
 	}
 
+	/* resume scheduler */
+	trinity_sched_resume();
+
+	trinity_pm_runtime_allow(dev);
+
 	dev_err(dev, "NPU HW reset completed");
 
 	list_for_each_entry(pdata, &triv2_driver_list, list)
 		mutex_unlock(&pdata->drv->lock);
 }
 
-static long triv2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+static void triv2_clear_cmd(struct trinity_driver *drv, struct triv2_req *req,
+			    struct triv2_cmd *cmd)
+{
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+
+	cmd_info->reqs[req->cmd_slot] = NULL;
+	clear_bit(req->cmd_slot, cmd_info->bitmap);
+	req->cmd_slot = -1;
+
+	memset_io(cmd, '\x00', sizeof(struct triv2_cmd));
+}
+
+static void triv2_handle_cmd_done(struct trinity_driver *drv,
+				  struct triv2_cmd *cmd, bool timeout)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	struct triv2_req *t_req;
+	struct trinity_req *req;
+	struct trinity_sched_desc *sched;
+	uint32_t slot = cmd->slot;
+	int64_t time_diff;
+
+	t_req = cmd_info->reqs[slot];
+	if (!t_req) {
+		dev_err(dev, "Failed to find the req\n");
+		return;
+	}
+
+	req = &(t_req->req);
+	req->stat->completed = ktime_get();
+	req->stat->status = TRINITY_REQ_STATUS_FINISHED;
+
+	time_diff = TIME_DIFF_US(req->stat->completed, req->stat->scheduled);
+	if (time_diff < 0) {
+		dev_warn(dev, "Detected invalid inference time of request\n");
+	} else {
+		req->stat->prev_time = (uint32_t)time_diff;
+		req->stat->prev_cycles = cmd->total_cycles;
+		req->stat->num_runs++;
+		req->stat->total_time += req->stat->prev_time;
+	}
+
+	t_req->total_cycles = cmd->total_cycles;
+	t_req->profile_offset = cmd->profile_offset;
+
+	triv2_clear_cmd(drv, t_req, cmd);
+
+	/* notify to the scheduler */
+	sched = get_trinity_sched(req);
+	if (sched && sched->notify)
+		sched->notify(req, timeout);
+
+	/* notify to the caller */
+	if (!req->is_kernel)
+		complete_all(&req->complete);
+}
+
+static void triv2_handle_timeout(struct trinity_driver *drv,
+				 struct trinity_req *req)
+{
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	struct triv2_cmd *cmd;
+	struct triv2_req *t;
+	unsigned long flags;
+
+	t = TRIV2_GET_REQ(req);
+
+	spin_lock_irqsave(&cmd_info->lock, flags);
+	if (t->cmd_slot >= 0) {
+		/* Timeout! check whether it's not handled in irq handler */
+		cmd = TRIV2_GET_CMD_FROM_SLOT(cmd_info, t->cmd_slot);
+		triv2_handle_cmd_done(drv, cmd, true);
+	}
+	spin_unlock_irqrestore(&cmd_info->lock, flags);
+}
+
+/**
+ * triv2_stop_reqs() - stop the submitted reqs to the driver
+ *
+ * In case of already-executed req, each device needs to determine the policy
+ * depending its capability to terminate the running one.
+ */
+static void triv2_stop_reqs(struct work_struct *work)
+{
+	struct trinity_driver *drv;
+
+	drv = container_of(work, struct trinity_driver, work_stop);
+	if (drv == NULL)
+		return;
+
+	triv2_cancel_reqs(drv);
+}
+
+static void triv2_handle_irq_cmds(struct trinity_driver *drv)
+{
+	struct triv2_cmd_info *info;
+	struct triv2_cmd *cmd;
+	unsigned long flags;
+	int slot;
+
+	info = TRIV2_DRV_GET_CMD_INFO(drv);
+	spin_lock_irqsave(&info->lock, flags);
+
+	/** Search the bitmap to find the completed CMDs */
+	slot = find_first_bit(info->bitmap, TRIV2_MAX_CMDSLOTS);
+	while (slot < TRIV2_MAX_CMDSLOTS) {
+		cmd = TRIV2_GET_CMD_FROM_SLOT(info, slot);
+		if (cmd->status == STATUS_CMD_DONE)
+			triv2_handle_cmd_done(drv, cmd, false);
+		slot = find_next_bit(info->bitmap, TRIV2_MAX_CMDSLOTS,
+				     slot + 1);
+	}
+
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
+/**
+ * triv2_handle_irq() - An IRQ handler to be called when a registered IRQ (IRQ_OUT) occurs.
+ */
+static irqreturn_t triv2_handle_irq(int irq_no, void *dev_id)
+{
+	struct miscdevice *_mdev;
+	struct trinity_driver *drv;
+	void __iomem *addr;
+	uint32_t interrupt;
+	uint32_t reg;
+
+	_mdev = (struct miscdevice *)dev_id;
+	drv = container_of(_mdev, struct trinity_driver, mdev);
+
+	/**
+	 * Verify that the IRQ is actually from the NPU
+	 * This is required as IRQ_SHARED is used when setting up IRQ
+	 */
+	addr = trinity_get_iomem_addr(drv->mmreg_vaddr[2],
+				      OFFSET_CBOX_EXT_IRQ_STA);
+	reg = ioread32(addr);
+
+	interrupt = reg & MASK_CP_SWI_STA;
+	if (interrupt == 0)
+		return IRQ_NONE;
+
+	/** Clear the interrupt first */
+	addr = trinity_get_iomem_addr(drv->mmreg_vaddr[2],
+				      OFFSET_CBOX_CP_SWI_CLR);
+	iowrite32(1, addr);
+
+	triv2_handle_irq_cmds(drv);
+	return IRQ_HANDLED;
+}
+
+/**
+ * triv2_prepare_req() - evaluate the physical address of entries in the segment table
+ */
+static int32_t triv2_prepare_req(struct trinity_driver *drv,
+				 struct trinity_req *req)
 {
-	/* handle ioctl */
+	struct triv2_req *t = TRIV2_GET_REQ(req);
+	struct trinity_input *input = &(req->input);
+	struct trinity_hwmem_import *segt_import = &(input->import_info);
+	int32_t *segtable_dbuffd_base;
+	uint32_t *segtable_extra_base;
+	int ret, i;
+
+	if (input->config.num_segments == 0)
+		return -EINVAL;
+
+	if (input->config.num_segments > TRIV2_MAX_SEGMENTS)
+		return -ERANGE;
+
+	t->seg_import = kcalloc(input->config.num_segments,
+				sizeof(struct trinity_hwmem_import),
+				GFP_KERNEL);
+	if (!t->seg_import)
+		return -ENOMEM;
+
+	/* dmabuf fd to be resolved */
+	segtable_dbuffd_base = segt_import->addr;
+	/* extra value (e.g., offset or size) */
+	segtable_extra_base = segt_import->addr + HALF_PAGE_SIZE;
+
+#ifdef ARM
+	/* sync segment table */
+	__cpuc_flush_dcache_area(input->import_info.addr,
+				 input->import_info.buf->size);
+#endif
+
+	for (i = 0; i < input->config.num_segments; ++i) {
+		struct trinity_hwmem_import *import;
+		int32_t fd = segtable_dbuffd_base[i];
+		dma_addr_t daddr;
+
+		if (fd < 0) {
+			uint32_t idx = (uint32_t)((fd + 1) * -1);
+			struct triv2_kernel_req *kreq;
+
+			/* it's for kernel input/output */
+			if (!req->is_kernel) {
+				req->is_kernel = true;
+				kreq = kzalloc(sizeof(*kreq), GFP_KERNEL);
+				if (!kreq) {
+					ret = -ENOMEM;
+					goto err;
+				}
+				t->kernel = kreq;
+			}
+
+			kreq = t->kernel;
+			if (idx < TRIV2_MAX_TENSORS) {
+				kreq->in_seg_idx[idx] = i;
+				kreq->in_seg_size[idx] = segtable_extra_base[i];
+				t->total_segment_size += kreq->in_seg_size[idx];
+			} else if (idx < TRIV2_MAX_TENSORS * 2) {
+				idx -= TRIV2_MAX_TENSORS;
+				kreq->out_seg_idx[idx] = i;
+				kreq->out_seg_size[idx] =
+					segtable_extra_base[i];
+				t->total_segment_size +=
+					kreq->out_seg_size[idx];
+			} else {
+				dev_err(drv_to_dev_ptr(drv),
+					"Invalid external segment (idx: %u)",
+					idx);
+				ret = -EINVAL;
+				goto err;
+			}
+			continue;
+		}
+
+		import = &(t->seg_import[i]);
+		ret = trinity_hwmem_import_dmabuf_begin(drv_to_dev_ptr(drv), fd,
+							import);
+		if (ret) {
+			dev_err(drv_to_dev_ptr(drv),
+				"%d-th segment with fd (%d) seems invalid: %d",
+				i, fd, ret);
+			goto err;
+		}
+
+		t->total_segment_size += import->buf->size;
+
+		/** @todo Use a local ptr variable */
+		daddr = import->dma_addr;
+		daddr += segtable_extra_base[i];
+
+		iowrite32(TRIV2_IDU_ADDR(daddr),
+			  segt_import->addr + i * sizeof(u32));
+	}
+
+	/* set the dma address of DSPM (reserved index: TRIV2_MAX_SEGMENTS - 1) */
+	if (drv->dspm > 0) {
+		struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+
+		iowrite32(TRIV2_IDU_ADDR(pdata->idu_dsp.dspm),
+			  segt_import->addr +
+				  (TRIV2_MAX_SEGMENTS - 1) * sizeof(u32));
+	}
 
 	return 0;
+
+err:
+	kfree(t->seg_import);
+	t->seg_import = NULL;
+	return ret;
+}
+
+/**
+ * triv2_invoke_req() - Invoke a req on the device. Note that all configurations
+ * required by running should be done before invocation of this function.
+ */
+static int32_t triv2_invoke_req(struct trinity_driver *drv,
+				struct trinity_req *req, void *sched_data)
+{
+	/* invoke request */
+
+	return 0;
+}
+
+static long triv2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct trinity_driver *drv = f->private_data;
+	struct device *dev = drv_to_dev_ptr(drv);
+	long ret;
+
+	if (trinity_pm_runtime_forbid(dev) != 0)
+		return -EBUSY;
+
+	ret = trinity_ioctl(f, cmd, arg);
+
+	trinity_pm_runtime_allow(dev);
+
+	return ret;
 }
 
 static int triv2_open(struct inode *inode, struct file *f)
 {
-	return trinity_open(inode, f);
+	struct miscdevice *miscdev;
+	struct trinity_driver *drv;
+	struct device *dev;
+	int ret;
+
+	miscdev = (struct miscdevice *)f->private_data;
+	drv = container_of(miscdev, struct trinity_driver, mdev);
+	dev = drv_to_dev_ptr(drv);
+
+	if (trinity_pm_runtime_forbid(dev) != 0)
+		return -EBUSY;
+
+	ret = trinity_open(inode, f);
+
+	trinity_pm_runtime_allow(dev);
+
+	return ret;
 }
 
 static const struct file_operations triv2_fops = {
@@ -624,11 +1036,13 @@ static void triv2_setup_buffers(struct trinity_driver *drv)
 	struct iommu_domain *domain;
 	struct trinity_resv_mem *cmd_buf;
 	struct trinity_resv_mem *back_buf;
+	struct trinity_resv_mem *prof_buf;
 	phys_addr_t paddr;
 
 	domain = iommu_get_domain_for_dev(dev);
 	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
 	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
+	prof_buf = TRIV2_DRV_GET_PROF_BUF(drv);
 
 	/* command */
 	paddr = trinity_get_paddr(domain, cmd_buf->daddr);
@@ -641,14 +1055,34 @@ static void triv2_setup_buffers(struct trinity_driver *drv)
 					 OFFSET_NPU_BACK_ADDR));
 	iowrite32(back_buf->size, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
 							 OFFSET_NPU_BACK_SIZE));
+
+	/* profile */
+	if (prof_buf->size > 0) {
+		paddr = trinity_get_paddr(domain, prof_buf->daddr);
+		iowrite32(TRIV2_IDU_ADDR(paddr),
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_ADDR));
+		iowrite32(prof_buf->size,
+			  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						 OFFSET_NPU_PROF_SIZE));
+	} else {
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_ADDR));
+		iowrite32(0, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+						    OFFSET_NPU_PROF_SIZE));
+	}
 }
 
 static int32_t triv2_init_pdata(struct trinity_driver *drv)
 {
+	struct device *dev = drv_to_dev_ptr(drv);
 	struct triv2_pdata *pdata;
 	struct triv2_cmd_info *cmd_info;
 	struct trinity_resv_mem *cmd_buf;
 	struct trinity_resv_mem *back_buf;
+	int status;
+
+	trinity_pm_runtime_attach(dev);
 
 	/* alloc triv2 pdata */
 	drv->pdata = kzalloc(sizeof(struct triv2_pdata), GFP_KERNEL);
@@ -662,13 +1096,42 @@ static int32_t triv2_init_pdata(struct trinity_driver *drv)
 	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
 	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
 
+	mutex_init(&pdata->prof_lock);
 	spin_lock_init(&cmd_info->lock);
 	/* init cmd bitmap */
 	bitmap_zero(cmd_info->bitmap, TRIV2_MAX_CMDSLOTS);
 
+	/* alloc command buffer */
+	status = trinity_alloc_from_resv_mem(PAGE_SIZE, cmd_buf, false);
+	if (status < 0) {
+		dev_err(dev, "Couldn't allocate memory for cmd slots");
+		goto free_pdata;
+	}
+	/* ensure cmd buffer is null-initialized, which is visible in NPU as well */
+	memset_io(cmd_buf->vaddr, '\x00', PAGE_SIZE);
+
+	/* alloc backup buffer for preemption (GBUF + DSPM) */
+	status = trinity_alloc_from_resv_mem(TRIV2_DLA_GBUFFER_SIZE + drv->dspm,
+					     back_buf, false);
+	if (status < 0) {
+		dev_err(dev,
+			"Couldn't allocate memory for context backup buffer");
+		goto free_cmd_info;
+	}
+
+	triv2_setup_buffers(drv);
 	list_add_tail(&pdata->list, &triv2_driver_list);
 
 	return 0;
+
+free_cmd_info:
+	dma_free_wc(drv_to_dev_ptr(drv), PAGE_SIZE, cmd_buf->vaddr,
+		    cmd_buf->daddr);
+free_pdata:
+	kfree(drv->pdata);
+	drv->pdata = NULL;
+
+	return status;
 }
 
 static int32_t parse_idu_property(struct device *dev,
@@ -812,6 +1275,98 @@ static struct trinity_desc triv2_desc = {
 	.dealloc_req = triv2_dealloc_req,
 	.prepare_req = triv2_prepare_req,
 	.invoke_req = triv2_invoke_req,
+	/* profile */
+	.init_profile = triv2_init_profile,
+	.check_profile = triv2_check_profile,
+	.get_profile_meta = triv2_get_profile_meta,
+	.get_profile_buff = triv2_get_profile_buff,
+	.show_profile = triv2_show_profile,
+	.destroy_profile = triv2_destroy_profile,
+	/* etc. */
+	.handle_timeout = triv2_handle_timeout,
+	.stop_reqs = triv2_stop_reqs,
+	.drain_reqs = triv2_drain_reqs,
+	.handle_irq = triv2_handle_irq,
+};
+
+static int triv2_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int triv2_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int triv2_runtime_suspended;
+static int triv2_runtime_resumed;
+
+static int triv2_runtime_suspend(struct device *dev)
+{
+	struct trinity_driver *drv;
+
+	drv = (struct trinity_driver *)dev_get_drvdata(dev);
+	if (!drv) {
+		dev_warn(dev, "Cannot find driver data");
+		return 0;
+	}
+
+	mutex_lock(&drv->lock);
+
+	/* 1) Ensure that the scheduler was suspended */
+	trinity_sched_suspend();
+
+	/* 2) Set pause state if it's in ready state */
+	if (triv2_get_state(drv) == TRINITY_STATE_READY)
+		triv2_set_state(drv, TRINITY_STATE_PAUSE);
+
+	mutex_unlock(&drv->lock);
+
+	triv2_runtime_suspended++;
+
+	return 0;
+}
+
+static int triv2_runtime_resume(struct device *dev)
+{
+	struct trinity_driver *drv;
+
+	drv = (struct trinity_driver *)dev_get_drvdata(dev);
+	if (!drv) {
+		dev_warn(dev, "Cannot find driver data");
+		return 0;
+	}
+
+	/* 0) Reset NPU devices (only once) */
+	trinity_reset_device(dev, triv2_runtime_resumed == 0);
+
+	mutex_lock(&drv->lock);
+
+	/* 1) Restore IDU setup */
+	triv2_setup_buffers(drv);
+	triv2_idu_load(drv, NULL, false);
+
+	/* 2) Set ready state if it was in ready state before */
+	if (drv->opened > 0)
+		triv2_set_state(drv, TRINITY_STATE_READY);
+
+	/* 3) Resume the req scheduler */
+	trinity_sched_resume();
+
+	mutex_unlock(&drv->lock);
+
+	if (++triv2_runtime_resumed == triv2_runtime_suspended)
+		triv2_runtime_resumed = triv2_runtime_suspended = 0;
+
+	return 0;
+}
+
+static const struct dev_pm_ops triv2_dev_pm_ops = {
+	// clang-format off
+	SET_SYSTEM_SLEEP_PM_OPS(triv2_suspend, triv2_resume)
+	SET_RUNTIME_PM_OPS(triv2_runtime_suspend, triv2_runtime_resume, NULL)
+	// clang-format on
 };
 
 static const struct of_device_id trinity_match[] = {
-- 
2.25.1

