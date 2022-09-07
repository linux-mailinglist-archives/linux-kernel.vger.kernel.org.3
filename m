Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3730B5AF9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIGCZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiIGCZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:25:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5447F24C;
        Tue,  6 Sep 2022 19:25:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Ld8W2014578;
        Wed, 7 Sep 2022 02:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2022-7-12;
 bh=K3S8MgRjg+L8r0Eza/TZbflDGw2/Yd/gtalqoBPG+wo=;
 b=EI5GCWhcJAFCyXq4viIBQSoQvAHikRKbBBYt5eMitmZYTyarpqCwXmTB9sCaNgleff8C
 PMVDJaypDgc68EOxItIucmONDug0ycvl5KtfgO1jv24YZB1OABgQpKj0J5jRsYBBs63R
 hGP4DS4krYLq9DNDAfXY7rgQil4tjgEWC/LV829GVNA13EuFeAPSu1qEcsDePEjhwZOT
 DV/lZfimITUN2NgnOFEVCH7pKadDRhBh2BGVTxS9TItdOv70a6ze5svinkzpxagcPSx4
 oaVAQRSQiJlfG0I1cF2wk3gFX5GPHhkipzROv9uyvNE34RUYkB7iccs5FmYhMwivof8W KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1fk47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:25:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2871gLpi039802;
        Wed, 7 Sep 2022 02:25:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9yxwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:25:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2872P7xp034666;
        Wed, 7 Sep 2022 02:25:07 GMT
Received: from ca-mkp.ca.oracle.com (dhcp-10-39-192-227.vpn.oracle.com [10.39.192.227])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jbwc9yxwb-1;
        Wed, 07 Sep 2022 02:25:07 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] esas2r: Use flex array destination for memcpy()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pmg7gbux.fsf@ca-mkp.ca.oracle.com>
References: <20220901205729.2260982-1-keescook@chromium.org>
Date:   Tue, 06 Sep 2022 22:25:06 -0400
In-Reply-To: <20220901205729.2260982-1-keescook@chromium.org> (Kees Cook's
        message of "Thu, 1 Sep 2022 13:57:29 -0700")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=734
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070009
X-Proofpoint-GUID: 3N2Nd_Bh8zhH4lzPBqkpixz_ElO88pG2
X-Proofpoint-ORIG-GUID: 3N2Nd_Bh8zhH4lzPBqkpixz_ElO88pG2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> In preparation for FORTIFY_SOURCE performing run-time destination
> buffer bounds checking for memcpy(), specify the destination output
> buffer explicitly, instead of asking memcpy() to write past the end of
> what looked like a fixed-size object. Silences future run-time
> warning:
>
>   memcpy: detected field-spanning write (size 80) of single field "trc + 1" (size 64)
>
> There is no binary code output differences from this change.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
