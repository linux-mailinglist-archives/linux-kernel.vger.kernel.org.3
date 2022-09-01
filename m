Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418315A8D20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiIAFMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiIAFMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:12:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3372122BE1;
        Wed, 31 Aug 2022 22:12:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNn73D030499;
        Thu, 1 Sep 2022 05:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=18OOGS2sPRiJ+9EzIU6kd0ZppZE6bIuuoI3mlcLK2ho=;
 b=mENwGyprbs5K6QROCeBaeuWxewkJ6jiRjENkopfT8zj/pX+jTxt5aEpl2e5bDR8mDyjI
 GZfnhejO4hzufQCIrK2cardNxdbeU2mnsCv54s7mn2wPwThYSV+opMZ66eVzDNvABu0d
 abgpA1X6yrqeXNzmmaaGPihjffk3c7cZj1Y8Grlrl1SQnEBtusXANC12B8waqpeOeUee
 CwTfHtUnCL4daTVp0DN1UFPjbjY7QQXqmDpj2xOaLmPYHFPO+cBu23nUdFqfV8ySJumQ
 wcbxQR5dIJqyojrittcRHWU4DoAn+TmwTIBEthNU63CnEL90G9FSNx1Rg/wAeSjG9yqj QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7a22b0tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813cnRa022878;
        Thu, 1 Sep 2022 05:12:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q61j2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:23 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2815CJTO026239;
        Thu, 1 Sep 2022 05:12:23 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3j79q61j0y-4;
        Thu, 01 Sep 2022 05:12:23 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        james.smart@broadcom.com, dick.kennedy@broadcom.com
Subject: Re: [PATCH -next v2] scsi: lpfc: add missing destroy_workqueue() on error path in lpfc_sli4_driver_resource_setup()
Date:   Thu,  1 Sep 2022 01:12:18 -0400
Message-Id: <166200876313.24183.16607865138971231049.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220823044237.285643-1-yangyingliang@huawei.com>
References: <20220823044237.285643-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=958 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209010022
X-Proofpoint-GUID: z-VHPOgN6j15dC1ndrJacd-NXMzED1n5
X-Proofpoint-ORIG-GUID: z-VHPOgN6j15dC1ndrJacd-NXMzED1n5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 12:42:37 +0800, Yang Yingliang wrote:

> Add the missing destroy_workqueue() before return from
> lpfc_sli4_driver_resource_setup() in error path.
> 
> 

Applied to 6.0/scsi-fixes, thanks!

[1/1] scsi: lpfc: add missing destroy_workqueue() on error path in lpfc_sli4_driver_resource_setup()
      https://git.kernel.org/mkp/scsi/c/da6d507f5ff3

-- 
Martin K. Petersen	Oracle Linux Engineering
