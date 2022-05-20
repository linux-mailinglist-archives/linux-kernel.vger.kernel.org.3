Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225752E191
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbiETBKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbiETBJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D48135696;
        Thu, 19 May 2022 18:09:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0In2W015720;
        Fri, 20 May 2022 01:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=3PJqp+pBAmGkc9uxsEHPEhEebwnH9ej2PLUFKh+KJwg=;
 b=Go6wK13UIdW5EizJn/mTmibvkugWqqLwJWAn6bKW05dOfbGyRZGdi4rUfQhHeNESbaH6
 UCPCPvOQrrTfzU8a4tC7i4A9TrBdlY9feNamJR8tPweffCFXGLXO1uMNS0ZaCltTeLbh
 Y7B7sg0fixZZJFyt2U50PHPrWJcXd28EpdJ5oGrvB3Tv2QzkdApY1/PAMPJag4f0Sftg
 YyIgGg8Gw1rXDMD15M27oM8bTy3vf0fcJcsRlBiHYKGy4W7EKl7RUKQXp0XOvkGTtczz
 CE0tkn2tBswbmNIzJG/+dScXsRlEXzQpSsOh3gj70l1Os2lYyOpDONWdOa9U3LNPI/Fr pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2372614f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nhQ020166;
        Fri, 20 May 2022 01:09:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKP030710;
        Fri, 20 May 2022 01:09:30 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-11;
        Fri, 20 May 2022 01:09:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] hisi_sas: A device rescan and IT nexus reset fix
Date:   Thu, 19 May 2022 21:09:10 -0400
Message-Id: <165300891230.11465.809227621168034825.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
References: <1652354134-171343-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7WOIBzubqVqzTKr-5l0x1DEeeSW-zRIk
X-Proofpoint-ORIG-GUID: 7WOIBzubqVqzTKr-5l0x1DEeeSW-zRIk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 19:15:31 +0800, John Garry wrote:

> This series includes 2x fixes for the hisi_sas driver:
> - In issuing an ATA softreset in the IT nexus handler the disk may become
>   lost as we may issue the softreset before the phy is back up.
> 
>   So export functionality from sas_ata_hard_reset() to wait for phy up to
>   synchronize.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/3] scsi: libsas: Refactor sas_ata_hard_reset()
      https://git.kernel.org/mkp/scsi/c/057e5fc03369
[2/3] scsi: hisi_sas: Use sas_ata_wait_after_reset() in IT nexus reset
      https://git.kernel.org/mkp/scsi/c/71453bd9d1bf
[3/3] scsi: hisi_sas: Fix rescan after deleting a disk
      https://git.kernel.org/mkp/scsi/c/e9dedc13bb11

-- 
Martin K. Petersen	Oracle Linux Engineering
