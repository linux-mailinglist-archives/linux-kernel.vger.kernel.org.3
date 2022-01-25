Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5797049ABE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiAYFom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:44:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51278 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235514AbiAYFlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:41:12 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P1i5Yf016125;
        Tue, 25 Jan 2022 05:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=hn4alr1qgwLUbeh7Pc2bg7Lxe9jmoANUClkdYn0J8bg=;
 b=dXp4NYEw5xq8WJj6h5lJ3deGWtu8eHZCSwa6X2rHPbPQupuKcyEJVKXFw61rHlvQ1lhG
 fiXrr54iRSmLkLseStjWswNOZkfF1/SmedfI+SWw2z0arojvNSKMV/5isdcRUHVoccIS
 R+7DO60TmgjVpqgQ8mNgY268h/EMGxSScf6NZh1Tf47F6j4l8VF3vaxGzxjW1HhUr7cV
 Ad8FAbPCdqAnkBU883PWsQxR190yO/reLL+15AvpW0uJvXjotb+mjxNwjORWoXcqaIci
 ww+IOm1Uy3bza/r2mh/HBPmfRJHPBAnbZmqrOI2sLnUChswd6Z5xGnTED09mLuVt6+lq Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfhw42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20P5eu1i181678;
        Tue, 25 Jan 2022 05:41:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3dr71x1sq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 05:41:01 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 20P5evOZ181790;
        Tue, 25 Jan 2022 05:41:00 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3dr71x1sgc-5;
        Tue, 25 Jan 2022 05:41:00 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jinpu.wang@cloud.ionos.com, Ajish.Koshy@microchip.com,
        damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com,
        John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ruksar.devadi@microchip.com, ipylypiv@google.com,
        linux-kernel@vger.kernel.org, vishakhavc@google.com,
        linux-scsi@vger.kernel.org, Viswas.G@microchip.com,
        Vasanthalakshmi.Tharmarajan@microchip.com
Subject: Re: [PATCH v2] scsi: pm8001: Fix bogus FW crash for maxcpus=1
Date:   Tue, 25 Jan 2022 00:40:41 -0500
Message-Id: <164308671270.32373.5920693563555904240.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1642508105-95432-1-git-send-email-john.garry@huawei.com>
References: <1642508105-95432-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X-sdo9Btk-_sfYVUqJKYHRyOfGgdwebL
X-Proofpoint-ORIG-GUID: X-sdo9Btk-_sfYVUqJKYHRyOfGgdwebL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 20:15:05 +0800, John Garry wrote:

> According to the comment in check_fw_ready() we should not check the
> IOP1_READY field in register SCRATCH_PAD_1 for 8008 or 8009 controllers.
> 
> However we check this very field in process_oq() for processing the highest
> index interrupt vector. The highest interrupt vector is checked as the FW
> is programmed to signal fatal errors through this irq.
> 
> [...]

Applied to 5.17/scsi-fixes, thanks!

[1/1] scsi: pm8001: Fix bogus FW crash for maxcpus=1
      https://git.kernel.org/mkp/scsi/c/62afb379a0fe

-- 
Martin K. Petersen	Oracle Linux Engineering
