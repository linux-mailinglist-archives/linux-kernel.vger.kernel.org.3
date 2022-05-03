Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE451B6E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbiEEEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiEEEHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:07:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904524AE16;
        Wed,  4 May 2022 21:03:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242Ld6k4013502;
        Tue, 3 May 2022 00:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=dmEA6hGxxtuC+j8W+AxbqsIvaoGaObxm2mCr1uDhWE4=;
 b=MPsiMux82SaRHuA0/STTnXUfo6q9faAFDs3X5iWKGYDvWIODJ2zU8hy2RemjPpXaIpFA
 ZaD/q1RT20yVQWOxSPduAQSotj6++YoDjwo64ho9JED0ueOyHqJ0RsneM+W4+I55bGJ2
 wW5RWcJukeqObj6vSd9xYxxnqWsXFhwM3tXNhSboNFigdzgSLX46HCPPl04/McICqyPR
 jvGNy1HCpbt72YPs2c+9GM9ho+xVN4qACQqh9uCfqnCmLbTbW5/PPacPy7UZfMJUiE/A
 4WdON3FIwKLSB/PoLvDBkmgjWM3bTbXzKXENwMFe21sMPTkrHi2T4cI3EsOcTnG8xor4 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqscnkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430op0C008959;
        Tue, 3 May 2022 00:51:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:51 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljC010389;
        Tue, 3 May 2022 00:51:51 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-8;
        Tue, 03 May 2022 00:51:51 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Manish Rangankar <mrangankar@marvell.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: qla4xxx: Drop redundant memset
Date:   Mon,  2 May 2022 20:51:18 -0400
Message-Id: <165153836361.24053.746636528875359461.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1650533091-28815-1-git-send-email-baihaowen@meizu.com>
References: <1650533091-28815-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uKjpovPXA_FtSU4vouwORSgnau5AN-L6
X-Proofpoint-ORIG-GUID: uKjpovPXA_FtSU4vouwORSgnau5AN-L6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 17:24:50 +0800, Haowen Bai wrote:

> The region set by the call to memset is immediately overwritten by the
> subsequent call to memcpy. So we drop redundant memset.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: qla4xxx: Drop redundant memset
      https://git.kernel.org/mkp/scsi/c/bda57fede0a6

-- 
Martin K. Petersen	Oracle Linux Engineering
