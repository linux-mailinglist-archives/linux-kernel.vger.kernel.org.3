Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F247651C8EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384992AbiEET3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiEET3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:29:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F741F614;
        Thu,  5 May 2022 12:26:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242MEVYs026258;
        Tue, 3 May 2022 00:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=d6ct1UaLVba3yw63uAkNVfq9np3/Rqs6yhb3xK0+OpM=;
 b=x2opaEy79OWCROeSa1n03EBsLrLvExky2JzpiJkzaYj1Y74T2aGMG5DGjjGrlID+pldb
 t94tdMR2dVdHiXmvBWbmbUmQn5LGvjd+tgi7sYL2yroIvSEn4XYWZ+4sj7LGgfhs6KOE
 mas05oz+PqBDq/BdUe0XDvl58UScciUgSKzda86lbSLfjjJ8gNcG5OSgI3jiGf0JtuLB
 whIzqlFS0o0i2vbwuzHoObry1x2ArioNQpSEO512YmMAvE0MKbAf3WkNvB/9BxDuEhOJ
 6NRvnVHGrOADQGxsEJSui9faj1HzivLAo5N6AyeivI0UZn4NznYuc3yEX1K40m9OGPvV DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc4m4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oou6008900;
        Tue, 3 May 2022 00:51:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plj8010389;
        Tue, 3 May 2022 00:51:50 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-6;
        Tue, 03 May 2022 00:51:50 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: mac53c94: fix warning comparing pointer to 0
Date:   Mon,  2 May 2022 20:51:16 -0400
Message-Id: <165153836359.24053.3311971754935367894.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1647244711-31575-1-git-send-email-baihaowen@meizu.com>
References: <1647244711-31575-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nxzsRVDO7-q06fkTPZkhIg9eMB_E2sBQ
X-Proofpoint-ORIG-GUID: nxzsRVDO7-q06fkTPZkhIg9eMB_E2sBQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 15:58:31 +0800, Haowen Bai wrote:

> Fix the following coccicheck warning:
> drivers/scsi/mac53c94.c:237:12-13: WARNING comparing pointer to 0
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: mac53c94: fix warning comparing pointer to 0
      https://git.kernel.org/mkp/scsi/c/93de8df20537

-- 
Martin K. Petersen	Oracle Linux Engineering
