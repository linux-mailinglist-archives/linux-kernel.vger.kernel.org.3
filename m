Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F34F92F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiDHKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiDHKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:32:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2CDED9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:30:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so12147925wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMG1g7rr9n+ottfcmWcC55uPNKGnZnLQG5qxdVFfJ/c=;
        b=GuN0iCXM2lz9mjvP6iCzd1e6rt5RPWJ4nuZzuAoDx9NGZHH5tDKPTiy7cAaUL5oRNe
         2XLkko5EpqaKsJHS92hd9/F/7EJGNUCcK/kgY41x0mhgLq1wC8Tb25SjOpJKLc17SrPs
         sw/kQskX+44pPyNZRYH5GEPFCLQ8DUSzAxoLkRmHT3cJQBi6za7uPIfDwD1E2gk9q2Iy
         MmiiotFxmzNl3MQYH1pdYhyYFRCpu4ANdni/IMv+Q5k1H4NplH67700EAIufIXm7Fs3H
         WP6mmanTZx0mJ9ZhpOOH1VT3NcNuO2Ve3VvisNFx6vvaXpCvmHYjAjboqXzIdax2xvZF
         ynWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMG1g7rr9n+ottfcmWcC55uPNKGnZnLQG5qxdVFfJ/c=;
        b=3FeTj+z9+8F8Vd4+Crq/0JYQqfl8/qcmXp8Ll0Vq3dtxRE1CBPHn4biD4lfjk7F5us
         t3Ouy9grgv1hylY3MNuy1fONKV6RT6UrSy81OYhFYELXGxVPtvhi2MakxoMQzfqf0Au2
         fQCD/gERHynCBiSorI0FbpDKuqo2q0x9Felhb0qbzNUX04255aAHKpAFeBp1WBtBRMjx
         uww7/JvAAtBVMcsFjuKf10b4k3D2M+eYZYjCiIitJeG4eoUKGf0yM+yVX5JM4hnHvl9t
         HmbsXTYvAy8zSQ9lsry3i/RhnGnPmDR9X9ZwaBrcGXOYPwe6Q8jT+OjKwWnWzHhk3oAv
         9alg==
X-Gm-Message-State: AOAM530X0H0+03LPqv4pmiUD40MJIUrl0pPUllx4jDHCPJQEK0QcLN0I
        YNQ8CKyBqgNees32IhZo9f5buw==
X-Google-Smtp-Source: ABdhPJwZ7jM3+apmEvFrdIdfPicFrGgQZzpdM5I4/wXm33byVs6x5S9P0Qn+4Q4HU8JohFPXPiB7yA==
X-Received: by 2002:a5d:47c1:0:b0:206:1c38:ab87 with SMTP id o1-20020a5d47c1000000b002061c38ab87mr13380817wrc.620.1649413834040;
        Fri, 08 Apr 2022 03:30:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n2-20020adfb742000000b00205eda3b3c1sm20181920wre.34.2022.04.08.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:30:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Date:   Fri,  8 Apr 2022 12:30:24 +0200
Message-Id: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several pointers to 'struct scsi_host_template' do not modify it, so
made them const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/hosts.c      |  2 +-
 drivers/scsi/scsi_error.c | 17 +++++++++--------
 drivers/scsi/scsi_proc.c  |  2 +-
 drivers/scsi/scsi_sysfs.c |  6 +++---
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index f69b77cbf538..65616a01761a 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -209,7 +209,7 @@ EXPORT_SYMBOL(scsi_remove_host);
 int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 			   struct device *dma_dev)
 {
-	struct scsi_host_template *sht = shost->hostt;
+	const struct scsi_host_template *sht = shost->hostt;
 	int error = -EINVAL;
 
 	shost_printk(KERN_INFO, shost, "%s\n",
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index cdaca13ac1f1..0bca4108aae2 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -58,7 +58,7 @@
 #define HOST_RESET_SETTLE_TIME  (10)
 
 static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
-static enum scsi_disposition scsi_try_to_abort_cmd(struct scsi_host_template *,
+static enum scsi_disposition scsi_try_to_abort_cmd(const struct scsi_host_template *,
 						   struct scsi_cmnd *);
 
 void scsi_eh_wakeup(struct Scsi_Host *shost)
@@ -692,7 +692,7 @@ EXPORT_SYMBOL_GPL(scsi_check_sense);
 
 static void scsi_handle_queue_ramp_up(struct scsi_device *sdev)
 {
-	struct scsi_host_template *sht = sdev->host->hostt;
+	const struct scsi_host_template *sht = sdev->host->hostt;
 	struct scsi_device *tmp_sdev;
 
 	if (!sht->track_queue_depth ||
@@ -724,7 +724,7 @@ static void scsi_handle_queue_ramp_up(struct scsi_device *sdev)
 
 static void scsi_handle_queue_full(struct scsi_device *sdev)
 {
-	struct scsi_host_template *sht = sdev->host->hostt;
+	const struct scsi_host_template *sht = sdev->host->hostt;
 	struct scsi_device *tmp_sdev;
 
 	if (!sht->track_queue_depth)
@@ -833,7 +833,7 @@ static enum scsi_disposition scsi_try_host_reset(struct scsi_cmnd *scmd)
 	unsigned long flags;
 	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
-	struct scsi_host_template *hostt = host->hostt;
+	const struct scsi_host_template *hostt = host->hostt;
 
 	SCSI_LOG_ERROR_RECOVERY(3,
 		shost_printk(KERN_INFO, host, "Snd Host RST\n"));
@@ -863,7 +863,7 @@ static enum scsi_disposition scsi_try_bus_reset(struct scsi_cmnd *scmd)
 	unsigned long flags;
 	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
-	struct scsi_host_template *hostt = host->hostt;
+	const struct scsi_host_template *hostt = host->hostt;
 
 	SCSI_LOG_ERROR_RECOVERY(3, scmd_printk(KERN_INFO, scmd,
 		"%s: Snd Bus RST\n", __func__));
@@ -905,7 +905,7 @@ static enum scsi_disposition scsi_try_target_reset(struct scsi_cmnd *scmd)
 	unsigned long flags;
 	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
-	struct scsi_host_template *hostt = host->hostt;
+	const struct scsi_host_template *hostt = host->hostt;
 
 	if (!hostt->eh_target_reset_handler)
 		return FAILED;
@@ -934,7 +934,7 @@ static enum scsi_disposition scsi_try_target_reset(struct scsi_cmnd *scmd)
 static enum scsi_disposition scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
 {
 	enum scsi_disposition rtn;
-	struct scsi_host_template *hostt = scmd->device->host->hostt;
+	const struct scsi_host_template *hostt = scmd->device->host->hostt;
 
 	if (!hostt->eh_device_reset_handler)
 		return FAILED;
@@ -963,7 +963,8 @@ static enum scsi_disposition scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
  *    link down on FibreChannel)
  */
 static enum scsi_disposition
-scsi_try_to_abort_cmd(struct scsi_host_template *hostt, struct scsi_cmnd *scmd)
+scsi_try_to_abort_cmd(const struct scsi_host_template *hostt,
+		      struct scsi_cmnd *scmd)
 {
 	if (!hostt->eh_abort_handler)
 		return FAILED;
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 95aee1ad1383..6f023a2f951b 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -137,7 +137,7 @@ void scsi_proc_hostdir_rm(struct scsi_host_template *sht)
  */
 void scsi_proc_host_add(struct Scsi_Host *shost)
 {
-	struct scsi_host_template *sht = shost->hostt;
+	const struct scsi_host_template *sht = shost->hostt;
 	struct proc_dir_entry *p;
 	char name[10];
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dc6872e352bd..cdc6e1ab8ce7 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -296,7 +296,7 @@ store_host_reset(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
-	struct scsi_host_template *sht = shost->hostt;
+	const struct scsi_host_template *sht = shost->hostt;
 	int ret = -EINVAL;
 	int type;
 
@@ -1017,7 +1017,7 @@ sdev_store_queue_depth(struct device *dev, struct device_attribute *attr,
 {
 	int depth, retval;
 	struct scsi_device *sdev = to_scsi_device(dev);
-	struct scsi_host_template *sht = sdev->host->hostt;
+	const struct scsi_host_template *sht = sdev->host->hostt;
 
 	if (!sht->change_queue_depth)
 		return -EINVAL;
@@ -1584,7 +1584,7 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
 {
 	unsigned long flags;
 	struct Scsi_Host *shost = sdev->host;
-	struct scsi_host_template *hostt = shost->hostt;
+	const struct scsi_host_template *hostt = shost->hostt;
 	struct scsi_target  *starget = sdev->sdev_target;
 
 	device_initialize(&sdev->sdev_gendev);
-- 
2.32.0

