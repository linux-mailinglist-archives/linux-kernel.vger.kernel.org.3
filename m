Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780454AD116
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbiBHFcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347065AbiBHEwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:52:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C6C0401DC;
        Mon,  7 Feb 2022 20:52:44 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182MKoI020213;
        Tue, 8 Feb 2022 04:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=EftwQZBNMaG9CP4bwEpRiG5L9sTc3/ZV20af5CRbZks=;
 b=Kbm2+oCpNoex32gN/Xne+9oIFyYkeaPz3cLLAGPx8yqhQB0d+SrubPVZeRPkpe1ZZtt3
 81cZIBAqofj6OC18U7x2Owek/VrHV9aWdT+7OEzZVeRvBEJgumJ7h66thGI8PHrgNPmS
 LDvHvtIO4n9YUDeW5lnXprBtRzFRrG/lxgRaWWLqT7mL+Tp+UOq//rShSyIrzqMNrkAZ
 5jPwhCK1A3ZSCE/maYHtMrvmcnj6IGa1fQuj11mcXb5ZSMFyvEfJZYb19VQWKaeUFQqB
 6JB/cgA5DspeIUqMTfVhP/brBUGa2lpAIZbSa1hsbl+uTyzMoab9ep0YIVMPo+edWNDc IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wsn3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2184q1rD088294;
        Tue, 8 Feb 2022 04:52:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e1jppss4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 04:52:26 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2184qKi1089147;
        Tue, 8 Feb 2022 04:52:26 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3020.oracle.com with ESMTP id 3e1jppsrvr-5;
        Tue, 08 Feb 2022 04:52:26 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.ibm.com, davidcomponentone@gmail.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        yuyufen@huawei.com, Zeal Robot <zealci@zte.com.cn>,
        linux-scsi@vger.kernel.org, bvanassche@acm.org,
        thunder.leizhen@huawei.com, yang.guang5@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mvsas: replace snprintf with sysfs_emit
Date:   Mon,  7 Feb 2022 23:52:16 -0500
Message-Id: <164429583888.16454.5762862266764524154.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c1711f7cf251730a8ceb5bdfc313bf85662b3395.1643182948.git.yang.guang5@zte.com.cn>
References: <c1711f7cf251730a8ceb5bdfc313bf85662b3395.1643182948.git.yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tWfj2z3rybWA5e-hH0TAG-H5bKFyNKur
X-Proofpoint-ORIG-GUID: tWfj2z3rybWA5e-hH0TAG-H5bKFyNKur
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 08:00:59 +0800, davidcomponentone@gmail.com wrote:

> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> coccinelle report:
> ./drivers/scsi/mvsas/mv_init.c:699:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/scsi/mvsas/mv_init.c:747:8-16:
> WARNING: use scnprintf or sprintf
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: mvsas: replace snprintf with sysfs_emit
      https://git.kernel.org/mkp/scsi/c/0ad3867b0f13

-- 
Martin K. Petersen	Oracle Linux Engineering
