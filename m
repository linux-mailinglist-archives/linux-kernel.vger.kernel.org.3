Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C685E4C9CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiCBFOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiCBFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0BA9A6C;
        Tue,  1 Mar 2022 21:13:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222Zc94016175;
        Wed, 2 Mar 2022 05:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=RqSxO4NJhDuTylpIv4kYJ/M3MCwiaoRyRtgFPOM/fWI=;
 b=CGyGzSMhYTTfR6npVy9cgVc6fSd4Xo00tr17meCnbZJS29JOSjYtDtLcnCbSjT/5PHLE
 kLkg8SG+R7yMQXwhnkCzq5P2AOu3mIq1YGOAICOlj8lI7t4eP6cl8FlKbYjGxeVJVTkK
 lyiqxAY4Qo7QFkWi2rrVR+YfOGK3SQwgQi9c0F5h7J0St74F9xM9UvhkY1oE4/SzTYH7
 twrNwGuxqAsmSFuGPZF9cGTjyEEYGDMv8uCIHyjrcNaeXycXdmk2oMFXRDlFh2Ip3caY
 NHVSWXzPtlaKzAXl2YbDbqfiWXBftX9WPDhXNjvm0S9q2Du0sq1JLGnkPsf+MopjOPIi 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9b9vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C0fK175174;
        Wed, 2 Mar 2022 05:13:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:35 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPM178145;
        Wed, 2 Mar 2022 05:13:35 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-4;
        Wed, 02 Mar 2022 05:13:35 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Finn Thain <fthain@linux-m68k.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] mac53c94: Stop using struct scsi_pointer
Date:   Wed,  2 Mar 2022 00:13:22 -0500
Message-Id: <164619702112.16127.13037547415899576278.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3529a59873a7de8455a27af2528341afe5069adc.1645484982.git.fthain@linux-m68k.org>
References: <3529a59873a7de8455a27af2528341afe5069adc.1645484982.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OcjKU32MXCcwRfC4MQaFwtJ7bljwZ2AO
X-Proofpoint-ORIG-GUID: OcjKU32MXCcwRfC4MQaFwtJ7bljwZ2AO
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 10:09:42 +1100, Finn Thain wrote:

> This driver doesn't use SCp.ptr to save a SCSI command data pointer
> which means "scsi pointer" is a complete misnomer here. Only a few
> members of struct scsi_pointer are used and the rest waste memory.
> Avoid the "struct foo { struct bar; };" silliness.
> 
> 

Applied to 5.18/scsi-queue, thanks!

[1/1] mac53c94: Stop using struct scsi_pointer
      https://git.kernel.org/mkp/scsi/c/55a94551f61f

-- 
Martin K. Petersen	Oracle Linux Engineering
