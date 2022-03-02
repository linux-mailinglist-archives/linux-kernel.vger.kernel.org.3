Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8A4C9CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiCBFOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiCBFOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C206558;
        Tue,  1 Mar 2022 21:13:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222UeWc006483;
        Wed, 2 Mar 2022 05:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=OlihYRTaePBe+8R6+oM4RfXk0mMR/OaVcCm09rsRSdE=;
 b=Ofd2rKLoAxLWNcVF3tmymcHJVhfJibcRfUeRrMw7gI+9sQ0WE3gdZTISV5RgExWCzqrW
 RymqsZLCaruU0SgPfs5k36sPlml5pLFVTHOwFgxYH62HWEczmbSlVav11BAPd3/idq5H
 i5tSBUlgbVGQ9Oa3MyufruU5KY766yRgE+oJJKnz1ULSf99h5Zf4RWC6/cNXm6v5dJ2O
 6coWbU7q3yl8B512RmFBV7lcZzBSqr+Ljz8Ey2nqujOy6vqCMLSbfO5SW7SJeyoJFtX8
 c/EHJ8R+H+lcQpMvJxC2cwrYL4HMKpkk1CPhtA1sGaUraYsXduJK3ATGB5ZhjBiDX1fy Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2ejm88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C1Eh175213;
        Wed, 2 Mar 2022 05:13:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:34 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPK178145;
        Wed, 2 Mar 2022 05:13:34 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-3;
        Wed, 02 Mar 2022 05:13:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: Use GFP_KERNEL instead of GFP_ATOMIC in non-atomic context
Date:   Wed,  2 Mar 2022 00:13:21 -0500
Message-Id: <164619702111.16127.16163616639439447777.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <eccb2179ce800529851ed4fabc9d3f95fbbf7d7f.1644906731.git.christophe.jaillet@wanadoo.fr>
References: <eccb2179ce800529851ed4fabc9d3f95fbbf7d7f.1644906731.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jemvxo1XqHYxGY6mHfJs0I1-YcIe0iKo
X-Proofpoint-GUID: jemvxo1XqHYxGY6mHfJs0I1-YcIe0iKo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 07:32:34 +0100, Christophe JAILLET wrote:

> Just a few lines below this kzalloc() we have a mutex_lock() which can
> sleep.
> 
> More over, the only way to call this function is when a delayed work is
> schedule. And delayed work can sleep.
>   INIT_DELAYED_WORK(&fw_event->work, mptsas_firmware_event_work);
>     --> mptsas_firmware_event_work()
>       --> mptsas_send_link_status_event()
>         --> mptsas_expander_add()
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: message: fusion: Use GFP_KERNEL instead of GFP_ATOMIC in non-atomic context
      https://git.kernel.org/mkp/scsi/c/e3af2e3b0019

-- 
Martin K. Petersen	Oracle Linux Engineering
