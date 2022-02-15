Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4694D4B618C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiBODUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:20:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiBODTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:19:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088520F59;
        Mon, 14 Feb 2022 19:19:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F2WvHh022038;
        Tue, 15 Feb 2022 03:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=Y457YTdXV5O2I0r5weXh5J18vYtPaowY8zWk4jkV6kU=;
 b=XwaUh/E67LGicq3GJRmDmiTDoXxgqnFK+jYeJuxMTI3wdmOuAEiEISohH76MIJxtorzt
 hp12XbkOIGD5dLeVieWzuFDjSL+s2oWYY0UsRx5+29757SdzcmmPA4/YbMU1RjQWZcoj
 1QS5tk7RMygnVvlmH8LxXUtW63Yy5lTIAXtWNOIyLhIVnWaBEiuH07kOtMG0wqIh8w/9
 rtzN6izxDGaVg4k3630c4rhYRQrqcOhcJuYHeiB26WL0h1nbcpfWRiP0Pzq3zPArNYDJ
 2KXY+rv0JRSqB2OWnYgzSpfruGmY0blpW9T2Cx4t0yn4b67spMyqOSQ/4wZztqCwy1Uq ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63ad6bqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F3GpFC057595;
        Tue, 15 Feb 2022 03:19:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3e620wpgsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:30 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21F3JMPC064243;
        Tue, 15 Feb 2022 03:19:30 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3e620wpgqq-6;
        Tue, 15 Feb 2022 03:19:29 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kees Cook <keescook@chromium.org>,
        Michael Cyr <mikecyr@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org, target-devel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ibmvscsis: Silence -Warray-bounds warning
Date:   Mon, 14 Feb 2022 22:19:18 -0500
Message-Id: <164489513313.15031.7832986884338779882.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208061231.3429486-1-keescook@chromium.org>
References: <20220208061231.3429486-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SLlgXN1neJdbvyITMnETiSiq6oqy43In
X-Proofpoint-ORIG-GUID: SLlgXN1neJdbvyITMnETiSiq6oqy43In
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 22:12:31 -0800, Kees Cook wrote:

> Instead of doing a cast to storage that is too small, add a union for
> the high 64 bits. Silences the warnings under -Warray-bounds:
> 
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_send_messages':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1934:44: error: array subscript 'struct viosrp_crq[0]' is partly outside array bounds of 'u64[1]' {aka 'long long unsigned int[1]'} [-Werror=array-bounds]
>  1934 |                                         crq->valid = VALID_CMD_RESP_EL;
>       |                                            ^~
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1875:13: note: while referencing 'msg_hi'
>  1875 |         u64 msg_hi = 0;
>       |             ^~~~~~
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/1] scsi: ibmvscsis: Silence -Warray-bounds warning
      https://git.kernel.org/mkp/scsi/c/03e4383c7ce3

-- 
Martin K. Petersen	Oracle Linux Engineering
