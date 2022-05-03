Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908FA51913D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiECWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiECWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:24:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE5101FB;
        Tue,  3 May 2022 15:20:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2430TJqd004092;
        Tue, 3 May 2022 00:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=HA3cSEb/S4T7sQu1MN6rSA97SIBLNaaqi7XaMI6TnDo=;
 b=xGdUjMyckOpjfrVIYHu27CgEGnt5Dx/K+fzTTzWDAdlWte97GK8HRn70+59r1pgvIdhf
 TstbVrAU9iDGsWFEDlMce9WyxvpipVg4k49eM4bU6nevHNRPY4bFH5XN3KQhdO0/gKc1
 LnJRyCHqCSDkxDMJPtpTik0gYZT3nbzURBGnp3z5iaHBvwxyxKlYMGz94YPPv4LXlosw
 IN+kICardc9kxsftr3VhJTG2DHQ/MonQUY2IlCEaixYbjHEKwKcubFtcBc74gpai8x/X
 8NeKet/KYmjBMrpRIQ1jnBCyHValm9PWUZc4ZfJSD3/D3iXeFws9Df0eyHHVO5Wd/IkY 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0amhj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2430oo12008891;
        Tue, 3 May 2022 00:51:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 May 2022 00:51:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2430pljE010389;
        Tue, 3 May 2022 00:51:51 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj83x4g-9;
        Tue, 03 May 2022 00:51:51 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 01/11] scsi: aacraid: Fix undefined behavior due to shift overflowing the constant
Date:   Mon,  2 May 2022 20:51:19 -0400
Message-Id: <165153836359.24053.2564518469406332154.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220405151517.29753-2-bp@alien8.de>
References: <20220405151517.29753-1-bp@alien8.de> <20220405151517.29753-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PfUYvM5O-7BqHhvZ4hEv1YEJZLotvuTH
X-Proofpoint-ORIG-GUID: PfUYvM5O-7BqHhvZ4hEv1YEJZLotvuTH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 17:15:07 +0200, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Fix
> 
>   drivers/scsi/aacraid/commsup.c: In function ‘aac_handle_sa_aif’:
>   drivers/scsi/aacraid/commsup.c:1983:2: error: case label does not reduce to an integer constant
>     case SA_AIF_BPCFG_CHANGE:
>     ^~~~
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[01/11] scsi: aacraid: Fix undefined behavior due to shift overflowing the constant
        https://git.kernel.org/mkp/scsi/c/331c6e910f1a

-- 
Martin K. Petersen	Oracle Linux Engineering
