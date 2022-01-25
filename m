Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81DB49ABDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiAYFnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:43:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38194 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235454AbiAYFlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:01 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P3dvCY005584;
        Tue, 25 Jan 2022 05:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=sqUvDyA5YZpT3JndOpFnDDOz6wZ/rAgG1aiM+F3xWkw=;
 b=jNEqIROOHq1GO38MVEs+E355KnwUxH+p10clWeFAny7QontAFAuekw+h0v3NfBKfQ/6P
 gqWVyTgyez7JZJWIE2rs89INNMjtwH0DDpvvk1xG3UWQnwFB+sCU/v3KtBaTE6qF7aQH
 eOjENlBDA5SaEALno7c4/Uqwf53p0kq1op1l80xsf9qNGzOP5cW6aSKbnYaCyTVZcrzf
 ONBjQOakNLoLq1r31/UfBTAW+dMrTyVn/NSovkCjvn4Jppq4diOrrPzCQUzL8L0nPPsr
 4iE/lOKEvMK8TFpyGMFR6ioKMMAjX9U9DkfWprOf2qsCDOzgUj06+dri3pP0OsMlLvYu iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9j7ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5eu1b181678;
        Tue, 25 Jan 2022 05:40:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr71x1sj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:40:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5embg181395;
        Tue, 25 Jan 2022 05:40:50 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dr71x1sgc-2;
        Tue, 25 Jan 2022 05:40:50 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: Remove useless DMA-32 fallback configuration
Date:   Tue, 25 Jan 2022 00:40:38 -0500
Message-Id: <164308671272.32373.2478043846712410369.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <5663cef9b54004fa56cca7ce65f51eadfc3ecddb.1642238127.git.christophe.jaillet@wanadoo.fr>
References: <5663cef9b54004fa56cca7ce65f51eadfc3ecddb.1642238127.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p6Xh9rVRl8eC5dSOorwm0j2goN3zjn6h
X-Proofpoint-GUID: p6Xh9rVRl8eC5dSOorwm0j2goN3zjn6h
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 10:15:41 +0100, Christophe JAILLET wrote:

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

[1/1] scsi: bfa: Remove useless DMA-32 fallback configuration
      https://git.kernel.org/mkp/scsi/c/012d98dae453

-- 
Martin K. Petersen	Oracle Linux Engineering
