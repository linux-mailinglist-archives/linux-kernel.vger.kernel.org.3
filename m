Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA24933E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351480AbiASEGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:06:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21010 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351468AbiASEGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:06:32 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx7Xn002453;
        Wed, 19 Jan 2022 04:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=ZFkTm14Hros7XNfwsRNUPHtpTppmIcVEtsV8v9/LdTY=;
 b=DzODZV+gPT67rWISunvpv+1AT5hBuJoOrAJwCK7OQZPHwLI9Wkt/8LLq1sxtRpbmyFiP
 CbhInYxFePWxPi0ng69tAmv71e/nPKqZ9B8mV0Q6/V2xp7hvnybNlbT7mAl1FYZooeNK
 XehWPiAAjaTir2BesxRMM1neCG8Xod6rtfeC0SadDNeTvJJuRYRDn1slAadZ7kSLMAVJ
 RaBV6+jtaYlLCDlWvHqWECI/dR6xSdepEj3M5YGM8Z2sX006e0QBCXFcoVKn/UPz+/qV
 +3nWWi9r5wkHxbBN0tbtBjeirfvWjQum4nlWdL86olDHGZL5RsRhEECaiNpkMVK/SutZ uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc5f3tfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J42AYr091589;
        Wed, 19 Jan 2022 04:06:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:20 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20J46HQ3110383;
        Wed, 19 Jan 2022 04:06:19 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr68-3;
        Wed, 19 Jan 2022 04:06:19 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, avri.altman@wdc.com,
        asutoshd@codeaurora.org, linux-scsi@vger.kernel.org,
        beanhuo@micron.com, jejb@linux.ibm.com, bvanassche@acm.org,
        SEO HOYOUNG <hy50.seo@samsung.com>, cang@codeaurora.org,
        alim.akhtar@samsung.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Date:   Tue, 18 Jan 2022 23:06:11 -0500
Message-Id: <164256513503.31841.5189730630900895646.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220106213924.186263-1-hy50.seo@samsung.com>
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com> <20220106213924.186263-1-hy50.seo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IJdk2lgPZoJqd633EHY2QsuV4Pqv4EFG
X-Proofpoint-ORIG-GUID: IJdk2lgPZoJqd633EHY2QsuV4Pqv4EFG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 06:39:24 +0900, SEO HOYOUNG wrote:

> The Tactive time determine the waiting time before burst
> at hibern8 exit and is determined by H/W at linkup state
> However, in the case of samsung devices, guided host's Tactive time
> +100us for stability.
> If the HCI's Tactive time is equal or greater than the device,
> +100us should be set.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: ufs: modify Tactive time setting conditions
      https://git.kernel.org/mkp/scsi/c/9008661e1960

-- 
Martin K. Petersen	Oracle Linux Engineering
