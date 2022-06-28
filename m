Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E055CB91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiF1D0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiF1DZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:25:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8225C7E;
        Mon, 27 Jun 2022 20:25:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25S2FjVe026421;
        Tue, 28 Jun 2022 03:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=OHJjAeC0RSNmwTveS/AFX+RW0Zi6hcwrrh6sG5/igRw=;
 b=EtWVXHDNrMzj07ZhwvodbAjaL3Fis+zoaZ4AV7Yog16tbNObPMbtj3oC6RiAtk16tP7t
 5e/F8mndWyGNV9N/zkcujfMsj/SDcN4DjDafulZrzYsrqR0cHz4mgTdpOlHMsj6KvVGF
 wAEp0xjjrW26DsFPpsrPVJQl0kVvy05zXhLUmGRNQuwdcRW8wFHwzWW5KfbRQYKUuiJP
 KFMojgfqvGhIMBuKydOoG1Bo+S9HtzJGNv5wsZpGwxgN/b38eVFYGysLS1FiXr9tVCgV
 m0ybkM+dozrZIvG+1dUH0YLt/ADmYXdQoWEB+q0BdUsjIX1yn2Hu1grlBu0d/Na3yv0I pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsyscrs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25S3F1p2002510;
        Tue, 28 Jun 2022 03:25:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 03:25:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 25S3NvqE016584;
        Tue, 28 Jun 2022 03:24:59 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt7jjkg-9;
        Tue, 28 Jun 2022 03:24:59 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     axboe@kernel.dk, Bo Liu <liubo03@inspur.com>,
        fujita.tomonori@lab.ntt.co.jp
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: Remove usage of the deprecated ida_simple_xxx API
Date:   Mon, 27 Jun 2022 23:24:47 -0400
Message-Id: <165638665783.7726.2129514185363786365.b4-ty@oracle.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617020430.2300-1-liubo03@inspur.com>
References: <20220617020430.2300-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CtFUbRkvB06-fTmo4QecfHSdAW0aTwz9
X-Proofpoint-GUID: CtFUbRkvB06-fTmo4QecfHSdAW0aTwz9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 22:04:30 -0400, Bo Liu wrote:

> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> 

Applied to 5.20/scsi-queue, thanks!

[1/1] scsi: Remove usage of the deprecated ida_simple_xxx API
      https://git.kernel.org/mkp/scsi/c/873cdda193fc

-- 
Martin K. Petersen	Oracle Linux Engineering
