Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A55B4C91E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiCARk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiCARkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:40:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDA2C667;
        Tue,  1 Mar 2022 09:39:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221GWQaM030543;
        Tue, 1 Mar 2022 17:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lVphAfAGNSx6WqOrRVbBUPCmy70SqB2EwHHA61Z5dwY=;
 b=eGrXWS4gG/rrG0WlNsqThaOnCLK3R5Q1WmRmNBBCCb8B3RzZ9MpnAdNEAQpnSF9SxgHP
 qiCgK/WWLJDmea0WRXBgaUNgW7Dk/pEM5oU2rl7twveKs248cdw26RcSwIQh1u1Yyy6L
 h9yKpy1AHKYGum/eeIZ4Jo2W+WqJ/8SOVVrVo1JG5PRi9NKjunvAP5S0FgnHHbxCGAMh
 HgEFAPrwlfHMrsFThgYQG+fAWHz8uP4tfQrwQz1QlajnyKewRro6Z5zBgPxZ2PQd2xrN
 nUzVRZsu+5iQmsEApag4U58+a+mom5/6zOUG234jq4BGYmZ6xoZnkPjdm4BhPuxn+nwN 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k43hvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221Hb72p059897;
        Tue, 1 Mar 2022 17:39:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3efc14xcvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 17:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AThiphVVH1ROYkDbKHM83ITXWMPCmVoJH1YYivwb9BBDm8IjcN5ibb/ry30xHtXDLhCUJQ5NuZEhBX8gixQvk5aaBOUd6tUMEWkFdGqDQPLM6xCcRCh3MgUTy9ZrhM+cEHKQCq9wpUL6B+Ro0iDIShKpukIMq89P90aE/bV5MYbpylzRnMygHwF6Jlx+lYkg40Kwz0NS7DMrLW1c/o8PiB+J1iCiwJOz9kbdD18xtLV/EiXVo/K54FM8RbCls1Re7BHMU8CPrwa+h30DBW+8qqk7RLtRb9JIM2OhgPlIJYJ0rvTNUv1QTSPNSeR6cSPXrljV9Mt1PLvdl+oV4n75cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVphAfAGNSx6WqOrRVbBUPCmy70SqB2EwHHA61Z5dwY=;
 b=D105cL1Mapv78Xs2Gp4yLF4n31ceUXY+8lYLxjKIYZ6JldEoLl1p8d+mel3qOuTAXX3DS+UNlonbs6Jh7wsjPlK9B5UiIlr2qcVMwKnLKrN+pDLymZoxT+WGIwf+E/bLZQEzE0Ps5eQyAW2evjs9McWfIVoSbtoed6QcVMvahl26nN5pFX2RPtfM04kN3ikPz6LF6wVzzi6qpfw/8FIVaXEP6aLWFO27Ae5ygJNSI+KybrKGqxPtVTKO4xCuJWdra1Z4rEP7dNgf7jKaLukN6VNUU0bOPyBKKeHAvsUyiOrLeP5b3QQJHSnbFW00kixStMKGsxNTmvXJ1hlsu15WNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVphAfAGNSx6WqOrRVbBUPCmy70SqB2EwHHA61Z5dwY=;
 b=OTNFI1uhdCCw8T/pWZPEVjDdvhf4gehYItcbCjN+qCy1nt4Qf/r8rCHxAg4A2Nq+4wqGDPSpwpydySbOlu6TAiTlwLa3Nt8u0xfWOI3VnuWV8rsLsZ1RijbmZhQrRTT8Yx2/bcC+Tfl68xUh6kgKSbOh4NLlF85nuVVFC0WPwts=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB2795.namprd10.prod.outlook.com (2603:10b6:5:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 17:39:01 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::49ae:9ccb:2e59:8150%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 17:39:01 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, jarkko@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        stefanb@linux.ibm.com, nayna@linux.ibm.com,
        mic@linux.microsoft.com, konrad.wilk@oracle.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 0/4] Add CA enforcement in the machine keyring 
Date:   Tue,  1 Mar 2022 12:36:47 -0500
Message-Id: <20220301173651.3435350-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0194.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::19) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea4f40d1-bd1f-4996-48c4-08d9fbaa5f10
X-MS-TrafficTypeDiagnostic: DM6PR10MB2795:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB279555A2606F69ADF4A353C887029@DM6PR10MB2795.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmVg1C/t5sdpvT46+vPXap3PbHM75rAUv2Qjz3P6LJrzBoi9QhgS6COju9wuKgX+LaPcXAsOnC6aYuKGLBF0euIghgYsoLtLiT7e89GSZm3nJcFSeHDDJa5/p5jesTGyw88LVp47DYHXHjCJfIMDJrWT0LcTacEeiiQW35f5+RvWYHuB9BsNHKL4RBcmSCb/xEFsrs930x1B4ryxSdMrHtpFLF9K6A+EPRphtCk41z9AtnNHk5U0tpMYP4m31Vzn2Egkjf9wzFqT9P+M7Krz4oJLMXSGyIvQbJRSpYArluCiZK/FyNJNVKoKJESYIpsfaK+M1axWuR8qFvoCSr4RVwtzfCKGk0iIddz9SjbSeGUCQS5TWHfSQgLxrIZjT3H4XIQFG6XIddguWwHrvAu6S0jssYHW71qZUl8k5GqdZskbsyzZhyje6unpZL+IDUC5ULjsTp77ndLT6g1V0O0BgTSWAoKvKw1L6apIXkuvuTXSJHNyKbng1UySJabBE4ePaTZGnPqMGnY7VkmjQtowpWxCFQDtRMHogCKEjEpZd5ZC/0qrDQ1nmfEmifGOG9XzY4IXYLEjVq6wjqARLljWLECbcb33qFVVKgxhZnOMi3VPzz8DTTmuiNlIk0dkt2Q8H5ztnM152qJzye+oy4oG6zI9SaVc0QLQFowxIxliVG3P/J+Mx5ob/xlNJFj0vSJU0ifJxW3L+6BCDNAYvX+xPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6512007)(6666004)(6506007)(52116002)(508600001)(2616005)(36756003)(86362001)(316002)(4743002)(26005)(66946007)(4326008)(66476007)(66556008)(8676002)(186003)(44832011)(8936002)(6486002)(5660300002)(38350700002)(38100700002)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2/q2rx5Y6OZurhpZu7FrAmfvyU1fi80JfACffOJmQep3VljLWNOSyROaE9F?=
 =?us-ascii?Q?e9NjjaKPlGzQ9UQbBiFoZ1GTYLTyGjCZWZD1MPIo2fLsKfCvtl8VsZRhbOe9?=
 =?us-ascii?Q?PYwSjnNtOt1OKyAV3GWRz2edZGSE0Zbfij3IYKf97jTsDh8Vg/DbdCDvq+UY?=
 =?us-ascii?Q?andFP/evaNvU5KYrbc71MUj74evsgiwvPq+g+2H6Z7CtjEyXmxUXcjsBU9PU?=
 =?us-ascii?Q?IM08mOjeGrKjYvFW80WXGGU0BpPoM7IoB9cKdhDd8Z2syWygZ5vkdRB04VYg?=
 =?us-ascii?Q?Zkg437jPqXcG4Ot1y7HICZQYmH2aqHKuuVheG14aEnOv8j+9Z+m5PMziHOli?=
 =?us-ascii?Q?uhPe5d/26VKQ6vj3lPMeSSk0uK3AqiMWMn81euPAdjPmiW/1YRe6gX2+LuzS?=
 =?us-ascii?Q?HnUMrUU/Cf1JK9qXb5gVgxH+4zJbmVPCvMsNCvS8P8zqc31vYsnRnXvMaGLi?=
 =?us-ascii?Q?dfFNMN87ghhmQIMgNSFOzA7RBNhG5ZvL9U+pa4sLRIJyvTtazmyV3gfTuvch?=
 =?us-ascii?Q?/YD9sKh5h36OWYLkLIAsIndeUDBqWUADcU1ZPJcVyRui2Dckygaq55DnRw5j?=
 =?us-ascii?Q?B5T7T48IcZ3KmPPClkIhyHsEt60KEMivYbnLD5UGi8vf9U+0jj9erGgq3GSN?=
 =?us-ascii?Q?r+J9O/p1Nt94YpNh1I1Yi+ERfprPDfIN9TilNfh5IO5TWOOI6hl+QYAvgAqS?=
 =?us-ascii?Q?Lt8h18kGJuWbBpByk4NA7tadv6V3HErpqsRWhZHlqDu5ZqzLRrFUXyVWUD6y?=
 =?us-ascii?Q?xY7q9OTWQd9lAZvUzV9FZyHxS4WrUdY9Xm6acu9lHdx/oZ0xB39ugUjEWB5D?=
 =?us-ascii?Q?lKbtBtR/S5Tfi0kEs19e3L4SIhzRZDcyzahSsaU+bbejj9KQMPgojMTPjYJ9?=
 =?us-ascii?Q?dA1evE9VyGJZIPkmZ1a9e4XpT81YxR5BvT1sRoCfKMD6Y+8K8KxveJQUeaMC?=
 =?us-ascii?Q?m1E1EGIKXh3f3cDfP1cJaba3REr/VtEumCbPg5tzWXeTz/iflbaOtYLxRZsl?=
 =?us-ascii?Q?aR6ayix44OkX0Q00dM/7qlT31n3zJxgwOxrBWJD6N/7ApLjrc8skR9/15PjX?=
 =?us-ascii?Q?ks2WqipzOC9xyfl9ghNU6sFNpEQlXFcLc4eBo1hQQGv1pUcN95DQnYo1uZYp?=
 =?us-ascii?Q?bs1hDmt2AYch/YXyBt3f1O/tF3r4wsRhzoaANvekSny887Ct1HUAvCpYyg+4?=
 =?us-ascii?Q?omafyqX6J6e9dfXt85iHXksOoOihf7q2gfzxuE38o+GVUUgDh8kI3vQiWnmg?=
 =?us-ascii?Q?P5SzMNdBULT+shRK2mtYmAqX0HGis31vs7cxcWdDy6MpTvlVuPZyLQjsH5i6?=
 =?us-ascii?Q?PLMn2wUxzs69i8IsbFKOJt2QbrSAXCPGLL76roKJzNe5ZyiNzna8YjpX5VjA?=
 =?us-ascii?Q?ui09DPSgGmzCV5DXFl1Pql/Rd43Op6aVQzRUHrz24tfjIBhZE+7a6ovaNlDS?=
 =?us-ascii?Q?Tq9NexLEB+JPfZQ09YvBRRlY//zAPTyDUBgtLrfRN6Wv5TQIfrr53DOvRhQq?=
 =?us-ascii?Q?oWPb1xJQCaY74RRe0if+6GO35DjWm18+SHoL7/nYlDciemUZBrtRy4m0k6Gq?=
 =?us-ascii?Q?lXoEVV1w+CLU/EUVXapOSjuRN/o8riFHQRbOFAoHuHBQGLd932zYmxliLPKb?=
 =?us-ascii?Q?fkdj6MM7BW+4SbmEy2BPnOZ1TPHTUmRKF+SpFNvf041PHCE5KoDEMGYTLCSK?=
 =?us-ascii?Q?wi8EaQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4f40d1-bd1f-4996-48c4-08d9fbaa5f10
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 17:39:01.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FYeT5uXPczwMMgCCAUYlfsUHG7wg1QkSUTwOb7HkojkwSsz65lTrDmDAiMxxD6mFgCotphyuNhkOv7pftSn/9kVvnM6TAI35BtFalH7Ha0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010091
X-Proofpoint-ORIG-GUID: tllySOMCSmvuZsykntHe2uz4FGtT6hSg
X-Proofpoint-GUID: tllySOMCSmvuZsykntHe2uz4FGtT6hSg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A key added to the IMA keyring must be signed by a key contained in either the
built-in trusted or secondary trusted keyring. IMA also requires these keys 
to be a CA. The only option for an end-user to add their own CA is to compile
it into the kernel themselves or to use the insert-sys-cert.  Many end-users 
do not want to compile their own kernels.  With the insert-sys-cert option, 
there are missing upstream changes. 

Currently, all Machine Owner Keys (MOK) load into the machine keyring.  Add 
a new Kconfig option to only allow CA keys into the machine keyring.  When 
compiled with the new INTEGRITY_MACHINE_KEYRING_CA_ENFORCED Kconfig, non CA 
keys will load into the platform keyring instead. This will allow the end-
user to enroll their own CA key into the machine keyring for use with IMA.

These patches are based on Jarkko's linux-tpmdd tree.
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git


Eric Snowberg (4):
  KEYS: Create static version of public_key_verify_signature
  X.509: Parse Basic Constraints for CA
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca

 certs/system_keyring.c                        |  9 ++--
 crypto/asymmetric_keys/restrict.c             | 43 +++++++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c     |  9 ++++
 include/crypto/public_key.h                   | 25 +++++++++++
 include/keys/system_keyring.h                 |  3 +-
 security/integrity/Kconfig                    | 21 +++++++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 14 ++++--
 security/integrity/integrity.h                |  3 +-
 .../platform_certs/keyring_handler.c          |  4 +-
 10 files changed, 123 insertions(+), 9 deletions(-)


base-commit: c9e54f38976a1c0ec69c0a6208b3fd55fceb01d1
-- 
2.27.0

