Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6648F3FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiAOBNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiAOBNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:13:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF805C061574;
        Fri, 14 Jan 2022 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j4X69JcLD6mdNWGbTcpDg4N2e78q2bD3JRVc0T2jhBs=; b=lS9h5WOextxA0Om5wNMAfwTXEa
        oh0VkAalNyGQuqUvoEJC2NPDtDNs2xeN9h6fXM0sQhTfxnvxIpmKPTJse7I6NcVErK8sxJMUN0WPJ
        CwvZwG8GDtRiDC7lb4bQDAwbXiiiNpbgqMaBDlt7/8/5m5cGiDXiEAjKtC6dlypZOppiJXP03g1Ee
        5Hu0R3InL5I1gy0L47RZafgBDJ/98wqceuGkCz8NoNEfE7NgOsSdATX+qGW/eMO5gNEqCHQ0yqvAn
        TZaYJuAMHimVlbSpT5iwGIkaF5EE3vGUBrpCv1cggDbY02o2Dd/caG6n7tnYHoqQWybl4mYVcpA70
        ri+kW4kQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8XdS-00AWnV-Ui; Sat, 15 Jan 2022 01:13:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] remoteproc: qcom: q6v5: fix service routines build errors
Date:   Fri, 14 Jan 2022 17:13:38 -0800
Message-Id: <20220115011338.2973-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_QCOM_AOSS_QMP=m and CONFIG_QCOM_Q6V5_MSS=y, the builtin
driver cannot call into the loadable module's low-level service
functions. Trying to build with that config combo causes linker errors.

There are two problems here. First, drivers/remoteproc/qcom_q6v5.c
should #include <linux/soc/qcom/qcom_aoss.h> for the definitions of
the service functions, depending on whether CONFIG_QCOM_AOSS_QMP is
set/enabled or not. Second, the qcom remoteproc drivers should depend
on QCOM_AOSS_QMP iff it is enabled (=y or =m) so that the qcom
remoteproc drivers can be built properly.

This prevents these build errors:

aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `q6v5_load_state_toggle':
qcom_q6v5.c:(.text+0xc4): undefined reference to `qmp_send'
aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_deinit':
(.text+0x2e4): undefined reference to `qmp_put'
aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_init':
(.text+0x778): undefined reference to `qmp_get'
aarch64-linux-ld: (.text+0x7d8): undefined reference to `qmp_put'

Fixes: c1fe10d238c0 ("remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org
Cc: Sibi Sankar <sibis@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>
---
 drivers/remoteproc/Kconfig     |    4 ++++
 drivers/remoteproc/qcom_q6v5.c |    1 +
 2 files changed, 5 insertions(+)

--- linux-next-20220114.orig/drivers/remoteproc/qcom_q6v5.c
+++ linux-next-20220114/drivers/remoteproc/qcom_q6v5.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/soc/qcom/qcom_aoss.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/remoteproc.h>
--- linux-next-20220114.orig/drivers/remoteproc/Kconfig
+++ linux-next-20220114/drivers/remoteproc/Kconfig
@@ -180,6 +180,7 @@ config QCOM_Q6V5_ADSP
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	select MFD_SYSCON
 	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
@@ -199,6 +200,7 @@ config QCOM_Q6V5_MSS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	select MFD_SYSCON
 	select QCOM_MDT_LOADER
 	select QCOM_PIL_INFO
@@ -218,6 +220,7 @@ config QCOM_Q6V5_PAS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	select MFD_SYSCON
 	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
@@ -239,6 +242,7 @@ config QCOM_Q6V5_WCSS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	select MFD_SYSCON
 	select QCOM_MDT_LOADER
 	select QCOM_PIL_INFO
