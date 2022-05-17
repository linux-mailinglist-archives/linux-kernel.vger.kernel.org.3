Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F49529743
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiEQCRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiEQCRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:17:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67993CFEE;
        Mon, 16 May 2022 19:17:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GL17SA017457;
        Tue, 17 May 2022 02:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=4TM0BsFQcBQ2j8NY0GhzInSbPX0iKWiM7IQsswsGUJ8=;
 b=J9Mq+dgozQ4bHYruACaR0S9/aNE5d/72Hanb4C0E99GZShYwKWkoAHfZMbTnYcBmDTTN
 FWGuFs+UQgurZSCD1Lid/v+91z3zXd8eE2EKyuq3imT8b2YPIjvW5h9OxtOqWdc6qK3W
 PysPqT3c1Cj8D+ZdKgWr3khotrGQmDRr9CPmXdoolDY0Eb477RRxlXgWcHK0uHt+9soA
 p3jUNfJ8F1lCTYvhSbj3/LBtAF97yql+WuJ5eEV1z+LYeOR1oUJJRPRiNpVbiXrJ9Per
 gCztujItJ4d07/nT1C+D3BnMvBD+izzEQjoxrVJSwkL66H9dGqEqIRju6KF38ZnkEe8v NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aacuyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:16:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H2G8qo019200;
        Tue, 17 May 2022 02:16:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83hkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:16:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24H2Ghvt019875;
        Tue, 17 May 2022 02:16:43 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83hkf-1;
        Tue, 17 May 2022 02:16:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     beanhuo@micron.com, daejun7.park@samsung.com,
        Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        cang@codeaurora.org, tomas.winkler@intel.com, avri.altman@wdc.com,
        jejb@linux.ibm.com, keosung.park@samsung.com,
        asutoshd@codeaurora.org, powen.kao@mediatek.com,
        peter.wang@mediatek.com, bvanassche@acm.org,
        stanley.chu@mediatek.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Several changes for UFSHPB
Date:   Mon, 16 May 2022 22:16:36 -0400
Message-Id: <165275376860.24722.13854337958203469096.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220505134707.35929-1-huobean@gmail.com>
References: <20220505134707.35929-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sRH789g8ojyoOZRx8niQBigb-JCm7Z4n
X-Proofpoint-GUID: sRH789g8ojyoOZRx8niQBigb-JCm7Z4n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 15:47:01 +0200, Bean Huo wrote:

> From: Bean Huo <beanhuo@micron.com>
> 
> Hi UFS driver developers/reviewers
> 
> Here are some changes to the UFS HPB driver. They are all based on Martin's Git repo
> 5.18/scsi-staging branch. Please refer to the patch submission information for the
> specific purpose of each patch. I tested them on my own platform. Please have a review
> and any comments and suggestions are welcome.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/6] scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
      https://git.kernel.org/mkp/scsi/c/facc239c87b1
[2/6] scsi: ufshpb: Remove 0 assignment for enum value
      https://git.kernel.org/mkp/scsi/c/6f341ed5e377
[3/6] scsi: ufshpb: Cleanup the handler when device reset HPB information
      https://git.kernel.org/mkp/scsi/c/a3f3c26d4df5
[4/6] scsi: ufshpb: Change sysfs node hpb_stats/rb_* prefix to start with rcmd_*
      https://git.kernel.org/mkp/scsi/c/d4300c552bf8
[5/6] scsi: ufshpb: Add handing of device reset HPB regions Infos in HPB device mode
      https://git.kernel.org/mkp/scsi/c/32d6eab31ac3
[6/6] scsi: ufshpb: Cleanup ufshpb_suspend/resume
      https://git.kernel.org/mkp/scsi/c/18ebe2390c61

-- 
Martin K. Petersen	Oracle Linux Engineering
