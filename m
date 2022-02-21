Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34EF4BE035
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357935AbiBUM2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:28:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357897AbiBUM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:28:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFD13E29
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:28:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L9SOdd003808;
        Mon, 21 Feb 2022 12:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VS1LvK2y5CyoWP4M0g0F6DAN/YMJDBUEYmGqgaWiOpM=;
 b=Y6GkWR/qoCjBfF1wBeI4vhBHbIK7A5Wrco9nB9spaBWH4i4rjQDxMwHw0bxTlStm4XVN
 twJU1TamQQU/y5zS6zSqeo45pHVyVAdw8W3/tucxtzWr9lxu5ufFpvus9CO8lh3t0xYl
 Pjw2QGEMo1f+NwsGuWzrbnHsjC2JNPtuPyNnxnJaUtNHarbHH0/mfGrbzBeom2jLmivu
 WTf5pvME8x2mHDTTeX7c2SK5GfLV3gJKEjv94bkU6AV+nfxbljt6LsuFSW+3N1BIdpb1
 +mboW57f49rk/pnyWeJAxWn+qYd8UPKfS90svqn1L3VNt/bbcLJgzNspXptumAEr6jI4 yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eas3v3y43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:28:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21LCGVj6159458;
        Mon, 21 Feb 2022 12:28:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 3eat0kfsf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 12:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS4i28XNG7YgtmDCBkN4nFHA7Mcm21gTXmcP1R+MsitPVkIzsGn0dt4ro7eEr9tqluDBlPlJQbVPzy20qjITwj9emiu+1tM/kKCELmIcAZN9XxElVtavOyKJjP+qXAhcQzucBzMzecuyfaiAuokyEuwbw/AH5cv+rthTXqjfMEpxOcMQxheM26UtVu/26fUGvJGtI2HpmIsYPqXUAOjuHxlgcu8H64ImmnRMJ5rlGhICcUsvwwQx2ohT8oaBJFm9z2lu/9GUbj7SBbibADTYxW5+6x4IW2mdzJQimgp+s3Txfj4JljzmzQiFrCq7tHsMzRQlPNjHBy4Lmfau/yYHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VS1LvK2y5CyoWP4M0g0F6DAN/YMJDBUEYmGqgaWiOpM=;
 b=G/619ti8EsRj6FsSpuyuigDjQIxHY5JdPXatucQQyhTozu/xT8nBn8lEM6paA9G6CVJ59IdUsLfJ2OYJpjfSDqYlfBhzDDONj4dzosrug2bRU3xjmY8Rv2lW34ATCuGpt36TTmakYaiNNUU1BDAzNlU1CX1l7vyo32Ttafv4cp4UHS9fqE5MDCJKQs6pdCT5+Rj/JClWjuZNY6k1AwYqrhbiSyvk+U6LYbIPoGl3WOOCCjGfy1wTruQDElDYkPpMbG+TED4lCTr2mYM/vxTuHiDRsGxdjoxkwY48V1S+WKA4TEOssgDHwYMzDaoEYfwBJ2tfDoO+PWfqDIeJuObuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VS1LvK2y5CyoWP4M0g0F6DAN/YMJDBUEYmGqgaWiOpM=;
 b=FzdSbUkZS100OzDf/xMF7m9YGw+fcl+vY/K+4Deq0HDarR5TssIqDft5C2aHDdqJsNCQAHrCHE/LrUIrCln/6GVK0kf4s2WDc0o3emNA4YhSnK5xbDNvV3XbBvt99dQ59IoyV7DLMzBCi/4QJs7K1QWSx2fe35ks2NO4uA7llk0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4961.namprd10.prod.outlook.com
 (2603:10b6:208:332::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 12:28:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:28:07 +0000
Date:   Mon, 21 Feb 2022 15:27:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: vt6656: Fix CamelCase warnings in mac.h and
 mac.c
Message-ID: <20220221122751.GG3965@kadam>
References: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
 <505ae2999ea93318e3745c69d8e36e2c108d9fd0.1645386791.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <505ae2999ea93318e3745c69d8e36e2c108d9fd0.1645386791.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0056.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56f1fc5-cc83-4bb2-572e-08d9f5359d9f
X-MS-TrafficTypeDiagnostic: BLAPR10MB4961:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4961BBAA769A8DE79CB8C9988E3A9@BLAPR10MB4961.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioWQLwy1hXUVPdxPcpgq9Z9tD850M3OClObbfE8XKLO92Wla5q0u/IeunCc3oU7Jv3Bj95tndX5L4yuN9T4luSwtWpFgtbpegpgY1deOIT/PfRdF+phlg7OmZ1ErVtLoNeIDB/+LXj63SAZk17hE6Rl2zq1wOGmTVzgVdezcXZcnc3yceAKqE95xEyxxYuHqOQnTibvTXsCR+g5fhu9MQ9ARWJPf81NTar5sKXvIzRP6vaC/pP7UYhyns7fMev+QIRyVl6QNI9LuPTVyJ+fr8RuhQWi+d9asGOrFB0OkNen5BBOa7e3wEZmaoanSCfEa88Q7ZoYFNog6EGmiH9olIhU68wcCoEHuby8hfojkoB7iqz+vyRZ1SSnpDYiNoPpC6ZWx4Om23XeefZ0iKnDa0CiPN5JC33hsNO8ScDxPsuaffyUqa4O+URElUTOxzJExjYdjuRVHrPUA/ZXgMj6L031OmuhTN2Gy8FnRwtxntfvyMjaaloJoolCAbk1T6ZGxthPQxiHe20uII4ur7plwR7FpOIL0XAL46W/Qxb6QOGSCWB7OUcwBiBdhgUtxL2860KyayOsxfxyP4TEf4E2dmJukYavddYC97FzC1g9sc2B2+tOQiwD9sixMUCAt7XUeCCipwA/Z3bAEVrw3x4BERDwcOY/8TynWzUPBZspa7M2mhhTdrHeoNYPjX8XhOeQsCiiJACCbPH4kLSiXGe5Wsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(33716001)(38350700002)(38100700002)(54906003)(86362001)(52116002)(6512007)(508600001)(66946007)(66556008)(66476007)(316002)(6486002)(6506007)(1076003)(6666004)(33656002)(9686003)(4326008)(5660300002)(8676002)(4744005)(44832011)(8936002)(6916009)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wfgbE87+KbicdrLHXshaV8yDj04SEzmbPi69nn6NOrrbvA//k6VquP9Fb3Fs?=
 =?us-ascii?Q?f+SLnb8TOU76Cy4toPTZPP2/Fc2Fw0rcBv3Efhd+NHYm/7B/030gqyk3zAtZ?=
 =?us-ascii?Q?8yDCGN9IUc4PVQsmleAyTzIKEv1XCkMvwRtQwL0etwXr6svKO6AjilSpY3eo?=
 =?us-ascii?Q?pPa1Q5jzULvpCF19IdZ39cuy2ESqqMQsP1IsuCOQbIoNgPlN2/GY4oCqMTWt?=
 =?us-ascii?Q?952MJCgLmCMEy90WEeltEry+YSkVwwnPkiZrw6ozCRiZJ30wuA4ADBob55u6?=
 =?us-ascii?Q?5AJlV/yMeNNdtvOV7HW/tB8qqqf2QLpZ8mkTRH0UpgRcOALwkcg3sTBWzB9Z?=
 =?us-ascii?Q?1Nmu3oK51ruNlIej9/OMCRnBtdE54aWEQgSjJUrLKyzJPr4zXEAI1Vf2Ls1Y?=
 =?us-ascii?Q?EfVpRCtvvENwLCgPHz3lcprBNYK4N+KxTUQZ8Tkep0rbWxSOwg+bWn7WFQh+?=
 =?us-ascii?Q?GYgsb8cngd+NdBDxNR3kInvjVEq/EwbgJ32IYDognyRdC6lPUF4hGolGocEK?=
 =?us-ascii?Q?5/PROQV8BsJnGuY1e+L4QA/g4t5cky/UEu7krWEQ6tn3hgCidqrC+Ny/6EM+?=
 =?us-ascii?Q?gQXkxoI5JJjBeHFXZKeg9vbTksfTaRWx8/m63eGGU6yMMy9JWCE1NpOeZ4KI?=
 =?us-ascii?Q?G86OtWXpluxCyc0vZXV2VRkSoK/TFolas5U4jqlYx5TTFYXo62Xm4cLfGsqR?=
 =?us-ascii?Q?AwR66kjSitKQnKknmM7Z6nmbsXcaT8zpSqqmJ6Owff/4TH0qlnR+hDZI8H4O?=
 =?us-ascii?Q?7KA1eZQocOO+jSzQzbxsD+4mr7VgSA/1bzNxTMc6X6KK+QUXsFJgY3pwHCNs?=
 =?us-ascii?Q?hedymDTfgH1ExGyeZ7xJZjgqjZqpEIYKJUwiVxw8ZHwNv0jHSO3blJaebxJQ?=
 =?us-ascii?Q?Z3yR/fiiKWyiEbr8eJEs5kbPIFUyTwXoxdfH9kclTsA3lnn3Xev88uqUpRgV?=
 =?us-ascii?Q?H8ezwNfixdDxedWQ6P56NSnJ9FVa0JblygJvDF3r5VfTKiqdneeCkx03IDGf?=
 =?us-ascii?Q?+RVg9/ubQQB66tEljamUz70wKkYylkS/spFyFVK+kktFeQpEMoTgR1dA65J7?=
 =?us-ascii?Q?tAbnklFHhmb0EgMWZtUNGYz95DWn8h7lQ7VYDjrZfC8biOVk+ZKE05lH8IWP?=
 =?us-ascii?Q?R9xVV3viNrQcAVIB1aX2XDqngukNVkl3AykfpsWIm2gvpNgtQxX2c0HQghZD?=
 =?us-ascii?Q?4v5PRxn78Ha96mW1w6zPgM/rKf0ZREA3b47Pt3z5VtorUj8BDBvK7Kt6UrVq?=
 =?us-ascii?Q?MTgrGBGVdwm8sV84A4x1WyxYPqY96TA3hr34AvQuBuBLwrBjLZc0uYYM6/7G?=
 =?us-ascii?Q?e65q0g5WCYKntHEhDXoznzWJT7soJZtxYjbERGAJeQx4en95BhvKz0p0TJkb?=
 =?us-ascii?Q?NKZpIYs9/KrVM1E7hlTWmpR1TP1UOhoCreTBOWt/Jq/HhbkkQXfn1uWyorZN?=
 =?us-ascii?Q?hVcYGQL2HLNhxxERJ7Le1uLwwcElFeOc/2NAcwtSNSUjVbF9ax0HQwd1WwHQ?=
 =?us-ascii?Q?AO1KiXRw5NP+FdhT0WRxMoWhvWBx7RkFlpD3Adg47iA4BxwrepIBVaU51Pmn?=
 =?us-ascii?Q?64RaWpBRjvEBfMvzenPNdPl+uweilM6Vb8T95Av6ca3N1YmO21gNG/1BII8q?=
 =?us-ascii?Q?LOMRzu6dv3H7rD4lNA+P0WOOWqOl+JpbCYVEC1rPax+HcWIjNxBL9h+SueYV?=
 =?us-ascii?Q?Vb7tMQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56f1fc5-cc83-4bb2-572e-08d9f5359d9f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:28:07.8672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdZYQTNizvTDuIB39nwXw8itbh4IjBVNt3MXQG+gm2ERkPX0D826Sgg/glRo8EIBS6KKZY9YMSnEls3D4jH9dHWCR20EQQGNqpBVbvMl0Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4961
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10264 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=749 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210074
X-Proofpoint-GUID: o-v5Yp9WK6HjMRw3IGcP30TeaOx0Srag
X-Proofpoint-ORIG-GUID: o-v5Yp9WK6HjMRw3IGcP30TeaOx0Srag
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 09:30:29PM +0100, Philipp Hortmann wrote:
>  /* Bits in the EnhanceCFG_2 register */
> -#define EnCFG_NXTBTTCFPSTR	BIT(0)
> -#define EnCFG_BarkerPream	BIT(1)
> -#define EnCFG_PktBurstMode	BIT(2)
> +#define EN_CFG_NXTBTTCFPSTR	BIT(0)
> +#define EN_CFG_BARKER_PREAM	BIT(1)
> +#define EN_CFG_PKT_BURST_MO	BIT(2)

Presumably you mean "_MD" for mode instead "_MO"?

regards,
dan carpenter

