Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D524855DBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiF1DYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiF1DYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:24:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86624F33;
        Mon, 27 Jun 2022 20:24:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S1U54B002153;
        Tue, 28 Jun 2022 03:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=wFj7jr5++wVzk3NhTMH3VP2cJALD8lp6NWC4+k64PCk=;
 b=zQpYyxoEn90fAOIgD5exJ3ItD9jq/QnwtMoiOVptb0t1e0NpMPl3R/2GUFUNGLKVA4za
 EnmCSAHzYtB2VpvsczmSvSBzv5Na1w/0YIlR5wCa6UKFF4Jsj4NxhezeWjYTHqPSbdUd
 eEh5Y9LB06nM0X0PpA5fs1sUiawN5iOMc8tkjpMOirInrBzJD3zLK7pG5gw1IsfVT8H3
 +TI2SmR338PBvLPtD6GdVH2jgOOM4bpsRj/3zzpUiK4NwCgcqj64USbog8dFNCATnCys
 6b33zo7HVRI29RgOIrBAA14i3kEx/XlvdjzA6GKHTy4sdnTSODd16Gz3n8hJTtkowKVQ mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52cunp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3Euqt032131;
        Tue, 28 Jun 2022 03:24:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1yjd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:24:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3O9ij005491;
        Tue, 28 Jun 2022 03:24:09 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1yjcw-1;
        Tue, 28 Jun 2022 03:24:09 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>, hch@lst.de,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: Limit max hw sectors for v3 HW
Date:   Mon, 27 Jun 2022 23:24:07 -0400
Message-Id: <165638664146.7677.5674015792755876546.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <1655988119-223714-1-git-send-email-john.garry@huawei.com>
References: <1655988119-223714-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oTwzKNERGeDhb51xc2_H4Wn1gZJGnwZL
X-Proofpoint-GUID: oTwzKNERGeDhb51xc2_H4Wn1gZJGnwZL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 20:41:59 +0800, John Garry wrote:

> If the controller is behind an IOMMU then the IOMMU IOVA caching range can
> affect performance, as discussed in [0].
> 
> Limit the max HW sectors to not exceed this limit. We need to hardcode
> the value until a proper DMA mapping API is available.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> [...]

Applied to 5.19/scsi-fixes, thanks!

[1/1] scsi: hisi_sas: Limit max hw sectors for v3 HW
      https://git.kernel.org/mkp/scsi/c/fce54ed02757

-- 
Martin K. Petersen	Oracle Linux Engineering
