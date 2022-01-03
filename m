Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB7483896
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiACViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:38:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46676 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbiACViB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:38:01 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203K1Oc6018143;
        Mon, 3 Jan 2022 21:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=QN8LZzGCuOO08NvSvJu3oIatZFhVvc1AAo8vkmi0fts=;
 b=BlmtomJqJlhWBmXsxBnPBr5JJYOlvJESusldLt1boVxTUGo5udxj/63YntfQOHc0MzUC
 Zhh/JrTBGWgIJDn5sUsm36NPi+QEL624eUrOC2wt57tXmi5/CVYJFqWHWQAmtWdx7axi
 /L8cZxSmsM9LtywoZ8Xlk2i4vkeUk3bXXAftsdGvrmXIA/1kfSLIigueUzGaXhF2qpal
 WHa5SVvXRliTzMqG1HIyTqBUFIaZLU7oPvOVrXw92MFjQhvrTpXepAvlIvbJa2NJxa/j
 6ZN0pCBlJzkmpvGPn4VinHExCoszs5FQyofYVwH0Bs2U3B5n8aoJ2NtHhGGpq2pz+/4N NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fgrah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 21:37:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203LZYqq110700;
        Mon, 3 Jan 2022 21:37:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3daes2tc16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 21:37:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc3Hnf3nNhFXty7UKYjqY36uLo7Dr4t/j4ATgv7dgIHnLC57RC1n/QlfGtCbLVlXaW/HyXC1wZBQqJkON5OhOuKwVN6ZQkevXS3E2NIYAb9750nalmadRztR6zjmTrrs6MIYbO0HinkG6WagbtvMlR3X+nDV+GtKC28uNjuYoW1TW+pkd5rDNFOoqmXuayrxyAENywRudZZtY543VdXoc5KjtXt+11i82+n+Km8lTRL+dhOVaVBt8fxLXfZjhlwegL/tY25J2wSbZSPHEmADWLev07g1Apzkso6U6/p3qAz2LGC60QfTYmDnin9TUZH7KbdYhyhZabG1AatWpq2tPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN8LZzGCuOO08NvSvJu3oIatZFhVvc1AAo8vkmi0fts=;
 b=DsKszHyCrDM/8+wMKNdsB7f2C3o1hHjkpe0n8+gQlJcg1KBBT8TgMTfqNaZ34vGV7IIde6b83dKPTwj0MHIwvMit5F1LmN2wvEkhjC6Q7tJk4bM3IAzaB/nkQUlueQZJxocJ4Y6wRtX5tZfk2STjXk7mdPU05eXyWrVfiCQys0+ZDrKQ/7a3Z+ZXZqNWtkKV+dn0OWj/iab50rlegudsxaL1QPLEdUqtk2l89JNGlyq8vbboyHCi5JeF/K6mHAn7w6mllK8W8LiRXIC/KvwLFKrB8LFpR00V75kYjIyNyVBYl0T+NDVZhZKFk7WGe1k/Uru3JMHmk9g94ikBWo1YSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN8LZzGCuOO08NvSvJu3oIatZFhVvc1AAo8vkmi0fts=;
 b=pyDv5aH2wK21P35ln9Fz3UlorTO7Go8X2M++L7hUS+ZxEG/f2oo7qOjymASMJqibvCAKiWpEs18LBMtIf2+L3hgCYBQVbZPwKCtbbbckDpaqvODBN+0Ym2QL5UAgwMZTJqxRzBYfJoV6A2eto668+LEgYYSr0anNuDJggtD+lbU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4469.namprd10.prod.outlook.com (2603:10b6:510:32::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Mon, 3 Jan
 2022 21:37:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 21:37:48 +0000
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o84s33w7.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk>
        <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk>
        <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com>
Date:   Mon, 03 Jan 2022 16:37:46 -0500
In-Reply-To: <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com> (Douglas
        Gilbert's message of "Sun, 2 Jan 2022 23:09:24 -0500")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d448a7a-64f8-4d3b-f24f-08d9cf014912
X-MS-TrafficTypeDiagnostic: PH0PR10MB4469:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44695E418A52C5009A336D378E499@PH0PR10MB4469.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERKUjl6hWKTKYgv5V3buScEncXKPaIrBpSaJoT+vgAlpbUFNfvinYl/NfpfEYdIsPFlTKzHjxHyy02EieyNq+D6y+zYC2XcBXqhRyZ+xzULjy90eFcqWxdQH2BrcbnJsukeLxoeiUne4/B9YtiGomH/YATwR+caXtHBKqespkdT7wQFHoMArGKq3lVcr6Nttdggk9tSoXdm5P6bgPyxfYvHRzG8FUCUiBl4IrkxPtF18513HreXE70vEf8KpRc4eITrPRguYCyY9oONLMv5oHnheghlunodzyvwC+laFoQp4fOHYm52tOg6EWJU/GX8tH93pvYHA84/UhMUGc4mOQa1Wn6yYfUOnRu+Ti3zY3g9eFcZwrLMthbW2XZTufkzNiG+jqdUOsDyEnt2pzOMQQEz0P6cmsvTXxh8Qp4Gmm4CdeZB86uxKXvrxHsiTPbEq8lG4Yxp6e5XQAXNksr/13vqqeIFbMvrv/8+Z1UAJpcQ484BfCwM7rn4MYCLQkiIJLvdg3JFIhapHk4kTrsbMP2E6OHmMsIreoEyuakXeZ/yWyAJoFxcj7S8bu0QL/ZTeG7enLi1OPJazbyjrhOeqTy0y2IktK2wJO4YdfvgPbrEaLXhSz97anxxRtGyS37kIwwZJ5Ecu6oU/Pwl9SZojT42VDgh42y5+L66V4QfACPPPaNJzgsxGPgN1G8FqJ5hGehPrm7LqPzA46RSRvoYlLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(508600001)(66476007)(66946007)(66556008)(4326008)(316002)(54906003)(83380400001)(186003)(8676002)(5660300002)(86362001)(8936002)(6506007)(52116002)(38350700002)(38100700002)(6512007)(2906002)(36916002)(6916009)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBg+iXGt/vSYm7YXn6363ffMABNsP9RvM+B+4ogWMGhGx+d0xXvpplC1aett?=
 =?us-ascii?Q?bohpLWkj6s+RPjl9UXQ8HbYnW+hLOOIOhD2iMsZBIeHiYDRLH5kpJK8kD/XB?=
 =?us-ascii?Q?Pqgi0EWSTv1C6mGuXP4lUgKwmxivqonfM62iXQI0sdBsCuHdrxYCaG4sgqmU?=
 =?us-ascii?Q?z0BZeuzTyJh1hxvTPpTP2PW1r30ED8oR2O1xIxjKDN1omlzeGdN/KXmVqxxZ?=
 =?us-ascii?Q?Nehd2sfQPdiS1/gUxwg6SA9IjmyvyQ3Y0qUjl24SJ4WAKNCu9qNKXSBKFjq8?=
 =?us-ascii?Q?ZtXt7MGTV2Aky75Z4wuaZicPXQY/TCjG2SXGTVl2viQp9+Rlt3PhxGe+1JfK?=
 =?us-ascii?Q?5d9j5llQ/pRjBaFvB+yJNAVkQaYMSkqCpGv4a+NfFFHRNA+zrpmXSsYFMV8k?=
 =?us-ascii?Q?gFPBcSZJjEOaUvCBQrMh21ajnu9uw2bvWRcjl2Dw80oaYdnB5nRJhJbggyem?=
 =?us-ascii?Q?kfF+umI12+iwEJhR+lcTb7j6nR69cM33KJ9MYMPaRBEsmiVCysLYkfUghjJ8?=
 =?us-ascii?Q?WXjiT9DYSXnjH2mX94Fnlo1BPvgjSrJt4MGsWKjku+1/EK+oiE52TWxzHmAI?=
 =?us-ascii?Q?7vdiLEjdeyQ/OJwGYpnqU32NVbZq002m4C+EGpQq3+BhUPWauypv+oiqtcBA?=
 =?us-ascii?Q?jVG0pN6UhfgUos/gdgnXhbl4Ge8wFcFzu80xGcLIFTKDzFOYBxT7XjSQAMy5?=
 =?us-ascii?Q?KuCp5qShADmSib6wMqAHAHyhUAP6soyASi1LIoO25HwYubE428gLwhE7rLHs?=
 =?us-ascii?Q?ugnezTQhUpFVY1AhvVCo0G5aYb7amIsOUPKCgZZA+Yew05dTzqXvTZRiLQBB?=
 =?us-ascii?Q?NCaBkAyYaaz5/iB+ec/ZUtElHLrJD/vOKuHyQVapCLnu/7SUUWviPI5Ho167?=
 =?us-ascii?Q?Q8Vu7zgIAa17taSbzvzpGmbY2v9xXsw00BRyPgWnTB7L3tGTrOsA/ISrMCXS?=
 =?us-ascii?Q?qBHEAT4nUe1DLC1G+oKWBqMtQCmbMifvCqfymnp+DSYl6rXP9ZTvAM15IVVc?=
 =?us-ascii?Q?t5VyjQsKUpJBzYrqS33BMuS/fEH88QpPV+9NrNygTsdUTIngmHmpWO8QobGJ?=
 =?us-ascii?Q?YuhDqUd6cNnvAZhMj6n/m2Y4qF3qPNVOxwQ1hTnMOl1qvGwtBWj5x55uc0JT?=
 =?us-ascii?Q?IcwjF0602R6cGgwVaEfEFkHsHxhlgm3Zd8WkX5CrLYXT9B6D9/KRLDONXjIG?=
 =?us-ascii?Q?VutsV3a0A1A45WoAQCRiqqnbC65KsJ7SccTL3nEfTn5Sp/IFjQVolNmp0b7D?=
 =?us-ascii?Q?C7ll7eBtmc47YygmV89ubMAMaIWOUBG0mPsdGT1aO1CpYz1DO34O0gjdvzi/?=
 =?us-ascii?Q?CIyDTEawgBrsF+e3jLpOnjI18tlLj52AhMPD/BEQeAPq2NOKUEK9eqNy2j2n?=
 =?us-ascii?Q?0nniS740Hd7ijxiGvaEZSDONqCFVl+tYZ9h5cRNAraGerwkqZm6IFJqTHb5k?=
 =?us-ascii?Q?96TV5G/cnFCH38xnU41oRX+vnHraV59ojJAVj3p94AWElppPuZVhwKG0MgJR?=
 =?us-ascii?Q?OFDrs5krFGglbbE0kD0g6D9BYdKOAAw6K6856SSmDddWwXLPWsmKelyLJ14q?=
 =?us-ascii?Q?6aTVhrcJkgw0x5xvc0At8BN2CfFjWIaqDaCghBc5B0Wegxd3mF/NqkF3lGCE?=
 =?us-ascii?Q?+H2AGxjrmTs3NldZ6xcw8V4qzYqDF+FxkmzRZc9tz15H7OeV8UMNvjtxpYAb?=
 =?us-ascii?Q?jhqTRw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d448a7a-64f8-4d3b-f24f-08d9cf014912
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 21:37:47.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCh4Xkc0LdGQVoT8x4wLgy5tODZ2PvPksmgZkEAZ4vsJx+sQLe7mGnd5NbraAyP8Bk8a/nKqdioygYknxyLgK7+8vN5QRWgyW+itAVvK+Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4469
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030147
X-Proofpoint-ORIG-GUID: 7G1htgEEc4OVVXqhEiovV4cpqsUGbDPu
X-Proofpoint-GUID: 7G1htgEEc4OVVXqhEiovV4cpqsUGbDPu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Doug,

> sd_read_write_same() seems a strange name for a function given that
> it is checking on WRITE SAME support. How about s/read/report/ ?

It was chosen to be consistent with all the other sd_read_$VPD()
functions. sd_read_cache_type(), sd_read_block_limits(), etc.

> And calling scsi_report_opcode() on INQUIRY seems a weird time waster
> (it actually checks if the SCSI version is < SPC-3 or does the check
> on a _mandatory_ command).

The call to validate INQUIRY is really to check whether REPORT SUPPORTED
OPERATION CODES command is supported.

> And for modern disks scsi_report_opcode() is called 5 times. Why not
> call the REPORT SUPPORTED OPERATION CODES command once and cache its
> result? It would save 4 commands in every disk setup (or
> revalidation).

I have some patches that clean up discovery and start using cached
VPDs. I hadn't thought of caching the RSOC output. Will look into that.

I held this series back since I was concerned about them clashing with
Christoph's recent revalidate changes. I'll get them sent out shortly.

-- 
Martin K. Petersen	Oracle Linux Engineering
