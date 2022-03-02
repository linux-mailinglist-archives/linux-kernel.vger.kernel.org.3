Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F54C9CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 06:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiCBFOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 00:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiCBFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 00:14:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32447ADF;
        Tue,  1 Mar 2022 21:13:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2222W19t006487;
        Wed, 2 Mar 2022 05:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=rHUgHhopvue/AAPK+/mb9kiUgRdUKw+MBpTb/HZqUeo=;
 b=Jb34d7WR340ztbLn/zsvOVH3ldehCgL08A3U0GCmGKabxmR5DP7xiI/Bs/xeRdZ+GJ+b
 Ej1WgeEkZQRxz5IM6EoWBTzLp+KBoFjxjb80EH/01O049thY72+Z99wqWyRqj+YZHR7p
 c/J/P7mSzehV5AAF4TmgE6n3Rj2GA4yt91acFMNcd+icBpP19w7wGXbmt1KfxCP27snU
 qxofTddO8acxcqXvB5yewV7pWrp1ovrKhFhvmpZWCerpM1hZ7TsE4/xKbrwl+G8XHDzl
 SRCFUQ5xoCsTiuY7diyERaZb8MtfIksNvh9VBC59uMaaF4mPy1IIpogza+ulPCV+S1Rj DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2ejm8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2225C1tJ175224;
        Wed, 2 Mar 2022 05:13:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 05:13:36 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2225DVPO178145;
        Wed, 2 Mar 2022 05:13:36 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3ef9ayxgcv-5;
        Wed, 02 Mar 2022 05:13:36 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Finn Thain <fthain@linux-m68k.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] mesh: Stop using struct scsi_pointer
Date:   Wed,  2 Mar 2022 00:13:23 -0500
Message-Id: <164619702112.16127.3138997344528184574.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <fbf930e64af5b15ca028dfe25b00fe933951f19b.1645484982.git.fthain@linux-m68k.org>
References: <fbf930e64af5b15ca028dfe25b00fe933951f19b.1645484982.git.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 94n0qQGh43OtFvqygZZ2-Rzf03EJusFa
X-Proofpoint-GUID: 94n0qQGh43OtFvqygZZ2-Rzf03EJusFa
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

[1/1] mesh: Stop using struct scsi_pointer
      https://git.kernel.org/mkp/scsi/c/2e1b3175f29c

-- 
Martin K. Petersen	Oracle Linux Engineering
