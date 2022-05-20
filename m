Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC77B52E188
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiETBJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbiETBJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCA1129EE2;
        Thu, 19 May 2022 18:09:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0JFqK023930;
        Fri, 20 May 2022 01:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=h3o0epr+LElo8wuRHEgVvV0PZDfi8uMukJ6SK4jvkiM=;
 b=wLxJC2+F2SKgBTndFgsGYBh0eIGQEpm/9LdxK8lDxbuPXthBwtP3Wu6FL9s0beTwvpBT
 jDYmYGfQjiGUa+1sc94Y9C7VGT9tHwN3ODqDJ6PuIW6y3Si7dLua8cIfgcDfSqDecCZF
 wZF1+bD9d1uTXmobHqHgtPzVAnimxsDByK2s25HyYzucHVWC4FLcd3KFy9rYU0pgFdsp
 PfTXFj4XHgnO5VT6HpWhRiprmYX7tgew++RLu4RZFWmHM7xXt+YUYhyHjm8WJXnBRD44
 5+OB2nQC193B2jqJogD9SFTHEU+QxbbSNfRYsTHhbkTxhKpFER3TAd990PGc8N6USfhF lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aanetk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15ocj020274;
        Fri, 20 May 2022 01:09:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKD030710;
        Fri, 20 May 2022 01:09:21 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-5;
        Fri, 20 May 2022 01:09:21 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     cgel.zte@gmail.com, brking@us.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: Re: [PATCH] [SCSI] ipr: use kobj_to_dev()
Date:   Thu, 19 May 2022 21:09:04 -0400
Message-Id: <165300891229.11465.3097494128929554082.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220510105113.1351891-1-chi.minghao@zte.com.cn>
References: <20220510105113.1351891-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b2VVXjTWMFY-HBH6mJr_GgTs5WIS8n9h
X-Proofpoint-GUID: b2VVXjTWMFY-HBH6mJr_GgTs5WIS8n9h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:51:13 +0000, cgel.zte@gmail.com wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use kobj_to_dev() instead of open-coding it.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] ipr: use kobj_to_dev()
      https://git.kernel.org/mkp/scsi/c/aabd5fea4946

-- 
Martin K. Petersen	Oracle Linux Engineering
