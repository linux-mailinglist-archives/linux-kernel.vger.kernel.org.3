Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8047DE83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbhLWFJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:09:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41602 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235176AbhLWFJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:09:35 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BN19KBP017247;
        Thu, 23 Dec 2021 05:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=+Uab6mKxODba9/IzOWCrlLSwqNC+svV8Lz4jtF9aIzw=;
 b=mEJ+8m0XwLwvhTnYXkJnYFCdNpFNIaVfiHyzKYbaF6BxHzX1LjRd5xrrOjyTxYllGlRZ
 bwZl+Tl4bVYR6d9PCepZE6y3uLgQfENp7vF73FOB4qyqKjp1hDbJoO3H8xoTCYB4d1gn
 ooKpcpARBZZSNcfljJqDbvji6eJqW7qKmZvlzR20mtfyeg2KY2nLiB1EVby6HxkhCCZ2
 paAA+mX8oZtZ5DLDR6pm73V0amQ/KYPWKfGGe8a5kAspl4Nze1fOJqght6y4/2hRjshY
 CTlZxptp2LHiXpuJW7d7BUPP7VeqzHySRn5et03D8XtEPihOx9PFYepPrzuIEvTZnva8 gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d4f6w08gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 05:09:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BN50vQQ102185;
        Thu, 23 Dec 2021 05:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3d17f68vee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 05:09:27 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BN59OTi125399;
        Thu, 23 Dec 2021 05:09:27 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3d17f68vdd-4;
        Thu, 23 Dec 2021 05:09:27 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] hisi_sas: Some misc patches
Date:   Thu, 23 Dec 2021 00:09:23 -0500
Message-Id: <164023594702.4594.9733277772140278376.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
References: <1639579061-179473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tOiWKWfJS_Pc1L6V9IhdywE5CoGqL79H
X-Proofpoint-ORIG-GUID: tOiWKWfJS_Pc1L6V9IhdywE5CoGqL79H
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 22:37:33 +0800, John Garry wrote:

> This is a small series of misc patches. Please consider for 5.17.
> 
> Briefly the series covers:
> - Factoring out the common and internal abort delivery code
> - Fix some races with controller reset (again!)
> - Fix out-of-order interrupt handling on FPGA
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/8] scsi: hisi_sas: Start delivery hisi_sas_task_exec() directly
      https://git.kernel.org/mkp/scsi/c/0e4620856b89
[2/8] scsi: hisi_sas: Make internal abort have no task proto
      https://git.kernel.org/mkp/scsi/c/934385a4fd59
[3/8] scsi: hisi_sas: Pass abort structure for internal abort
      https://git.kernel.org/mkp/scsi/c/08c61b5d902b
[4/8] scsi: hisi_sas: Factor out task prep and delivery code
      https://git.kernel.org/mkp/scsi/c/dc313f6b125b
[5/8] scsi: hisi_sas: Prevent parallel controller reset and control phy command
      https://git.kernel.org/mkp/scsi/c/20c634932ae8
[6/8] scsi: hisi_sas: Prevent parallel FLR and controller reset
      https://git.kernel.org/mkp/scsi/c/16775db613c2
[7/8] scsi: hisi_sas: Fix phyup timeout on FPGA
      https://git.kernel.org/mkp/scsi/c/37310bad7fa6
[8/8] scsi: libsas: Decode SAM status and host byte codes
      https://git.kernel.org/mkp/scsi/c/4be6181fea1d

-- 
Martin K. Petersen	Oracle Linux Engineering
