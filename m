Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23F5471236
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 07:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhLKGqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 01:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhLKGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:46:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B9EC061714;
        Fri, 10 Dec 2021 22:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=m/bupCjck7SxJ1A7FuvUBMcV3+Q621Kz/I2dJt2yOgQ=; b=IqdHkG0K6whIhKqFjDtE0wtmRi
        1FfmsLyX3yzBHgD0npJ3Thipx2HYM9BqEywbgwo0ecZw5jLPcJ0wS9B+UoX/r3PrnllSwAN3ZQkfn
        c+RmJ7sG40Ye2FexCw1xztW4WWQHIuMAu6aMw2naeqbLBj+bZLSjsXogCg0e3sbxM/sOnEWA1ax0O
        PCXl7RVmryoSG2tblidqJOQM44+SYqHEuIKvZF31AiSqDL2QQ0AvulduLiop/FbRGV+A0VyoovWxE
        SZz7+CGMClfM2fNqk+FZVvGgv+ax+Oo1mQHHxg2PEd8OxCjsG5R92Qu3OghSozRtcz3lhZlxYMI9c
        3LhiNBWA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvw98-004duM-Q4; Sat, 11 Dec 2021 06:46:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: q6v5: make symbols modular when QCOM_AOSS_QMP=m
Date:   Fri, 10 Dec 2021 22:46:14 -0800
Message-Id: <20211211064614.1315-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_QCOM_Q6V5_COMMON=y and CONFIG_QCOM_AOSS_QMP=m,
there are linker errors:

aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `q6v5_load_state_toggle':
qcom_q6v5.c:(.text+0xac): undefined reference to `qmp_send'
qcom_q6v5.c:(.text+0xac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `qmp_send'
aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_deinit':
(.text+0x204): undefined reference to `qmp_put'
(.text+0x204): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `qmp_put'

Fix these by requiring QCOM_Q6V5 symbols to be modular (=m) when
QCOM_AOSS_QMP=m.

Fixes: c1fe10d238c0 ("remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-remoteproc@vger.kernel.org
---
 drivers/remoteproc/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- next-2021-1210.orig/drivers/remoteproc/Kconfig
+++ next-2021-1210/drivers/remoteproc/Kconfig
@@ -176,6 +176,7 @@ config QCOM_Q6V5_ADSP
 	tristate "Qualcomm Technology Inc ADSP Peripheral Image Loader"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
+	depends on QCOM_AOSS_QMP
 	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
@@ -195,6 +196,7 @@ config QCOM_Q6V5_MSS
 	tristate "Qualcomm Hexagon V5 self-authenticating modem subsystem support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
+	depends on QCOM_AOSS_QMP
 	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
@@ -214,6 +216,7 @@ config QCOM_Q6V5_PAS
 	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
+	depends on QCOM_AOSS_QMP
 	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
@@ -235,6 +238,7 @@ config QCOM_Q6V5_WCSS
 	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
+	depends on QCOM_AOSS_QMP
 	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
