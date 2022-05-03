Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4851B732
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbiEEEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiEEEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:39:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D4A197;
        Wed,  4 May 2022 21:35:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242LrpKC032436;
        Tue, 3 May 2022 00:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=9xNo423aYGgAB4qTUyVVdnVwr+pI0bOJaK6nPJshNoA=;
 b=nzc8Hy3+L5KAPGE4WtUOvutlKRqzYZ0Gi+OUBr0ZiFlXyPbdYmvA8aHkp/dH4z3TW58n
 MhThLMJsbt922q5LJJj8QkyxdjKU3fi7VMFVNXIRZuTQoVj85Zhn5uedpfbDOdveZ9kh
 BcLD6EdGQvN63W9LebIM9SW/b+K4EuDiUd8SqfmD6szRMSZY/AmvZtqulgZZ/cUUAa3t
 VJQGbXFU+bBra4FcYS+sGMveXCuIor1uZLoo0Q8spOB0Pnfs2TSqQiql0BiCMfJW/58Z
 Ybyq2Kz3/uRGj22bkN06//XlmiKaZ2bJGIjcxuStYwi1TNhYzwExJLl8kKNqHWyY5sE2 OA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oqBu009009;
        Tue, 3 May 2022 00:52:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83xbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:52:05 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430plk0010389;
        Tue, 3 May 2022 00:52:04 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-32;
        Tue, 03 May 2022 00:52:04 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        target-devel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: elx: efct: remove unnecessary memset in efct_io
Date:   Mon,  2 May 2022 20:51:42 -0400
Message-Id: <165153836360.24053.3746670237732598405.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220318145230.1031-1-wanjiabing@vivo.com>
References: <20220318145230.1031-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Lse0w1_Z39HX8YrFSdYEa8iScjtGN_Rv
X-Proofpoint-ORIG-GUID: Lse0w1_Z39HX8YrFSdYEa8iScjtGN_Rv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 22:52:20 +0800, Wan Jiabing wrote:

> io->sgl is allocated by kzalloc(). The memory is set to zero.
> It is unnecessary to call memset again.
> 
> 

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: elx: efct: remove unnecessary memset in efct_io
      https://git.kernel.org/mkp/scsi/c/507bd398a056

-- 
Martin K. Petersen	Oracle Linux Engineering
