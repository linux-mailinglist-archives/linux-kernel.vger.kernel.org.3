Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBA52E198
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbiETBJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiETBJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098DF129EF2;
        Thu, 19 May 2022 18:09:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0JN7p030255;
        Fri, 20 May 2022 01:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=A+GjuZ2zd2rtSbDhPqVYhSMuMmvSGTiOWbGal5KdhHo=;
 b=bGGV7WT3HpOjOwMTyg3xL9GBOf2kGkRRX1hDus1EHuK86YMZkZW8M2RaA8zvwBruuYdD
 sxXFIfIQCQxd0A+8h0OSnajhvnWV9PBqVwswcCxrX9M0SiSXsXKXzIO+UamGkSLRxG8j
 4EGZZuQex+CGynSsg9aIJ9Swk7XTW+mJTMu1VYC3wG1IteP+b3iT9LsMrxagJrpU1MvE
 QPbIVzC+puN6dEkZFvRO3Z7xtqtA6jd7i3bWswrOk2ZtKCImAhKSGsojeijlSYHeWSEi
 Q2nSZjz+kC1NkuSVmP4trhSbKOQ8dz5HdwB6uBVQJLlyLvdun78aCQ9bs6UjKn0kOOcI 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310wtqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nMM020176;
        Fri, 20 May 2022 01:09:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GK5030710;
        Fri, 20 May 2022 01:09:16 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-1;
        Fri, 20 May 2022 01:09:16 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: dpt_i2o: Drop redundant spinlock initialization
Date:   Thu, 19 May 2022 21:09:00 -0400
Message-Id: <165300891232.11465.12336284631669008040.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1652176024-3981-1-git-send-email-baihaowen@meizu.com>
References: <1652176024-3981-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W5GKhqritYDh4rlGiUbQjwgpi82wp9HA
X-Proofpoint-GUID: W5GKhqritYDh4rlGiUbQjwgpi82wp9HA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 17:47:03 +0800, Haowen Bai wrote:

> adpt_post_wait_lock has declared and initialized by DEFINE_SPINLOCK,
> so we don't need to spin_lock_init again, drop it.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: dpt_i2o: Drop redundant spinlock initialization
      https://git.kernel.org/mkp/scsi/c/91fdd0788878

-- 
Martin K. Petersen	Oracle Linux Engineering
