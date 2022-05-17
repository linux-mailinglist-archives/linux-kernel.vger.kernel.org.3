Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20376529741
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiEQCRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiEQCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:16:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AAC3CFC8;
        Mon, 16 May 2022 19:16:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKjIku009400;
        Tue, 17 May 2022 02:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=kIvQXMUpqHeuFl1hb4BdCEnDxRQq83wvnFw0BeZmr+I=;
 b=txIl8TiUKqFx6HiZ3EWR0lPk/HIl2Pp0E5vEuHjTdN4cz9Z70rgmnP3nClH8QuyDfhln
 k4pxoRTnfmdk92GixIr3u3lEggCN76D+BK+2EEhR1ZCN7so9o07M31bkdIIqkAKq7n6b
 B6f8agEEqQRT4JBRsp6X6guTh2E/sYlQOPXxpU0cbL8ol+pHgONI7wfFV4Pf6mS1ooNp
 C0iDCwSahe+hc76XwlzjteDkU8zoQKdSsIuJOUt7WPKkr2sJJnN0oxMNY+ZUpXhj6Cz0
 MFghFbKeDzjlV74TuF6gPD3o7TjYB37K225IGgOpDFmrwqenzoyrD0IYiIKN6qrWguCa Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24ytmwjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:16:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24H2G8m4019236;
        Tue, 17 May 2022 02:16:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83hm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 02:16:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24H2Ghvv019875;
        Tue, 17 May 2022 02:16:44 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v83hkf-2;
        Tue, 17 May 2022 02:16:44 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linuxarm@huawei.com, Xiang Chen <chenxiang66@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: Undo RPM resume for failed notify phy event for v3 HW
Date:   Mon, 16 May 2022 22:16:37 -0400
Message-Id: <165275376859.24722.16712573380099585234.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1651839939-101188-1-git-send-email-john.garry@huawei.com>
References: <1651839939-101188-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IP0pTEvs5yFoDDBZKxzZgAKtP4WXWv4c
X-Proofpoint-ORIG-GUID: IP0pTEvs5yFoDDBZKxzZgAKtP4WXWv4c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 20:25:39 +0800, John Garry wrote:

> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> If we fail to notify the phy up event then undo the RPM resume, as the
> phy up notify event handling pairs with that RPM resume.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: hisi_sas: Undo RPM resume for failed notify phy event for v3 HW
      https://git.kernel.org/mkp/scsi/c/9b5387fe5af3

-- 
Martin K. Petersen	Oracle Linux Engineering
