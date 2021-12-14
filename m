Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB03473C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhLNElN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:41:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36282 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhLNElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:41:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BE2O1jA005506;
        Tue, 14 Dec 2021 04:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=h/Mky9KhdcsSZAGpTnYmQ2cyEra7+cJI4aG0SSlbyAw=;
 b=INSDnolF0TzwyxHV9IMPK6XVXlejwIcKXL0gHsqlKHGmgn7JbVhJkoLIkSkJpKLXCrjG
 dtX/R8zCsA0SfqBw9bO1G1uDAqJ9dVrzyjWHrb7laoiEBsyr3ozvigUniII0nMru4DYl
 a5KMC5ljxuCwK+zphtZUKV2faTJfK5X0Fd3XzJxLxZvOJGcjV9rrfkb3W+ZloRhXF31Z
 vv/UTo7ms3MX49A3MUyEhrvbixI3/9jNDgXyoHhBGaHerNmsam1V87uBATtBm7jgoJHx
 o2oDMRS6sKZIdEwVj6mXGGPa5bT2iXEdCf39GQ29ARpaYVu9FhSFTTUY0piwxerj1Vi5 kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u2asg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BE4ZXmN032358;
        Tue, 14 Dec 2021 04:40:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3cvh3wp5be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 04:40:55 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BE4aj9A034843;
        Tue, 14 Dec 2021 04:40:55 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3cvh3wp5ab-3;
        Tue, 14 Dec 2021 04:40:54 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, john.garry@huawei.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] scsi: hisi_sas: Use devm_bitmap_zalloc() when applicable
Date:   Mon, 13 Dec 2021 23:40:49 -0500
Message-Id: <163945683291.11687.2480317688241626115.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
References: <4afa3f71e66c941c660627c7f5b0223b51968ebb.1637961191.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5hNP_JKoSyqai_S3HvOIQfFMO92ETEy3
X-Proofpoint-GUID: 5hNP_JKoSyqai_S3HvOIQfFMO92ETEy3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 22:15:21 +0100, Christophe JAILLET wrote:

> 'hisi_hba->slot_index_tags' is a bitmap. So use 'devm_bitmap_zalloc()' to
> simplify code, improve the semantic and avoid some open-coded arithmetic
> in allocator arguments.
> 
> 

Applied to 5.17/scsi-queue, thanks!

[1/3] scsi: hisi_sas: Use devm_bitmap_zalloc() when applicable
      https://git.kernel.org/mkp/scsi/c/54585ec62fbd
[2/3] scsi: hisi_sas: Remove some useless code in 'hisi_sas_alloc()'
      https://git.kernel.org/mkp/scsi/c/d43efddf6271
[3/3] scsi: hisi_sas: Use non-atomic bitmap functions when possible
      https://git.kernel.org/mkp/scsi/c/4d6942e2666e

-- 
Martin K. Petersen	Oracle Linux Engineering
