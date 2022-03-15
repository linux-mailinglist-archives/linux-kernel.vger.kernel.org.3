Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAA4D94A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345224AbiCOGdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbiCOGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:32:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C14A3F6;
        Mon, 14 Mar 2022 23:31:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3M3Dn021977;
        Tue, 15 Mar 2022 05:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=mmXx/wyVMz9ehfry6mGcafZhCzbcd2rWgC9pmyVkFkk=;
 b=0FN7NCCytyY1CJBlAnDjN3ZuSNx+yd09hFzT+lLas8MVqc3t+y5fzzPCA/Vf5R7iP4yo
 9Y74HRrOt/u/Uhdyclt7DykeiiK+p1KHvtyvm8vPKFZFij8kZAC9DvbmGp+xziT6B8Vc
 ZUY9bVi7rDtH7qEDKsDwlCEDIhtvoJW4NF6XKA7ZmNKpvFEfk/VThb4zy9T+g/adfShE
 PzYTYIQS05ja+HYEoVYWRRa/1yPgmPdQI9Dk+9vo4ib6/T3Qr8wjwnLIaf8tzG0TMplW
 boDdjh4u2URRTn97CYYMUh9N52dUL4HsgzBluM/cjJNprrjkP9u/nUyHwxyGJp99O676 Gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60r9y1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 05:02:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22F51JUb004847;
        Tue, 15 Mar 2022 05:02:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3erhy25wub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 05:02:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22F52cq5007094;
        Tue, 15 Mar 2022 05:02:39 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3erhy25wts-2;
        Tue, 15 Mar 2022 05:02:39 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     hare@suse.de, Jianglei Nie <niejianglei2021@163.com>,
        jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: Fix use after free in fc_exch_abts_resp()
Date:   Tue, 15 Mar 2022 01:02:32 -0400
Message-Id: <164732052813.23186.105308943748760649.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303015115.459778-1-niejianglei2021@163.com>
References: <20220303015115.459778-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lCP9KMjawGnv-9AMLq_C4YB7byUd88FD
X-Proofpoint-ORIG-GUID: lCP9KMjawGnv-9AMLq_C4YB7byUd88FD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2022 09:51:15 +0800, Jianglei Nie wrote:

> fc_exch_release(ep) will decrease the ep's reference count. When the
> reference count reaches zero, it is freed. But ep is still used in the
> following code, which will lead to a use after free.
> 
> We should return the function after the call of fc_exch_release() to
> avoid use after free.
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: libfc: Fix use after free in fc_exch_abts_resp()
      https://git.kernel.org/mkp/scsi/c/271add11994b

-- 
Martin K. Petersen	Oracle Linux Engineering
