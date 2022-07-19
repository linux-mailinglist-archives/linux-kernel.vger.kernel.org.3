Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3470957912A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiGSDJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiGSDJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:09:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD803AE73;
        Mon, 18 Jul 2022 20:09:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J32xFo013956;
        Tue, 19 Jul 2022 03:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=0Yvig2rZZR5x90mVUypP2XrcbbnAsqsInJnyfw4//7w=;
 b=JKg6FnWPJDJP3ot6vFlECSGQM4EHyzfITVk+kkHj3q8AH3RXboppZUm+LR45T5HKT4O7
 OyXys6zWZxLzWKRK+9EqswL8XrA9aPjdtGt8Urp3FnhpIQGPf0m2zulsETNUxlJLDof4
 Jl+8fn8x1d13Qziu5UmSPPoYj6n0aUqg6zVAvETr/la9YBWa/LXC/vh8owSLERdxMM9E
 98G+4riyG6YE/epJQJ/yAvx/Juwmg1jgA26OmjfnEbDEIXdoXAEUk+hd9TRL+LB2UKnz
 4CjCZnyqlDD2J6oo0+qBja3xHQMYTJ7Z2AhiPqKbWSuoIqJAeNy0I886tfyGhbCGAnH2 YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs4xed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 03:09:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IND6rR002047;
        Tue, 19 Jul 2022 03:09:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k2yptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 03:09:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26J391U5016855;
        Tue, 19 Jul 2022 03:09:03 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hc1k2ypt1-3;
        Tue, 19 Jul 2022 03:09:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     sebaddel@cisco.com, Karan Tilak Kumar <kartilak@cisco.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        gvaradar@cisco.com, djhawar@cisco.com, jejb@linux.ibm.com,
        satishkh@cisco.com, gcboffa@cisco.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        arulponn@cisco.com
Subject: Re: [PATCH] scsi: fnic: refactor code in fnic probe to initialize scsi layer
Date:   Mon, 18 Jul 2022 23:08:56 -0400
Message-Id: <165820009734.29375.2668957033788213674.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707205155.692688-1-kartilak@cisco.com>
References: <20220707205155.692688-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=859 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190011
X-Proofpoint-GUID: VQXUDUkziZOA_SCesj40hU-mYvTftuwd
X-Proofpoint-ORIG-GUID: VQXUDUkziZOA_SCesj40hU-mYvTftuwd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 13:51:55 -0700, Karan Tilak Kumar wrote:

> Refactor code from fnic probe into a different function so that
> scsi layer initialization code is grouped together.
> Also, add log messages for better debugging.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: fnic: refactor code in fnic probe to initialize scsi layer
      https://git.kernel.org/mkp/scsi/c/aec95e3a8ded

-- 
Martin K. Petersen	Oracle Linux Engineering
