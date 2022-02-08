Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA304AD0B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiBHFcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347059AbiBHEwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D2C0401E9;
        Mon,  7 Feb 2022 20:52:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2183uVSp027133;
        Tue, 8 Feb 2022 04:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=zbVDoYA479ZbcRRUhWt2GKvc3OrtvWEZdtetf1iNwKA=;
 b=jVtSZLOKJdJjyd3b8KQtw6ZSI7oKyxoHwEpJrjJ9sY/+WpnLhw9YzkbHK6e6jBu1R0C2
 GIPxHPezHQd1P5wEOhaDbJyqx6pbrg6WgYKkh7wUdIRanU3m32K/dqb9mrBintZCIDFa
 Qu23Uxtl6vapSuDguIj7AMDSOaWZEb2lx2R1e3fOhc0Vc79KZnLRrrEovsuDAv7kuB3s
 CWxuLarRZgUNMC0RHOslUhT9TBigYE0ki64QLD6CB0xvUOMIIdXD5SsB8XfeEySno6YB
 wx3eMnCqHzUh52zUV3AdzYAMga79eYwytBvf/5hFPpagqUGSNY0Mxsz3bV7z9RdKEV1V Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28g3j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q1xW088260;
        Tue, 8 Feb 2022 04:52:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppss3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:25 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKhx089147;
        Tue, 8 Feb 2022 04:52:24 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-4;
        Tue, 08 Feb 2022 04:52:24 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     anil.gurumurthy@qlogic.com, davidcomponentone@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, Zeal Robot <zealci@zte.com.cn>,
        Yang Guang <yang.guang5@zte.com.cn>,
        linux-scsi@vger.kernel.org, sudarsana.kalluru@qlogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bfa: replace snprintf with sysfs_emit
Date:   Mon,  7 Feb 2022 23:52:15 -0500
Message-Id: <164429583888.16454.10783127045958324875.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <def83ff75faec64ba592b867a8499b1367bae303.1643181468.git.yang.guang5@zte.com.cn>
References: <def83ff75faec64ba592b867a8499b1367bae303.1643181468.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 73BlMtZdzsKVrjqk4t9vJ8ZfKS5es687
X-Proofpoint-GUID: 73BlMtZdzsKVrjqk4t9vJ8ZfKS5es687
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 08:03:46 +0800, davidcomponentone@gmail.com wrote:

> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/scsi/bfa/bfad_attr.c:908:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:860:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:888:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:853:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:808:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:728:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:822:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:927:9-17:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:900:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:874:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:714:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/bfa/bfad_attr.c:839:8-16:
> WARNING: use scnprintf or sprintf
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: bfa: replace snprintf with sysfs_emit
      https://git.kernel.org/mkp/scsi/c/2245ea91fd3a

-- 
Martin K. Petersen	Oracle Linux Engineering
