Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6B49ABEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiAYFpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:45:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20060 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235625AbiAYFls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:48 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P2iOdi010986;
        Tue, 25 Jan 2022 05:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=8y6tLrD7cxqBO7T5WgdJm44GUjaKlkao6YCIV3FbrY8=;
 b=GF0vNmfO9kmagg5eBaZuZ3j657BHQnXqztX8GJddEDrkLr9D31yMURfVjtJapz6bUn1b
 BXbBTw6fxGYiTh/2aohjf03NQxDRAddYDPegl9Bt6znGqijjnlMNxE2WUcYOty+N2wVc
 5iwjpn46A+kcm6ghrVqp14QbJhcpPRzH6Dt33Q6Yc+1fMI1anD3ILZeXnTrOjNTfixqV
 MYDx8mDqj8G2F1c0JlOLfmUbr3MtgtrGloewGGZy5algWrm0MnsA3lK5nsOKg9Pk+xWx
 5vZXZEh3WUrbK/ruBDjBAoh17Q1aEMbPN5ehfgRTOvWGBidvLiYqfZHSveEWHk58CwGk qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaa1bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5eP9m145360;
        Tue, 25 Jan 2022 05:41:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3drbcn1su8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:35 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5fW79149214;
        Tue, 25 Jan 2022 05:41:34 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3drbcn1ss0-2;
        Tue, 25 Jan 2022 05:41:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cang@codeaurora.org, avri.altman@wdc.com,
        linux-kernel@vger.kernel.org, sc.suh@samsung.com,
        beanhuo@micron.com, bhoon95.kim@samsung.com,
        Kiwoong Kim <kwmad.kim@samsung.com>, vkumar.1997@samsung.com,
        hy50.seo@samsung.com, jejb@linux.ibm.com, adrian.hunter@intel.com,
        alim.akhtar@samsung.com, linux-scsi@vger.kernel.org,
        sh425.lee@samsung.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] scsi: ufs: see link lost as fatal
Date:   Tue, 25 Jan 2022 00:41:29 -0500
Message-Id: <164308927348.18787.15246053294728008313.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1642743475-54275-1-git-send-email-kwmad.kim@samsung.com>
References: <CGME20220121053945epcas2p386871d63f104de31d8fd0c123615b876@epcas2p3.samsung.com> <1642743475-54275-1-git-send-email-kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yxPfAXsk8hwe0xz4BMwZ9BsTe-AEi-Uo
X-Proofpoint-ORIG-GUID: yxPfAXsk8hwe0xz4BMwZ9BsTe-AEi-Uo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 14:37:55 +0900, Kiwoong Kim wrote:

> v1 -> v2: modify comment
> 
> This event is raised when link is lost as specified
> in UFSHCI spec and that means communication is
> not possible. Thus initializing UFS interface needs to be done.
> 
> This patch is to make UFS driver see Link Lost as fatal by using
> INT_FATAL_ERRORS. This lead to host reset whenever a link lost
> interrupt occurs.
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: ufs: see link lost as fatal
      https://git.kernel.org/mkp/scsi/c/c99b9b230149

-- 
Martin K. Petersen	Oracle Linux Engineering
