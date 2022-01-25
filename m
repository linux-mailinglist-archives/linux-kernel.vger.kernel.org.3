Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AAD49ABEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiAYFou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:44:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54778 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235525AbiAYFlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:19 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P1i5Yh016125;
        Tue, 25 Jan 2022 05:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=N2EF81Bf5CfQnrO58+azCItXag2lwc0+0KRtkDVi7cg=;
 b=kGLJwlyGLP/skLCo53TLQXhRP6dfmhA6Eb0lVKNNOmkw64R9cnd5OLexwDgpf8lA/Can
 lKJuLCxewXiJ1zd0KkH5MTifhP44Pk8Pu/pYGVOa04KrakTRxa2MNQp3u45F6NGCBpmb
 vld7e3dLl5ZVWeiiIgAIS1fIwfd8VVQQyAv5nJxczfUR/tXCjdax2DwdlWNVseUU6gEM
 xFoB0ceY4fH8oy5NZ3J0ABTGqob4Hdk1dSjfd4K894tP/e/90ChtXmjH5e88BT/U7EAX
 9XqqqbVTQZd5vnnvRRQvrfhBJrp42FeGX51x9gEUUAYT8389TW7xiOBOiV8hCScFZ5I1 fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfhw4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5euTq181698;
        Tue, 25 Jan 2022 05:41:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr71x1stm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:07 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5evOj181790;
        Tue, 25 Jan 2022 05:41:06 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dr71x1sgc-10;
        Tue, 25 Jan 2022 05:41:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>, hch@lst.de,
        james.smart@broadcom.com
Subject: Re: [PATCH -next v2] scsi: efct: don't use GFP_KERNEL under spin lock
Date:   Tue, 25 Jan 2022 00:40:46 -0500
Message-Id: <164308671269.32373.10524301439896995179.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111012441.3232527-1-yangyingliang@huawei.com>
References: <20220111012441.3232527-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CY8ERybcboHaOPIs-nApS0Mb3ADNm0iq
X-Proofpoint-ORIG-GUID: CY8ERybcboHaOPIs-nApS0Mb3ADNm0iq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 09:24:41 +0800, Yang Yingliang wrote:

> GFP_KERNEL/GFP_DMA can't be used under a spin lock, according the
> comment of els_ios_lock, it's used to protect els ios list, so we
> can move down the spin lock to avoid using this flag under the lock.
> 
> 

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: efct: don't use GFP_KERNEL under spin lock
      https://git.kernel.org/mkp/scsi/c/61263b3a11a2

-- 
Martin K. Petersen	Oracle Linux Engineering
