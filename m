Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0820A581E27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiG0DRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiG0DQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:16:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56C03DBC0;
        Tue, 26 Jul 2022 20:16:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R2phCC029985;
        Wed, 27 Jul 2022 03:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=J2vBu1m4zTDwawbCKsSD5AhIF5f7bJkTK1Ll+UnC+HY=;
 b=RUcztjtvY/ykesoOqjVdG4iyE/6+UStvTWw66FgfulNYdS1LOamC5Acow0D2gPIgzmz4
 AL5uLFIgh/111E/lHojNbYCYjKY4FOZr8x3xUNKbVI+OULVoRNlFx0Zruix/pnbA15l0
 tq/2fYhEq5law2ghx6BVmga6aromdWvdPBCSXiQb+A7u6MFwN1mKIxmty86PdZm1UseS
 5gmr5IrMXr/XoUqWAp9NaFwd+Et2cluzn1HkmxFbInzCDgLslza9UwZUSzzvQHKaFifG
 /5aVQ8f9FlyPCZyrhQuatnLIwyNH8vPkCOFekpBpvVhI8rK2giErvY5Z9XTifj9+o15b 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsrbrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:16:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26R0XEvs034456;
        Wed, 27 Jul 2022 03:16:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh633p3w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:16:02 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26R3E0gw008228;
        Wed, 27 Jul 2022 03:16:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hh633p3uc-3;
        Wed, 27 Jul 2022 03:16:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] scsi: ufs: ufshcd: Read device property for ref clock
Date:   Tue, 26 Jul 2022 23:15:56 -0400
Message-Id: <165889172881.804.1367014483116861516.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715210230.1.I365d113d275117dee8fd055ce4fc7e6aebd0bce9@changeid>
References: <20220715210230.1.I365d113d275117dee8fd055ce4fc7e6aebd0bce9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270009
X-Proofpoint-ORIG-GUID: ox54HQOKDaSm-QN1emBiExysxKFBZJ_p
X-Proofpoint-GUID: ox54HQOKDaSm-QN1emBiExysxKFBZJ_p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 21:03:53 +1000, Daniil Lunev wrote:

> UFS storage devices require bRefClkFreq attribute to be set to operate
> correctly at high speed mode. The necessary value is determined by what the
> SoC / board supports. The standard doesn't specify a method to query the
> value, so the information needs to be fed in separately.
> 
> DT information feeds into setting up the clock framework, so platforms
> using DT can get the UFS reference clock frequency from the clock
> framework. A special node "ref_clk" from the clock array for the UFS
> controller node is used as the source for the information.
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: ufs: ufshcd: Read device property for ref clock
      https://git.kernel.org/mkp/scsi/c/ca452621b829

-- 
Martin K. Petersen	Oracle Linux Engineering
