Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED85AF9FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIGCiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIGCiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:38:16 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD13956BA;
        Tue,  6 Sep 2022 19:38:16 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286N60Xe029176;
        Tue, 6 Sep 2022 19:38:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=l1fn4n5Uf2HgBaPCQlMwX9MKFZT17n3KP/IPHwyfryY=;
 b=Kv1e/S+JyDCMsqupgtoVdcqlCaZ6u+bvrFUZpaZ+SOuNcMCd2DvS1IUA3Hn0ACmThPem
 hiOmC0J9P6GASgATU/FQlyRJsdpLe51WWdgLn3AbhfvD07mqK5q7vOPLqtCNg5ojXQe3
 EmTy4sE6XHs2aFDbjduXhaemBB7PLFVe7hw2ix95Je2c7Tm+WxdjJ1zfAPNmBnDcDHiF
 V+Mn1OL3+7akHXjA9YRwRAUw9vv4shR3r7qRvAa75oqjVaHHMjWzSYhxGHc1NvAlXGkL
 boyI4JaaTBMRslUjslFR1HOqX6p0gyNGTdwFjSIytnmi3pyVqdLCxeRon0yEVauSUd6U xQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3jdxjemwt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:38:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 6 Sep
 2022 19:38:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Sep 2022 19:38:11 -0700
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 632B63F70E9;
        Tue,  6 Sep 2022 19:38:11 -0700 (PDT)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id 41DBD88D34B; Tue,  6 Sep 2022 19:38:11 -0700 (PDT)
From:   Arun Easi <aeasi@marvell.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        Arun Easi <aeasi@marvell.com>
Subject: [PATCH 1/1] tracing: Fix compile error in trace_array calls when TRACING is disabled
Date:   Tue, 6 Sep 2022 19:38:00 -0700
Message-ID: <20220907023800.4095-2-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20220907023800.4095-1-aeasi@marvell.com>
References: <20220907023800.4095-1-aeasi@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: cBSl9oT2M0ggqnsnDg36ZRttD1FP3jGH
X-Proofpoint-ORIG-GUID: cBSl9oT2M0ggqnsnDg36ZRttD1FP3jGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
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
 include/linux/trace.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index bf16961..bf206c3 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -48,6 +48,23 @@ void osnoise_arch_unregister(void);
 void osnoise_trace_irq_entry(int id);
 void osnoise_trace_irq_exit(int id, const char *desc);
 
+#else	/* CONFIG_TRACING */
+#define TRACE_EXPORT_FUNCTION	0
+#define TRACE_EXPORT_EVENT	0
+#define TRACE_EXPORT_MARKER	0
+struct trace_export { };
+#define register_ftrace_export(export) -EINVAL
+#define unregister_ftrace_export(export) 0
+#define trace_printk_init_buffers()
+#define trace_array_printk(tr, ip, fmt, ...) 0
+#define trace_array_init_printk(tr) -EINVAL
+#define trace_array_put(tr)
+#define trace_array_get_by_name(name) NULL
+#define trace_array_destroy(tr) 0
+#define osnoise_arch_register() -EINVAL
+#define osnoise_arch_unregister()
+#define osnoise_trace_irq_entry(id)
+#define osnoise_trace_irq_exit(id, desc)
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
-- 
2.9.5

