Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4344C1FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiBWXis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244881AbiBWXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:28 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5E5A09B;
        Wed, 23 Feb 2022 15:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645659476; x=1677195476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJO28cZ5d4onrWSSPwvwkejj4FA3oYjfcxSdxHBpzKY=;
  b=S+ys3OdwOMfnpBk52oM1FUhMEENXpOvn3mR2D/DpC0BaxxAwPrKvgOvd
   W0k9fXRGthrd9D+aXDRdQ5TICawPPCmjfYxm8MCReEK00rmddWLCNK8nN
   X5eU5GB7Cav0ujZH8GmtAGs8aQCS6KWRFhmL9L0yofjOZ3pAhruFoUzwF
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 15:37:56 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:37:56 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 15:37:55 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 04/11] gunyah: Common types and error codes for Gunyah hypercalls
Date:   Wed, 23 Feb 2022 15:37:22 -0800
Message-ID: <20220223233729.1571114-5-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223233729.1571114-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add architecture-independent standard error codes, types, and macros for
Gunyah hypercalls.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS            |  1 +
 include/linux/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 include/linux/gunyah.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e6a8488fa3e..59e7070f726a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8403,6 +8403,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/gunyah/
 F:	Documentation/virt/gunyah/
 F:	arch/arm64/include/asm/gunyah/
+F:	include/linux/gunyah.h
 
 H8/300 ARCHITECTURE
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
new file mode 100644
index 000000000000..8743bf4978e2
--- /dev/null
+++ b/include/linux/gunyah.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_H
+#define _GUNYAH_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/gunyah/hypercall.h>
+
+typedef u64 gh_capid_t;
+
+/* Common Gunyah macros */
+#define GH_CAPID_INVAL	U64_MAX
+
+#define GH_ERROR_OK			0
+#define GH_ERROR_UNIMPLEMENTED		-1
+
+#define GH_ERROR_ARG_INVAL		1
+#define GH_ERROR_ARG_SIZE		2
+#define GH_ERROR_ARG_ALIGN		3
+
+#define GH_ERROR_NOMEM			10
+
+#define GH_ERROR_ADDR_OVFL		20
+#define GH_ERROR_ADDR_UNFL		21
+#define GH_ERROR_ADDR_INVAL		22
+
+#define GH_ERROR_DENIED			30
+#define GH_ERROR_BUSY			31
+#define GH_ERROR_IDLE			32
+
+#define GH_ERROR_IRQ_BOUND		40
+#define GH_ERROR_IRQ_UNBOUND		41
+
+#define GH_ERROR_CSPACE_CAP_NULL	50
+#define GH_ERROR_CSPACE_CAP_REVOKED	51
+#define GH_ERROR_CSPACE_WRONG_OBJ_TYPE	52
+#define GH_ERROR_CSPACE_INSUF_RIGHTS	53
+#define GH_ERROR_CSPACE_FULL		54
+
+#define GH_ERROR_MSGQUEUE_EMPTY		60
+#define GH_ERROR_MSGQUEUE_FULL		61
+
+static inline int gh_remap_error(int gh_error)
+{
+	switch (gh_error) {
+	case GH_ERROR_OK:
+		return 0;
+	case GH_ERROR_NOMEM:
+		return -ENOMEM;
+	case GH_ERROR_DENIED:
+	case GH_ERROR_CSPACE_CAP_NULL:
+	case GH_ERROR_CSPACE_CAP_REVOKED:
+	case GH_ERROR_CSPACE_WRONG_OBJ_TYPE:
+	case GH_ERROR_CSPACE_INSUF_RIGHTS:
+	case GH_ERROR_CSPACE_FULL:
+		return -EACCES;
+	case GH_ERROR_BUSY:
+	case GH_ERROR_IDLE:
+		return -EBUSY;
+	case GH_ERROR_IRQ_BOUND:
+	case GH_ERROR_IRQ_UNBOUND:
+	case GH_ERROR_MSGQUEUE_FULL:
+	case GH_ERROR_MSGQUEUE_EMPTY:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif
-- 
2.25.1

