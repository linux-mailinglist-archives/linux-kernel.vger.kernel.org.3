Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071C597C13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbiHRDNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbiHRDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:12:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5569DB45
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:12:48 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11c5505dba2so409990fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=A20rvbZgmNPYkLfaiZt9qnCUQAw3Kt0N7s6tmp7a2KA=;
        b=d0N6gzVrMnOa9Y/dDy8fMZYFqA5PMaZG3eAjzlvMXr5a9CbN5JAl0iM7/i+FhD+pof
         8fT/ZsxgPDbFUn3iHSupTnCSZFI1C6OkKmqvpbVhyqjgiTr9MFeBIaDVqUcy3tYjXxUf
         hQb7Ud6zWKMPhMjLlfSWEb12BXsAVlJcsslIUmScsydhHMGNfRa25ns5c798P4NCXI4w
         UZZ7i25oQMoqOtO3sD3j7NyM3HAZLPpmy5ks6EvpIggwJHNVxuGDzkOXnGnXIG2KgmJH
         IOQZAw33DIWNMB3Spbv5otYHir5lNCncTzYfyVbzCpMsApI3uZPQ4vKL2YmSn0AHCWQB
         gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=A20rvbZgmNPYkLfaiZt9qnCUQAw3Kt0N7s6tmp7a2KA=;
        b=yghoMpdPcORD6Bb8Dg5fT3/k6gNiKKd0NMqQ6HuK4C3tK2oUAy4yeCTeQMaCyXuYAo
         WbgCbPPvX9/I3/irIgTUyU2Av7KvWk2t0oKQA+/kfH5sSatd+gcDssVSz3w9i0KfKd6h
         PIteHOKEpQ7kEhSghh4ZVRBUp2vJXF1RBCgziqbQTC1DCYXf5xrw+BDb5BCqHfnUSvAt
         XTgU0h8YLmr+tNlq3KemtXoMPHK+YQ3UQPB68ESe4vzhMK3JH8AO3CM8gc8SFh48o0iF
         2cf15g1HegDrIsiyGFuplpKabas2hWLlgnI7VzSo8s7cK5O2ac9jMJv8KLm45qSrpAMb
         T/lA==
X-Gm-Message-State: ACgBeo2xNy0JfSAGFECTaoMoTU6NXDIKhqjJm9rHCCaQhmc7N8SKwZBs
        vHk5pbOOu62fBOcVUOsMjw9aWg==
X-Google-Smtp-Source: AA6agR70di5vYAPux1jq7TKIwR6Nf17GlttCYSNA8yuAtElp5y0LvYgzYj3A/TvjzVfpf37friDIww==
X-Received: by 2002:a05:6870:f5a6:b0:10e:450c:5c32 with SMTP id eh38-20020a056870f5a600b0010e450c5c32mr449980oab.135.1660792367408;
        Wed, 17 Aug 2022 20:12:47 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b0011c25975c1dsm112382oao.25.2022.08.17.20.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:12:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
Date:   Wed, 17 Aug 2022 20:15:10 -0700
Message-Id: <20220818031512.319310-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818031512.319310-1-bjorn.andersson@linaro.org>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC GLINK service runs on one of the co-processors of some modern
Qualcomm platforms and implements USB-C and battery managements. It uses
a message based protocol over GLINK for communication with the OS, hence
the name.

The driver implemented provides the rpmsg device for communication and
uses auxilirary bus to spawn off individual devices in respsective
subsystem. The auxilirary devices are spawned off from a
platform_device, so that the drm_bridge is available early, to allow the
DisplayPort driver to probe even before the remoteproc has spun up.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/Kconfig            |  14 ++
 drivers/soc/qcom/Makefile           |   1 +
 drivers/soc/qcom/pmic_glink.c       | 336 ++++++++++++++++++++++++++++
 include/linux/soc/qcom/pmic_glink.h |  32 +++
 4 files changed, 383 insertions(+)
 create mode 100644 drivers/soc/qcom/pmic_glink.c
 create mode 100644 include/linux/soc/qcom/pmic_glink.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e0d7a5459562..2289f5e0d5ad 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -91,6 +91,20 @@ config QCOM_PDR_HELPERS
 	tristate
 	select QCOM_QMI_HELPERS
 
+config QCOM_PMIC_GLINK
+	tristate "Qualcomm PMIC GLINK driver"
+	depends on RPMSG
+	depends on TYPEC
+	depends on DRM
+	select QCOM_PDR_HELPERS
+	help
+	  The Qualcomm PMIC GLINK driver provides access, over GLINK, to the
+	  USB and battery firmware running on one of the coprocessors in
+	  several modern Qualcomm platforms.
+
+	  Say yes here to support USB-C and battery status on modern Qualcomm
+	  platforms.
+
 config QCOM_QMI_HELPERS
 	tristate
 	depends on NET
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index d66604aff2b0..fbbd1231e554 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
 obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
+obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
new file mode 100644
index 000000000000..d42127521eca
--- /dev/null
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Linaro Ltd
+ */
+#include <linux/auxiliary_bus.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/pdr.h>
+#include <linux/soc/qcom/pmic_glink.h>
+
+struct pmic_glink {
+	struct device *dev;
+	struct pdr_handle *pdr;
+
+	struct rpmsg_endpoint *ept;
+
+	struct auxiliary_device altmode_aux;
+	struct auxiliary_device ps_aux;
+	struct auxiliary_device ucsi_aux;
+
+	/* serializing client_state and pdr_state updates */
+	struct mutex state_lock;
+	unsigned int client_state;
+	unsigned int pdr_state;
+
+	/* serializing clients list updates */
+	struct mutex client_lock;
+	struct list_head clients;
+};
+
+static struct pmic_glink *__pmic_glink;
+static DEFINE_MUTEX(__pmic_glink_lock);
+
+struct pmic_glink_client {
+	struct list_head node;
+
+	struct pmic_glink *pmic;
+	unsigned int id;
+
+	void (*cb)(const void *data, size_t len, void *priv);
+	void (*pdr_notify)(void *priv, int state);
+	void *priv;
+};
+
+static void _devm_pmic_glink_release_client(struct device *dev, void *res)
+{
+	struct pmic_glink_client *client = *(struct pmic_glink_client **)res;
+	struct pmic_glink *pg = client->pmic;
+
+	mutex_lock(&pg->client_lock);
+	list_del(&client->node);
+	mutex_unlock(&pg->client_lock);
+}
+
+struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
+							  unsigned int id,
+							  void (*cb)(const void *, size_t, void *),
+							  void (*pdr)(void *, int),
+							  void *priv)
+{
+	struct pmic_glink_client *client;
+	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
+
+	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return ERR_PTR(-ENOMEM);
+
+	client->pmic = pg;
+	client->id = id;
+	client->cb = cb;
+	client->pdr_notify = pdr;
+	client->priv = priv;
+
+	mutex_lock(&pg->client_lock);
+	list_add(&client->node, &pg->clients);
+	mutex_unlock(&pg->client_lock);
+
+	devres_add(dev, client);
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);
+
+int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
+{
+	struct pmic_glink *pg = client->pmic;
+
+	return rpmsg_send(pg->ept, data, len);
+}
+EXPORT_SYMBOL_GPL(pmic_glink_send);
+
+static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+				     int len, void *priv, u32 addr)
+{
+	struct pmic_glink_client *client;
+	struct pmic_glink_hdr *hdr;
+	struct pmic_glink *pg = dev_get_drvdata(&rpdev->dev);
+
+	if (len < sizeof(*hdr)) {
+		dev_warn(pg->dev, "ignoring truncated message\n");
+		return 0;
+	}
+
+	hdr = data;
+
+	list_for_each_entry(client, &pg->clients, node) {
+		if (client->id == le32_to_cpu(hdr->owner))
+			client->cb(data, len, client->priv);
+	}
+
+	return 0;
+}
+
+static void pmic_glink_aux_release(struct device *dev) {}
+
+static int pmic_glink_add_aux_device(struct pmic_glink *pg,
+				     struct auxiliary_device *aux,
+				     const char *name)
+{
+	struct device *parent = pg->dev;
+	int ret;
+
+	aux->name = name;
+	aux->dev.parent = parent;
+	aux->dev.release = pmic_glink_aux_release;
+	device_set_of_node_from_dev(&aux->dev, parent);
+	ret = auxiliary_device_init(aux);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(aux);
+	if (ret)
+		auxiliary_device_uninit(aux);
+
+	return ret;
+}
+
+static void pmic_glink_del_aux_device(struct pmic_glink *pg,
+				      struct auxiliary_device *aux)
+{
+	auxiliary_device_delete(aux);
+	auxiliary_device_uninit(aux);
+}
+
+static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
+{
+	struct pmic_glink_client *client;
+	unsigned int new_state = pg->client_state;
+
+	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+			new_state = SERVREG_SERVICE_STATE_UP;
+	} else {
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+			new_state = SERVREG_SERVICE_STATE_DOWN;
+	}
+
+	if (new_state != pg->client_state) {
+		list_for_each_entry(client, &pg->clients, node)
+			client->pdr_notify(client->priv, new_state);
+		pg->client_state = new_state;
+	}
+}
+
+static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
+{
+	struct pmic_glink *pg = priv;
+
+	mutex_lock(&pg->state_lock);
+	pg->pdr_state = state;
+
+	pmic_glink_state_notify_clients(pg);
+	mutex_unlock(&pg->state_lock);
+}
+
+static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct pmic_glink *pg = __pmic_glink;
+	int ret = 0;
+
+	mutex_lock(&__pmic_glink_lock);
+	if (!pg) {
+		ret = dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
+		goto out_unlock;
+	}
+
+	dev_set_drvdata(&rpdev->dev, pg);
+
+	mutex_lock(&pg->state_lock);
+	pg->ept = rpdev->ept;
+	pmic_glink_state_notify_clients(pg);
+	mutex_unlock(&pg->state_lock);
+
+out_unlock:
+	mutex_unlock(&__pmic_glink_lock);
+	return ret;
+}
+
+static void pmic_glink_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct pmic_glink *pg;
+
+	mutex_lock(&__pmic_glink_lock);
+	pg = __pmic_glink;
+	if (!pg)
+		goto out_unlock;
+
+	mutex_lock(&pg->state_lock);
+	pg->ept = NULL;
+	pmic_glink_state_notify_clients(pg);
+	mutex_unlock(&pg->state_lock);
+out_unlock:
+	mutex_unlock(&__pmic_glink_lock);
+}
+
+static const struct rpmsg_device_id pmic_glink_rpmsg_id_match[] = {
+	{ "PMIC_RTR_ADSP_APPS" },
+	{}
+};
+
+static struct rpmsg_driver pmic_glink_rpmsg_driver = {
+	.probe = pmic_glink_rpmsg_probe,
+	.remove = pmic_glink_rpmsg_remove,
+	.callback = pmic_glink_rpmsg_callback,
+	.id_table = pmic_glink_rpmsg_id_match,
+	.drv  = {
+		.name  = "qcom_pmic_glink_rpmsg",
+	},
+};
+
+static int pmic_glink_probe(struct platform_device *pdev)
+{
+	struct pdr_service *service;
+	struct pmic_glink *pg;
+	int ret;
+
+	pg = devm_kzalloc(&pdev->dev, sizeof(*pg), GFP_KERNEL);
+	if (!pg)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, pg);
+
+	pg->dev = &pdev->dev;
+
+	INIT_LIST_HEAD(&pg->clients);
+	mutex_init(&pg->client_lock);
+	mutex_init(&pg->state_lock);
+
+	ret = pmic_glink_add_aux_device(pg, &pg->altmode_aux, "altmode");
+	if (ret)
+		return ret;
+	ret = pmic_glink_add_aux_device(pg, &pg->ps_aux, "power-supply");
+	if (ret)
+		goto out_release_altmode_aux;
+
+	pg->pdr = pdr_handle_alloc(pmic_glink_pdr_callback, pg);
+	if (IS_ERR(pg->pdr)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(pg->pdr), "failed to initialize pdr\n");
+		goto out_release_aux_devices;
+	}
+
+	service = pdr_add_lookup(pg->pdr, "tms/servreg", "msm/adsp/charger_pd");
+	if (IS_ERR(service)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(service),
+				    "failed adding pdr lookup for charger_pd\n");
+		goto out_release_pdr_handle;
+	}
+
+	mutex_lock(&__pmic_glink_lock);
+	__pmic_glink = pg;
+	mutex_unlock(&__pmic_glink_lock);
+
+	return 0;
+
+out_release_pdr_handle:
+	pdr_handle_release(pg->pdr);
+out_release_aux_devices:
+	pmic_glink_del_aux_device(pg, &pg->ps_aux);
+out_release_altmode_aux:
+	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+
+	return ret;
+}
+
+static int pmic_glink_remove(struct platform_device *pdev)
+{
+	struct pmic_glink *pg = dev_get_drvdata(&pdev->dev);
+
+	pdr_handle_release(pg->pdr);
+
+	pmic_glink_del_aux_device(pg, &pg->ps_aux);
+	pmic_glink_del_aux_device(pg, &pg->altmode_aux);
+
+	mutex_lock(&__pmic_glink_lock);
+	__pmic_glink = NULL;
+	mutex_unlock(&__pmic_glink_lock);
+
+	return 0;
+}
+
+static const struct of_device_id pmic_glink_of_match[] = {
+	{ .compatible = "qcom,pmic-glink", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pmic_glink_of_match);
+
+static struct platform_driver pmic_glink_driver = {
+	.probe = pmic_glink_probe,
+	.remove = pmic_glink_remove,
+	.driver = {
+		.name = "qcom_pmic_glink",
+		.of_match_table = pmic_glink_of_match,
+	},
+};
+
+static int pmic_glink_init(void)
+{
+	platform_driver_register(&pmic_glink_driver);
+	register_rpmsg_driver(&pmic_glink_rpmsg_driver);
+
+	return 0;
+};
+module_init(pmic_glink_init);
+
+static void pmic_glink_exit(void)
+{
+	platform_driver_unregister(&pmic_glink_driver);
+	unregister_rpmsg_driver(&pmic_glink_rpmsg_driver);
+};
+module_exit(pmic_glink_exit);
+
+MODULE_DESCRIPTION("Qualcomm PMIC GLINK driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
new file mode 100644
index 000000000000..40470f8dfc1e
--- /dev/null
+++ b/include/linux/soc/qcom/pmic_glink.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd
+ */
+#ifndef __PMIC_GLINK_H__
+#define __PMIC_GLINK_H__
+
+struct pmic_glink;
+struct pmic_glink_client;
+
+#define PMIC_GLINK_OWNER_BATTMGR	32778
+#define PMIC_GLINK_OWNER_USBC		32779
+#define PMIC_GLINK_OWNER_USBC_PAN	32780
+
+#define PMIC_GLINK_REQ_RESP		1
+#define PMIC_GLINK_NOTIFY		2
+
+struct pmic_glink_hdr {
+	__le32 owner;
+	__le32 type;
+	__le32 opcode;
+};
+
+int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len);
+
+struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
+							  unsigned int id,
+							  void (*cb)(const void *, size_t, void *),
+							  void (*pdr)(void *, int),
+							  void *priv);
+
+#endif
-- 
2.35.1

