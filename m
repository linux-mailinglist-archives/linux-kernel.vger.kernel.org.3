Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA63484DA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiAEFdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:33:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45302 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234116AbiAEFdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:33:41 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204Ni9Vg032174;
        Wed, 5 Jan 2022 05:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=feIe/D/Z1rIAzyMEClpMhJjJpMhI2XsUA6KR1NPolQQ=;
 b=ZexumzgpRY3UzVTeX7PmBV21NlJT0fM4B9vfPBF9VUIMAU+xG2Iv7VdxZqasJuXq2ukS
 SkyWDnDAOO/osOq3qY1VRU2cjlg80npLvBJoS2mpLRkgn78qv3ikJYwooTzZR+dvlMMA
 FRyrKnmwJo4rB6AG5CCLQ3rfPGX8w9C4k9DHGlYhqPIxCQabgLi7GqkgBWUyDO9HVwEV
 QS1+3DrMQGZ0Ls45kFTmBT1wqQKzF91+i3FgpoKHpbT9EJ2xq+i17KHjKpLllQyfSOnf
 YYgbDJ/I1nBF2DRa+I64GAtkSAWy4y+s38wi/wjn++iRFq+ekYzk67QJNrmwoMZMRyOa Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st40uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 05:33:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2055VbGe122472;
        Wed, 5 Jan 2022 05:33:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3020.oracle.com with ESMTP id 3daes4nxhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 05:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4sCEqtMLeI35Oeqjw92dTLdKoPQb8hgSLJEs3ligLAc4jEGvIoYF3Aev64XNssYpVBlLTtyo4QX+eyi+YW/97bPcpHe+LPM+XDAsjAa7dNmyCqplbEOBDA1rRZkAIGtsKmfzQs2Ot6ZEnIUTkY5mfsI/e2md2vfCxyYu3pQ0WH/goWlOm9ccG/65J9syATlsK5HbG2ud26vkmzeIbUdgUO5BQP3pGXRso2N+qmVy849yuKJHKqdTejMtR1/ZqyNwiWe8Te8sXg9ZRL/M0zyawcyOi+6OCf22gvUml96wLz0ABfsBaZLWiJH+UEwMLI3Y0xL1p1pTjubVB8BWXmwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feIe/D/Z1rIAzyMEClpMhJjJpMhI2XsUA6KR1NPolQQ=;
 b=by3MagOSptn73xlO/ZTXFBh/h8CW/oONMr5sVG/UoUqaIrDKu0ZDx2aIEH0qpSVp0uKHQpFCRiM5AAPR678TJHOyjDw0TwlDwW9rdpGAtj5IWmmmtRqSVVMvrFrF+eYuQV929Uq4uxJsXAzzoeNBZ4D9f2vbvv9ElVUiykTwFqyot2VdG+mzzODSX8RLpj4pBideK+vN2igU90CecltVi4/aqrDpX5WWYeK2MBXD2V7GIJAUmyE9msNFNmbtU6/0Zn3fJL/LdTjllarZaY8vSuD4Ty5X1xRmWg5kieXAUF/zOPSIzik171zZhjsDnZpZ4ZuXJDQFwyA1HQCR3y1nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feIe/D/Z1rIAzyMEClpMhJjJpMhI2XsUA6KR1NPolQQ=;
 b=bFIj7Zl9zfcazTrX181/KmMIc0TXGd8uIHO+FGsbmATLdM35AMHzOsXEe9aVOab5QE3hcoSbeq6EHjC1tZ1KMPBT2sXDzWlBhFQecNeN83Suidl30pNlcVrc70DXl0kAeRz3HCfZ0ZUJhpkkCjDqdkLDf4n3gnOkU2RZ2klBKVw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 05:33:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 05:33:36 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: mpi3mr: Fix some spelling mistakes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee5mzqzb.fsf@ca-mkp.ca.oracle.com>
References: <20211224175240.1348942-1-colin.i.king@gmail.com>
Date:   Wed, 05 Jan 2022 00:33:34 -0500
In-Reply-To: <20211224175240.1348942-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 24 Dec 2021 17:52:40 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0032.prod.exchangelabs.com (2603:10b6:805:b6::45)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4405eba9-bb79-45b1-7ca2-08d9d00ceba6
X-MS-TrafficTypeDiagnostic: PH0PR10MB4791:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4791F6B63ED39B112D0188978E4B9@PH0PR10MB4791.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jt/Tl42QCBpHBsRY1/UEmvJW5NKu1yJ+dbgTqea2KFZAL+a1GJSwQSu/V05Ocr8fQhGCtWybTTJLZmfdC2vMvyEccdzPzL2j49A/Qe/JncYGgeECR3ahAEV4YO+AVgQojUXj4Db7x3lH2YOt1QpreePH+fMrVV+yQlmwaz+642jQk66ZhGy6sDnMOZHuE/2GOV1TSqVHrCUSNe2qRuRrfufOx06fSlrVZrRw03vDf/gLV5gVwtoJowhcW2rCg7jr5FlbRHpB8WV4ZnyvnjZ8rp1Xvp0WLNXqVMsm8rm+sxFPlXHUKAy5fYhLcWwxI0ulKttSS52jFn2IaOvfwDww/GMXPSB0BTcNiBTuRWqs1E23Vd6v9ycCjwfj1qC9V3OjLmeQWnupPIdSj3tlnaxK1Dlyx3HNaKXNMq1GD7VHfh+iBsU1olBbUD53pr/9h4LNgpTHY2TGTtElG10oAgIt4H30ynMu3BqJl3L1S4hAkaQs7oIA3qyaUEZIuIDfjAOhrTKWM3Pr1WLBl0DoZQs6+3i8fbrXoGmCf0s2cS+TCcqSfgRrZn9tjYaM2rzM4qDcEeV7UaESpa6D9KkjrIOMjwME/YiqRQVo+bJB6VYy99PWDjK5BngMy6rUPgl+WFpIqeYmTJjDNAqviFQHgPTGDZ9mtPcbDOK5/RAw5kZByIGRWOaUWq8o54i0WQxVGqv9PFYWhRuKf95fdrJ50bctcD0elscGXLIYFkp6B86d50U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(26005)(186003)(66556008)(66946007)(38100700002)(38350700002)(316002)(5660300002)(52116002)(86362001)(4326008)(558084003)(2906002)(7416002)(6486002)(6512007)(6506007)(36916002)(6916009)(8936002)(8676002)(508600001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7bYgHSP8iqa0WQWBwlRxgka9vmm2FqXVCIYXIbhsOQUfUvpW9N9ZI332qTU?=
 =?us-ascii?Q?B+C6tsrzno4CWTdkvGmv0pQ6/UilCwex4TYapLVnYatyWZ0dvzqHAcOB8g/A?=
 =?us-ascii?Q?SwUpdi6AM1OhKLuL3eSVKz2Q7G+F2uGSR3OaK3rGaf3sTupuxLkDoE92dMeP?=
 =?us-ascii?Q?NmiEJwicA9NApq7vHXLPwVU4TJiur9p2pjts42dsj/r1ng0Dqc5BDL/jHuJF?=
 =?us-ascii?Q?3tLo0tiWlXQwcfH8TtliKGrNWrR2LPqpI5YCGEbTpQoFNO9c2TW5VEWsolWQ?=
 =?us-ascii?Q?pqIJmEgN6CKnLAwHF7eQdAj4b9kVtE9xhcSgUNIx+yYgclrCwEFID8M9yPf+?=
 =?us-ascii?Q?Q+LDxA0TtebbrBfvxyBFV0oFrXL+CuqTenFlT4DIDFpkZl5+V5zawOMf/HYN?=
 =?us-ascii?Q?oWiKMFY/PNGzs3MI54g856H7O64BnLIRYXmBToTy0sqWLQVbIQ/KVV1eeonV?=
 =?us-ascii?Q?J0oMTvI7sik55dnLwNC8g8HR6JrZf+EIHmB8VVDbUxbIQmnHe00YiDiGS5NY?=
 =?us-ascii?Q?AhKqSekB9BMRPN0W6jX7lXZfSGhh3k0Qq6L6Y6QrY8seakpPn4x2SHL2QLkG?=
 =?us-ascii?Q?QWAVmxySj+sxZ8BcqVOZnNWHmHpqtVgHlwEU2fP9D48fgzyov93/Q9WGqXWF?=
 =?us-ascii?Q?sqdqWBgFy3Jjr+JdxV82I/MU9Sz+OIN+bVbeEaUiMKzmNXKXKeXb0VtpWeGM?=
 =?us-ascii?Q?rbFTl9FxKSePbJHBS0Qhrviwc4KENMyE1lc7ynufq90nAAwtGI6CDxfsM/xh?=
 =?us-ascii?Q?i+MSu1AGAMi3tjdPOYAyxK0Apvyra7GsTYMm9WlR+DVxu7fOQuRzFTSP2DbA?=
 =?us-ascii?Q?G2NbfN85GPwigaWAKuyyEVpoldgopAQbp7TNwCCrWHPPIzn9vyXCDyMkNFIo?=
 =?us-ascii?Q?zpQQaHB/WvJqzpMTKkNSJ1q4TXcjsRVungwptkjHzHPJN50mX7rE5wKzQ1Tc?=
 =?us-ascii?Q?ry/JbBHcPJI5HU0Lb0ABJ0rTt4Cq5f6naC0RLjH0YdxZayRatQFy3pQMCbTt?=
 =?us-ascii?Q?4yVYptRIXunl25ClmfTuwTokA637qKagHFsWGPOYZqdeTU7BLnwhTZI7XxlO?=
 =?us-ascii?Q?FyPnb0IsQ80A8ogkyarwRntJ56NyouG8rPQONAtAbCO4M3kFKcUfxM3oU6Pu?=
 =?us-ascii?Q?5RaYiCurQC8fxUSzd2GERomWdGmSSKL+BiJjbGqUK/1WKfGWoMDRDFEbeULQ?=
 =?us-ascii?Q?O/6LlAzBq8X4cppss77mXgMCoaVsmkZfklHvKYMpaidHXypgmzH8mf8+UYfy?=
 =?us-ascii?Q?mValRjw864Kuc3AcRsR3oypEJB1D95BUgbYHNdreqi5yBPZJBA3+mPD74IcA?=
 =?us-ascii?Q?iko4vsbMyNkGUgLD3xuDJApzxxxKc/Eh37HaNF1VaI02KEKqvFLk2Yjq+I5V?=
 =?us-ascii?Q?zhbMAKrXqzu5KCEB3DWdETlNTxXgwndhSOG0bZFLcXBQqK2ci1/NgdFvx6ub?=
 =?us-ascii?Q?0aWfi3XQm9kqBwix3S3bs8SAD8OUmkg8YlGaSu/zfhpyAVzdYaaYgx2VCZ1i?=
 =?us-ascii?Q?FGFEGjsAfRHsim2U4W8hptIWNiXISQp2rrGbP4ui4X8/UbZNMr9jAIo/Oj0Z?=
 =?us-ascii?Q?D0PQD/U/Jkvgd6kDZEwBZCVTISF7VIl4gAd/afYt9+VFWxrGIMquQsGewlP2?=
 =?us-ascii?Q?shz314G61AtIrtyLoG5Y/VKlWNgBXP5Lgi+98sA7NWgXXiHceRizeQvxC2i+?=
 =?us-ascii?Q?Cr48Gg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4405eba9-bb79-45b1-7ca2-08d9d00ceba6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 05:33:36.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtKknsIzeRirs/e+d+w2QwRtqIDKvjVM5lNhZUPxYsScfBbguO/JgeUApakYeliGjqxpYgDv6e6vcXldxeSVe1bFq+JEHA+VUHJIEWH8F4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050036
X-Proofpoint-GUID: OFZCZnFmcD7QPmQncsiLTPram4AYIdGk
X-Proofpoint-ORIG-GUID: OFZCZnFmcD7QPmQncsiLTPram4AYIdGk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are some spelling mistakes in some literal strings. Fix them.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
