Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211924DBD54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351310AbiCQDFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiCQDFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:05:02 -0400
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59220F6B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:03:44 -0700 (PDT)
Received: from excmbx-17.um.gwdg.de ([134.76.9.228] helo=email.gwdg.de)
        by mailer.gwdg.de with esmtp (GWDG Mailer)
        (envelope-from <alexander.vorwerk@stud.uni-goettingen.de>)
        id 1nUgQO-000EEm-H3; Thu, 17 Mar 2022 04:03:40 +0100
Received: from notebook.fritz.box (10.250.9.199) by excmbx-17.um.gwdg.de
 (134.76.9.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2375.24; Thu, 17
 Mar 2022 04:03:40 +0100
From:   Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
Subject: [PATCH] message: fusion: Remove unused variable retval
Date:   Thu, 17 Mar 2022 04:03:25 +0100
Message-ID: <20220317030325.30526-1-alexander.vorwerk@stud.uni-goettingen.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: excmbx-11.um.gwdg.de (134.76.9.220) To excmbx-17.um.gwdg.de
 (134.76.9.228)
X-Virus-Scanned: (clean) by clamav
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning showed up when compiling with W=1.

drivers/message/fusion/mptctl.c: In function ‘mptctl_hp_hostinfo’:
drivers/message/fusion/mptctl.c:2337:8: warning: variable ‘retval’ set but not used [-Wunused-but-set-variable]
  int   retval;

Fixing by removing the variable.

Signed-off-by: Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
---
 drivers/message/fusion/mptctl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 03c8fb1795c2..f9ee957072c3 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2334,7 +2334,6 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 	ToolboxIstwiReadWriteRequest_t	*IstwiRWRequest;
 	MPT_FRAME_HDR		*mf = NULL;
 	unsigned long		timeleft;
-	int			retval;
 	u32			msgcontext;
 
 	/* Reset long to int. Should affect IA64 and SPARC only
@@ -2488,7 +2487,6 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 	ioc->add_sge((char *)&IstwiRWRequest->SGL,
 	    (MPT_SGE_FLAGS_SSIMPLE_READ|4), buf_dma);
 
-	retval = 0;
 	SET_MGMT_MSG_CONTEXT(ioc->ioctl_cmds.msg_context,
 				IstwiRWRequest->MsgContext);
 	INITIALIZE_MGMT_STATUS(ioc->ioctl_cmds.status)
@@ -2498,7 +2496,6 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 	timeleft = wait_for_completion_timeout(&ioc->ioctl_cmds.done,
 			HZ*MPT_IOCTL_DEFAULT_TIMEOUT);
 	if (!(ioc->ioctl_cmds.status & MPT_MGMT_STATUS_COMMAND_GOOD)) {
-		retval = -ETIME;
 		printk(MYIOC_s_WARN_FMT "%s: failed\n", ioc->name, __func__);
 		if (ioc->ioctl_cmds.status & MPT_MGMT_STATUS_DID_IOCRESET) {
 			mpt_free_msg_frame(ioc, mf);
-- 
2.17.1

