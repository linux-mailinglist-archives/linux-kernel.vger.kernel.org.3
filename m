Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1A54EF34
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379718AbiFQCUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379662AbiFQCUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:20:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3372B60AAA;
        Thu, 16 Jun 2022 19:20:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GNmtGY026652;
        Fri, 17 Jun 2022 02:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=46rOZ/wy2QC/SFSw6K3GXEKJrcwnyZZKW/7s1adV2nc=;
 b=MvkwvafxEMVDCyLIsz6OrlBizHz21zmaqPz6x378oG+VSjgwTxJRI8hk+NWvLQA9R3Hw
 RX3hMvE83wJHpsAiOQ2I4YmOGwIVCXT0HndK+rnIDctAe6ME8yT+TvQAwXx8/d633z2J
 LH2kyY8Yk5B0foVU9a7Uo/2TTv2Zl9/y1vRr7rrM3TFBc0L/k2e5pSgbVNupFR1txux0
 AuvbmW2STqk6i5eInX8kOgSo+AbQS4mdFJa4M0I7usFSEDjQtzfXFNT1Vw04dZEHlTvv
 qk4q3flv58mys4dUgaSMIWNBm2EmBc6n3jPoaVPf/i2nzLPtaXHwgfm0C1XMoE+Cyvlq Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0mt29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:20:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H2GGrF038459;
        Fri, 17 Jun 2022 02:20:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq327fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:20:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25H2KMSe006844;
        Fri, 17 Jun 2022 02:20:25 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq327d4-3;
        Fri, 17 Jun 2022 02:20:25 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, brking@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ibmvfc: multiqueue bug fixes
Date:   Thu, 16 Jun 2022 22:20:20 -0400
Message-Id: <165543238454.26073.9657501808078382036.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220616191126.1281259-1-tyreld@linux.ibm.com>
References: <20220616191126.1281259-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FWL63DJf5ixlJBt2S8RfBBQ72Y2_qn9K
X-Proofpoint-ORIG-GUID: FWL63DJf5ixlJBt2S8RfBBQ72Y2_qn9K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 12:11:24 -0700, Tyrel Datwyler wrote:

> Fixes for a couple observed crashes of the ibmvfc driver when in MQ mode.
> 
> Tyrel Datwyler (2):
>   ibmvfc: store vhost pointer during subcrq allocation
>   ibmvfc: alloc/free queue resource only during probe/remove
> 
> drivers/scsi/ibmvscsi/ibmvfc.c | 82 ++++++++++++++++++++++++++--------
>  drivers/scsi/ibmvscsi/ibmvfc.h |  2 +-
>  2 files changed, 65 insertions(+), 19 deletions(-)
> 
> [...]

Applied to 5.19/scsi-fixes, thanks!

[1/1] ibmvfc: store vhost pointer during subcrq allocation
      https://git.kernel.org/mkp/scsi/c/aeaadcde1a60

-- 
Martin K. Petersen	Oracle Linux Engineering
