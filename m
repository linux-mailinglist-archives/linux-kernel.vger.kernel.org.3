Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F84512B28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiD1F6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiD1F6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:58:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F887C270
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:54:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S0pDSI025790;
        Thu, 28 Apr 2022 05:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ej1xNOV5CAI40gSbIdJo+75NKpdA6chPPcjBMw6ni04=;
 b=aAIzgt36p613ST5wqBislg/Gw3EukYmp3Qlu4kBjlfu+Kw462xeGC5E0gEqLRQcsDgKF
 bBHBPLdhjsPOE4HmVLFrr7C5ji2RBjjkjTFsdhiVJrX8CQOHiTqsII91XXAZ2WVrCcDS
 e8vP/yKtcZZAkRDwUe8LYOxtp2l3nbJ/D4QwixBoaAVFdhXkYlQ4C2cxr1lfodCA5woI
 kxb5Amy3AO1b2nQFRyADnjkgoBCHJUbFzZI95cqhDRhuhyyaFdcJl/1DOO4cPo2PnVSz
 2av1yKE+L1rcHCxBxMWA7NcvgSrjH6FgC/bpNsQvmHN4BeVWUrviav8qPa/Z92KmpGFX Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mu1jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S5kcYq033752;
        Thu, 28 Apr 2022 05:54:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yn5ab6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfWsSbnny/JSIGOwWfVtfZ4Ua7WZ2fOwnQePZEp9Wsa3s0GoBGSS/8dAjiWOUmR24Tdf+Hyn9Yf5+tn8s5pgSqKrbBIOAXeEFzdEQBCKkgqPf/E9ku8JEwlp5frfgW3tTGzRtETyso1KG6oLN0AKjTNqnRP5dA14pAXera6jhhpr+dpYlm8RUJ3VuWuh0/2kApikDxHXIVxnTaScvkU/HhG79cUrV/XUmcHalKJEPdlQjK9CKRqYYkWjO3yzOAY8N2NAwMr+Sl7FKCmI4WQHRpv6Xbh3lr/zB/ABparzEUW9g8iR6kUDeeqDw7I+Pl/XoP0be+cyVvB8KEcM3jNztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej1xNOV5CAI40gSbIdJo+75NKpdA6chPPcjBMw6ni04=;
 b=TFdTnBzz132xuV+IoewvTcLZnWH1ldavXoNowABEdRZARwOlHEBNzWIkMtaRzUElljYFjVFQJ4gwqyas+B8CCR4gz/X9lgfkyNpNpJVPOxGcikBuX7J8egDIACb0sAQQLzxx/EAIMNYO2HfftnnR0dat9T5DV25IHffxtJnP55SCryHWN+tAuEHNiPRTFsJTtBBvhEhw4GdulckOvWq94a36nxXzp/jbDKK78zJG0T4gkrmCkoaHmAun55AbfwMfcxODQ3zo+X6UsM0dgq2xC3UGuBmmxbM8AiQmJrvtjpfI/qgUme0+R+gMTVlpWyEWqBFjBkwn5CorCvhOThyXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej1xNOV5CAI40gSbIdJo+75NKpdA6chPPcjBMw6ni04=;
 b=s1f18KI8IFPGDKpeNaMdtt0+IfUcwaXD5hlzUbzAok8ig3vTxPtah86G2s8+ATvFKwCbLlCFWsgMM8DVlwG4z+urOn/pGOo8BdnznRaeySS60HelHPeO0jN5VIM3VLgo/4mLQ0Y3Ejp4lW6W9ydkcndvX+TMr1EHg4pdyILcRc0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1789.namprd10.prod.outlook.com (2603:10b6:301:8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 05:54:43 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 05:54:43 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] kernfs: Remove reference counting for kernfs_open_node.
Date:   Thu, 28 Apr 2022 15:54:26 +1000
Message-Id: <20220428055431.3826852-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28f54023-67fe-4cb8-6af8-08da28db97af
X-MS-TrafficTypeDiagnostic: MWHPR10MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1789B445DD4B8D7350D93FACB0FD9@MWHPR10MB1789.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHCTjXwvucUswroPZL07gIqwCM7fiCiBrBCi6DPVAajP8p5TmzRbWdT4K00WfeKdptUUF6hPPuj76sr8SwMwmVqt/e1USW1x7URM2hr7e9CIjT1vjBTYxhgGvnQsFY6td7/XHoEJeHj7l7hbNEV7kLwCrT83iDcrNsXaNrzLZK9smE4Inu+RcEtYffxA+vvs9dpljBVyRr79pM1CUgYXSe/jhbNk1eIS0jcXeXD03QKbmp1DDAprg1kkRwmVKIjGTh+EXQgo4SHRoGizANk25cU+LdVdX8rlBMY6NPgAt6/Bya6A8347WQuG+EyFkn5nEKhBFucoICv57LAsjhq90hufYlvvDa8Ig+N0qEFZYKygasxiF3E7uHeOMMGTwLYe7knu41rb9WqafPKgaqKTDfd1bJkH8UzVqZAakdv7EBB+S9ECEZtOelhWZzRXsFol7b1WUCofrpcqUuq4EeKwr81Q1KeQx3YvjP+DJfjhaVBaS7rLjSIooZqWuYIENhPQ4IyeMcXIAik2Z6bRrPiSrU+6dEali9tkU2QLrX5LbIb+KA6JO4weDjSsxXr4+GTSksDWwG34XouMd/lc718fzfABZ6B/VB15v8H/FZMN8tdOOka5O+EWE2mNGCdqFAkO7HI4XiTynx0q4/sgj/3uIRIL0M0h11Bt0wZ281N1ZC6qpfMZ+79/R2zW8SdjQHRTo4BNV5CF14ygWJKTkDBrUm5JaqMylFCK+7RjyUNHoH6Ry2Ol9f2dI6An2uRJ/dz1IIau+ESRbQG5iXRMKRDYVwkiUbzjQvYPLj5SnKoJyZPdvD+nb2deMbd1sae4zUao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(2616005)(6666004)(66556008)(26005)(8936002)(66946007)(6512007)(508600001)(2906002)(38100700002)(38350700002)(86362001)(1076003)(966005)(52116002)(6486002)(4326008)(83380400001)(66476007)(8676002)(186003)(6506007)(36756003)(103116003)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdXEHc8seEt/hL5IXKHoUQwA3vrqJDyv0aTNUYTOqf66+++IuJ2qikU8Vq5J?=
 =?us-ascii?Q?wEPTZRMG6McTLA4KlPgJbRNzAtOr1gU5hTbSXspZZ9aJpJ0aKoFWu8DZMxmt?=
 =?us-ascii?Q?UNqVrFCqhAKBOZ79unl6E7WttPseRfhWoS0zoiS9sGyBwGc4ITg1DtlPHgf6?=
 =?us-ascii?Q?6VxrnQJWW4l8PAihcH0mW18atEV8HZnORJ2Gm/57EtfYgzenZ5ukMU3GJ/JI?=
 =?us-ascii?Q?t8CPDyZCleyBmh2XmY2X5F34G6Vred5FoCtqbv7um8HQMvOxxlGqhjiz6ari?=
 =?us-ascii?Q?BaYP3o8QBDQPvpfNt80wStuQB8xVABDS9fG2kUh26r7HAMMIo0QGxwt7qoN+?=
 =?us-ascii?Q?zvZat8Zlq2Jf5r4y7eg2pNVzWxqB/DpK1uY6H2L/nr1sDuoPLG2wOL9EFnhp?=
 =?us-ascii?Q?DgSWfcUJKwxHUMkxbCmPxVcT6c0VPnApmX5mI8sGohiMEpa3U9MXxD0AHri8?=
 =?us-ascii?Q?Mj1M1teBWeMPjHsRwtoxuSbtIJhQp5q3TycNuDVO2zr8+d+KyC1hot/Krtsi?=
 =?us-ascii?Q?qs19Dj1zYLrdgKWhgNTgkfI/VHPden8GoFxVjzTT3vmwNCr6aUBwMgv7pq2G?=
 =?us-ascii?Q?NtA/ZNR+7TSH62hf+dn99q624fltIwGF4Bx7TbkwoSzBsmt1LUvTU3vOPYpY?=
 =?us-ascii?Q?QQjhFJzMgy/kg0PSApThAFPWcZMhrCOd3f7rTQljuDqY04dLcklruKhr8SQ8?=
 =?us-ascii?Q?ZOQzeia8Uoo2pUulKeW3iaWbOQRPH+pIGxTxqZ+Yr9FunQBjEypyAIcP7ph4?=
 =?us-ascii?Q?THFDvrBbvZ+LxqFNtO84ziZSfJGxN3grr2Eg9qkw+BmixaThlUErv/vuTUe6?=
 =?us-ascii?Q?Uwl4JCwUAtxVOmn5dL/5ykRc0l8EUeGemkm+QBWu+xHVbYBce24Eax5QCqdy?=
 =?us-ascii?Q?tMZxchnX5bOI49bLLemdRQF+O+3GmWnrm0UwH4yqbr56zcU5DMyXlD0ZKXvg?=
 =?us-ascii?Q?TA4FsJRheAf2a+DXN7vWQHpRtOiA/SX3e03QTAnjiba1Oux/KmV9e8FnKYsb?=
 =?us-ascii?Q?FWojhhhY0MfaqD9E0wAU+AUbmxBMVcL5Yzvzs/D9oa0QfMAtDs+EexDcmNYu?=
 =?us-ascii?Q?bnUdpglXdMxWFOKoXeP6RCGCO1Y2CeANSviRJiZ5xrpyB/DvZZuiOn8yQfHz?=
 =?us-ascii?Q?ydQ+pvGcC4ArfjGH5CVMrVfwJ1b+HJ46735741xZX8u37JCHyn/dm4qbBHxs?=
 =?us-ascii?Q?kQ2ea2DUyiXi4HzEsKB/yBLuMOCiJ+e8qfU8elcE2mRb7Ae03RBn2lJbrSzo?=
 =?us-ascii?Q?u1xTWsslwycNFv5eKNfBggRE8gwKp/cDfIApu23zDshQs/fVHmmzuPhTOgao?=
 =?us-ascii?Q?nTOnwymu7gbPWpjcN8dI72gPo+BcZ1etUceXso5v122MnYLPZyAqN8JDYIMl?=
 =?us-ascii?Q?895WwSjV3TUN4SnIKoTwnO2F786MNqQFopvQFThN2CWogITxFyrwFbjAWPjK?=
 =?us-ascii?Q?Rr6dser2Fn984ePyNHl39NQEYJRL2a1gOP6bxBkY8cDlS9bdCRBhL5d1IUOg?=
 =?us-ascii?Q?6KzXrucnHu7f+bubVsQrcZwfcgGEmFTevKW6LKrAkoSmALcihiNHTW/gC7Co?=
 =?us-ascii?Q?otudqe3Ts0vnV/uBMt7scRgcPM5H55D0BlNX97xxN+RfS5jydG/FY2E7bcNc?=
 =?us-ascii?Q?+GKtneMZT8dNnvxy+I2TRbnlif49p6RyzhQdOaDeawA8MW7EQ3PcUemd8vEx?=
 =?us-ascii?Q?oSIJgb6Vf7TXJazUq1aolU0+HAyeh6XPouZZyK8Y3lZzFhzU9RQ99H0f37QI?=
 =?us-ascii?Q?yT+mxeyeNPEfrJzR/w2wezfcedUX1cw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f54023-67fe-4cb8-6af8-08da28db97af
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:54:43.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/tB1VVvH8umv/WXBpOMssjuBmYAXF0Tne0y2VjYZhVNq1ENMYsXENQwCwkxSopXTJyTI2hIjm53rE2uGD0XUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1789
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280035
X-Proofpoint-GUID: m0V_gkTuq8g-f5M0TR4g68QEkSGuEdQU
X-Proofpoint-ORIG-GUID: m0V_gkTuq8g-f5M0TR4g68QEkSGuEdQU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains subset of patches (after addressing review comments)
discussed at [1]. Since [1] is replacing multiple global locks and since
each of these locks can be removed independently, it was decided that we
should make these changes in parts i.e first get one set of optimizations
integrated and then work on top of those further.

The patches in this change set introduce following changes:

PATCH-1: Remove reference counting for kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

-------------------------------------------------------------------------

Imran Khan (5):
  kernfs: Remove reference counting for kernfs_open_node.
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 247 ++++++++++++++++++++----------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 ++++++++-
 4 files changed, 223 insertions(+), 108 deletions(-)


base-commit: 088fb7eff3496e0f61fdf68bda89b81a4d0a4434

[1] https://lore.kernel.org/lkml/YmLfxHcekrr89IFl@slm.duckdns.org/
-- 
2.30.2

