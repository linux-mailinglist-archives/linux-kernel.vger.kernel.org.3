Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1144A462FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhK3JkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:40:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39386 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235582AbhK3JkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:40:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9Xa8T028197;
        Tue, 30 Nov 2021 09:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4n5b2gOTI6z3NO8Y5BaXe5mlXzA4jwzbzYv7fj9kPoo=;
 b=BRhvBUcSgKEiSTZbR91C8EOPj4Fuv43KTS3dqRiXyieB7TgBi2vci/JUG7mduyKrPZkm
 VaTk0e6swYY1NJaXj+/145daHmviagBtI/jwIjqpMIxuKZC95Uo94Q/QSNwBEQ/qp3u5
 vGnQia5lrA31wnP9h2lih11dq3a+m0brS0yWtqNEdfqbbTSdvlJxKyTl9tKLLWr+tapW
 JAwBSUisyz+x07PKysnl0cHfgxrsBpE4x4JN5fCA/eYHYu/+289mw5z/dcXmi0t0PBiX
 gNRhr8P6mw9VUga485aI1YOiexEXy4mMZciB9voFpOCI9TiO/HagIn46ZNici+xXjQGX bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wffxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 09:36:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9Vg3W157099;
        Tue, 30 Nov 2021 09:36:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3cmmupndvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 09:36:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR4JQ7LWhxXSoh50mOen5KVNpYmPYlAaFPQi4mAcV/6JYL5NFRd7yAUEGDXCiJd+8XbYuQv2Ujth/bfYRQ0dmaJaWpvCciAf4YlPUMLLJE0zsBTSYa5hzrRFBQdIVr7/xP8ERewS2GbmvNe5NdVEm5xPIz8V3XvBah9Im7FjUUDqBQGfQ5MM0ijGZlwtZOxdIrDSyu/Xppm2D+Y2StjXyfcnQLwvldlXVdsijy4YuKfQkxJEDNC8EXt1FVUm1HUQCnS4d/5m6jlujhCqKCk1WU9byfCaRmvKXtG1kuQNhChVvDhrCz01tQdFVpZs7xKYClqt0z3ylRLC42umlJX5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n5b2gOTI6z3NO8Y5BaXe5mlXzA4jwzbzYv7fj9kPoo=;
 b=N88BsUdSYufBOgJVeDAnBlgfEPaLINpQ3YULdD57KV64ZI7RQh6nVCR3zJfnjqGAyGTFU8sPh+xwbwNdFRV7LL5WykX00Udek6t+AdnhwxKCdBf9pLrTGeTdlRKHgY1iQCjpz2aJ+onIbqdfnFA3jGs0oiYnYiJF2Dck8nAg0cl8c/2utTctwf1Qo4eZcObdMjiqnABhk4gMgu9wpv5xHvzAa5hBvo8TlsTf4ZyFMRpMuwhpE5Aju4Ddw+BbHAg7Zdg+UqpnhTJeLBUzkNQVaCUTMc5TioL5+v6x7trWEz8ivM2IxC4VtouccSTXh3DPYCeW4vUR558Lv8bRvKHpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n5b2gOTI6z3NO8Y5BaXe5mlXzA4jwzbzYv7fj9kPoo=;
 b=yLq5uLrVYe84Dxw/0lv4+52wvxtJatPogKdkA2GLjxSO+TWPsrb5Ai2lQ/PCnYmv0aZN/pba1nfQj3FbwC3sTZhkTtZeLIwhsXaWmSI9od2GdfUHNH2RmUyKkrZIU2hhqHesljvF3o43QGlTGIggY9Nsk5v5guq/HNrKEM5AvPM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Tue, 30 Nov
 2021 09:36:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:36:04 +0000
Date:   Tue, 30 Nov 2021 12:35:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     davidcomponentone@gmail.com
Cc:     TheSven73@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: replace snprintf with sysfs_emit
Message-ID: <20211130093544.GS6514@kadam>
References: <21e2111f6c2590ac24ad15d39e87160f9425045b.1638186054.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e2111f6c2590ac24ad15d39e87160f9425045b.1638186054.git.yang.guang5@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 09:35:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e7a8df7-0fe9-4be1-4e9e-08d9b3e4d3cb
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-Microsoft-Antispam-PRVS: <CO6PR10MB555512F13F64E4EBBAF299048E679@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83O1UVEhaJoeILSgx2AgI/V93mPvGmxRHNZP5UhuY2HjGyF7wIcZayxFaXVrNim3rIfaFF/4AOm5foGnbFUpL2dQyu2w+ydAuHvS9vJwIOtqYtyukTuNSx5m5AjYTCkLzxtdhvNwKwWF/1mrx5B+3ScvTxcD1uZp0GdAxG59/1HgCshu0mQvRZiQBC+nm0ADvgRikdGj87wWfFuThb9Zve9yj6zUEvPUWl8U2fD3LdenI/t4ayz9JD758vN2xxZ/qWnA73FpfhLnf8ocdyQCwmfY/L9owop15gu5TEuJkIG9JD9QlwXyF8Zh+fFAJfDv+67Ohzz53vzNxlA3VLatrcQ0dmyFNyTlSH8SJv0wGCHZvh3cR0m+cvZNindD+/RC1pfKOVXDl6h2gCu22Uy/WcuKErUtcLn6F2orwtIkjItwh7OQ/vhdkFzGNwkIJnDK/Mck71ualrpRMstvrJ8mPXDLcj1C5dDD1WoQrsLlG+3MZykDqtQOyru7bUOUzeS8pKCbDJfvpcZkVAGbsDGahwpgeM0gXR9Jqut+iLQH/MFrFf6C7496EBKzethUTomTvWx3XwpLS3clkFAPEAJakwErSy3eZJXC8qOzstkR/PHBRbbHtY6+7kfdCgzPnLryHq+Lm7Uno51F70CyB5F7ketKLuwPb8twfhbPTZEVqSNkQLkBQ/471RyWsuREKSPDX1AoSeJLEeW9XHFhYOi8Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(55016003)(44832011)(1076003)(5660300002)(956004)(9686003)(6916009)(66556008)(26005)(86362001)(6496006)(33656002)(54906003)(316002)(558084003)(8936002)(508600001)(8676002)(38100700002)(38350700002)(2906002)(9576002)(6666004)(186003)(4326008)(66946007)(66476007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZAIm22tQDMREvorMmAyQNaAfA6ap/Gj/wLdUXfYxe2hQUrUFjTGNPyv+XGYf?=
 =?us-ascii?Q?GbZGkNVBRxX/+LKPcfdB2oVrp8zn0n5PSVH3DIjUA6+RZ8fkO1LwKEhRv8Qg?=
 =?us-ascii?Q?jy/PeUWLivxKlZPzFvHQIWv9WvrvPtlESEX0qf3vHMS1Ls1w6mNQari2gv2/?=
 =?us-ascii?Q?O6tfHupW2ke0Znrrj/yS4Pfc/nq6GTJL4XTPtbUET3BgO7bJId4Z962TV7Zx?=
 =?us-ascii?Q?yGTgp9YuVBEzUM8AtQtVs5JQFZVMw+uL55DIgWjH/KBbXlpQKyYQGUUpVRcu?=
 =?us-ascii?Q?v5BH4qIYRV0INhkDSO7NIKkA0MxfrAwIAU2HOXJZJpsIWtxUnbFdJTZz2q/h?=
 =?us-ascii?Q?IdpNJiwEwQ+RMHHGKX48wMxXsMXfCpU1wdRqpc+gzkQBek857lMVrBEIdMfa?=
 =?us-ascii?Q?f5fUWBJWlKWKfBJFLHE+L92vffw7YTzwLEKd0is6mYMFtuaBeZg5sNpbM9HX?=
 =?us-ascii?Q?9xfbXnLorTqAybXNtxwqlHJEt6dZ/c4gwdFcp/kfWTw68xGpPpT3aagI/TLa?=
 =?us-ascii?Q?YYx+baXF80dLxc2uzTiT29sx5S3NwyKxyZ9lT7MkK3+0LVsj3sddqUJ6QzqR?=
 =?us-ascii?Q?D7RogH8sp3cDSQCSnvYjGWXigAhA/bIOwUU9Nxl6IP/7GelSUya46M+sFYyO?=
 =?us-ascii?Q?0e5LkiSVGjsBimVDDZqqJklgu09FtbbjPNAQfUCTfKgfBuj6nsuWgKAtp4fa?=
 =?us-ascii?Q?GHXziHpgFISFtDgCrfMcbd6Gc6SpH3tcgTN25tw7o3v5uXqQyG8IHzxvyxZ3?=
 =?us-ascii?Q?sHLDiU1WeNuv28c9Th3Fakb9kcgouIMp30cARpZ266JaqQBxjCuQLbMTKO2e?=
 =?us-ascii?Q?lewDZC//bus0eGLxO1mJuNe14jWHsfUHnFLvSI6MxQoJw9SuPkgJZsWi+wK1?=
 =?us-ascii?Q?2dPbRhxjZPSaWvc4a49hvtHpvkcExUizMt3xEOvggiC+HCDpV92iE5Q89WSD?=
 =?us-ascii?Q?+Zg6MbtJbDt9QrxFg5ivYLhCIECGc4+h4xIehxbUee13/CJhZxxS74+CxqKZ?=
 =?us-ascii?Q?CRRlYS16Y2m/GUDfjOiZ1967DQxzAUvCgzUmw91b2xvsIDtrWofTpCHiQv+W?=
 =?us-ascii?Q?7zzBc26kUud8NvEIQvytR/4FTt9mDkJyhVlhiNazxvYFMUX+IygBrgDVBqke?=
 =?us-ascii?Q?E2IBZPLCFOt9o9XpoZgXn3jgtYuh2+rsA6gMSwI/zr+6ebQjMYoqmWrU9cqZ?=
 =?us-ascii?Q?7cqdI1cMiFaqo8qJenZgCXm+TxcMBfiXoA4NHufnU1pl0sw+tRcKzEDYydxl?=
 =?us-ascii?Q?57Oy4ybc0V/vf8+sUlOe/hRhoznI12cj1274IsubVlXRLhUIM5dxfugW318g?=
 =?us-ascii?Q?v/O8g5LzCEP/rh/09IOi05WzDUyXXP8iwPNHzY1VtLaIGYn2nrGro2tEf1av?=
 =?us-ascii?Q?Ob1pCeZmgrDKlpwcl0kCKuJbQdspJryWmVXRZJJbNHg5vXDIV29Ra84Fn2mq?=
 =?us-ascii?Q?zxR2prHWYGqjZGzN0GX36uUBCc+SiW94jTAjPtknpBx83WXlTbt7AB0hAgUn?=
 =?us-ascii?Q?b/Lb9mWeOMRthZJof6G9zP/PKvwVNT8gRDw/S1r6vx36ml/iPjYjQFd9kwDy?=
 =?us-ascii?Q?CrQGrrriWJtkrrFITGnmHyAMl/A38V6/fdIe4geXFJO0lWNF/kkZfWidzk+B?=
 =?us-ascii?Q?UMEau+liETjDXuyTpcbjWAL0O42YqycUM6Asnbe5YbAeFMUr0l+Iu3OzmJv3?=
 =?us-ascii?Q?iF7j0y3RgnJjmiliB2olNKrjw3I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7a8df7-0fe9-4be1-4e9e-08d9b3e4d3cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:36:03.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bka3grmKWEF+60AePtoVUAb0AVEr7ije1c1L7+p7Z9DYQuDaqc8H3Gz21W10UJ9/vUhDeZCJFQaDCh8D5rIiJ+PTg1mAf3XMvsvihArz0T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=634 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300054
X-Proofpoint-GUID: pysHi4YRtPHpCudcfjeyup9X-oHfBFxo
X-Proofpoint-ORIG-GUID: pysHi4YRtPHpCudcfjeyup9X-oHfBFxo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Subject needs to have the driver name.  Do a `git log --oneline
drivers/staging/fieldbus/dev_core.c` to see how the driver authors are
naming their patches.

[PATCH] staging: fieldbus: replace snprintf with sysfs_emit
                 ^^^^^^^^^

regards,
dan carpenter

