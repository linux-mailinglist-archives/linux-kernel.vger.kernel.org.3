Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912385A8D32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiIAFNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiIAFNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:13:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB897122BF8;
        Wed, 31 Aug 2022 22:13:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNnMUB017375;
        Thu, 1 Sep 2022 05:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=raF5/Ou6qyOaiPL+YO354mjW+A+FzuL3L4u8ghTPjyk=;
 b=sj5YVb9srC04VOeZa4zuzI6yittYV2GFgynMhI3tgeIiCXDYSfUyXQlYN8wBYcl7uYQS
 1W2PKYNvfgbxnmhtHHP4bc2cTgGSEdjxF5QVZWFEr9o6didI85GjQGY/FlRgk499v7Q3
 4FVEsZlh/LGMAWXLAz0Vhovp0KGPMXYvABKm8EofoAxcOC6w7/FuXviMryC0JrnyY6iy
 S46zNcdTXFX9sEeGAtCZhUemZ1+35DhryGLwDxp7oGfNzP2njwBeU4JDOwpuc7Zbzt38
 KKQi4LE/ADZeSDEf0f66VD2U5aiCvlYKgbKkkK57DJROH2WDwAQevO5Fn4eMxeW5Uj5+ yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0u06f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813a136033685;
        Thu, 1 Sep 2022 05:12:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gr3g33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:12:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2815CsXP008754;
        Thu, 1 Sep 2022 05:12:57 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ja6gr3g0k-6;
        Thu, 01 Sep 2022 05:12:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [PATCH v3 0/6] Replace one-element arrays with flexible-array members
Date:   Thu,  1 Sep 2022 01:12:50 -0400
Message-Id: <166200877450.26143.6347697881068660910.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1660592640.git.gustavoars@kernel.org>
References: <cover.1660592640.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=800 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010022
X-Proofpoint-GUID: WdVYu2dnXtEylIDs1StHp-bb0yuN1OeC
X-Proofpoint-ORIG-GUID: WdVYu2dnXtEylIDs1StHp-bb0yuN1OeC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 16:35:19 -0500, Gustavo A. R. Silva wrote:

> This series aims to replace one-element arrays with flexible-array
> members in drivers/scsi/megaraid/
> 
> I followed the below steps in order to verify the changes don't
> significally impact the code (.text) section generated by the compiler,
> for each object file involved:
> 
> [...]

Applied to 6.1/scsi-queue, thanks!

[1/6] scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_FW_RAID_MAP
      https://git.kernel.org/mkp/scsi/c/ac23b92b27e3
[2/6] scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_FW_RAID_MAP_DYNAMIC
      https://git.kernel.org/mkp/scsi/c/204a29a169f4
[3/6] scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_DRV_RAID_MAP
      https://git.kernel.org/mkp/scsi/c/eeb3bab77244
[4/6] scsi: megaraid_sas: Replace one-element array with flexible-array member in MR_PD_CFG_SEQ_NUM_SYNC
      https://git.kernel.org/mkp/scsi/c/ee92366a8439
[5/6] scsi: megaraid_sas: Use struct_size() in code related to struct MR_FW_RAID_MAP
      https://git.kernel.org/mkp/scsi/c/41e830269d68
[6/6] scsi: megaraid_sas: Use struct_size() in code related to struct MR_PD_CFG_SEQ_NUM_SYNC
      https://git.kernel.org/mkp/scsi/c/48658213202c

-- 
Martin K. Petersen	Oracle Linux Engineering
