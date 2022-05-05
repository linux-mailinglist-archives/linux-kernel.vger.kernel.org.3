Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABD51C2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380731AbiEEOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiEEOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:46:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB456F95;
        Thu,  5 May 2022 07:42:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245DSNOq013507;
        Thu, 5 May 2022 14:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=F5rTyHeM1UHdjfZeC+4fp+ByCrvy4DLRy95uf+aXe0M=;
 b=nhABQKd2sKLKtmQAVeyi7lj0cPGpM23umg4JykwISwlrbbvwIk5Bhhp9NBmrQk7BM2xM
 NyLW64mzgzM7anjvPoXmygJLGa+mJMM0PuZAATVrGbPwIRuqDph9yWJYrusUysccTgxX
 Ys8VdPF6+ifsElGrV3+nhpaQzGfd89HrnS16TrsHxgG+ea/VT9x0ff04/4ilebvPpLwU
 lGnCXrMbo7de71fyZ45z0nfjLYPqqjl8qBJXk3hSk7qdgphScevgQ9f6BFOJe8AjJkDs
 w9gTaNdoPZ/zlJ+fHt7hAV4o4z3lBDr62OM2w3PaltiwmbMv1+62Yin5eIExTAn+CXCd JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqskjr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 14:37:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245EZOCd002817;
        Thu, 5 May 2022 14:37:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a73pdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 14:37:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 245EbNjN008186;
        Thu, 5 May 2022 14:37:23 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a73pcs-1;
        Thu, 05 May 2022 14:37:23 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     harshit.m.mogalapalli@oracle.com, dan.carpenter@oracle.com,
        James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: Remove redundant memset statement
Date:   Thu,  5 May 2022 07:36:57 -0700
Message-Id: <20220505143703.45441-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QneWUrFrThNje_pYJThDiadbzhYRVLDn
X-Proofpoint-ORIG-GUID: QneWUrFrThNje_pYJThDiadbzhYRVLDn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As memset of 'bmbx' is immediately followed by a memcpy where 'bmbx'
is the destination, memset is redundant.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/scsi/elx/efct/efct_hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index d4bb37960a3c..5a5525054d71 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -1402,7 +1402,6 @@ efct_hw_command(struct efct_hw *hw, u8 *cmd, u32 opts, void *cb, void *arg)
 		mutex_lock(&hw->bmbx_lock);
 		bmbx = hw->sli.bmbx.virt;
 
-		memset(bmbx, 0, SLI4_BMBX_SIZE);
 		memcpy(bmbx, cmd, SLI4_BMBX_SIZE);
 
 		if (sli_bmbx_command(&hw->sli) == 0) {
-- 
2.31.1

