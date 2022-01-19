Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06864933D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351434AbiASDyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:54:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351378AbiASDyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:54:11 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx43E018362;
        Wed, 19 Jan 2022 03:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=tpCT6q0gSBkQfRMgvgH8aOWMQXxsF6xC7CY2xGk6+k5euDDKLEybO5lo/pshgy4uStbn
 MO/wIucUk/utw/nxKHW9tsADvIZNVTim90hRxLwRsmkT/aZcVB375Prw46DHCh4zror/
 YW/ypVvjWDJQYiJW1YeyNfXvUh1RVimFKlys5O2fYIeMfuUu1+ZakeSBQHJlOzBnQ99D
 Y5JzW6J72dspNrdXQpKUJQONzt/16Ae7rMP4WcSMLxZqMq0brs0Yp4YgkJ4REIu7McXC
 R2xr4sCpAi2ilmXL3VDaIw/iqUpGRaFjA/z6SdrkmDWBhFm/vVZNuKXGR7/+3yz+Ov5r 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc51bq6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:54:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J3ksE5078673;
        Wed, 19 Jan 2022 03:54:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3dkmad0vjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWlcVCgvCT4bIaYEjV6O0GQbAt8FGX2AWvS0PPl3qJCu1W8Lzcw8QoI3RTVpkw25jDrehr088jhtXpRD4A3cG7OTFAtrni+gTX9g8sLICpKpaImgKwg5HhNSu4aUJokXconwTwzv7GaBS/ILvhSvW7s/M6bBCGL2+nhKyj1pPHOXtjeHC4evAuOuwX0dlkaL74KmGIbDFPAUwH2oNWw6JzrpTS0cD4pom9hND2IyP5jdQ1P6SoVXD4n4KHtWvBUACpspHtV1JhviEzSGXi7aNZZ8fxbktbO/3KK+p4qept3gpJyKo6BkUME4RuipDQkGfz2BbdOR/NrEvzoRrsWwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=J+F35fbB4uZOw3WaqEXeZ+JaNiQGmFGE3yOaevNVuph1o6HtrLzQdV82QrAqqzTehOM2HYoLSG5+hZqUXhBfYCW9hpRllswzi1E6stIXEg8b1GEgaBM+X4Uqf5ycwCN5DE7ExhhWmxCvGod5IUZkTSLDfuljPZ3AaDZv1CgRIoE3wGbsTjzkUzTUTAuB13VUbCmrAXvTahr0f7EoE9edD0C6opiKdDXJ/TMwQo5uJ7e0aYVcRyETfZBf4l7Wo35uSvwZzLOnuyxxHIIQHBR3hu9sZuLAgAwd9R5VhiRBGPKpVcPkFcvRm/5KUOWplS0a5O+FQYItolkbtK/8rSSBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=COele5gGkbQ+m7R1CSeSLWqz0jpK95g1m7SL+zxdQTYr234kScDHVHzaAYDYtGCzNa79541e67+TEARMjPqDGwdI6BQdj9CTLwN9yJGhPMOoVmnPoZoXbPX5pDDpy5BPG9aC6Cm584X3dCI0XT4VU4R5GKwV6jRkyOO8BsZZoQs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3979.namprd10.prod.outlook.com (2603:10b6:5:1f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 03:54:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:54:01 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: hisi_sas: Remove useless DMA-32 fallback
 configuration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ee54l6sv.fsf@ca-mkp.ca.oracle.com>
References: <1bf2d3660178b0e6f172e5208bc0bd68d31d9268.1642237482.git.christophe.jaillet@wanadoo.fr>
Date:   Tue, 18 Jan 2022 22:53:59 -0500
In-Reply-To: <1bf2d3660178b0e6f172e5208bc0bd68d31d9268.1642237482.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sat, 15 Jan 2022 10:05:22 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:806:22::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 725523e7-e470-47b1-27ca-08d9daff5405
X-MS-TrafficTypeDiagnostic: DM6PR10MB3979:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3979568AFB9D2E033E6F0B818E599@DM6PR10MB3979.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOKy3xIuoGlZ4bHjQxcCG5brVvThkyB8WpjbXGTs9GoHx+ZqvGEfIwt0t5KmrSC6422obqUnjC9X1N2q1wGsFL9Jx28uqk511uYLM5ES+eWaZ2LFf4UKQwTCe/D+K2HcdOIvgt7mT7j6HsaWI8w6/6Gd/TFbQ50WArzxHYRkZ9b2iNCY795kMB6mMCb3G8sgNoCSR9VFR8wHU15abTlxmoJSQMD6uP9EBPqnec8LqRK1fBgIGoDxjWlzrUTbpb+CkfdmAEMy3behBqr66qVGig91A8lPNUGAFiLMoVYTgZ+bUaDa4VvX5CE2LvRUb3X9YlqTdea4s81onJdylL3v7Lus5z1zbtAapmWMTFJBfT73e2hGQcAUFfpgQ/3agGFBa/E8S0rnGZ3XmA9u8sUKyXE3ohRei4pFCycE25K61AZIt9K4UkJFHMukvu7yg2Z1PWEismty/pR2WFtNlFWOv9GvxstscdofSSSOQUTYN9ibqvg3K+zvKkrsLtPd9qtQt04m1dxZAi4tp5If6SS8TPYM72lmJHLhoPl9qalbniVhLhAlVXAcAg6oupLPLRIot2aBVIukFeWEuBMoNJ5l5KBVriLUFXi8qqNeAoNxxfAJc/J4R11LckuAFZ948n0dD1RmfstlJkgLjx5XACx8q6X9CXAmF/d/3PWv/cwsf0aER/C62nmddzZXSkX/G6SL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(86362001)(6512007)(6506007)(508600001)(558084003)(4326008)(8936002)(316002)(54906003)(66556008)(6486002)(2906002)(6916009)(8676002)(26005)(36916002)(52116002)(38350700002)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tH+v9B2XanBKRPwLOJcrhhoTxfbWDl0UumHuhSxnYVWZ/C2g0wLqnOBuEqRJ?=
 =?us-ascii?Q?2guzjqcOw/42g+lKB7+U0UzmKns9BTEK3/z/K1//mr9F8rL97RZDozU0Eztp?=
 =?us-ascii?Q?Q1kXiJFCFM1hGBaGJBKQCXloBZM3jwIQYbT9UbWDc31ovK3N+iGeMZzwmxZ6?=
 =?us-ascii?Q?5ydWCJm7jCRuA2lqgS4HmNtM/tmHGzCfYy1rJyzpG6nss4Ku55QWAHmMKTn/?=
 =?us-ascii?Q?bTPVgVJOi3pbJ/BcOKOcr3FUX2XATNawV4OE38G7QV8+FgJDc/1ScZSsfup7?=
 =?us-ascii?Q?ztL9oaaCC2ehAGhZTYDaFt7P3hx8w+APtHZXZ+2fc5X5BKlNvRYlKJo9LHgA?=
 =?us-ascii?Q?FIh/d3xoP3D5ejPqx3s8IQ8+GXzupWNd3G6lnnzixkDtRF/YEQnYn8bpvDpW?=
 =?us-ascii?Q?n1ZOFNSv5LhK0EGIqv3oi8v5fbuw1IWtkwRBKCWaaMNwsNe2Y2LzLkL60YdR?=
 =?us-ascii?Q?StO9jdyVBJmH+NbzWdmoO7ke/fcmgGjRhhf7St7pdjH59RExu8T9+TVagWeb?=
 =?us-ascii?Q?x+xggxPg8l6355Cj8HzPiCJZu51fyEVfdNuifbUQUkBGKU9vQKbuwIAFCRkV?=
 =?us-ascii?Q?YpHDdfO9FmiLGxRYn8seilqI98XkIZ1I3YCAIbGb38dTVtG/nCLdKbiLI5PA?=
 =?us-ascii?Q?gyC/gMV7qekE/KinsA7X40whL+SJQekPQii+rhlT0ui+GaYSnGmMt38vfvaV?=
 =?us-ascii?Q?6F0mwAt9fN4fJYSIpnqzGEXExLBch99LtYd5Xit4ZWRuQOWl4GV5Brv2dQVw?=
 =?us-ascii?Q?W/wwGyDMy1cnmXIdAuSA2Tu4OUEhOU/MOOYomd5LE/PWqUcFCbEOtU8PFvFt?=
 =?us-ascii?Q?QNRrQ371g+OVOkP9jWiBZr7uT+Q/MIBKWpdsqni/Lsj9nu1FEpUIE2iUobfp?=
 =?us-ascii?Q?p3VIxLyd+m0jr3CaeORJnclksLFXtYOh0P75+2vH2sK45DUGxuwJb+zWtWkO?=
 =?us-ascii?Q?9sOeLvMa2177ZQJ/rLbFVFZ9CmmkvmwCX5usDMlVvPdRKgvZlYvaRjkx9K9U?=
 =?us-ascii?Q?Nyx5raO/+OABHr7OhIYq6fQH+gjLUedlQvWy77h54nIiPtIbzZw/xIP3ITER?=
 =?us-ascii?Q?7JUiAiCGUFnUc27laQ3WYpo6m6E5frbat8aonohQhPjehi66lt83J2huGrJ+?=
 =?us-ascii?Q?v0P2gyGNXJTSIo0nnv+rwmwV6nZKAnsDGD1fm44H1nnBbNa7b0bdNyaOvgOM?=
 =?us-ascii?Q?QvO5uV1WSjzE7q7IKak07vSn4UxsfEl2H96RmbqPzxxvjBDUesQJk0xiKCYc?=
 =?us-ascii?Q?CAhcRUpzoUa9J+/mstXLLG4z+BSh/t2da38QyhYTWiijBs2PMNMLFH3qQuVI?=
 =?us-ascii?Q?Wa5k24PBkFePa8ZnIjafFHNuYKizYo8SP8D1R+B+9bb1MR2PnT3isBWnACGr?=
 =?us-ascii?Q?t3ngVm/xOKg/+bcFpDSvI6Y//ZMuELkQVJzeU/XXHdNdsdAjA7effZnSRLil?=
 =?us-ascii?Q?CVfN6tELx9AHG152lS1hSV39szm6L/dA91NechmxKpR0MRHORvAV5P+7MqPX?=
 =?us-ascii?Q?M3tGYPF1x68Am5/nI8pVPX7ZvmYN5V++rifV/kwfYkgCmDAvf1zW9jRT/OTw?=
 =?us-ascii?Q?V+GOfBPeyIx5vNIyUg5dRAqc1JPO8ERflMnzFxY7sFV6NmEK64xHyUhQbt7b?=
 =?us-ascii?Q?G2kPu3so0qanRqoYNa+CLn78LzG4QFuW0Tu/8Ps3SdL7DqQTJv155UOiSkfn?=
 =?us-ascii?Q?scNmrQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725523e7-e470-47b1-27ca-08d9daff5405
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 03:54:01.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URHm1Fh8k8RybAAeTGX8iqji7T/VLkYTFkLTXBFKh9+E1RyWim3oe25jhjncoz6LdITnRW/YWlnDGNp4IZgu4932p+p4xE7rWlEXW5ioRE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3979
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=996 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190017
X-Proofpoint-GUID: Y6MpSJHluJpjQxo0dnxoGofl8r2yl-bb
X-Proofpoint-ORIG-GUID: Y6MpSJHluJpjQxo0dnxoGofl8r2yl-bb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.  So, if it fails, the 32 bits case will
> also fail for the same reason.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
