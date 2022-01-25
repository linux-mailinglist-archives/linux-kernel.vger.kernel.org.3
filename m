Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADA49ABED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiAYFox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:44:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20784 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235626AbiAYFls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:48 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P1bXsa001332;
        Tue, 25 Jan 2022 05:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=mjM+Nm44oOV34gDRMPqiFvM8QA1bcvWWmTThMa0QDH4=;
 b=myAomR0InR33n2Tj+jKexIdOOVND1cx6jVZqL/pE7QtncNsPuCoT1SLYFzIUHqcI26Wt
 q947oj1+AbOdQ+zF4BDWbYg4sSr6/Y0hZxVeL74hFI0uQvVLo4Os2cHGmqCdkBT8ufBM
 IIxteJg9nY6eO16uPt0YzofqWqPkM6mbzTmbwf1Cu88TF9UTlc7b5uxF2fyRCes92GIF
 +3i4/8MCa8btOzvMD0CFw2JnvA8VsBXrGaGt2gbnde8FUiTpsRK1V8JkBoRpkIXlSl1w
 pHwiB603rmIXqXm4qdPyz5th2FyiYIzerYmhqNcvcPbgCQMN3Li/M+4eX+nDyTHK/SM4 PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s1ut8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5eP2H145458;
        Tue, 25 Jan 2022 05:41:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3drbcn1sv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:37 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5fW7B149214;
        Tue, 25 Jan 2022 05:41:36 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3drbcn1ss0-3;
        Tue, 25 Jan 2022 05:41:36 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cang@codeaurora.org, avri.altman@wdc.com, sc.suh@samsung.com,
        beanhuo@micron.com, bhoon95.kim@samsung.com,
        Kiwoong Kim <kwmad.kim@samsung.com>, vkumar.1997@samsung.com,
        hy50.seo@samsung.com, jejb@linux.ibm.com, adrian.hunter@intel.com,
        alim.akhtar@samsung.com, sh425.lee@samsung.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3] scsi: ufs: use an generic error code in ufshcd_set_dev_pwr_mode
Date:   Tue, 25 Jan 2022 00:41:30 -0500
Message-Id: <164308927348.18787.13724566963992033005.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1642743182-54098-1-git-send-email-kwmad.kim@samsung.com>
References: <CGME20220121053455epcas2p4f2710091dc5f722a220be91243c60eed@epcas2p4.samsung.com> <1642743182-54098-1-git-send-email-kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xvq_4z0n5FyFToJjS71gT_NmdpXb9Zyb
X-Proofpoint-ORIG-GUID: Xvq_4z0n5FyFToJjS71gT_NmdpXb9Zyb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 14:33:02 +0900, Kiwoong Kim wrote:

> v2 -> v3: change the value of ret only if it's positive
> v1 -> v2: modify the comment of ufshcd_set_dev_pwr_mode
> 
> The return value of ufshcd_set_dev_pwr_mode is given to
> device pm core. However, the function currently returns a result
> in scsi command and the device pm core doesn't understand it.
> It might lead to unexpected behaviors of user land. I found
> the return value led to platform reset in Android.
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: ufs: use an generic error code in ufshcd_set_dev_pwr_mode
      https://git.kernel.org/mkp/scsi/c/ad6c8a426446

-- 
Martin K. Petersen	Oracle Linux Engineering
