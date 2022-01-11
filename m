Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1934B48A600
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiAKDBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:01:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63456 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbiAKDBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:01:53 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B09EjS026247;
        Tue, 11 Jan 2022 03:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=fM84YbY96knJjphEdLo3yrBmlt4temUrdb9+eJ5OXUo=;
 b=AXDz75L1F3xy9yNNucaX3CfXrYu8sk7twDxDACrNI2k0ANmujuAtvB75xJhZMO9Iivvo
 ujn3RA7rKATCEyHnln8K69HL/q5ScAHJZLS8sKZ1qvFciDx8ZwR5Gf4k+6baF5Bg+xc6
 PVuNnIZpRz2yC85kqJbY64DFlHKaIPxlAixlVxjWwBnoO4WkpyeU8HStdRGz7/Fv9//a
 ZNsvvYpiJcYf71jfyuJwudYftVQ9+jz704CrsMFthzCi5bZnT3GQsVPhzTCnhV/uTiQI
 rEn/t030HUJFMBJH4MvlXq9yLrFwEftFuTsmBMXhDzCQooOBI1CHKIHs8O3C2E9U6snp og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nhqs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 03:01:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B31a4A007044;
        Tue, 11 Jan 2022 03:01:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 3df42kyp2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 03:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4yjcUadKIcW05JIkYxCrpaMLSzvMNuZPDnITiWVXUiM5e57SsqL+rQaSOn9q6r02DI7OTYWBg4lB8dCnjA+fRT+SGQFi1UsVoloRAUNinVbRQBSmx0V4TeDZIaIm3ppZqIisRkhCe4Dhk4fA9pNdfqvZnyrpxvZkDnZ/oCDk5fayyMJIsB48hqxy4Tm84wAQObU5jOZ8nAA469RDpk0xZHL9X41NiePNexAzzh+EqWdHCSY8aPU6TfUa1roMFDb7ncxWipsZn8BioC4/UrJUVGTA1W1BsZapKTtbVHBGwCmwnLk69VfS2KpGtwhtY05ZmavRmOArr2L9mU9HtrvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM84YbY96knJjphEdLo3yrBmlt4temUrdb9+eJ5OXUo=;
 b=hh8GafqKnjvgyQhuk1yYpItH+EHsYqOHZPvTXbFaaM6Cj4sSXbjk6Ksu0VlIfwlos12Ly8BrUu/svgb/fJcp4QZExtvjY11rvmrFqTAlmzKcyd4LG6aisGO8rYsWryc2VKHqv1XdReDZ8EDyO5lZlmW/EyfnbYaTiYBf5HcsbJ45PYNCB5+MZy1h1vDw4wLXwTFaUDc0AEemeZX5rbhO8qDb5fJmcHDWdVMDuA4MpH2B9MOSCIA8khI2eZCL3FNIL5rjdn20TmRLEq/A3GMbXerdoTLU+rDkWpkoTRndjx7L0adnIo3v/IgqH8BxpU53sGoot7s7ru9bTaVhvfntwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM84YbY96knJjphEdLo3yrBmlt4temUrdb9+eJ5OXUo=;
 b=ywKeAaCOTCo+bY9ujGXp9yIv2LRuYHs+ejV4HgYdTm6bRzWHA/+QBQVMVSCyeyiSHbg+AYyqsnjKT/y5kydCAx0ctaQKs6s/5q/owob9Ke1LTATqpJLt7L9rsjsPWMjXjBLL++lPD4Wai740CNvvi1SOtKP32mHkHjC5rg+MJaw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 03:01:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 03:01:29 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: pmcraid: Fix memory allocation in
 'pmcraid_alloc_sglist()'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a6g3q8mu.fsf@ca-mkp.ca.oracle.com>
References: <11a1bc98501de37baa5bcd10b61136f6e450b82e.1641816080.git.christophe.jaillet@wanadoo.fr>
        <20220110164417.GA7133@lst.de>
Date:   Mon, 10 Jan 2022 22:01:28 -0500
In-Reply-To: <20220110164417.GA7133@lst.de> (Christoph Hellwig's message of
        "Mon, 10 Jan 2022 17:44:17 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:f2::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a8d8418-9727-43bd-a57f-08d9d4aeaa59
X-MS-TrafficTypeDiagnostic: PH0PR10MB4454:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB445449DB13682BFB15694AE78E519@PH0PR10MB4454.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QCEmct/6uoWudRo5emNmecu2XYc8/epqNf0mu9TStbk2vF97Ct3Fn47+I2+Z4cx8tClh9lu2DwwFmKdkH8xGTxwi2APQ+GgYD1pJnU0seoT/4VHIWuAri5UnB2w3IiScSN8gCqlRduIOx4KkZmMf6Q29BHUjUYqyx/vqLC6oJi6/XawBQ1Plx+gyLoFNuPR/vzV9JHLh0nKb7XTGoEvcEXNK0xcEdUh0KixiteMpOw2udKd+5Ptk1XvEJIVzNb2c4dNLVSFqDxtG4mpnkHWqyg7jwa7fXk9hlw0HavAg04DvgKgsaGqhbukd5JEjul2Xn8QgoTgtGGm3sXjrhO/kThIalHxpfN2ImySSdpvrMpIK6c9Qm1LuzORGyx5Bs86Y2m+ralfyi0Ub+ElVGd8jqAEF7D26NlpuyTrDP3N3EW23Qo+XMZy1EthHuqRz/fN5Yg4oLDh/Vv0T7IZsCisRE1Sg4/hJnp0siD2SjL/k1DxtF26noeoZnGICieSSoxUmdxZhkPjPBVdPP2+LMwiBaMc0AMKDvO75mX9oCkQeFF4hGEXJIZaF4kIyYtWvnC0qkbFwJ7k17CiZuTCpCNh47VMxVZlF6gCf9mkz1VJvegcosQXqanShwRvxC55va3ZVX6ATSu3OQZq3NkDsqv9vwv8pRr7OqDrAIu0dBS4k/wvtgr+3q5PF2S65ZKU1o3NyZyzVNtYT5PgPMSCKEDitQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36916002)(508600001)(52116002)(86362001)(6506007)(6916009)(316002)(6512007)(38350700002)(38100700002)(5660300002)(4744005)(66476007)(26005)(2906002)(6486002)(8676002)(66556008)(4326008)(83380400001)(66946007)(8936002)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tjUvHnt+5qrOHIyJCHwsb0jDb6qOiGw7PIJ4RE+XGgd2jprx/R2BS3XxAW1?=
 =?us-ascii?Q?XdheF2ydj490/IuLa1nJ+RqctT8J6hEqd8i224DPD0bFeqkyh4dtS7GYHkTD?=
 =?us-ascii?Q?Gx1EMhle3kyfda52nSXOG7L8vtai4gGHmXJJAiqLuvQpRHEFqxFAWlS8C5nW?=
 =?us-ascii?Q?lTWHvU3M/CaBxOTS1YbYk0xy08AnmXsfpDTWyr+r8l0XISeVpZYP3cl44jLz?=
 =?us-ascii?Q?pS7EW8ao4SrvcjlLGGUQerd/Lstk7QpQEMOYUAUlIWHhCFpEoirVjJViiMDy?=
 =?us-ascii?Q?BRkNT+Z393d6PRyDI9VBIKpLVLU3mcG5INs2PUvbDm4WXDY5TGqlBX9yS0Hi?=
 =?us-ascii?Q?5DAtsKKT0rg/gq5t/GvYAeZZzEDEy7i4uCVs82VHUiqzv8T2ZWjeDtvNK95P?=
 =?us-ascii?Q?K5Nnj75CMxt1d30YbqLE7Q5ZjgSBxvrgZFd6+2vFEBBLX1FwQ/JOIwLer4WJ?=
 =?us-ascii?Q?XvmHHVHhp1MNypIBEtnRfhDM3tgRqaH9Rwzpqv92wCSNppT96kPVJlp1N4IE?=
 =?us-ascii?Q?Z6dGHLVeEREvb9Q/EMWBPurOjN0yHSsKGqXPGO/hmNV9xufO0+6r+ZjXLHy/?=
 =?us-ascii?Q?TnTGFWK1U04RXgcBSf6dx2rRyiSNSQkjRmSMh84fihhTiKFK1IPCKmyBGJNN?=
 =?us-ascii?Q?g79W6aRh2iVLw1UrxokY9mHtgTgsvxksHpcBnlLTyjDolhKsY7rSu91vZyp2?=
 =?us-ascii?Q?OGNNcZ00rbE9b9n1h/PAOiI2Xb1tsEmLuBIJBp6vwBbf7OieYJDi2LNYUtcE?=
 =?us-ascii?Q?w+olLP7Yy+u/Fje8pNzBw2aJCtgAXLeEtR0eY21bpq+Wh+VAd9pA702zrYwq?=
 =?us-ascii?Q?RePdvWa1P07iDTTNvCGUDFiDSwsCHpJlC/z2+k2eENt55wuQYp9p9YbYS41a?=
 =?us-ascii?Q?ShskJUhIO5syXtHxOASHnK3Bf+hXpIYfOLJ35hR/H4q1ufCHWJ5soh/6qxOj?=
 =?us-ascii?Q?/6vYv4sRQRxqKcwNeiExzEg8xL5/nB0o5Q8pxkIdngW4XxvwgZyO/srWWgnU?=
 =?us-ascii?Q?kZUMDl9I46xE1M8scGvuYFOyHURXLWJOD0fRQ0AJWNL508+P6/m7qUjpy6A6?=
 =?us-ascii?Q?V0RZT6CEXKnhow6BK5hYQEaTZCeYJXIKa3kNM6uxAy2FgsxE3WjMghQ7Xv6W?=
 =?us-ascii?Q?AU9OFm0Q1dNb5kLXg/vjKWmy3MkbVAJCQAC3xKX3jNc6Q482sBcF1t0WTQ8y?=
 =?us-ascii?Q?BZDoTRPeb/eZF/uoz8nQku9nITyIL1PBvAUz1bXcD/6OLEvdOX9GpH4kck7M?=
 =?us-ascii?Q?LDOyeB+pFjIoKo8zadBayZhGe4GyzB5z1IFY6ayrWjITDfE76b7+ZkP095Tm?=
 =?us-ascii?Q?aL2z4/UqdWdDcSwMTBWJMHA8NsuHfAZbQVIIiOzpTjOn948AbPcokAXL5cGg?=
 =?us-ascii?Q?w5F85sVZbBONNo/jjYLLZVmRJoD2GTLkhzwYINRf8B3DDdBQt97D8q/FXjWj?=
 =?us-ascii?Q?E7AbNh2IOAnsxOSSWldgDm5+G9Rxm9lMIJ58iMj536y6f2lR5WMZpHYM8z1t?=
 =?us-ascii?Q?cg6o934dZ28nJZhgJZSS4Z8favtV98ZYdJgk5xHZhchbkZjICw0qr7VooD9z?=
 =?us-ascii?Q?IOkV/V+9PWMaxxRW+vhwma6CLcbCG2a0Xo+g2oq0ZNSjJ2Nrv7my+Z87ou2I?=
 =?us-ascii?Q?Dnf6lLX+IsoH0tVN80NgkTvrz+ZdokiZP2HD7bXQgUs47Jp3G/bC/icCJrxO?=
 =?us-ascii?Q?61QI/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8d8418-9727-43bd-a57f-08d9d4aeaa59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:01:29.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7D4XJTjJaoVdIM8HvmiGmnJuWaOzooYN9B6WGTCvQ70Egnjabc7twZOmJRsGHBLL7BID60AqBmxRXWxJOPam99QjwqptTHrbB0PMYC65MB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=866 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110008
X-Proofpoint-GUID: gk1HnnnEn2qku7ZaoVX1d7Xo32J5y3SQ
X-Proofpoint-ORIG-GUID: gk1HnnnEn2qku7ZaoVX1d7Xo32J5y3SQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

> The whole passthrough ioctl path looks completely broken to me.  For
> example it dma maps the scatterlist and after that copies data to it,
> which is prohibited by the DMA API contract.
>
> So I'd be tempted to just remove the PMCRAID_PASSTHROUGH_IOCTL ioctl
> implementation entirely, and if users for it do pop up we should
> reimplement it using the proper block layer request mapping helpers.

Given that nobody has complained since 2018 I propose we remove it.

-- 
Martin K. Petersen	Oracle Linux Engineering
