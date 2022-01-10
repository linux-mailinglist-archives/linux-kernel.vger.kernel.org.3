Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2A489C79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiAJPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:45:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46848 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236387AbiAJPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:45:07 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AEDpcG015371;
        Mon, 10 Jan 2022 15:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RwyMqh3Ma+/vs0vOUpw08IzTvJVskeAFvGpaKE3Zd94=;
 b=aVojlwoa+MGK9I9kPNx09r9GTc1vQO6EaEY4+mFKdAdOmsosrmbB6wzpjqQnPzP9smBa
 Orj01frEJgq/BQxhP6cxECM5UYHb9dWnnkMc6jX+ae5DbZL/IrkA5FRiXzPvcnyHqd6K
 zY5B3JNzal0u5/Y8rDhEfCwjkVAEMm3ffG+p5Hl6wA4EgPthADMoKA4ubSM3/3T+GEYz
 sJeTNVcMLp3drAV9Nlm7ERsdw72gNBmwel4eBMG63Jkys2Vz8zcmIYUfvetE+ssdYuFQ
 oQW5KGt1NcOwrs8E91X3gAyBAVWJiYIbUbbFBI4Guo4sRcLN9s8uZ754SEtUS9VdrHAc dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtg8rwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:44:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AFfujV114432;
        Mon, 10 Jan 2022 15:44:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 3df2e3euqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XunsyigxhTkNTKwaYYlnDM8Qo4PXqM4DFDb1B1YYugKRl01DuPV9lX8xBJSBV8yVHbSBhBI9qOf59WTBQ6K3VvGlAT8ot7vH3Df4Vz62KRpehMZnjU0hEIuMPP3cCcvxG2Cn+436d0aim7bK5/2uuhgb8McQi7n+u7M3pvkWWpbJcSRZP8VIPk4Q0R5WFfBR5UDCJYQRlI2JBh+6aPs/X/feIZGg1ClngH4ojtCtMt2s/Wrudx8hXtjZ0KowVetYEJQind87Alo/UErVBaAJIZ7WlhsBcgG4kr9KSG5Me5Z9sD2W8kQG6jOYIT/lAjBX6d+OIU2SNqUo7AGgVyBCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwyMqh3Ma+/vs0vOUpw08IzTvJVskeAFvGpaKE3Zd94=;
 b=NciIYOJ+YQ4UdWNdsiqUCqHdiBCm/rgPWDIe2XWHlGZ2MGIpy6MO56r0XVi7GuyXNuBIEWn1OmAYFwHLNPxBbAM/EHfnT/JJz/jAx9vVkj3rrLFSGWy3lNYHbX1JhdBKr/HZ4Qntkq1zFwCdTsI9Q8FsBWmGxQj0vq2u5yyh2+weHb0QRskKYoKxhBaf1NuWdcP7jVrF2tke1nHRLydBT6yWgEg7VsbIfNqAiE8dw32uHWlhdkwVhGNqvqhlJgRvHgxsPQ9NKEL0M8hyOSn1kGun65mLEem3S/fMTs6r2Z5SptJ1Hf+2NTVD/ysaP1/XkxBEtvIhWLQhcQhC+mLO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwyMqh3Ma+/vs0vOUpw08IzTvJVskeAFvGpaKE3Zd94=;
 b=zJGWiylV6tws4VuZzl7IpsoHSjvGpyQqutCHVvsz7ka13Ijp4/9iHOkl74dVO9/vT78yj6z9h9BTO+AfwmjhYepm7fsx0IVhHDukFf22eto+RrU6bWyKrHEnle6SDr7Wrb5Hi2iYP/0mlHLkXBM0NShvG7ooHSDmehC7ECuRv+M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5451.namprd10.prod.outlook.com (2603:10b6:510:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 15:44:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 15:44:56 +0000
To:     =?utf-8?B?7ISc7Zi47JiB?= <hy50.seo@samsung.com>
Cc:     "'Avri Altman'" <Avri.Altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <asutoshd@codeaurora.org>, <cang@codeaurora.org>,
        <bvanassche@acm.org>
Subject: Re: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135lvtx2a.fsf@ca-mkp.ca.oracle.com>
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com>
        <20220106213924.186263-1-hy50.seo@samsung.com>
        <DM6PR04MB657535F7CC817A0E2893F668FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
        <000401d805c6$8329ae40$897d0ac0$@samsung.com>
Date:   Mon, 10 Jan 2022 10:44:53 -0500
In-Reply-To: <000401d805c6$8329ae40$897d0ac0$@samsung.com> (=?utf-8?B?Ig==?=
 =?utf-8?B?7ISc7Zi47JiBIidz?= message
        of "Mon, 10 Jan 2022 11:05:16 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e44f50-d972-4817-e904-08d9d450267d
X-MS-TrafficTypeDiagnostic: PH0PR10MB5451:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5451B2EC31621D1E9EA1F0188E509@PH0PR10MB5451.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1V8vXzif7MSgZkLosqR+4Z4j7fnPzZJxKu7TyamCpqkgW9CCUZ3VtJ4YPL4rWAN/IxYVUI6A2iPym2EBeU1nZ2ykcMKSRV8b9yQV1Br3W7lH8fEH5hCBmy49Kbmaa1QgTJsrWcoot4557tIJidWVnIlb1Ia53axYEJAa+VXMCQ7URZciPFAVRl5J02/HvSyU9s4pNAF3Jjk820otQBEByONfVZqSqofGyDSXikbIoLYdqw5ND/lszLeA0DKdRXwOefVlv+re0TgDcwUGY3F9ujnBhWGfFnf6A5Rwz/0uuIYxD49R9SsroXTVJiRow5r0LjkCFHH4w1KsuNNKLB9sVNmfKq2sMBy+BuTQGgwAnBUteUYRtv6zpNWt+BFb687htQ0LoReyQD3OxKd9sGQj6vGA/5ENPWq/9YUpYWHTMrmyLCp+ZXM1Miwawqsfw2TI3Ytcr4z5AbfgGecIiwkLYi4nFi9I4Xgxj0vJv/9buYq2aZnVbBPteNCJVMq254MqmFwS4VJLHRVz4Zuq67eGYDS+KW7Jn3zhi81xe/JapovY3FuXiRbtyV9bmGyd1/mYVPmg0XZhhq6Ii6ryune1dOiOSYUs9p+btv5xosSR2VkyQ/D+At6+4pxkqyEmYAINB/xiKp5gWWNyvsC2oqGGNQKMPcIrOmEMGOS20xuwU0OIrTOCYGWRG1231B75AZqkHa+twS9q9aOVahYKM/XFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(558084003)(6506007)(5660300002)(7416002)(66476007)(36916002)(6916009)(8676002)(8936002)(6666004)(26005)(83380400001)(508600001)(86362001)(4326008)(6486002)(316002)(66946007)(186003)(38350700002)(54906003)(66556008)(2906002)(6512007)(38100700002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vE1Sc+uhsg5ZcxKxyycvIiBi4XSWhhppBhO0yZ9JTEb3Rr3pWXOADOxSImGh?=
 =?us-ascii?Q?K+5GA1mGzLlF1n1qw7rBn+MkK8+g2Omsc+oqGIXhQinS86754dCQthmI1ByC?=
 =?us-ascii?Q?LwXQMcIa8Ev3evCp80Rhzdy51NOnY1FSdDvqlhvG9M8f68yabkRJgdH+fAvw?=
 =?us-ascii?Q?3W/LbH1XqKg0/P/MDiM56ydzlStYPBsN66RLO2pPAGMvthHU1ZWh5KQMfOI9?=
 =?us-ascii?Q?UvxFa9z6dAx2YpxqyArun7LDxgm72916jjw+YrHK5RhP5H6y/8VlcFRyGIe1?=
 =?us-ascii?Q?wnkIEGui35ZJ/uEAirDOpyoEYs14sGH3R4fsP/ZLrgdJfLOJInFi42MgkF51?=
 =?us-ascii?Q?4Uhe4jPpBS4z/qz3K1bAv/Je7jtPtKuHi0O34m4BQM68BQgvzzAW/fHW65Wh?=
 =?us-ascii?Q?0QrPm+ulJv9D+SRM8UYqXeDWfdNSrBUqxPEo0Ql4AkpgHN/FGtPRoAx35CBk?=
 =?us-ascii?Q?Gpu0x9/CzloQIEBgi4SfXGmKRxxXni3qFa9XiUkriMeumM5ZbKagC2BWPfFt?=
 =?us-ascii?Q?ZOTf5Tby0J5xx0GskeMpa4qi1yLePPrVGlg+byrdu15GbHHNDt+GrRgDUuWK?=
 =?us-ascii?Q?kggRkuu9Ago5qWdsGU0BzMXrAJZDg9iD+2/kdH41ngksh5gQ3L6yVroOqDXq?=
 =?us-ascii?Q?ixIcK4O6YNJTqbbYYnCpsQNZigJQapl0h14nwt+OZX7htglY89nwDSMn2nUR?=
 =?us-ascii?Q?hWgJMLoTz9JQGAYr+BqUlrTnXCkFTo0XXwUkfJ6JoI/MgYZ9emG1ecjw8GMl?=
 =?us-ascii?Q?kdgGvknGa/uiz54hxzbbXfitH+y10Amt6xOuaNeTiKxZWPTemadbqmORTj4y?=
 =?us-ascii?Q?5NNOTG6A68f1YRQhXKYR33YbEYRDXz5niCC5D2u9//gA/zCpwFTcPU06F6hZ?=
 =?us-ascii?Q?cYUcIcOeF46Bgrly3lnZFHPlWQItdlygzWVEHBxDFVcVDYVIHs06tz2wextH?=
 =?us-ascii?Q?2PoWL3N7byEmcgOIAHREq0ykYjI6X5aRQAlmlN/sFyvHDO6Mir6J0Q7jLmyK?=
 =?us-ascii?Q?mZcouU/z+hOsELKIu80R+U+j+Z3O8u1Vg8IfN4GHoAoaFqeOilpuHfrYgRQ9?=
 =?us-ascii?Q?0yC0EnZN15a3kgqz7ec4Q9rwTDWZCp0MANaNbmHa6qRSLvzrKvS91J5G+pzT?=
 =?us-ascii?Q?BElPaaB4yUf/lkWUOqQ3ZmuOF2BZKJZObsmhI3YYcS/FG6ENsjcHgkFBaiGn?=
 =?us-ascii?Q?41RySpn0rrXPbxZNCKu4yRxvc4QqomWdXLF5GRRy9UzDeAoTlBD8HrvlVkWE?=
 =?us-ascii?Q?19A3BY9XeKW9ym101mRWseB8QLdCReiqMmktHzgSjnCs45l9zzU9D8jlhYJT?=
 =?us-ascii?Q?qvHw4grXBqJennedIWeObYyNrXyW9TmH7dP5A3QToA60oQe2q0S7lOiiePOp?=
 =?us-ascii?Q?dXr5lEE0esqYgBNOmkGxfEu6k0gCqeWvlVZdbeg02+mMhNK5F0Yhc+OqXvWH?=
 =?us-ascii?Q?qGh8SELsCV+RrMAfZVCtUP1k0CXxqefv21j//jz/4/Tu/kHOreJlJvz4mrua?=
 =?us-ascii?Q?zVEMaHSVakZ9rB3wb2cJt8v/vuJ/yoLZBnXheiH8qL0EvPZkoavK6pIAi1Su?=
 =?us-ascii?Q?oeKBTzqjcCQK2RY/xMFMMm6frwHpaTyoxsyOsgX5zkuelDseCYnfJbME0iAi?=
 =?us-ascii?Q?8BNTAbVxyPK0hCL9eni0LBuLKflB/iVnZv+sLlf0ud7+WfyOW3Apcap1awK5?=
 =?us-ascii?Q?etiZIg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e44f50-d972-4817-e904-08d9d450267d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:44:55.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kODexxnjnd3+u9Vohf8OP3jtYSR+uBYNObHg0O1ausjlUDIOLxSpbMmqaKGPhAMZuU/XhKFHG408ZQTOulgmj0pUIgOj937atZD6cU8vxuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5451
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=610 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100109
X-Proofpoint-GUID: mCl4xCXw7ta-jVs56bV-LEU5_yzDx77t
X-Proofpoint-ORIG-GUID: mCl4xCXw7ta-jVs56bV-LEU5_yzDx77t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If register "UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE" quirk, using this
> Tact time function.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
