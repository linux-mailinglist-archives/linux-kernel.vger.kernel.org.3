Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14849ABF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbiAYFp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:45:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16942 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235623AbiAYFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:44 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P4emRw005953;
        Tue, 25 Jan 2022 05:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Gb5xYRcTvDL82zLNU4ufie4IQp23BbDAPogYfnIbPr4=;
 b=pb3X0gbMnN7IPWbexRbiNt9UMrG+URe9PCrvQHKuEh69mijql+GcqbOTrWIY9iRPseIC
 5F1fFf0uwefdJO/dxHfC8xQz+LD8zs91BZGNQPM1ENOs4DnmogSSc30U5b6+Nw0ZwJ/g
 T0VXEIOddKWKJYqkj4k+iHv1zVVkxhWkPxRGhk5+TamIHMrL7eDIMVkECcqpavobnHPr
 WVm4RR0WxX7R0zLP7D6Jwy1XnQ3jB0Y4A/HVHUdfi5j0CA/ehlR+M+dqN1N+TCk4q3eJ
 QmYrUothXDvyb3JO/281Vh5EK7GU7XD6oI26wMS799uv7pKPz7kSLFHjcGfKEyDaRJny HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaaa1bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5ePUc145364;
        Tue, 25 Jan 2022 05:41:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3drbcn1sw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:38 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5fW7D149214;
        Tue, 25 Jan 2022 05:41:37 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3drbcn1ss0-4;
        Tue, 25 Jan 2022 05:41:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v1] scsi: myrs: fix crash on error case
Date:   Tue, 25 Jan 2022 00:41:31 -0500
Message-Id: <164308927349.18787.5117723366670318865.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123225717.1069538-1-ztong0001@gmail.com>
References: <20220123225717.1069538-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NgnwCp9j4awYqYIU00erXzpt0ccGIzXr
X-Proofpoint-ORIG-GUID: NgnwCp9j4awYqYIU00erXzpt0ccGIzXr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 14:57:17 -0800, Tong Zhang wrote:

> In myrs_detect(), cs->disable_intr is NULL when privdata->hw_init() fail
> with non-zero. In this case, myrs_cleanup(cs) will call a NULL ptr and
> crash kernel.
> 
> [    1.105606] myrs 0000:00:03.0: Unknown Initialization Error 5A
> [    1.105872] myrs 0000:00:03.0: Failed to initialize Controller
> [    1.106082] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.110774] Call Trace:
> [    1.110950]  myrs_cleanup+0xe4/0x150 [myrs]
> [    1.111135]  myrs_probe.cold+0x91/0x56a [myrs]
> [    1.111302]  ? DAC960_GEM_intr_handler+0x1f0/0x1f0 [myrs]
> [    1.111500]  local_pci_probe+0x48/0x90
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: myrs: fix crash on error case
      https://git.kernel.org/mkp/scsi/c/4db09593af0b

-- 
Martin K. Petersen	Oracle Linux Engineering
