Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120152E1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbiETBKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbiETBJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:09:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1601135695;
        Thu, 19 May 2022 18:09:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K0J2dg017727;
        Fri, 20 May 2022 01:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=9ddqngHzWJt54QQBToDEPQQu2rszhw3+900c5O72/s4=;
 b=sP+WXG0OfBuWn0KRU83iIHaVDTlvnYWIhx/ea8RLOIdpFSu1qct7WHmwx5FcavuSQdNH
 cl1TGvH2FV4+spwGFqbnrNcIvY6Oc3dCdNYbFrb+sIVeZJCpwxDbaC2yf3Ntvc6qVArd
 ITwe0ezINWf01tLokmu8fS6OU8MqF/jaFEO9yMWsrJB0f7lDjOVFYIiH5uQZd4VRDJaF
 ndWJyy/BmHE3Tc/GGNuX0XOGloYBJmj2S/iOKkZEO53Ay/CeAQLeEAoobkYlIcR3iJm3
 E3zr7Jz5t/u7pH+onT9qnpvBh4Qz5sr71axlXSLb1UgX612smaXCgFjziUeGckxrW7nT BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sdte0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24K15nUg020179;
        Fri, 20 May 2022 01:09:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crytt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 01:09:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24K19GKR030710;
        Fri, 20 May 2022 01:09:31 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g37crythd-12;
        Fri, 20 May 2022 01:09:31 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: Fix memory ordering in hisi_sas_task_deliver()
Date:   Thu, 19 May 2022 21:09:11 -0400
Message-Id: <165300891232.11465.16554701363800250632.b4-ty@oracle.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <1652774661-12935-1-git-send-email-john.garry@huawei.com>
References: <1652774661-12935-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Qo0f2iEnXMkVXhyTsWla8KnNyz_nSfw0
X-Proofpoint-ORIG-GUID: Qo0f2iEnXMkVXhyTsWla8KnNyz_nSfw0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 16:04:21 +0800, John Garry wrote:

> The memories for the slot should be observed to be written prior to
> observing the slot as ready.
> 
> Prior to commit 26fc0ea74fcb ("scsi: libsas: Drop SAS_TASK_AT_INITIATOR"),
> we had a spin_lock() + spin_unlock() immediately before marking the slot
> as ready. The spin_unlock() - with release semantics - caused the slot
> memory to be observed to be written.
> 
> [...]

Applied to 5.19/scsi-queue, thanks!

[1/1] scsi: hisi_sas: Fix memory ordering in hisi_sas_task_deliver()
      https://git.kernel.org/mkp/scsi/c/6c6ac8b7773f

-- 
Martin K. Petersen	Oracle Linux Engineering
