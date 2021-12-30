Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E0481CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhL3OMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:12:51 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40772 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233197AbhL3OMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:12:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V0Lr-zD_1640873567;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V0Lr-zD_1640873567)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 22:12:47 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next RESEND] firmware: qcom: scm: Fix some kernel-doc comments
Date:   Thu, 30 Dec 2021 22:12:45 +0800
Message-Id: <20211230141245.29444-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix qcom_scm_call(), qcom_scm_call_atomic,
and qcom_scm_cpu_power_down() kernel-doc comment to remove
remove warnings found by running scripts/kernel-doc, which
is caused by using 'make W=1'.
drivers/firmware/qcom_scm.c:191: warning: Function parameter or member
'res' not described in 'qcom_scm_call'
drivers/firmware/qcom_scm.c:191: warning: Excess function parameter
'svc_id' description in 'qcom_scm_call'
drivers/firmware/qcom_scm.c:191: warning: Excess function parameter
'cmd_id' description in 'qcom_scm_call'
drivers/firmware/qcom_scm.c:219: warning: Excess function parameter
'svc_id' description in 'qcom_scm_call_atomic'
drivers/firmware/qcom_scm.c:219: warning: Excess function parameter
'cmd_id' description in 'qcom_scm_call_atomic'
drivers/firmware/qcom_scm.c:360: warning: Function parameter or member
'flags' not described in 'qcom_scm_cpu_power_down'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/firmware/qcom_scm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 7db8066b19fd..9a699e2f7544 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -179,9 +179,8 @@ static enum qcom_scm_convention __get_convention(void)
 /**
  * qcom_scm_call() - Invoke a syscall in the secure world
  * @dev:	device
- * @svc_id:	service identifier
- * @cmd_id:	command identifier
  * @desc:	Descriptor structure containing arguments and return values
+ * @res:        Structure containing results from SMC/HVC call
  *
  * Sends a command to the SCM and waits for the command to finish processing.
  * This should *only* be called in pre-emptible context.
@@ -205,8 +204,6 @@ static int qcom_scm_call(struct device *dev, const struct qcom_scm_desc *desc,
 /**
  * qcom_scm_call_atomic() - atomic variation of qcom_scm_call()
  * @dev:	device
- * @svc_id:	service identifier
- * @cmd_id:	command identifier
  * @desc:	Descriptor structure containing arguments and return values
  * @res:	Structure containing results from SMC/HVC call
  *
@@ -350,7 +347,7 @@ EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
 
 /**
  * qcom_scm_cpu_power_down() - Power down the cpu
- * @flags - Flags to flush cache
+ * @flags:	Flags to flush cache
  *
  * This is an end point to power down cpu. If there was a pending interrupt,
  * the control would return from this function, otherwise, the cpu jumps to the
-- 
2.20.1.7.g153144c

