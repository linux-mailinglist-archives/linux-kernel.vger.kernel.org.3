Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025B349ABF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiAYFqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:46:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31400 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235409AbiAYFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:40:55 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P1VRwS019388;
        Tue, 25 Jan 2022 05:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=LZnB4L07KX57W1nMkDDt+14Tce7jS78AInJQ9XIn0JA=;
 b=a1XlucWmtEK0B0zfylAZIH+2vDa8Z9PyRPgAxAyGpaDuE2zuCCwOjKqIPxyRGsgcMdDB
 AG9c1OGS+/Nt3yfG6XfDfFLvVS2RkIKbLUouFodWxiZ9f0BMmIaePlX+SnFk8k4OQ4uj
 pq59t8veCB3190LQyTmetwd034x8Pcp9SDDURwKDhci6s020IUPAJCYEzDdyTU8vL5Oc
 HCTBq+Csc1RFyJ8Z0UDQ7W8jiVZdokPbmo+j8OvFndXn2mEcaBWl7vXjSQf50pFweC8e
 bjlCikElctuTMSiVKKtgtxyePTVlGrc0RqanEDJuNxqDHbaN9HPcgeHqzQFUKt0HQX6j 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7asxpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5auwX172061;
        Tue, 25 Jan 2022 05:40:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr71x1shf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:49 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5embe181395;
        Tue, 25 Jan 2022 05:40:48 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dr71x1sgc-1;
        Tue, 25 Jan 2022 05:40:48 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Remove useless DMA-32 fallback configuration
Date:   Tue, 25 Jan 2022 00:40:37 -0500
Message-Id: <164308671272.32373.7479857078284374730.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <dbbe8671ca760972d80f8d35f3170b4609bee368.1642236763.git.christophe.jaillet@wanadoo.fr>
References: <dbbe8671ca760972d80f8d35f3170b4609bee368.1642236763.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wfgt_y3oIB8nlCN-vsMWRsww0p-0Ae3t
X-Proofpoint-ORIG-GUID: wfgt_y3oIB8nlCN-vsMWRsww0p-0Ae3t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 09:53:03 +0100, Christophe JAILLET wrote:

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

[1/1] scsi: 3w-sas: Remove useless DMA-32 fallback configuration
      https://git.kernel.org/mkp/scsi/c/fb8d5ea8fd90

-- 
Martin K. Petersen	Oracle Linux Engineering
