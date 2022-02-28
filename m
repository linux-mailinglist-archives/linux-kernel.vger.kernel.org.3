Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59864C6115
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiB1CWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiB1CWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:22:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8436C909;
        Sun, 27 Feb 2022 18:21:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RNqL8G026186;
        Mon, 28 Feb 2022 02:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aLcNZzHOFnFxChhkqxnxK5ri4JGK8wmmRSzXeArpsOo=;
 b=PNb/1TL3M8X6OTpbt94whOw1txjeSD0vXZSBV8Vx6q6wgYBOEMdAwEMcVcW8GKmN7Jf0
 eDS6uQeVkInZpzEyOyWhFPyOGAWxiGeACeARgRgkRFZ1SmTBOBBzTs1iIwxNnXJmEvKr
 q3EcJjgmfshuUF+KMMjei+KoPWsF9nXEKvZJqi8eG1HXk8u4vgGjk4x20sOvlOiZhKcM
 cxgkVKMkjp6Gc9xcOTDhsX9llqT8LO8mmwZyIK2Lr5r4z3MeLgOp/3PaVOTB1NkU0k9Q
 UhCLmlRWP8aOCF1nwNvzB+O6ljyUHVnviFU1lqwXDMlPg7SuKUF1aI6NZ4kdFmmWfQgZ rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efc3aas83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:21:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S2B9an001675;
        Mon, 28 Feb 2022 02:21:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3efa8bw7sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4P88bkoYy3PdGntg2l3iyj82KtAzC9f0wa6KF5UagnBgKQut9bu9Ev6MOm4vZU6dhhW0Tse3+XAECjjZYWYQA3N/vqc1aaoQSVHb7QhPrUV4DC2xceHL0ak1lNknUq3IA3gMY+fxmbRDejhIzNP1RbT2B/hLx1t0W/zkpNBgOSrnuUaTx2y85i2RiYTEMq78WINZunKr5neiBHX3y11HjMFjhHyA7C1mBrwnmEKbStTL5f7pg5bnDQMcvzvsl45sXWtema//2l+TVqHxGAccSxCq58ivZcH7nBYKydymKBB9gFhByG/+r/GpMrGzFy36p2QByX5OxXw+O4TexMCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLcNZzHOFnFxChhkqxnxK5ri4JGK8wmmRSzXeArpsOo=;
 b=R5etdOSiAqF53DvGUf3ALfMUx7ogiXQVQBhzOk2d2ZrB0xPYHbKOAm/tQyMB061dBgJ2Fva/rD5xbdrNhboJv35IpVWhN9NzqRC2FkJHHDuVaWIMaRUBvCmM66784ecpEhFz08u36SsVRXxFAZwaF/75BWbgrWCzltoKx1yVl59M6t7g8VQc7iK7uHy43Njr8q7lQriZ2P/7bMCGl1NiLBrij0pJ/j4eSE3Kb34VjQ5yO3HHLVouUqDby/fRe7SggfRP1RcDKawJzcxEIoqEAEcGxX7hMiO+OzUzUaPeDfMoexoIh+uFc6lmahioYQuBrsXiWqNTfNI8IwMWEjh7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLcNZzHOFnFxChhkqxnxK5ri4JGK8wmmRSzXeArpsOo=;
 b=SrKs4uRxRWpb50Gs7tEejNv0SLhx57b2nefqLb0qTeXOvKdKVXDIkrT2Yaegd6CJPOdOn7rvH3qap/whb4XXCy7TTLo4odfP6DRJjtmefQSUM+1LG1Kyr3kIJp8eOpw65DfEslt0yDXFW5h9mHgb06q5yLGYM97/NTT5FEPMVHI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5352.namprd10.prod.outlook.com (2603:10b6:408:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 02:21:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::180:b394:7d46:e1c0%6]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:21:53 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: Use GFP_KERNEL instead of
 GFP_ATOMIC in non-atomic context
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fso391e1.fsf@ca-mkp.ca.oracle.com>
References: <eccb2179ce800529851ed4fabc9d3f95fbbf7d7f.1644906731.git.christophe.jaillet@wanadoo.fr>
Date:   Sun, 27 Feb 2022 21:21:50 -0500
In-Reply-To: <eccb2179ce800529851ed4fabc9d3f95fbbf7d7f.1644906731.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Tue, 15 Feb 2022 07:32:34 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0365.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd160e27-b609-490a-b6f0-08d9fa611553
X-MS-TrafficTypeDiagnostic: BN0PR10MB5352:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB535296927E49991DCFD1E41C8E019@BN0PR10MB5352.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngGN4bB7zN6FU/jRo8DdBZN44TWRld5BcnRzem48Ywl517khFxrAB8/mAtDgVVjrQZPcFi8XqaHSWSK85ZS+Sx9FC6OLK37xhrpIOn3v+p3W74tsnfeUNmBmOijyrMNOt0W1KzipsUgBVbBIPUwBcN8FyXsFBWjumgFTzZX+dYKkI81EBi5O72MyGuJdmRey3evZROsaOxDXhPsKReiC82nceXEHYLyXqPVcM/yPgkaY/mEvrmLqHGxOe1elSjVfkdmJYAUzIvda1wl1m9zVav/y19QJ20GMvajUmPQ2u3kwIZj4k4WvXPrFDfB4Mov+z0HdToZzuw2mNqav9VnGll18+ugDKPbID8ZdZZJIyfRWqCsZ4GoTTQjQU3lnEAQ04XFVhVykAtI7HUzjpy4U+rdhfz0V9yCVpDR+CBX3MDw2KHzJlB9IasQItY/IzUqg09VuJurEadFPHhcbp5uD2usEXhcLb4wj5cZqU0WlF8Kl0mO2wWRHYsBldGsZj7otDZghuEkeFQCMFPHvHxVY0gYqXBYnH/qfQC+oibfWrkEzl84cO0v/4vL7qyw+cW8/UbJYnyVFb/p/rYDBd9IizKN2KhKrzZ6H1MPYj4TkCEd05JisMpCeHFDFDBW3N5cvPHn7sNncHB1YJ6IZ87zroseL3J7oNX7xV4aIBv+q1CjFDn2QJ5u4SssX9PhpXMaoxVwrEyaXUei5BDrJUAPmuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(83380400001)(6486002)(316002)(6916009)(508600001)(558084003)(36916002)(8676002)(2906002)(52116002)(6506007)(4326008)(86362001)(26005)(66946007)(66556008)(66476007)(186003)(38100700002)(38350700002)(5660300002)(8936002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikUsOAOj1Jh+/rk9jp1QKGIs+3XvRymAhI1fqlpawL03v4UBaCvm29YTVWzE?=
 =?us-ascii?Q?JS0IG++p7d2Md184jD5Q2LxmPUHdEsBUWZoa7b9qocctLlOyICMWdjj6zjUn?=
 =?us-ascii?Q?DKpKKLCtKpa51aFxQRZV0lmI2QIS95cClrFe94kIrumtipJydAKMRlcNMeBC?=
 =?us-ascii?Q?4bCBl03ifS3eQuY0XIZwlwbydb+ZWGBdTNlZ+kRABfcwU0nQi1PTAImWrinO?=
 =?us-ascii?Q?cxqt/r7ImVqGN9dc4J0cHBeey2nEkrlpTFJFIVT/dz8Y57CPp/ZSs4McGrhX?=
 =?us-ascii?Q?wNLMv9ueFDd9u0YLPChvIohb6S2FuapE0aL5w4EWsThrb+VGDyz+KVKlvld5?=
 =?us-ascii?Q?XQDhHeeiKxWQezSHSKGnFrOC+pkT5T7vemAUUVEjlO/Bq8NX5a16h75P4T6z?=
 =?us-ascii?Q?Vt93l37AMFnNIOjfhlG++NZ5tezdZ2YZGauPP3J1ZzspXiaAuFS5DS2Gl8fc?=
 =?us-ascii?Q?ZkUbppfkwv0vZ0rbFR7Ypf/1h6FbfVAjWD270a/MWUbDFpE3MABADxQ7PX0o?=
 =?us-ascii?Q?Qd+HOMfYV+lIOTmClR9DKkiwIQZvklazk3rK+pR+rfEVJzcsPZUEKRo7/Y5K?=
 =?us-ascii?Q?EwER43nraPeF7SLCCYiqUB0hIXk26wgy19BdsahjwMV4a8QaP2hDuKVtXWrt?=
 =?us-ascii?Q?2/xWp4uoNA72+F/fD8PSKsXhxQmWmuBShMRgW2m89LurWsJKuMmUh04qbOWZ?=
 =?us-ascii?Q?CHCPeHg+VExoRjw5eaK7psVfKQaNrlOc1cNZMeFZpthQscLo1TMJu0IrFVuL?=
 =?us-ascii?Q?uYMAqsvLF55FEEbhZXEb5UU4aXV90xoV2IOt8w0WpHZaiLEXdffVS1vOtZHj?=
 =?us-ascii?Q?BdNMvZvowYg1oh2fWCejwaSHrEn5ZvINYky5c4XniBvHFZ/kxwKXud1nJ/EP?=
 =?us-ascii?Q?0ziuCPSmACWe1sNgfLD73wnnK2iMEgwNnNp0WF+S3L1md4Oc0eEgrQTEM9I6?=
 =?us-ascii?Q?X1X1jsj63zaOJH7KSRKrAkucqqU8Z6O9Sl6l3r41Ta86nxAINmCG8BEIRJf7?=
 =?us-ascii?Q?Uu9Mr/XCZpCjYJJAh134zFEiUOXcF+IwVuYUmP8zFJ2pVISL/8df1d5Jw4r2?=
 =?us-ascii?Q?OW8Qy0bEg4Y+q8g2ZAmFngsdB5rxhTBtLq2ihTo4hhC0BGdAKucw8ARKRO2P?=
 =?us-ascii?Q?OyCZylqNNxlJV0mMip3aQkD3vsKZnfVGXWI6yHEjcBWA9A13dUmW3YPvfLrt?=
 =?us-ascii?Q?wlHL/jwfPER61/7aCxb1fnFaMcYDk30W13KdAOgXwq5HznQNbjfXByMbI/Tk?=
 =?us-ascii?Q?J4h7iUVvWZzp69Eun1A2YA8ELuxJdQhWXmrAdXV/34dnwV3qq/SiWoIjA1IH?=
 =?us-ascii?Q?iRicUHdEFZTbbqWENaTuR3ae3WJ1kBypsM5n6x/hO8rqsiiugV1TKqAiqyce?=
 =?us-ascii?Q?h9cUKb+WDLsh5EY/L3l0reO9E8ElyHe63NTvIY7urSBAkEDGXAlyyfLF+nGn?=
 =?us-ascii?Q?RymjOaM2qyaljAGAsvVBAuGLsqf49YTuiufRP/quy1wm7jFzUHzQ1E1K/Z3N?=
 =?us-ascii?Q?Cuyf/d2IAY/VtiqW4gz7rTrGiHexEeqQAkMn4L/004IUhRyDMW4oV/vvC31K?=
 =?us-ascii?Q?BbQ9au5OSMEpmWJtnZnmyHnw7vrgW6X72MtOCcwC3EXlAawBnpo4vFgualnG?=
 =?us-ascii?Q?jdMLruTSrZ2YgXsoQaA/UcrAdsQLk3SRSjxcgfCmx/94AOdr0hTQKEceMjJ4?=
 =?us-ascii?Q?rOgWdQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd160e27-b609-490a-b6f0-08d9fa611553
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:21:52.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/Y1QNNgWamfrPzkZl8fwAfgiTbzEppa8yu5j5n4WjwNw2xPhyV6UCUxPzFjxdZcuiOvqYqAS929Z5rTBDi+PCjJQ0tA1QoXvTqzXIHVojY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5352
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=923
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280012
X-Proofpoint-GUID: 11Mk75qpDK_6mgLNSjFodGTO1uxeu3gV
X-Proofpoint-ORIG-GUID: 11Mk75qpDK_6mgLNSjFodGTO1uxeu3gV
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> Just a few lines below this kzalloc() we have a mutex_lock() which can
> sleep.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
