Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BE473C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhLNEke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:40:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7604 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhLNEkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:40:33 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE1Xx0v004559;
        Tue, 14 Dec 2021 04:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=aznH5l5En/sczyiO3evzo5zqAZaM7F3F6iuZ/NbDaic=;
 b=SG2plJ4JJEq+Uv2lH1QpCG9Nd6vzTKbn+FNWP71xd87KRkl+KvB2ci6ZoqvMRsU9hkWp
 84tuHJO8qsBkubEKjPcfEukyg6yLOdGoNhS0M0XJY/+783VsMrsP91Tiu+/w9qolonsh
 Rq2FxSGZYFksgvMgtbcKdtjunNujuzteE2EfC2ICDYVnq3J4DhPF+ka/SCeAiZjXed+E
 WAQmF/ZzHKGJ76+NPr+sCUesWMovNaHCaCFx+4hkAZiHPk3htYkJQyc0nh3hn5oohq3X
 CSaH/dstMxC8Fq5L8gKXTHcSSYVJQDhmugNRjNzSL8fDFMSuFMu/HQFhb/rV4P5NLP3H kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrtpmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4Z3po173806;
        Tue, 14 Dec 2021 04:40:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3cvnep983g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:23 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BE4eM2O184837;
        Tue, 14 Dec 2021 04:40:22 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3cvnep9837-1;
        Tue, 14 Dec 2021 04:40:22 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        jinpu.wang@cloud.ionos.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org,
        Viswas.G@microchip.com, Ajish.Koshy@microchip.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Date:   Mon, 13 Dec 2021 23:40:21 -0500
Message-Id: <163945671657.11494.4596359811374597542.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1639390248-213603-1-git-send-email-john.garry@huawei.com>
References: <1639390248-213603-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VvWwwNoC2OKAGFG3ckZ6FQhMtA_yPnN0
X-Proofpoint-GUID: VvWwwNoC2OKAGFG3ckZ6FQhMtA_yPnN0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 18:10:48 +0800, John Garry wrote:

> The driver supports a "direct" mode of operation, where the SMP req frame
> is directly copied into the command payload (and vice-versa for the SMP
> resp).
> 
> To get at the SMP req frame data in the scatterlist the driver uses
> phys_to_virt() on the DMA mapped memory dma_addr_t . This is broken,
> and subsequently crashes as follows when an IOMMU is enabled:
> 
> [...]

Applied to 5.16/scsi-fixes, thanks!

[1/1] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
      https://git.kernel.org/mkp/scsi/c/2fe24343922e

-- 
Martin K. Petersen	Oracle Linux Engineering
