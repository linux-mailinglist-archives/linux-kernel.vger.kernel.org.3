Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247C0581E26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbiG0DQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbiG0DQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:16:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47E30F70;
        Tue, 26 Jul 2022 20:16:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R2fNJO009917;
        Wed, 27 Jul 2022 03:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=caMNZ2egmWoLpJLxec44rb6hyINpFacJIsw+Y97Gbr4=;
 b=QpMPEKWCrEDKDWuSTvzRIbeBxQQJrWKk++4gbXUUz6yRZDKpW8cMhyCC1kjfSurG7H2K
 /IE44ep8YWuYFMCOOf+LZv5VJEvr0EfrbYj5zDbYIa1111pI7hFvg6/hawB0R8bZU6uR
 DGIy1dvG+be8w+FQr7zLHeh/e4pR1QWo59u4rOHWVjW8Rxw0jTzKaCBGc+s4j2vqHI2V
 LcO1mlfentL9acWT0WmNSljXbeG/QTcPApxYgi0FR8G53npzQ/d3ClbbeELgdWjQAH4V
 cpaJ3yo6Ub0LiQiKDS/sVBrcS5ug1UPrx34857YxDW2PsEXxUa3a/x8me/UZk4XBQaNi Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4r885-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:16:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26R153F6034496;
        Wed, 27 Jul 2022 03:16:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh633p3wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 03:16:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26R3E0h2008228;
        Wed, 27 Jul 2022 03:16:03 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hh633p3uc-5;
        Wed, 27 Jul 2022 03:16:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        nathan@kernel.org, trix@redhat.com, mingzhe.zou@easystack.cn,
        linux-kernel@vger.kernel.org, mgurtovoy@nvidia.com,
        linux-scsi@vger.kernel.org, ndesaulniers@google.com,
        target-devel@vger.kernel.org, llvm@lists.linux.dev,
        michael.christie@oracle.com
Subject: Re: [PATCH v2] target: iscsi: fix clang -Wformat warnings
Date:   Tue, 26 Jul 2022 23:15:58 -0400
Message-Id: <165889172881.804.7713790521620814576.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718180421.49697-1-justinstitt@google.com>
References: <20220708211447.135209-1-justinstitt@google.com> <20220718180421.49697-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=866 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270009
X-Proofpoint-ORIG-GUID: _xA0ySTBFTMEFoAEBPrpBnwMsUhJjA3d
X-Proofpoint-GUID: _xA0ySTBFTMEFoAEBPrpBnwMsUhJjA3d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 11:04:21 -0700, Justin Stitt wrote:

> When building with Clang we encounter these warnings:
> | drivers/target/iscsi/iscsi_target_login.c:719:24: error: format
> | specifies type 'unsigned short' but the argument has type 'int'
> | [-Werror,-Wformat] " from node: %s\n", atomic_read(&sess->nconn),
> -
> | drivers/target/iscsi/iscsi_target_login.c:767:12: error: format
> | specifies type 'unsigned short' but the argument has type 'int'
> | [-Werror,-Wformat] " %s\n", atomic_read(&sess->nconn),
> -
> | drivers/target/iscsi/iscsi_target.c:4365:12: error: format specifies
> | type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
> | " %s\n", atomic_read(&sess->nconn)
> 
> [...]

Applied to 5.20/scsi-queue, thanks!

[1/1] target: iscsi: fix clang -Wformat warnings
      https://git.kernel.org/mkp/scsi/c/71b25693b22e

-- 
Martin K. Petersen	Oracle Linux Engineering
