Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAFE4EB901
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbiC3Dr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiC3DrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:47:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D76579;
        Tue, 29 Mar 2022 20:45:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U2x7Fg016620;
        Wed, 30 Mar 2022 03:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=VzqSbvd0J//6D7+K7K/uT+Kwt+uRpo+KVdjROl0wr5M=;
 b=pjg3i4s0Cg3H9T8Yx6HhhS4hRpd4UaSNh9l4VjTwzX3hflnTVcJwePeWN3KZWD54T/DE
 j6hFLZz8rMq9neJmoABOMIT3okZIpyDWysnL/15/tb7MtS4fRDCe2qrnAPgHLn6kvmoJ
 Cl7dUcQ0OvKqLTby/xgajr97V5xmeRPwVYmXo7nuxwRjbXOdFCb5beqe/es5jUTmjZhr
 TpWLXNIM7ky4cRZkI2M4fo2CcYPssi7fHeZsAXSTY8eEF5aB7AfzZ2ktcxFL/ca0QXIj
 IzqCzA9rf3CkIFqgEjXkKE+K5DQfZXA/kP1r3FYyAMI8HAx8Qa/ZsgmdmNzyIFDRCsWN /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctrdab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:45:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3bbc8128777;
        Wed, 30 Mar 2022 03:45:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3f1tmynd5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDTEfUx/oDD7ybw/ZxVaoMl4J8qVBqjM8/IAUFaEVBi/x8Z3ODLTvv9Tj1DUqKifPtXLu0qDFIx8CR+AuW6Vebu8nnQL5DBXHD7NuTJllTkgZwuheeYow7Tvj1IY0fY+2wE87062QYkgEWMq1wRCHxXIe4UC+Sry5jyZenFzLmNjVdyP2NvrC57kmAANk2rnFO/aAhTOi96Gsy4Y2xCfbL7jT/YYpXrRfO7HYelrtKWil944pImSDxYR4ehle4+97YqO5dScq0W96LsheFuix9iWg3OaTXG4EJuUBHLcaldSr1h/YWEJV4dEFaRd0BhXlrQyRNfc53BQED/vT4tK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzqSbvd0J//6D7+K7K/uT+Kwt+uRpo+KVdjROl0wr5M=;
 b=MmJezJTINoGyx/3/VGlK3nA3TEoA7Seiydz6tvY5ZArJeKBRb33qHRdg0vJh8uJcRnMFwU1vCYwzHdo86q3ooTbAk+5mBD4VhrLoyGen3CouiKMflJRHm0a6iFveSwSYfwxtc2loQ9+BShn1bJhNFjandQocDGVbRM4WPbDNmogElEXytiwg05ohtqwAbgJbmnIVSK/X8vU+tIjDBMpi7qKETR/FBYqvzfYxufUnBVTkXlwSzv+90ReCzaKSpe760KMkz5sWNTUv1Vvxy5tP8NHYjmlWKqX2H8T3N1wyaJfRIIkHdUqMcCXx8lB8dfnKe5X8aWL0iyo3UAbOVAUKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzqSbvd0J//6D7+K7K/uT+Kwt+uRpo+KVdjROl0wr5M=;
 b=zuNfdxXm9BQatO6U2hjL8ZxIsCJMcQKT6iqI8khz3kg6cIftZDHZotwUZv2Wb6LDj3d2q1jWztPaGOQfloMKgT5alM258VTOg5sQM8h1RydYjzF7Y31Y4QM1s6kc7VXIowRmIZO2L1hNPbZp/H6Q8n4z/mUuV53gF0x2xdW+w30=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Wed, 30 Mar
 2022 03:45:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:45:17 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <damien.lemoal@opensource.wdc.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <bvanassche@acm.org>,
        <martin.wilck@suse.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <hare@suse.de>
Subject: Re: [PATCH v2] scsi: core: Fix sbitmap depth in
 scsi_realloc_sdev_budget_map()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee2kumrh.fsf@ca-mkp.ca.oracle.com>
References: <1647423870-143867-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 29 Mar 2022 23:45:15 -0400
In-Reply-To: <1647423870-143867-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 16 Mar 2022 17:44:30 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9cc58e1-2825-47d4-a169-08da11ffb4ef
X-MS-TrafficTypeDiagnostic: MN2PR10MB4173:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB417332E29A02A08AC1C87D4C8E1F9@MN2PR10MB4173.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4IRWdBfLvEP9yGloTCJlGElijj2/Xzwhd/akGgZJqOex51hse9kZJyPxIWXJbQOnvq2mCbEdVqvavwc2KhvE8uLQiNRk0oewJmw5OqutUlwndGLtkRNgThgGinkNilvQYDP141OS5kCa5cnF4IZlG/5YtxgCeuek5LmV5id+wuCi+pzEYDle/9eNhyx6f3OV7kD3zHp8/1KUMTNztGjgYTDu0h+OsPcISR14HWEpkY9S8aEFLxOvQUw6qwcD+bpxUQArVcgvsJOMssufxKktcoWWsi+xXwMyoBPm4CGTSDoxWBTlXljq3T5BRjK53mmoLVjAJHLODxiGvPqBemOw+GgVr7F1m43u+7CP/9Ox27la8oc1t+/GFFCdloCt834KNHBxZsvp3O3KJmbgcC0Qc7X11Mk+CVBpt1uALnegbRa6aU6lr5b8XvYhPZUlVo1u/cuSdgXs5mtI1mpDJPhftzMwEE7CdZoe5Sg9GaliC6xCNNczCyzCAFX5Ti0byhBImOApA8IP0TAGZfLAaqDlgkNLMubyCkeqyH9Kq2PNT1ybyJopnR5N2hccMTqR0TK54yz99OiHvvaabnydxf74/OnIik+eikT76ga05dpzoiVwiZnR5OoB7AqGj3In1wixeIHRVOwdry4C08Xywv9UT7GAckHAZgcomBxcfQvRKw9RC+KFukgKwhuo23QgNVP2YJBTmoDx+Hbu/L4nvu4AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(4326008)(8676002)(54906003)(7416002)(36916002)(2906002)(66556008)(6512007)(6916009)(66476007)(5660300002)(86362001)(52116002)(66946007)(558084003)(38100700002)(38350700002)(26005)(6506007)(508600001)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iflWh4xfpW+fkAgqAZadCx1JKN/MF1w0ZAA7j0SNN17AWsRkEGaEMXgWwRAT?=
 =?us-ascii?Q?zjevQFJIGR9K5zR5DVBvy++WuXMhsSyN6JUGS3Uu69vq8XhfW66KVgCc73Fn?=
 =?us-ascii?Q?uGeW8ws1uQzjMvBODSVvE2kmR9+pM6fkRwrDadV5fmiR8KazziR5pTXFvai1?=
 =?us-ascii?Q?OxtO0dKP9inlvwU+rVx5Zjx++VLgWPP9GNoJfKEGT84uvLv6v+vxVl/WFP4K?=
 =?us-ascii?Q?5gG9XaWpP8czGx0EvsFIhNNwkaf04PiE9rPl5kb6RXY8pPfMb1rxIfOFGscC?=
 =?us-ascii?Q?rvXAeRogw4b7+x1kHHjA10V9w1DpTWctCzxRXetAZNL9hp+o9q1H17Y20amA?=
 =?us-ascii?Q?B89BK8w3EV/93eQwAphIhEq8Xm02T4k6li4R56tda1mp1cxO4gnUjFtRTZ8b?=
 =?us-ascii?Q?rOv8w8jjENnaMO+5vCq/LWETO89eTyOv/AeFazsRBTehyws9Vr5Mw3p0Dtqv?=
 =?us-ascii?Q?NdYZihqByM1XPjbCt5nbL8/crKvZ/KZ7hzogxToyFZhmchzgR/F16H/AVtRP?=
 =?us-ascii?Q?Akx6anE1gvpTZhToe8+HqWA0i0NXjNBFSj11iCwjlTrRMTmMhXyfJkEg7yTy?=
 =?us-ascii?Q?eIkBSSJjGqvCUKcB5iLL5fj7Qt3UovSzLOcpZmkYan26/D6qEAWIGY1mTms6?=
 =?us-ascii?Q?ECH6OiW2HCGLyhMIjtksQdDG8AOTzLxJULjptIYP+xJHmf9SFd/xAkv37qgh?=
 =?us-ascii?Q?B2EevaPW15TL638Pyy66N2Db61b9TNgiv8zHMBsaVzhVrCWXo77QZwCuwx4e?=
 =?us-ascii?Q?2+x18YWut3JsvqR1xI1HZfKiQd/HIaL5Kec0+qOCtflvcb7L8xTg5P7e8J9J?=
 =?us-ascii?Q?+Z9jePH8BBloYXvoT8p8Cpcn4RpohuA/6mxyQgRa/ldEq3HxK0NVGbzTWXm+?=
 =?us-ascii?Q?uz3F01oCG5JCCLWA9e4XY9LAcgGYj/3JeK0/HuNqk/MAvtKZFPa8Kb6GY3o2?=
 =?us-ascii?Q?LaQnTvnlqvRuItHJQeVDrbaVdd9uqIIthaHkjlIlQk0PGYbgOJoA2aeTihZQ?=
 =?us-ascii?Q?ztUaDQKBfZ24OtPbBpqR/exr7JICGtvWs1K1tiC2uazoRc9ESuz9hDLhQydP?=
 =?us-ascii?Q?rLbSqKnC3ivqG8QcUwqtvkVyBTGtTgjFIalbpRanACmKGUJGIQ396Qjre5ka?=
 =?us-ascii?Q?ORh/KwDYp4e7qYd3ALmd9tUXTWyfMsSuSb2i6X1Zj5ycoPZk/sJLt1vld2+R?=
 =?us-ascii?Q?uEqHJRFeKBGwlQWqdt/PcGIKDHXDX015CmiLsL9ODr7X3VBjTPZhyxrAidIe?=
 =?us-ascii?Q?RzN9EI+MbKm9De8LSzP2oFl98lKi2B8iz1hdJXSq8V1XpRr/UCCkBMra8Nob?=
 =?us-ascii?Q?Vfr9VuodjRzzASTgAACH1c9uM1QbL/JSiG/E0gZv2myepYYsNBJy0lMhtZtH?=
 =?us-ascii?Q?F2f3QN/mqlp9NgvmKBHr9UE2LcQlXoeHBPG2mYQjJVMCmF0Wgvegu1Q5cZ7g?=
 =?us-ascii?Q?Ah0YDOrgIer/TEkhrInLXL87nZXzmx4WVGbS9dPR0LsfXTAuGzY3n1vMTvKF?=
 =?us-ascii?Q?GxYMom9k3/S7UXQuIn8hA/nTLaMnc0W/ruhwTtB3uZ2PuWjrV4bgwnHmbQLb?=
 =?us-ascii?Q?0x8sLg8n95mMlZc2pyQXd1d8FA+8qpq5IAKw3avwJuXv7A15+4pnazHzWPcx?=
 =?us-ascii?Q?8SoalDa3UVzBYyXmwPgfMSPhuiHoQ6+jAZ+GnU3Vn+Tkqovbmvga42HYOzt+?=
 =?us-ascii?Q?x/+slZYREcjE5WbfyM7264rgDs4aCMMDzkL/rrWZ1VJuE8b63Fn5PQ1jvF1O?=
 =?us-ascii?Q?XGCTYB+5Yg/0cPd4ZS8muxvTNYOc8W4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cc58e1-2825-47d4-a169-08da11ffb4ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:45:17.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yhQmW4nLguehgMeZCBNdwRAAYjuqDIU8n9/fSrwP682w+Jd2yARBKT9MFtD3taDRvVQZ4VuhPqW5a9fUcyaya6vF/shykidEci1djvVmY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=952 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300015
X-Proofpoint-ORIG-GUID: yzSYldATm8hYMBu0TkAnypcnBYPAPMU1
X-Proofpoint-GUID: yzSYldATm8hYMBu0TkAnypcnBYPAPMU1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> In commit edb854a3680b ("scsi: core: Reallocate device's budget map on
> queue depth change"), the sbitmap for the device budget map may be
> reallocated after the slave device depth is configured.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
