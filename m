Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18E647C18A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhLUObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:31:41 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238478AbhLUObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:31:40 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BLD4UTY032089;
        Tue, 21 Dec 2021 15:31:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=I880/oBhiEsXpazbj7JBRXbXm3Rb2zoCfk+AqE1NF9E=;
 b=TsyI8HTxTG5PL2FLAobWZd3l1hnygBzxmWdWjFfDE32DUFkzEzyEUE8RVtHwW5bZd5pV
 X0KMVyJWkU8vBhuM3sI0Ned7G5/dEl983swCovvfVLzefXxHe06YtzVr0Dh1tJd+Mup7
 9T9Fp8PYQl5bqFg9Ci6to06c+QCBEcs1IfUELwBOQMU8UdyoaxRDLaXp89/ScJjMwebT
 T8ij1RgYXWCwad8/gYvsBu2iOdptKqASFieiHRx40D2I1tPwbP4l969Sp92MWkj+/7t2
 sK2uUnZKhLj6/g4/lGfIM7emphn7YalrBzjCJCHQQQVs8fnHwfzgcPPs/2kYYW8pN0k+ lA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d2nsxqk17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 15:31:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68B93100034;
        Tue, 21 Dec 2021 15:31:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 61E8420C8E6;
        Tue, 21 Dec 2021 15:31:37 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 21 Dec 2021 15:31:36
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH] remoteproc: stm32: Improve crash recovery time
Date:   Tue, 21 Dec 2021 15:31:29 +0100
Message-ID: <20211221143129.18415-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a stop is requested on a crash, it is useless to try to shutdown it
gracefully, it is crashed.

In this case don't send the STM32_MBX_SHUTDOWN mailbox message that
will block the recovery during 500 ms, waiting an answer from the
coprocessor.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index b643efcf995a..7d782ed9e589 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -494,7 +494,7 @@ static int stm32_rproc_stop(struct rproc *rproc)
 	int err, idx;
 
 	/* request shutdown of the remote processor */
-	if (rproc->state != RPROC_OFFLINE) {
+	if (rproc->state != RPROC_OFFLINE && rproc->state != RPROC_CRASHED) {
 		idx = stm32_rproc_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
 		if (idx >= 0 && ddata->mb[idx].chan) {
 			err = mbox_send_message(ddata->mb[idx].chan, "detach");
-- 
2.17.1

