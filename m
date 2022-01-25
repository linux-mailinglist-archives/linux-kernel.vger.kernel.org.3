Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D092149ABE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiAYFoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:44:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42610 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235464AbiAYFlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P3K9Bq005517;
        Tue, 25 Jan 2022 05:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=mFjM56BpWy/TD1of+kXG2Dg+y7MNt+HYKQGNQIjUFW8=;
 b=H4jvJzdFerOjkPRnQRkqMHqalfpWfHcs5AqbixAjpNHcMlhqpT95Npyw1B3qtsarTkWG
 Wap2UBqDbTdLmfw6KGRV8g4s6cCPRFFzqsaK1xIumZA4InS5tp38rlXrkY4z36yLshTM
 /JlbPOB9RowvcwiOIxkz2kVGkV+vHIU7W8VLPSLQPGk/EUqPb/YI+kvHQVgQgjU4aAWa
 ss8pJB9HzDCviriWlH8w4GVhFRB5gMiD94a5C7TfvPekW6YEd57Fn19nlY5VzAVeucaK
 8ZQELqpnhc7kt9JGKEPaI1aDH4gKVsaGwHvu+o8wr4YCWohhZvOsw/b2weV+nQ3taExm Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9j7tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5evrM181775;
        Tue, 25 Jan 2022 05:40:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr71x1snu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:57 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5evOV181790;
        Tue, 25 Jan 2022 05:40:57 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dr71x1sgc-3;
        Tue, 25 Jan 2022 05:40:57 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: Remove useless DMA-32 fallback configuration
Date:   Tue, 25 Jan 2022 00:40:39 -0500
Message-Id: <164308671272.32373.7807949381295180194.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1bf2d3660178b0e6f172e5208bc0bd68d31d9268.1642237482.git.christophe.jaillet@wanadoo.fr>
References: <1bf2d3660178b0e6f172e5208bc0bd68d31d9268.1642237482.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZTSUw16RDWaIFiEmCZL1PWaF6NZBZtJ3
X-Proofpoint-GUID: ZTSUw16RDWaIFiEmCZL1PWaF6NZBZtJ3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 10:05:22 +0100, Christophe JAILLET wrote:

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: hisi_sas: Remove useless DMA-32 fallback configuration
      https://git.kernel.org/mkp/scsi/c/8001fa240fc0

-- 
Martin K. Petersen	Oracle Linux Engineering
