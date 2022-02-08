Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F44AD0D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347166AbiBHFcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347058AbiBHEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA2C0401DC;
        Mon,  7 Feb 2022 20:52:28 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2181aScD020227;
        Tue, 8 Feb 2022 04:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=rLQyDok/OdsY3uWhXn5QM1EJTW+UGzZXOkOAuWiu/lM=;
 b=bDsNc/RBnJpL7Wfrav7cxSCS2+6DT3miPXoWOuwJ0Uur0TwdhsPyYIQp3+3wN3EztyxE
 TuM5GrLmOuaHQJ5Rm+fTj1LgxWfRZcAYOvShGLz9Y9S9S1/84y5ZZ9YhzR+ggL2p0z5K
 goeEpKjKuMzFvY4+isOOzd0zny5TyAz+kv+hNEjvCjDxdM9lwEH50aFTy/XtNhbjPvo8
 fmDf7Y/wL/EVur4vuKloZIIvRW/D/haowLImbo03JLBvcrJPUsy/lsUU4lBAN393hF8e
 r74tlgGjo70FTxZAOWWmH6CA0aYGDgbpHyR0Ex/y2//+lqiv1Zexlg+aqVGlIGr1Rqob +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wsn3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q1mX088288;
        Tue, 8 Feb 2022 04:52:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppss24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:24 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKhv089147;
        Tue, 8 Feb 2022 04:52:23 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-3;
        Tue, 08 Feb 2022 04:52:23 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, cgel.zte@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, Zeal Robot <zealci@zte.com.cn>,
        linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        mrangankar@marvell.com,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qedi: Remove redundant 'flush_workqueue()' calls
Date:   Mon,  7 Feb 2022 23:52:14 -0500
Message-Id: <164429583888.16454.17233610108532756457.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127013934.1184923-1-chi.minghao@zte.com.cn>
References: <20220127013934.1184923-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NuubuORyLqk2-lECVusWieguUTKTNcYh
X-Proofpoint-ORIG-GUID: NuubuORyLqk2-lECVusWieguUTKTNcYh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 01:39:34 +0000, cgel.zte@gmail.com wrote:

> From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
> 
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] qedi: Remove redundant 'flush_workqueue()' calls
      https://git.kernel.org/mkp/scsi/c/0603be719237

-- 
Martin K. Petersen	Oracle Linux Engineering
