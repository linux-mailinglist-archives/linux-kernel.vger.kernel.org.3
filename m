Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276675AF9CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIGCW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIGCWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:22:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E988E4C9;
        Tue,  6 Sep 2022 19:22:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286LdHKt015737;
        Wed, 7 Sep 2022 02:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2022-7-12;
 bh=sjhjPzp+E0Slbvjm45LABf3NEmJWwZUWoq8fmYBiICc=;
 b=WC/WNb6lao1VCU3eRJHXE/82TiBHx+3a19WsAMcMYWGFvM0NCgM5IXacPm9qtrZVgIAT
 AFfavHedpCarhukq3jO6COaWqI6o/NiRwm319lRk29vUXSIb9zV7QqPDD4+YWF08a3tK
 73i7q3HbELWzyDiweIsUoXqOvpXPeMvu1kSv3Y+X/sk+UtiC4olGGL7ygKLoq/XJr2D/
 kt897++8GDZVhb+9fE0LSMs93zSRxXwt+YKNauY9ngNwkXQ/93xXE3XmBkS3fdMrKmId
 nVqNmAObNcmq7nT1nDUG+ncMdG782qW9qqon7J5naEsur+g1NDchSe1ZnXU5shXEKZp6 eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftqh69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:22:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286NBVKh030599;
        Wed, 7 Sep 2022 02:22:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3q64j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:22:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2872MoPP005753;
        Wed, 7 Sep 2022 02:22:50 GMT
Received: from ca-mkp.ca.oracle.com (dhcp-10-39-192-227.vpn.oracle.com [10.39.192.227])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc3q649-1;
        Wed, 07 Sep 2022 02:22:50 +0000
To:     Letu Ren <fantasquex@gmail.com>
Cc:     aradford@gmail.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH] scsi/3w-9xxx: Avoid disabling device if failing to
 enable it
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8pzgbym.fsf@ca-mkp.ca.oracle.com>
References: <20220829110115.38789-1-fantasquex@gmail.com>
Date:   Tue, 06 Sep 2022 22:22:49 -0400
In-Reply-To: <20220829110115.38789-1-fantasquex@gmail.com> (Letu Ren's message
        of "Mon, 29 Aug 2022 19:01:15 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=680 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070008
X-Proofpoint-ORIG-GUID: cLnIFJGtE77j52fIPi1ekFKdel0A69eu
X-Proofpoint-GUID: cLnIFJGtE77j52fIPi1ekFKdel0A69eu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Letu,

> The original code will goto out_disable_device and
> `pci_disable_device` if `pci_enable_device` fails. Kernel will
> generate a warning message "3w-9xxx 0000:00:05.0: disabling
> already-disabled device". We shouldn't disable a failed to enable
> device. A simple return is fine.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
