Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE84C5EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiB0U5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiB0U5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 560292FFE7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2601B106F;
        Sun, 27 Feb 2022 12:56:40 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD08D3F66F;
        Sun, 27 Feb 2022 12:56:38 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 11/16] firmware: arm_scmi: Add test driver generic notification helpers
Date:   Sun, 27 Feb 2022 20:56:03 +0000
Message-Id: <20220227205608.30812-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227205608.30812-1-cristian.marussi@arm.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few generic helpers to allow the test driver to register a common
notifier block and related read routines in order to test notifications
when supported by the specific SCMI protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm_scmi/scmi_test_driver/test_common.c   | 177 ++++++++++++++++++
 .../arm_scmi/scmi_test_driver/test_common.h   |  28 +++
 2 files changed, 205 insertions(+)

diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
index cbe2eec4f2ac..c44fe702196e 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
@@ -14,6 +14,22 @@
 
 #include "test_common.h"
 
+struct scmi_test_setup *
+scmi_test_tsp_shallow_copy(struct device *dev,
+			   struct scmi_test_setup *tsp)
+{
+	struct scmi_test_setup *tsp_copy;
+
+	tsp_copy = devm_kzalloc(dev, sizeof(*tsp_copy), GFP_KERNEL);
+	if (!tsp_copy)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(tsp_copy, tsp, sizeof(*tsp_copy));
+	tsp_copy->n_priv = NULL;
+
+	return tsp_copy;
+}
+
 /* Common File operations */
 
 /**
@@ -70,6 +86,167 @@ int scmi_test_release(struct inode *ino, struct file *filp)
 	return 0;
 }
 
+int scmi_test_generic_notif_cb(struct notifier_block *nb, unsigned long event,
+			       void *data)
+{
+	struct scmi_test_notif_reports *nrep;
+	void *d_report;
+
+	nrep = container_of(nb, struct scmi_test_notif_reports, notif_nb);
+
+	mutex_lock(&nrep->mtx);
+	d_report = ((u8 *)nrep->reports) +
+		    ((nrep->count % nrep->max_reports) * nrep->report_sz);
+	memcpy(d_report, data, nrep->report_sz);
+	nrep->count++;
+	mutex_unlock(&nrep->mtx);
+
+	return NOTIFY_OK;
+}
+
+static struct scmi_test_notif_reports *
+scmi_test_notif_reports_alloc(struct scmi_device *sdev,
+			      size_t report_sz, unsigned int max_reports,
+			      u8 proto_id, u8 evt_id, const u32 *src_id,
+			      notifier_fn_t notif_cb)
+{
+	int ret;
+	struct scmi_test_notif_reports *nrep;
+	struct device *dev = &sdev->dev;
+	const struct scmi_notify_ops *n_ops = sdev->handle->notify_ops;
+
+	nrep = devm_kzalloc(dev, sizeof(*nrep), GFP_KERNEL);
+	if (!nrep)
+		return ERR_PTR(-ENOMEM);
+
+	nrep->reports = devm_kcalloc(dev, max_reports, report_sz, GFP_KERNEL);
+	if (!nrep->reports) {
+		devm_kfree(dev, nrep);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	nrep->proto_id = proto_id;
+	nrep->evt_id = evt_id;
+	if (src_id)
+		nrep->src_id = *src_id;
+	else
+		nrep->src_id = 0xffffffff;
+	nrep->report_sz = report_sz;
+	nrep->max_reports = max_reports;
+	mutex_init(&nrep->mtx);
+
+	if (notif_cb)
+		nrep->notif_nb.notifier_call = notif_cb;
+	else
+		nrep->notif_nb.notifier_call = scmi_test_generic_notif_cb;
+
+	ret = n_ops->devm_event_notifier_register(sdev,
+						  proto_id, evt_id, src_id,
+						  &nrep->notif_nb);
+	if (ret) {
+		devm_kfree(dev, nrep->reports);
+		devm_kfree(dev, nrep);
+		return ERR_PTR(ret);
+	}
+
+	return nrep;
+}
+
+static int scmi_test_notif_reports_free(struct scmi_device *sdev,
+					struct scmi_test_notif_reports *nrep)
+{
+	int ret;
+	struct device *dev = &sdev->dev;
+	const struct scmi_notify_ops *n_ops = sdev->handle->notify_ops;
+
+	if (!nrep)
+		return -EINVAL;
+
+	ret = n_ops->devm_event_notifier_unregister(sdev, &nrep->notif_nb);
+	if (ret)
+		return ret;
+
+	devm_kfree(dev, nrep->reports);
+	devm_kfree(dev, nrep);
+
+	return 0;
+}
+
+int scmi_test_notif_manage(struct scmi_test_setup *tsp, bool enabled,
+			   u8 proto_id, u8 evt_id, const u32 *src_id,
+			   size_t rep_sz, notifier_fn_t notif_cb)
+{
+	int ret;
+
+	/* For testing allow enable only for one notifier at time */
+	if ((enabled && tsp->n_priv) || (!enabled && !tsp->n_priv))
+		return -EINVAL;
+
+	if (enabled) {
+		tsp->n_priv =
+			scmi_test_notif_reports_alloc(tsp->sdev, rep_sz,
+						      SCMI_TEST_MAX_REPORTS,
+						      proto_id, evt_id,
+						      src_id, notif_cb);
+		if (IS_ERR(tsp->n_priv)) {
+			ret = PTR_ERR(tsp->n_priv);
+			tsp->n_priv = NULL;
+			return ret;
+		}
+	} else {
+		ret = scmi_test_notif_reports_free(tsp->sdev, tsp->n_priv);
+		if (ret)
+			return ret;
+
+		tsp->n_priv = NULL;
+	}
+
+	return 0;
+}
+
+ssize_t scmi_test_notif_reports_read(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct scmi_test_buffer *data = filp->private_data;
+	struct scmi_test_setup *tsp = filp->f_inode->i_private;
+	struct scmi_test_notif_reports *nrep = tsp->n_priv;
+
+	if (!data || !nrep)
+		return 0;
+
+	if (!data->used) {
+		int i, cnt;
+
+		mutex_lock(&nrep->mtx);
+		cnt = nrep->count >= nrep->max_reports ?
+			nrep->max_reports : nrep->count;
+		for (i = 0; i < cnt; i++) {
+			u8 *rep;
+			int j;
+
+			data->used += scnprintf(data->buf + data->used,
+						data->len - data->used,
+				       "[%02u/%02u|%u] - |%02X|%u|%u| = Report: ",
+						i,
+						nrep->max_reports, nrep->count,
+						nrep->proto_id, nrep->evt_id,
+						nrep->src_id);
+
+			rep = ((u8 *)nrep->reports) + i * nrep->report_sz;
+			for (j = 0; j < nrep->report_sz; j++)
+				data->used += scnprintf(data->buf + data->used,
+							data->len - data->used,
+							"%02X ", rep[j]);
+
+			data->used += scnprintf(data->buf + data->used,
+						data->len - data->used, "\n");
+		}
+		mutex_unlock(&nrep->mtx);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, data->buf, data->used);
+}
+
 int scmi_test_fixed_buffer_open(struct inode *ino, struct file *filp)
 {
 	struct scmi_test_buffer *data;
diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
index e02c2521f090..93c05db0ebff 100644
--- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
+++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
@@ -66,8 +66,36 @@ struct scmi_test_buffer {
 	unsigned char buf[];
 };
 
+#define SCMI_TEST_MAX_REPORTS	20
+struct scmi_test_notif_reports {
+	u8 proto_id;
+	u8 evt_id;
+	u32 src_id;
+	unsigned int max_reports;
+	size_t report_sz;
+	void *reports;
+	unsigned int count;
+	struct notifier_block notif_nb;
+	/* Protect access to notification reports */
+	struct mutex mtx;
+};
+
 extern const struct file_operations scmi_test_string_file_fops;
 
+int scmi_test_generic_notif_cb(struct notifier_block *nb, unsigned long event,
+			       void *data);
+
+int scmi_test_notif_manage(struct scmi_test_setup *tsp, bool enabled,
+			   u8 proto_id, u8 evt_id, const u32 *src_id,
+			   size_t rep_sz, notifier_fn_t notif_cb);
+
+ssize_t scmi_test_notif_reports_read(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos);
+
+struct scmi_test_setup *
+scmi_test_tsp_shallow_copy(struct device *dev,
+			   struct scmi_test_setup *tsp);
+
 int scmi_test_setup_open(struct inode *ino, struct file *filp);
 int scmi_test_fixed_buffer_open(struct inode *ino, struct file *filp);
 int scmi_test_release(struct inode *ino, struct file *filp);
-- 
2.17.1

