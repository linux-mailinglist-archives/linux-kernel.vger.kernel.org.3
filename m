Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481A5AF9C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIGCPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiIGCPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:15:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C880530;
        Tue,  6 Sep 2022 19:15:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286LdHJa015737;
        Wed, 7 Sep 2022 02:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2022-7-12;
 bh=5A8FeuoOCKzY3l4HA1V1gqmZbc/KeIvGqYETbyRYz9s=;
 b=yfy8OsUf9HikUQoa+IH7ZBQb0T3v23svPuldyTk5iw5qoC+rtoPpULBXusB09rnw1g9H
 eybwZfkjmm2JF8jyZrFU6wBTpgbNNB8pesUH+PaVRNwq1gPbYMjulLG7ZqOnGB3VY0eM
 jM2oVkWZP/dSRH51OJasr/vpC4sUyp8Ag6Uk8nNB0dmDHFzUAlBbeFJttI7jbmK7FIor
 5moKiOm5HBRw2Xjf9c7kxP6RVghpYgPNwKmV055jB4V06S83fF5I42SDvEfgJ7ssCkat
 RG64Gv2adF+4fYwA4naAsXqkW0FbBFxRsw44EGo6SQ0FknsLrIZLsku5r3rijcptf4QP 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftqguc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:15:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2870Px5A031243;
        Wed, 7 Sep 2022 02:15:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3nwqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:15:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2872FM9d011335;
        Wed, 7 Sep 2022 02:15:22 GMT
Received: from ca-mkp.ca.oracle.com (dhcp-10-39-192-227.vpn.oracle.com [10.39.192.227])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc3nwqe-1;
        Wed, 07 Sep 2022 02:15:22 +0000
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi/qlogicpti: Fix dma_map_sg check
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d2ggcb4.fsf@ca-mkp.ca.oracle.com>
References: <20220826101435.79170-1-jinpu.wang@ionos.com>
Date:   Tue, 06 Sep 2022 22:15:21 -0400
In-Reply-To: <20220826101435.79170-1-jinpu.wang@ionos.com> (Jack Wang's
        message of "Fri, 26 Aug 2022 12:14:35 +0200")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=776 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070008
X-Proofpoint-ORIG-GUID: h9WXWpSxoPIA7Fw1M7BOca_kbIuIWn9N
X-Proofpoint-GUID: h9WXWpSxoPIA7Fw1M7BOca_kbIuIWn9N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jack,

> Add the missing error check for dma_map_sg.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
