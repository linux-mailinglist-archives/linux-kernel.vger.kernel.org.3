Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3116F493F71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356563AbiASR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:58:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37814 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346442AbiASR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:58:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JGisWk014084;
        Wed, 19 Jan 2022 17:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Gg3o902ikdWqCIMDtRLuyuDrLykxb9QO0nV3ewZxr4Y=;
 b=FFhG93KldfBbdxvRGuU0wH8YhAnSbA1lgDgwv3xcKQH7nSJLRsbq/k/JjJ4ao1rsLeSq
 EpYdebCyHULRXcXSK5FGiUIEB050sWRfPOmVCWjnps5RDa6saQlgdGTIXf7Uv/ZiJFOF
 nop4+T2fLtC9UKSyLwrmmmrCjVgTziymMsKOW9r66R9hUcOxejFQVGHPImJaaKEb/ykE
 c8LCRRRui7qQgoD7NB1W8wBDceUFlLkA8MoqWkaZoZMb+a1J1gtiYAlomsDuRaRClbVd
 xoMsQ2CrLre+E3m+tvNujvo7BYImWon+qnzjmiXNpSn1+5gydZWeSCpIu+tNtztQL5v2 Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc51dn5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:58:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JHovUl183252;
        Wed, 19 Jan 2022 17:58:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3dkmae1wr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STDkb60/TNQOqydoeH7j498liq6ToDbYoui9ItCa1GST2O1mxEkaOnvbKaVks7JCIfeQjgXc2nMfvQFP0zQLzNzbXkCq7ReEgKYUQkgi8zoAGEuta6h91qghO5sS9qeA6gGcf1daas7lex7R8iQTAOAfVdOjiHqECzRZpEuIUdJMS6GcUMQTMtJQpc1kq1RlF/74NDSUJiBsBomH6xwGbiiD0rYqg3ecawpyLkaozAaaxk8Scj5dmLal+b+C1ocurMblk38xYudzT6fKx3JZZ4pZYVQRrNtptl2LPZ2Jv5rfp5EjcOFyUoFU3UlkdN1DKWl6fFIYf4DaZ4ynhtoy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg3o902ikdWqCIMDtRLuyuDrLykxb9QO0nV3ewZxr4Y=;
 b=LSLaSOtyqIIbg/3ApcDv3s62407QHOCPEhNTrrxEasjkt+axc3LFruPfuXVJJWxO/GldCP5nSAwsnEO8CNtplFtR9yoGbb+IS4EXWZkP8TZgybWkVFNv1ECVnO+qoYHmM/N3OjBuj6c1SwNjW//B/J+1g3cgv5JJ0JDiAI4Pv8BRXV/6xbJMOVjIrEwVrS4HhzQvMT1xg2VQXTSjUUWmBFDHYhuhFib5eq9FC/QoNZFNuJq8Wryth6GdhInuPpbD2yk3bWTwIbqb1Hf2foq/gaV+OF7mivGAWYZkGBnXeziWqitaR1On3+GHwD9ZwynAVBVfiFAdOBQ8fOqoSNb9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg3o902ikdWqCIMDtRLuyuDrLykxb9QO0nV3ewZxr4Y=;
 b=IfYUmh0vU9zmFcFWPOpTXI2vFhlP4yLiKk6hiiB3bXVGy1IU+YaPPARbNBx7Z+1jFwXNOjd1++iqjDGoCnjDTqIZ5PVKhWBUxxJ8Ka7+gnZ4LJLuNpC2XkWCEcb+zoOPK0cEhi1bUscIX4Mch0ssy5h53/gp6Du+qo/iYkcTSXY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5005.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 17:57:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 17:57:58 +0000
Date:   Wed, 19 Jan 2022 20:57:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ajith P V <ajithpv.linux@gmail.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fwserial: rearrange comment to avoid warning
Message-ID: <20220119175739.GM1951@kadam>
References: <20220119084159.5759-1-ajithpv.linux@gmail.com>
 <dd6c45ef-70a4-9a54-affe-2bab17e13ce0@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6c45ef-70a4-9a54-affe-2bab17e13ce0@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0013.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd9a48d-b2d9-49d6-57b3-08d9db753a19
X-MS-TrafficTypeDiagnostic: DS7PR10MB5005:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB500581D179B26B8260780C138E599@DS7PR10MB5005.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSTMKmyw5ngSiCoMdDfRxw44nYyKpuVU+N/KIyU00+ZaQXppt3U1LICj5EjuLMK/7HmqZGeoQ3hU8ZPGk1b+MPIE1dWeGl7SiODY0Reg5nTecBjnf9HI4pKyxdp+B8hyIqBvUteYtLqN79QV9HLmOzeczmKd9BsXn+k5pQFPu1cM9zRvJvZ0Ucs1TztwrMUJY4CMg115uRmK3Kydhd5P8U1qCArDozsabdd1b9Q92lgH4/0iiMU+OcMEiX9V204BVII7Ki7tP4Hu5kVub2v1RwappW+jl5vA1hLEwxee2Ol97m7RkeVYwsczVKKVnoSuDdz7Cu5cAz3HZb0DdxWq/lEpU4CMrpk8xCseWwP1yV6kSs7J//aUf0Fo8mPFbyVQ8+bK1zhqTxzgWxUk/NShWmnABt31Osto2HYsMYDRRJeusAsiAEpbWKSw4sus/gquzWWuwrq2cRbR7HRRljgpDw4cJ6wPJxFE8mEmGYrQzEvcTdKQNgTYk/2Z+dIxyhZa2+jdvIOvZDXDvJAXHRwJnB1LvLp17g/Q7Tg+cgq9XkUS3VktKyLgPE7KMdvT8kSNs+PLBLU0FawgCuYw5XCNRQAfRUkCa/XGWiKf9u0moPr66UaVQcDzUgSCJK4Q0uPeGq0CdXy15CtqNFAn+PbfOkz5Bl/zO8ynHvG0ZbaRUdbLdr0pRwbhHq8Zwrdl5BK77a++NdKC99hgfvaTWnGfIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(52116002)(186003)(26005)(5660300002)(8936002)(86362001)(508600001)(6486002)(316002)(44832011)(6512007)(6666004)(6506007)(9686003)(6916009)(66476007)(8676002)(53546011)(33656002)(66946007)(1076003)(83380400001)(38350700002)(4326008)(38100700002)(33716001)(4744005)(2906002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WK12V0q0l9foSdRzdbgg0aiy/lNRQ5eHtmwTrZpVU4Qq7xuLGoMzDl2qzhky?=
 =?us-ascii?Q?6LiEMkr2k51dtedtFTqSjg8yCeJSoUPT6l3f5Ji05j9h4T8emg4Bb50IRQ6D?=
 =?us-ascii?Q?Zj/yIf4RbiF6iEjAzmh7+oeQAp+LxvjQMZaSPnbKDTfthO0i7w+JN6hjj8K+?=
 =?us-ascii?Q?sKwqAvP7lau7R1hgCp1IREtwlEEYxD0nWdgAyyNb5IdekrC9lexZ5gbpSs2v?=
 =?us-ascii?Q?cxsRBA3GvA0e96jwWCeI7drs6NtD4G15i1VmALXUofEwMYblmF6MYl0Ogcox?=
 =?us-ascii?Q?UZUGoewi5gOyxMke9wbHVcbsC2duQz+CFJFr0kJk8I174QwXk4BE4TyFupQi?=
 =?us-ascii?Q?wOvaSNRkWz3us8MXAmM2tlQbE9Z1rNIOsErnS3sE+smnXeuN0z4otOzeD3TG?=
 =?us-ascii?Q?m4xmD7l7JFMLoWsYCAMcHN0kfxd6RpUkCF/vIbqLiEeaGFn/DpxZn3dBGBbh?=
 =?us-ascii?Q?johqFoOeVmw6vpUY2zokf5TQp/6EpIXUeZxFt9v9YKhfu1JTS/9eqpyoSgKi?=
 =?us-ascii?Q?TkqbtsTa1W4kREN4nldNAGuzL+BL8oztLv8dqYiNooA5/F1/4hXdcvIeG7a2?=
 =?us-ascii?Q?EhZtfMfaJrjxbOtFqe4ICL44TYdIjWpE304C/qlLgmaVZ1j3LAL7Z0INHts0?=
 =?us-ascii?Q?I8jEqOzk3dzY7nZvjgoCYwk5IbZiryKYqXyyJTvDcyqwWMCo0MsJMPadKQV9?=
 =?us-ascii?Q?12NohPrG9TB0sYl4rs/3GVSanBzWAMrx+EO12YixfJL7yovyJBAVIo8a+98t?=
 =?us-ascii?Q?/msk+zGr7JUwF03fymkLCN+G0P2O/QolGPcCOpKjAArClH8v2el2gGJCq57V?=
 =?us-ascii?Q?SdsnBqCkZQpQ3qsDwASq3CmZQYfa440iloMGJulXuUyP4FJkRmSVyuGZGbd3?=
 =?us-ascii?Q?ylSC3A6ZlRknTS9Jh7BYyMvOKN5TEycxociIIcxkfZtjqAQS9lmjvVfwhVVI?=
 =?us-ascii?Q?n//jb151pN6KUKzI+jiP7ZDoa0S3Ag970aUyjW1/LCC8bwpXwLgsRlJorhxb?=
 =?us-ascii?Q?Ucas2lWA2wV+e5iwEwAfXE+ecJaMVmf1BJJ+whFaV5J+K48MKLy3GaN+ZUei?=
 =?us-ascii?Q?mE8/FRDNbhrgSPNz5WiH05w3TblUrT1ZyMYz/r6I/KK8KJK4NpeLWIIs5Eeu?=
 =?us-ascii?Q?9rVjxO4ifswLn8rolWU82WFIfcNuUW0LqqqR5pK1XvytxvLfLeXjbv6Ky19W?=
 =?us-ascii?Q?b5gCQU/ZkZY3UHq8pDPBOoH3rN2cqP7IO5wbP4g74HzNN59mRSWg4vXyZXyq?=
 =?us-ascii?Q?qA5Uu89oHNfmst7uBZh3DEAIOtJsDxk+LelkzJLmaQZgeFyHl/3j+LXlIBna?=
 =?us-ascii?Q?Lq+zWiw8PxzaFrDfsvR3s36s32DsmUxoCwJZZWqD52Y5EdnDoL7ncBH67zgR?=
 =?us-ascii?Q?aPP5kQdp7kougVet9mvHYaYBGqFY0Ml8kOdLdM4jRByxwapf8BjpGmI5dJZi?=
 =?us-ascii?Q?u2f6CS4MS2cYB0Q1IlmIpx+8w+wuGkqoCWdDlbbnNO0RbENNpvcIkl0YmyIp?=
 =?us-ascii?Q?OGI+Q9jxKHNRZN9IPCE4QbrK9dJLFawV0fM6QOtwNFnm6dfdOWauf6+7ppqv?=
 =?us-ascii?Q?JPHWqkd4l1mQ26ng6r2Z1F5h+HkjIBQOhdfPVK0BlQdSd4IlorwqIgffA8qE?=
 =?us-ascii?Q?QfAkg1lcdM8hD+jQOFsiAAJatoxR9ZDLwOsruNR9ODcY7nlJ4YYIxmVV6TxQ?=
 =?us-ascii?Q?bHLd2Z4LQ5ew6FZt+nGQU3M8eeM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd9a48d-b2d9-49d6-57b3-08d9db753a19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 17:57:58.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujcu6pa0XkS7cM6oSbIHZjl7fuKCUNYMfLlCYBOz9BBvI2zhYfFYPraOjz1oKGlaa85MR6eRGRBhbpEuZUQBwpoJlsAQ+5w/kO1Slvgkt0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5005
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190101
X-Proofpoint-GUID: sgKoNk2Ir_QUuZtIE397LYnGQRxnC2iI
X-Proofpoint-ORIG-GUID: sgKoNk2Ir_QUuZtIE397LYnGQRxnC2iI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 07:19:24AM -0800, Randy Dunlap wrote:
> Hi--
> 
> On 1/19/22 00:41, Ajith P V wrote:
> > fwserial.h comment contains word "bits" 2 times together.
> > The sentence required this however it produce warning.
> > Change the comment to make it proper.
> 
> Is that a warning from checkpatch?

Yeah.  You're right.

WARNING: Possible repeated word: 'bits'
#207: FILE: drivers/staging/fwserial/fwserial.h:207:
+ *         bits 15..0  correspond to TIOCM_* bits
                                              ^^^^
+ *         bits 19..16 reserved for mctrl
            ^^^^
> If so, it's OK to ignore something like that.
> checkpatch isn't perfect and we know that.

Yep.  Checkpatch is not the boss of us.

regards,
dan carpenter

