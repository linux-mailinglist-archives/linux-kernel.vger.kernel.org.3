Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797652E18B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbiETBJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344218AbiETBJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33BE129EFD;
        Thu, 19 May 2022 18:09:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0Jhhc031924;
        Fri, 20 May 2022 01:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Kj26JZllMxwkQTpx5hspsbsEJ1NdUc3HKhtXUQtVy34=;
 b=UsLyNjm0qf+nC9A2jVHSNy2WZCYXFdDVQG3V314k1uTkDwazttlfFEA2OZeBNtgMFQLB
 cdOKQ16cchjCEznX78jdmnaIGai3KJ9QuOEFL+gCEqxtzXYqi8JlGEeS6z+bavJ4Aymh
 dJ/Yk/iqroUYGUHSCPEeK2nAMCZENLdfay5i0UIQxR44cnyJVH5UK22MjuvBMm6mwPZI
 ZJpFt9peyVqY7KMJEq4Izpt5lugY4zBI+NGR+SBQ/E3rrZ2cjgEuUgR2tCEcaUrj4Xr7
 Ou5Rk8IB+9tLP6sHWVgBnwDIJo80ZJu1QREjTqdeiYJGIXXbqog7QjuBZ3r4yHthMjf4 eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310wtr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nUX020179;
        Fri, 20 May 2022 01:09:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GK7030710;
        Fri, 20 May 2022 01:09:17 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-2;
        Fri, 20 May 2022 01:09:17 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH] scsi: elx: efct: remove null check after call container_of()
Date:   Thu, 19 May 2022 21:09:01 -0400
Message-Id: <165300891232.11465.7199146004705451866.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1652750737-22673-1-git-send-email-baihaowen@meizu.com>
References: <1652750737-22673-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -cCNsx-DUyTBDwoOH5JTMOluawsh9FeD
X-Proofpoint-GUID: -cCNsx-DUyTBDwoOH5JTMOluawsh9FeD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 09:25:36 +0800, Haowen Bai wrote:

> container_of() will never return NULL, so remove useless code.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: elx: efct: remove null check after call container_of()
      https://git.kernel.org/mkp/scsi/c/d627660c22b5

-- 
Martin K. Petersen	Oracle Linux Engineering
