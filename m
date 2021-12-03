Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C82467077
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351342AbhLCDHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:07:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3996 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350224AbhLCDHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:07:43 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31YGH1032323;
        Fri, 3 Dec 2021 03:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=3GtMorerQQ94N/li8Ak8hBK5n/1RQu5Lb86Ot3mNBE0=;
 b=0PMO9CzpU0dIitj9N5B13Sa2yUunvieGY87lBCHhL5aTN9X9idIArtZxxDC06iLVhYX7
 HMi8oRLsEkxgTFfnQciooxWv5Wbs/ov5L54vTxJwFUqvccNDLrQvfUMUEGQRla0/+1SO
 qNggSIso2juqpgicaAuiVQigBjw9ot3wxP74oDNFLnURoDFBl6dYjRWwxaCsmsa+DxaD
 m4A7HgwwzCOqWRq3/fUqtziVaVidchdD7X6UXs5IJc9JHT6EDerSR1wsrJnFMlP/gs4z
 JU7I4aXJC65s9wo/hUxmOSb9UwptVZ/vVw5I0USF90WP5/LexhbgLCek3u1lbS1HTcQi qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7wewc6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 03:04:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B331qEP188371;
        Fri, 3 Dec 2021 03:04:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3cnhvht9hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Dec 2021 03:04:02 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1B3340ia003616;
        Fri, 3 Dec 2021 03:04:02 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3020.oracle.com with ESMTP id 3cnhvht9f3-3;
        Fri, 03 Dec 2021 03:04:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "supporter:QLOGIC QL41xxx ISCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "open list:QLOGIC QL41xxx ISCSI DRIVER" <linux-scsi@vger.kernel.org>,
        Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>
Subject: Re: [PATCH v2 0/2] scsi: qedi: Couple of warning fixes
Date:   Thu,  2 Dec 2021 22:03:59 -0500
Message-Id: <163850060429.30297.3525452173890019336.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211126201708.27140-1-f.fainelli@gmail.com>
References: <20211126201708.27140-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xNK9rECQH4c1KUyWvU9InjSaJ4Gvmv2V
X-Proofpoint-GUID: xNK9rECQH4c1KUyWvU9InjSaJ4Gvmv2V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 12:17:06 -0800, Florian Fainelli wrote:

> These warnings started to show up after enabling PCI on BMIPS (32-bit
> MIPS architecture) and were reported by the kbuild robot.
> 
> I don't know whether they are technically correct, in particular the
> unused 'page' variable might be unveiling a genuine bug whereby it
> should have been used. Please review.
> 
> [...]

Applied to 5.17/scsi-queue, thanks!

[1/2] scsi: qedi: Remove set but unused 'page' variable
      https://git.kernel.org/mkp/scsi/c/6d8619f034f0

-- 
Martin K. Petersen	Oracle Linux Engineering
