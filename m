Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D635B0CC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIGS6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiIGS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:58:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643B1A1A47;
        Wed,  7 Sep 2022 11:58:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287DUec0021446;
        Wed, 7 Sep 2022 11:58:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=M4Xgdk036G8QDaxW7reBpNJ7o7pavTG+PHCrE26StPI=;
 b=kPBunb93/UEDf0r9OkhKqihMd+mwXd4KFUgwaw9anXQMdyIiaqnF66y9r7IDqzYWuHJs
 chvtyZ2WaE80TL+X763m4LEGdlVWdzW7cwdXun4LxOlRJY2pZ5kIM8AQjc1a3zhQl+Au
 YFBiWneScBfWpn97sq5f5TBwXfya400o0ogozeWVUv7DdX8T3wdMG9xj9mI2xhK+mU2n
 2gwSn1WsbPQhpQht3m9mOlmbDxPPy027rDdxWcpWdlTBDmllmVzTiLVjFwFaS/4rg0ym
 RrtyphiybUURE09jXO/raIm9aCqAjjOsdBpCKJpar8vQCI/iAwcFGzXHOq/MTnteBIsi TA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jc6epywmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 11:58:37 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Sep
 2022 11:58:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Sep 2022 11:58:35 -0700
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 92A023F7050;
        Wed,  7 Sep 2022 11:58:35 -0700 (PDT)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id 79A0388D32D; Wed,  7 Sep 2022 11:58:35 -0700 (PDT)
From:   Arun Easi <aeasi@marvell.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Arun Easi <aeasi@marvell.com>
Subject: [PATCH v2 1/1] tracing: Fix compile error in trace_array calls when TRACING is disabled
Date:   Wed, 7 Sep 2022 11:57:45 -0700
Message-ID: <20220907185745.14382-2-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20220907185745.14382-1-aeasi@marvell.com>
References: <20220907185745.14382-1-aeasi@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v1nKtS6kW2EMFh8e8VXGErNBNZIdfHAw
X-Proofpoint-GUID: v1nKtS6kW2EMFh8e8VXGErNBNZIdfHAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this compilation error seen when CONFIG_TRACING is not enabled:

drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function
'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'?
[-Werror=implicit-function-declaration]
 2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
      |                         ^~~~~~~~~~~~~~~~~~~~~~~
      |                         trace_array_set_clr_event

drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function
'trace_array_put' [-Werror=implicit-function-declaration]
 2869 |         trace_array_put(qla_trc_array);
      |         ^~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arun Easi <aeasi@marvell.com>
---
 include/linux/trace.h | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index bf16961..7138990 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -2,8 +2,6 @@
 #ifndef _LINUX_TRACE_H
 #define _LINUX_TRACE_H
 
-#ifdef CONFIG_TRACING
-
 #define TRACE_EXPORT_FUNCTION	BIT(0)
 #define TRACE_EXPORT_EVENT	BIT(1)
 #define TRACE_EXPORT_MARKER	BIT(2)
@@ -28,6 +26,8 @@ struct trace_export {
 	int flags;
 };
 
+#ifdef CONFIG_TRACING
+
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
@@ -48,6 +48,40 @@ void osnoise_arch_unregister(void);
 void osnoise_trace_irq_entry(int id);
 void osnoise_trace_irq_exit(int id, const char *desc);
 
+#else	/* CONFIG_TRACING */
+static inline int register_ftrace_export(struct trace_export *export)
+{
+	return -EINVAL;
+}
+static inline int unregister_ftrace_export(struct trace_export *export)
+{
+	return 0;
+}
+static inline void trace_printk_init_buffers(void)
+{
+}
+static inline int
+trace_array_printk(struct trace_array *tr, unsigned long ip,
+		       const char *fmt, ...)
+{
+	return 0;
+}
+static inline int trace_array_init_printk(struct trace_array *tr)
+{
+	return -EINVAL;
+}
+static inline void trace_array_put(struct trace_array *tr)
+{
+}
+static inline struct trace_array *
+trace_array_get_by_name(const char *name)
+{
+	return NULL;
+}
+static inline int trace_array_destroy(struct trace_array *tr)
+{
+	return 0;
+}
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
-- 
2.9.5

