Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635A4933EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351487AbiASEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:06:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24406 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351460AbiASEGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:06:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx3mT022260;
        Wed, 19 Jan 2022 04:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Is0RxxFusS17EU4y8KEr+vNiOrU+GXKq+9bew6VJxEI=;
 b=QMR7bTqrOki/WC4guc/q8gseADxVFLpL/wxXO7JYN3ixr6tSBhDPdKsoJV3FXTvfgtJ+
 xI0GHJBFmOPSUMO5SUb2+zBc8wHTOVcUvCUycCJPq44y6RHNyAKYyfekp3NLGM0r7ncO
 GgFkk4LUCHld6HolSVzfr5sT0zMsXgfPrc+uXT11xZlIlqcnrvMEXwXozIrQqnoGGCYg
 p5li0RW4o3U89y/r6Vy0Hq+lxhAb9GBKrTLJSrlRRW2GGwJKdiOhPZIb8cv/xaOqJwhz
 lIYamnnhEUcNkPE8o85cRVFUsdLnuZL/D8p9i0L71SWnWnABvBowwmw8jCkuRWzuEaz0 Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52uv8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J42A5N091561;
        Wed, 19 Jan 2022 04:06:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:22 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20J46HQ7110383;
        Wed, 19 Jan 2022 04:06:22 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr68-5;
        Wed, 19 Jan 2022 04:06:21 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-scsi@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] scsi: ufs: ufs-mediatek : Fix NULL vs IS_ERR checking in ufs_mtk_init_va09_pwr_ctrl
Date:   Tue, 18 Jan 2022 23:06:13 -0500
Message-Id: <164256513503.31841.2498520978130234851.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211222070930.9449-1-linmq006@gmail.com>
References: <CAGXv+5GF1WOeXVtnknAa4GYXE3Hd-UzcCBCyQzT6KY3tJCrVGA@mail.gmail.com> <20211222070930.9449-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aLqOXzXBfJv9DFzSfV1-xmycvzNoXC2E
X-Proofpoint-ORIG-GUID: aLqOXzXBfJv9DFzSfV1-xmycvzNoXC2E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 07:09:30 +0000, Miaoqian Lin wrote:

> The function regulator_get() return error pointer,
> use IS_ERR() to check if has error.
> 
> 

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-mediatek : Fix NULL vs IS_ERR checking in ufs_mtk_init_va09_pwr_ctrl
      https://git.kernel.org/mkp/scsi/c/3ba880a12df5

-- 
Martin K. Petersen	Oracle Linux Engineering
