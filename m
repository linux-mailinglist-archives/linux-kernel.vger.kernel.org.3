Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248914933E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbiASEGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:06:24 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25828 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345914AbiASEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:06:22 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxWLV011214;
        Wed, 19 Jan 2022 04:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=qfNHRZNAv5K92DWooDSEcud7+z+x1WfUa/KOsFKw/Yk=;
 b=Z0ZcLCMAtix5E7lyqjR7zt63Wqjr+cvsFE/S0xWn5X5wiMaydDOyBjyfhCbzxgEE2jc9
 VP7C7FkGo55bh//uhv0oZb2+SnAvZf4EpSWI+jCbTL7M7PXC4DHsdokTLPipbO3gSmLP
 jNvy/+cXWlUHTiE9ouNR1973XSJn3pj9cldI9LPRndEz/+xV3mDO6kTPuMWSGbAu0YdF
 Q188EjAI5O+uk0o40Eg7o/0CPqRpd8PDyjp0F1IxNUv8qS0b+LjsJIVaYM93KsP+p8U2
 KHQFli8oebsjXyHxInln+wsVPpAswPei23ZeGppazHyqF9dU6zmCXmKpKPOJzMAniGjr Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnuueh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J42AZp091606;
        Wed, 19 Jan 2022 04:06:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 04:06:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20J46HQ1110383;
        Wed, 19 Jan 2022 04:06:18 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3dkqqpnr68-2;
        Wed, 19 Jan 2022 04:06:18 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        target-devel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: efct: Remove useless DMA-32 fallback configuration
Date:   Tue, 18 Jan 2022 23:06:10 -0500
Message-Id: <164256513503.31841.13425632142718657762.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
References: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vY66LZ6qZleUcXDEy6rM_neNllun1NS9
X-Proofpoint-ORIG-GUID: vY66LZ6qZleUcXDEy6rM_neNllun1NS9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 19:57:04 +0100, Christophe JAILLET wrote:

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> While at it, return the error code returned by dma_set_mask_and_coherent()
> instead of -1.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/1] scsi: efct: Remove useless DMA-32 fallback configuration
      https://git.kernel.org/mkp/scsi/c/1aa7d9799e85

-- 
Martin K. Petersen	Oracle Linux Engineering
