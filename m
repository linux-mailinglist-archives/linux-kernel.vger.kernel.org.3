Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAA4C0AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiBWEBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiBWEA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:00:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73261654A3;
        Tue, 22 Feb 2022 20:00:29 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MN8LqN021784;
        Wed, 23 Feb 2022 04:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=i8o97OI1U1jsjj7hSszd63ALT/ODDcUwgTDxj7J+bOo=;
 b=GJM69SJ1YYhOBEuP/0GcDBLEjjihU80CybvjU3a4Z43MD7PuEYRSef3/ej43Bh5FFI15
 LeFU6JrLbV05rrO8bWbw5VQcpvMFXMCTb1idYWcQMlVQJPbZMgR6sXVvx2/znHlQ+AUv
 1XAajXdid7v4aqZMmSNTxFtdxCOvUe6ihhFYT/30cWMBFqX9msgCDdl9qgIBEcLiG4oj
 NDwa0OuK1Ss+2/pYPu4EHAlGjBhh9kJrZVX+k5Q3A7iRxQpXNCY3At73v6GHpJkIzFHR
 7JQmAnoN3oNzhH5s2fk3enhPZqhslbt9YiGDCs1TVNlWRBuxBzvBAihmbxdDTrcK5bES Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar2n27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 04:00:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21N3uiXk015618;
        Wed, 23 Feb 2022 04:00:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3020.oracle.com with ESMTP id 3eat0nw2ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 04:00:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM7xhrHJeREqX4StI4HuN0V6b0KG6R48iyZt2QqG1oUVRj7V1I7yI62UHk4YtRVuSHlq9EzL+Vwf70m4u6ARGs9Vq7W3OA7syt28Olj9ulAZPc0QMV2ipGE5f/rCRKMVJwn+/I1RiVqDmP8dchOsEoIP7kzm+6ZP0xmVntO1SjpTr1N7UhyIsWa7GWRnVDaWDCqsXuwnfnI77ROcDj6bJA+vlhQZ5Wh0+Gq8VT9W6wDyubcyBmPxPYEcjHYymCU9S0tGBDtHLcDSaHlM892sSZPACHBRbwrqvidRuE8lbBDt1wPQbJCehrve59MDVUjJaYipDPT/wuFeg0NisUT7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8o97OI1U1jsjj7hSszd63ALT/ODDcUwgTDxj7J+bOo=;
 b=FVoyqXKuNLRhKpS5jeI1uyiZHowpGuU5dJEMXvZyLT1dziaP9FIpknvCSIw4Zbo6F4gcwrP9GmeDV6YQHxgsVFA3nHvqMic3sbnIgm7YXz3rOHUwmO+KhzZRLyZg7zP4Shfpz3YfzaqFoIssrW9TgJw5M0M3Yyj1ncjK+h5OfVx4+XSda7COvliUjSHxv3WXBYrlzfKCWtOJnCMx7q6aGPCmSTBl1RiSNDJX3B/1p4j51LGYGHxaiWjjVZgyavD1Ebt18Gaww10dWNPjKwgAb4VY9D29x7/BHh/0bsjpYPa3S4535xOodo/aPDAslmxxG4UHaBrJT70uF64TtqujTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8o97OI1U1jsjj7hSszd63ALT/ODDcUwgTDxj7J+bOo=;
 b=RLFy2rSpzhlvs4cPKqhIERhEV2+RuHFuqC61pUVrKVhZHr68VqgHFUtIfJhXbNl8F/28FvDvT0v55rIE+/VJP2107TRdfyU/x6WmSKm2RZO+AjGMGH4LjDd+StQZNFl6M6GA9SkUl+QVn5CTVd+WJrL+8q/rJr5aJwg/HMieIGY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MWHPR10MB1488.namprd10.prod.outlook.com (2603:10b6:300:23::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 04:00:10 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 04:00:10 +0000
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     JPT <j-p-t@gmx.net>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: blocksize 4096 even for floppy and CDROM?
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsoab5n0.fsf@ca-mkp.ca.oracle.com>
References: <e4ab39cb-fbe7-1148-8d8a-5cd46866159f@gmx.net>
        <f94fc06e-c0ff-103b-789a-87af52c53e11@infradead.org>
Date:   Tue, 22 Feb 2022 23:00:07 -0500
In-Reply-To: <f94fc06e-c0ff-103b-789a-87af52c53e11@infradead.org> (Randy
        Dunlap's message of "Tue, 22 Feb 2022 15:24:13 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a5cdff6-b8f3-4917-a717-08d9f680fc85
X-MS-TrafficTypeDiagnostic: MWHPR10MB1488:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB14880B19BB2ADDE460C580748E3C9@MWHPR10MB1488.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxEWUHyNN/cAXC9CZ7qOwLkFKZhB5KkOniIZqSoC4XRUls/o+uuq+8S+eMdYUs/FRDVoMXaPCyLy+1bIago3o5URg7PkHEA8DMIxAeC+WiIGqoYn5ZqHCIPPMo/I1FQFWxIzuOpieTd3GW2kmAeYPbVV0XCYuOw7oBfFWl7IXY2tlX4Ob8vV4Ss0+uEhwcxdReaP0I0roCFh9EJxYjbDagyu/2vznbsZin1FFVj/eH7hNWJN2qGafS8N7ViZdgjItmbsUfPQobRYgbd0HA0MK7oaBScDFFVnNEhYPPr9NhwWuGTdknjyx0+8X+XbM6k+2fxdWUzefMSJZGiSQnnDijnpR3JYX50KkBo3+A5I0lr96+1n/PuZk1AuYx+VSEALFkYPoLmGFBK2YKpaf8eJaJKIr504jQgSTPyCXHV78AbyK+APH3KiXiu7NoBWzc33v3PZr4L9scntCEyncM1hDdj81lRB9WYz04qmgljnpnoTva4lgFiAs3SGInEEQd98HNILCy2b+M7rkIW8fBSv8LR3IbtyPsxqFavd1AaDeq6YMOw6m4nSzWPD5xnRbM682VbrtP3soPDzh8eg3+YkpW4Jn4h47SrXpMvjInOrs9RzhOpA2bZeEKvUrzna5t0vA4KH8uYRQ6ahYS9Ya5FBM/6/lTfKL2MrPVl2u1l0RdeaBWJx8j83H4flsw2nlMEQnrF7QG3++xSkoE649GpyFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(66556008)(6506007)(508600001)(6512007)(36916002)(52116002)(8676002)(6486002)(66946007)(66476007)(6666004)(86362001)(316002)(6916009)(83380400001)(4326008)(38100700002)(38350700002)(4744005)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5g9ql2/9O1BrnxPoesWTrlUkbc1XXBWuwQIUumyRNtx/YX+4gUO+tLZEu94z?=
 =?us-ascii?Q?EQXTQ7V2HAfaM3L8qzsbNavKJB0GDXysMO9108nuuy0LggetDwoyuFxfSghT?=
 =?us-ascii?Q?V+tlHc9q2DFiugkJvTbjLgmfq0xasm0epce5Uh1ObX5ATf64d9eK4uDO39uy?=
 =?us-ascii?Q?ccOU/egxDVBiaSpozCsFz50EfUVKfICQZbjWAXoxn4KcW2mm90MbXPM0x+wu?=
 =?us-ascii?Q?tlCJa7w3JNq31SGnAaAcUV2I6jLiB3+5CdhjccFccrf+zviWSAFk4cae70z2?=
 =?us-ascii?Q?KVMDkEEZYWmAD5uhMF+jSyXDYI2d3uj2CibDfRHyvcsxs4ndAxeN5/0vcS05?=
 =?us-ascii?Q?E2Nmc0WRV6kPyUYXe39PbsH4T7e5cADxLV/GCF01vTi0PsaPy7aEva1RXKHI?=
 =?us-ascii?Q?RHxJfpOwyyC2BiMBIC581gQA7NTBsJIM3UO6dZIh41RVFDu/HGVKlkdhwuxp?=
 =?us-ascii?Q?ZTWb7KJ/LA30PpYYuWZxTKag3Zs+ZB05nyUoPzXwMcULaIKz0/g3Yvl/KOML?=
 =?us-ascii?Q?pP6CAkKTKglNCPZh5TzfD4hnc832rOQoGaqgkLfASPYue13+zRXRmexbkdfY?=
 =?us-ascii?Q?Bf5XdI/i5GlBfesCLW1FFKvhEvI6QpOhkvn1ndRk2P2gyiXG3H6MpJHpJfnc?=
 =?us-ascii?Q?SImyTSITtdOiMoikKMedCFRu1B+XwDHSAHcQN/3j29FTOYIM4Kvvt3ZjduhT?=
 =?us-ascii?Q?h7L4EGxxgEaj2elwtRLueE17TyYNpSmPwyyeZGgZHucXWOpC53wqkjZAtmab?=
 =?us-ascii?Q?JN8SZKNbdIOJHBcFys3yNsRvcgnQcZCh8Yx94NsX7geaUQY8RW1bdnv08ecF?=
 =?us-ascii?Q?qGwKcyEq54PMfyGQzF4yIrJu7BJ6NsXvlxj0pzMnefSR0+2aFx9g0x2kvnnV?=
 =?us-ascii?Q?ro+kuKyRxAPf6WwfHuYdnMew4exWHOaIXBxL6Rhig3IX0Rpjw2KQ2NVTUAsI?=
 =?us-ascii?Q?PB4agMNxtZvMVc5blNKD/v7di7ixjFn89TEMuKyij6YTdUtkufoduRjcaKAv?=
 =?us-ascii?Q?nzMKdugfdfd3vl30TofGBhawaZGDf2MJW7rEnIV/miOsWPY8hKYLYWsC5R51?=
 =?us-ascii?Q?qROxhh0e4V3UReAqM1edNMf+2f8PiCwOsMIrNxvgc3mZUeWxV5tO4M8BpLpq?=
 =?us-ascii?Q?zctgAs513/jDyvDr+H7NZHgu8zz0/xb6VQViEuvTXMheI4cp+MHyJ7/y8pyP?=
 =?us-ascii?Q?z48k6uAt1IrhpPKdZbtavJZzZ+jakNVeuTktrp7SQsJdM35jD23RmWcxckbL?=
 =?us-ascii?Q?6VsEBTegPxwLvlK5EqH0BfVjfz4iZGIxhuB+kxPNZrfmBhhZr9dmJ6AfPm/u?=
 =?us-ascii?Q?IHARhTpgZ3XMIUcVaNrqWUJvRWcrpjI6bMp/YCsM2FI08/AsobKljRPx8ueC?=
 =?us-ascii?Q?jjMxuHfCqTqbZChneu+lRK6NObRcTqAkTR7TZ5dIHHySeRBBqt/7wNpZ32ec?=
 =?us-ascii?Q?ztDo/tVm/Ty35+pbJwLZmRfauxLldoOYjJgOW6P0slS/l+T4Iu2x//YyuohT?=
 =?us-ascii?Q?2rDnWC0xXAra+9qoVagZgS9pYyPHIjk++sJqJG0q+/8do4qiC48xptrwT7Cv?=
 =?us-ascii?Q?smZM0gZulF+5/WvS+xKuaw5DxWjhqBXrB6d1IdPcPKNmCsJBos/yd+juG05G?=
 =?us-ascii?Q?mv6zXc33yvRako1ClcVAkktmLDJ9bPjd+wY0ZAxWVoZf8par4ii8KEuO2uvT?=
 =?us-ascii?Q?XbWdtt/fs9qxvabi6xbnESGSdWM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5cdff6-b8f3-4917-a717-08d9f680fc85
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 04:00:10.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoYid4iBdNsg79NB004yOiSjIB/Sam+1Rwj2bI32DgwDgCQQT+zHIqNC/hDYN5VADr4qKSoZYjej7oHT4L3GEvdTfUIndrvTeAzrRQywG2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=745 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230018
X-Proofpoint-GUID: YRyMkKJPq31jBqvfpaHLRGNFbGUGWzAU
X-Proofpoint-ORIG-GUID: YRyMkKJPq31jBqvfpaHLRGNFbGUGWzAU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

>> I wonder why safecopy always says
>> Reported hw blocksize: 4096
>> Reported low level blocksize: 4096
>> 
>> even if the medium is floppy (512) or CDROM (2048)
>> 
>> is this a kernel issue always assuming min 4k block size?

Not sure how safecopy queries the block size. The kernel supports
devices with 512, 1024, 2048, and 4096-byte logical blocks.

-- 
Martin K. Petersen	Oracle Linux Engineering
