Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471184C61ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiB1DoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiB1DoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:44:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562063982A;
        Sun, 27 Feb 2022 19:43:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMwaGT029567;
        Mon, 28 Feb 2022 03:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=WDPd4UU66TYdGYyEzivTW4h3BXzO/do4dlet7bzcTrs=;
 b=HZTxdwhjO6Pw2Qxq8pxHVMvOukRLGlwvT7PFBgEqjESCJ8w1CoUeOcKAh9IFnJkVHnSJ
 lqgWMV5KgLmS5Ejhhp2cyxkJHQ7w9OTKBoGqFCtq8De5iNKog9vSfYzeHW2Ofw7b3ifO
 Oss032za4bI3puwS59qV1KgUcbyiDG7AoD2CIg6H0ax5Jg7piGKzY0WtUZEo11tTLLrc
 z277hi2/yQk2+QUER+UjPtOFCOgfV85YYLUG0b85Y2jSBpabk8Kpzjs9361NH4qrXHIx
 VK+2upTdNojG+XXMHUo5lmgANj1LSii37xlRFgGuQSqaRblrFrWRtxQD/OH1RJN2uZw0 Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efbttayev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S3bHn3157825;
        Mon, 28 Feb 2022 03:43:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:43:32 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21S3hPvw165853;
        Mon, 28 Feb 2022 03:43:31 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by aserp3030.oracle.com with ESMTP id 3efa8bxnt3-7;
        Mon, 28 Feb 2022 03:43:31 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, bostroesser@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        xlpang@linux.alibaba.com, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH V4] scsi: target: tcmu: Make cmd_ring_size changeable via configfs
Date:   Sun, 27 Feb 2022 22:43:21 -0500
Message-Id: <164601967777.4503.13105145657095242015.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1644978109-14885-1-git-send-email-kanie@linux.alibaba.com>
References: <1644978109-14885-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hGCbUb_VMG1B_joGWGWU4EG_X7pw8rT_
X-Proofpoint-ORIG-GUID: hGCbUb_VMG1B_joGWGWU4EG_X7pw8rT_
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 10:21:49 +0800, Guixin Liu wrote:

> Make cmd_ring_size changeable similar to the way it is done for
> max_data_area_mb, the reason is that our tcmu client will create
> thousands of tcmu instances, and this will consume lots of mem with
> default 8Mb cmd ring size for every backstore.
> 
> One can change the value by typing:
>     echo "cmd_ring_size_mb=N" > control
> The "N" is a integer between 1 to 8, if set 1, the cmd ring can hold
> about 6k cmds(tcmu_cmd_entry about 176 byte) at least.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: target: tcmu: Make cmd_ring_size changeable via configfs
      https://git.kernel.org/mkp/scsi/c/c7ede4f044b9

-- 
Martin K. Petersen	Oracle Linux Engineering
