Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A64EB923
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiC3EBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiC3EBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:01:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60FAD131;
        Tue, 29 Mar 2022 20:59:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3537T011976;
        Wed, 30 Mar 2022 03:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AxvP/LAWTOzuWkXPfu2nvQQZ0vZY9GPL3wuSsajPsFw=;
 b=Hy52zx0TcvnLm0vXuBxZ9K9nZOlhmoecysnyBP07ED6hPPLB3Wsm/ihg5RJ/EgDFVi3t
 viB75NE7KhkvGvDhwCZ7zfmpFrB3mQEhhuTwVuy9gtSc5dqLg6W75H3vMMAR0QUqSACf
 7qt8Tcp/IyCoI1v6R5zAqzgQideKSPBo2e//hnegPYFzdb4Uc65jc3FhpKs4GbfFIw6w
 m1BaHEwfmF39qzRURiSnX3qLauC0xwmtyaM9H9aTG1k8XhdaDvHo1gXJBnmGAC81UPYR
 TVNwoZcVupnkSlWYJ9appMGtAFXfrdANYQkKtR389OrxPH+dURwAwUyDRjn0ZnvFv2Tn tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2gb8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:59:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U3p72Y143356;
        Wed, 30 Mar 2022 03:59:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3f1tmyndrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 03:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flMaWpz18BZLn4mTeI8pgh16Zf13v4AML6l/qiaLUmjEhg2AcIXu0jwlxv8rmYSGCAZGgorrroBaaXjHkF2qvXDN6F/azy2p1rasoiSzNieoXIZSz4cgtT/Stn9IJFJsCOJSJliTs2ySPsXM5FqdZqE8giMJaJwwTyH9NXUjuuyl2vn729UmiLnbhP7C3A3C8RxUahtsGskeKxmdelb6pGlsdni5NJFpAv8viz0UL8J7nc17Qoo5eK36phCyq1IEChDAZJi1Iom5XFNn5gNLa2ElYflFuesQSMiK1bl16JYpoE1TWdYKBxRMybMGQEnzZDDpzN3WBOlLRxe82Wqlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxvP/LAWTOzuWkXPfu2nvQQZ0vZY9GPL3wuSsajPsFw=;
 b=Cu9qjdMGxxDxUz+Uw7BSyDjAby0jxNEEABW7pLbGqRFq9AWa5N3rSyUvvjAdhapZT6V7COApJAqaBjpsRJJ8amfpx3KEDDYfFewst8t8XL+5zKfis8sQxpLL9AnWj34InB3sSlxe/ITneAMZ9P07YOW7/X8dKrxmiiIz0A4rDsl7V/xV8Zxm2DuXNlLA4bRLPSPCGSd8y6AsI47thlN54vfHqWeKw7WijS87XhtzlFbeasNJCoWCek3H9kQcibTwE9YCa+HPVQ4BHb5N88wUKY8lmdgY1mdR+1WAIe/qSKaR1VQbcXS6C3ctp0+gXaJNzeghoMZJ07AvF7h8AQMYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxvP/LAWTOzuWkXPfu2nvQQZ0vZY9GPL3wuSsajPsFw=;
 b=FioFE0EQyq6Lfb6L9GdFasVw5CxmGc40KsvYeoAW1boWHPM76YqQJMQIw4idiw+m1EqSTDrdVfZy64dza/6wj9X/ekFs/PZ146ns9Pqfmg4rjh5xcGzb4Ht2dKj+xXzOL4nVo/ygD4epVd1wfU8g4nhi6+7Bjk/qYG23g1lmU2o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB5505.namprd10.prod.outlook.com (2603:10b6:303:160::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 03:59:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 03:59:42 +0000
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v2] ufs: qcom: drop custom Android boot parameters
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h77gt7j0.fsf@ca-mkp.ca.oracle.com>
References: <20220321151853.24138-1-krzk@kernel.org>
Date:   Tue, 29 Mar 2022 23:59:41 -0400
In-Reply-To: <20220321151853.24138-1-krzk@kernel.org> (Krzysztof Kozlowski's
        message of "Mon, 21 Mar 2022 16:18:53 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0086.namprd12.prod.outlook.com
 (2603:10b6:802:21::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e9ca2b-7ad3-48ae-0158-08da1201b88f
X-MS-TrafficTypeDiagnostic: CO1PR10MB5505:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB5505976014A3EAB3868425978E1F9@CO1PR10MB5505.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMPIo+22VF2MlojlME2oOiYOED80jtRp6ezne/84rCGprQi1P9c/7iUZ70zsNrn6pSLt/+J6EfKpfjSqhRqKuo5o8evG/qS49+IxfWAEOdux0C4yL9bH/F6Yt/n6LpsJWBlA/f646/AjeOGMrj46K7ntZFIs8KQiWM+60EYWbug4mgvKyxdvCe8PFUhtojZapQFqc5AqsI0fPeW4k+ry7VX6UTq26HLJHygNN1muMQ0ueDxGH7tvffIi4pj712bHx1dL3pzHadVb++dZih3hK7bGmrusZ69MpoNZKUcPv/CNRH37K7qWiQRDOqL0HrdAPpoNxCFhKDv9z6LjNryfeDKhvQso8OJnJzay/XvyPTEYmta9H0y/Qzgj22pQQj/NA6CwLlXQEYDbWabO0fKGuESFVtRbmQtbvwnZ2QvbYDLZxxoukJj1AujMoledUMpARIpBovXplWsgPesDb55DCi+pcsPQ+17WVLq9EL6CrhRVxANnMbxsGqOMWwEdxNW/MaeHGxCi+ttiFJoPpgKBRfXhmP+OdqGyZYWe0ymE/bRk2lokMjx7zfBc2zi1vhi+Rwm7aL7eZHLZ2YmSxQaQV3Z5GrA9/EaO7baKUXXK8p5A26w4zSfVXdQvWEHGbp5BqfEDKmCdj37a3xgY3Yc5slfnU1c3hMQ6/3Gs1ymdPNBIacG+u/1ZM3W3jzhL8Qxz3e0oMKAGv2cTXW4iE02fcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(4744005)(2906002)(8936002)(6512007)(6506007)(86362001)(6486002)(7416002)(508600001)(52116002)(5660300002)(36916002)(38350700002)(38100700002)(4326008)(8676002)(6916009)(66476007)(54906003)(316002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tywzwOPkrvi0/uFLoqJPRfIjxwn8CZbtnJUSuaKEZ3m8JAkGC5jy3gN6ixp?=
 =?us-ascii?Q?u4V5JQyplEvAk1sCo2c0P04U7inxnnxLlU3SshuZlELHWECyUHCyNSH/jdyS?=
 =?us-ascii?Q?/gYU0wNHMmEi7Q+QvPiU16i1a7smldjUuUBXA4WxjfGfb+7lvimZVZNJxYoW?=
 =?us-ascii?Q?XkkGK/LJVhPVuSA46xT+9hwsjLp/JWhEhCAVzFUktIctpvA8V01aDDR0w0cf?=
 =?us-ascii?Q?YlJ9JBzmDkKUvgQBwlU5+EaAiOXV0nHzG423rzuROnMbky1RA0D+sy94SyYu?=
 =?us-ascii?Q?zFL3FyneIcufXOPSoyywHLiyX1ORmXcnK/co41MWvf3/Nf0scJixbEXzHN4w?=
 =?us-ascii?Q?gpPLqGDxWFOtNTTQW+1f+ar6G0q+5Q+puz2SjcRRg7a0mvV7DKqIp0LrrAaK?=
 =?us-ascii?Q?1VKXVTJjppVykZsMRbbm89leWO2H4O5O2ebj06NjyEkL3TcyITpr2E6V5WCt?=
 =?us-ascii?Q?z+f9vDkoCz6QWtforR48o1AudwpyxfM/npGNUuljAJFzuSwHA1vkLysk//bd?=
 =?us-ascii?Q?5FGmMKA193q3M0LWeFJnosCgYfqo9t1bJ+lIXXzjvCPWXLlnGqDYNuq8Zg9R?=
 =?us-ascii?Q?7IunjyumYGiAuCiJhuMrZ6UbK5QUe2OBwvHXvj6giUnDhCvcVyGBkrBQrW/9?=
 =?us-ascii?Q?hqP/36NP1/0Sh5vw2/nkiCPtNu9hX/rLYPba0UUGnNs8eYtko7KLT1amtcuA?=
 =?us-ascii?Q?UpN44atxK2NmKyCPxXKkKviYugnr9l1/7f9PGeu3P9bRPGv/JXXHvGDFHdx+?=
 =?us-ascii?Q?+zUk/a3cu6sHM5gsj121tTO85lnFUb9zIS/tas7iur4rb8KtJ2a2awEQvA4J?=
 =?us-ascii?Q?0E8MGvf82idInDyEYku3VB3JKl9FTBa6dx103mxNJm8QuWIZb05LBh2TFN6Z?=
 =?us-ascii?Q?ZPaZL80NNFveS96TMdLk+l6WIwEllGI31FL7avq80jVdq4otD4oK07bQq9ZF?=
 =?us-ascii?Q?O1oklhGDAg9EuMohoRLdopdTRfJu8HgyHd4raaVmH7x5O6GqKxevTC7BtrSO?=
 =?us-ascii?Q?hf22rH7Thm7rGCTJaQ6LVofpNEpTBMeK5JNUbKnuIDsRuqkXEgXRNdqI840i?=
 =?us-ascii?Q?bNZV70VQPNv5f5lU7aS4IEgb7fPbOn9/uHaWnlh1NYhPjeHHzgJ6DyAV4ZNY?=
 =?us-ascii?Q?ep/Seezm0R8Cy0ouUQp0kfEZMggDDAByrjaZCmkgBiTmwWRorhQfNBvUgdIt?=
 =?us-ascii?Q?ghXvMAGK4eKOj5py+4z2VDn4elt/TSqnr0y/o7S5k3/WMB7FSmbWjghSR5nL?=
 =?us-ascii?Q?3vz/4OXQIjLLuuzrbh7FcOb+ORVxs1nwYl9uRyBAayzY606LInoHYfYANpb0?=
 =?us-ascii?Q?EnnwXYx3avGTKqGq1dffLrQDKPzDA9+UHzWUpBkQDUhbFa+n0XQlvXQXKTv3?=
 =?us-ascii?Q?b4ooW+/PJ6F582RTe1VAtN85PPleo0hEP2OhmlVbQ5eeLVLOfHdRVDdpriQs?=
 =?us-ascii?Q?z445F2vW9LDiyjsTbuxO2Xxd1Gk9Jpc3vTbi+g+bTOl5A0RQGpyGFFlPNROb?=
 =?us-ascii?Q?rPSf9wniVQIfLDP5MBH3MLEVjaAI2E/D6V4u70sCQHxocPwo05wlALOSY2rO?=
 =?us-ascii?Q?pcPQdcYZGbNb8CtlQRFIa45tcD8A+8GglxTyqSqWK3ond9EjNUcDoQ7KvkEU?=
 =?us-ascii?Q?dH6RsucYXjISrxf8EIDDBmtLuZbjre6HYVzLJoIL6quzh0vd7t95j1F1hUyb?=
 =?us-ascii?Q?HqmTtrL/wE6k8CSbb20whriEbpnsSVKZFroMcl3dyNlA/7qAU4Q2kRbWGqo9?=
 =?us-ascii?Q?nAjWVIZznIWt/Sv/Ij2X1SaTA2VsF2I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9ca2b-7ad3-48ae-0158-08da1201b88f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 03:59:42.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP6lw1SrT9JfWN2MzF8TBmyg8ChosM6m6Ls0tlkd6j9HbES4fdzU1JUKVopTVptx7Rt2CyqD3xwf76+1PeJNxlscEhb/AC/0K7B6a6rrcaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB5505
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=888 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300017
X-Proofpoint-ORIG-GUID: RfXOHhXDqRVmMsj1MgTX1BaUaOdux7eK
X-Proofpoint-GUID: RfXOHhXDqRVmMsj1MgTX1BaUaOdux7eK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> The QCOM UFS driver requires an androidboot.bootdevice command line
> argument matching the UFS device name.  If the name is different, it
> refuses to probe.  This androidboot.bootdevice is provided by
> stock/vendor (from an Android-based device) bootloader.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
