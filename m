Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3B4861AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiAFIwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:52:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20388 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237097AbiAFIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:52:32 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Xq6c018915;
        Thu, 6 Jan 2022 08:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8l6I8bkWQFIM9/cNHM8XNSfHTqI83aJWs3Qvu2VNB10=;
 b=rwG50ecNRvGHM30lZzqhVjJrGOujEk2/uZ0fbtsFBIiZeYQr9peZVBLiv6Qhma2OA0i4
 g3hiank6IDrdz/UQEuqjVS3Sz4i4iX3KPKoBjh4CsLt9leviIaGjo2y5jatrfkd15TJT
 HR6w/7XRhurd57/g9/3Jf3nGtrNJL3S3M9fCCUjv7sWv3c3QvwmId/ebPUg9jiu6dGL7
 Xi+9BY9Ax1SgL5CKJxeItFXaxLhZPFwTuU0WnfYxlEkj+sR/dxWQHVq68RI57FygB1Ah
 zrlcd+DGUMLnIOIzORJfkRJaMutUsmDVijTyh+7OrkOXEr9E7UVoNulmbKQMDvyj0fLB rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpp957t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:52:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2068jKHQ103798;
        Thu, 6 Jan 2022 08:52:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3ddmq6cukr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gphR3GDLbpCq7M7FLms+ji5E9CxhOd6X0IKuH3xD9gEkOj9HJ+5sIHox1Px0g4AJRbq1wQN8kHQbqKo1aJbNZ472OX+g37neLDUMCwGMtQj01YG8/kuCCewr+kv/vFcMKgUpQ5Oo7ZdEQpxtQdqEPkFZQFGdM6n31cEM8mkSvBM2LguyYwTamsO5A9pA9ROstG2QAeDUznom8ER4SBvlNZyUXcuydH0xQQkZ71PZbcWysgMJkTcsrv24DWaV9eaq9Rv7CMiE5UWU7ZWjeIsJC8ANvDYeDNY/fJ6SVRGfXPq5vKdkS5eyX0SqXsA7jksF/xPMpJGYQeF7IwhRdZgf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l6I8bkWQFIM9/cNHM8XNSfHTqI83aJWs3Qvu2VNB10=;
 b=EJjFCRdtMSKO5NKDGS8Rtr8x7N8PLoA+PB3vLLERhUyTF7UjPHp4jivb1W544zR28U82zlaZTED65CEDMheuE/K0nsLGGa5rTlYcbiw/CsYAN31oLcE2jOKNGTrgk/8aBgc7ENLNyLdtCIQbWI+oRr+i1uNvnQuR8niXXpvygnthPaNWTuBskE8Lyk42++9u/AKy6qbZ25dnwac3G1ZFlu0Njp57WO9xTznklGq4TVmJ75uYrA+U329l04tvIK5YGZ3SllUMGhUwzQ7ymXj1RumMbuTZ4Wtb1k39v93Rt4FqQCoY+EC3tB6CTLWDLkLJWoZopovj2c0T9ix9r5H6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8l6I8bkWQFIM9/cNHM8XNSfHTqI83aJWs3Qvu2VNB10=;
 b=ZMbnxUup4yNUBLl8QHzSJx4h+qIk1wgzv5PY6c2R4ATHNRu2il3n6F4Co+bmOLrOhwoJ12Fv1bt/vXh4RlIF8W4P+tT+YUQsVGc0cR5Kn2R3unz9M5zN4ku2WssTt2PDaGrSRKzaqX0hsQd9KcGSXk6vy7qpJRSoEdAYJQfw4ag=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5713.namprd10.prod.outlook.com
 (2603:10b6:303:19a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Thu, 6 Jan
 2022 08:52:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 08:52:22 +0000
Date:   Thu, 6 Jan 2022 11:52:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] staging: r8188eu: remove the private "test" ioctl
Message-ID: <20220106085202.GJ7674@kadam>
References: <20211226212535.197989-1-martin@kaiser.cx>
 <20211226212535.197989-10-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226212535.197989-10-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5409dfa4-8f4d-469b-9ca9-08d9d0f1daaf
X-MS-TrafficTypeDiagnostic: MW5PR10MB5713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW5PR10MB5713A6D0B9D08054E87731398E4C9@MW5PR10MB5713.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfUNlxHs2aKo4RtJu8JKSStQaXHxyj7973DBBldroCke4+N6LkJYLEbSz3IPnZASE4XV+ugZYQlEacgbBJADjX1HZ0G1/u7fJzrLD4I+8LWZ2PYJL7jDp05U2YV5fUcaeF439Q1D+mn67nLONMucm2JVzSaXQSvTfS96ggeC0MK+K2cXVECXgKiKBePf5X1VMXUN7RN11T/eO6I7NnB29WQ/1TSaSQ/ZcUlQPEgqpfv2Hed1VNJ/vScgf1UDEZGB2uZNoxkS7ZBESWQGbXa4VLcmuHYjhVpCvo10OHNPb0HLxR1Td+aIOzalnath8p8X7iyy729dwiEiZqOP6GpmldQF7B5sqp/XpaIUQJaX0M+2fW69TmWhtbLDua8Fbfw7HpV+ukrGPvQjaLsrp89kDtHrK6yJga0saAvY9btcoY9HfvRKNzdvWhiay7MXJWp7hWZCnuAG+ZHgoGpDwMhk0cT56OhpEifLfmJWBwJQSWqSIDLmU4IJGeXBd/x/LVtL8dYvAbyq3c2rr5MMujIJ8pna13LwyqF1uu+Otl/uBW2R2rMrDxLp8BGQApZ7xquRiDlEkiWXPTsqolFeCgQMosy44NYfeowDf4UYWY9osMsoMoDUzljA7gg1DlmDZD+dTuFI1k1D0vxPPDYzn/hQXlHJaBxs22RvGMnHaVs+SXUuctdpfKbvlOdV9Em4IGcD4eTmpNjS6WLw/nU/8f+TPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(33716001)(9686003)(38100700002)(1076003)(6512007)(38350700002)(4326008)(6486002)(6666004)(52116002)(508600001)(26005)(66946007)(6506007)(186003)(66476007)(8936002)(8676002)(86362001)(66556008)(6916009)(5660300002)(558084003)(316002)(44832011)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmO0VGBwPtetpbi9zOB9OZ7Cw1UaTu9q9n/K8pvis+LCLOMuORaLicccx/WV?=
 =?us-ascii?Q?dKiOM2P6wWJRCE1IeFU5rjvu4b2Jk+ZusM9tfvQyRm4d8rU+JBvnwkNIlmyR?=
 =?us-ascii?Q?BidXBVmzAdd4Q9sAb4WEJH9FPyZlsG71NLZB6Nd9VkLhcf0bfWwbca42mBbB?=
 =?us-ascii?Q?G9bXrBdFZzUQXksNVObixBUD68qq4SEtMlVVFIeiJ+0fnfXqY5h1lUV+bra9?=
 =?us-ascii?Q?kzZDWtXHpCniFNnagmVuxufA1YYM3Y4KDQENzOaph2Cm7JgH0aNLoaxonySU?=
 =?us-ascii?Q?nKq4NkKNVoHAAKgwlBZ0Dh136MIq9zAFamQb0pjHg3spYI2mwoHbJ0CIAl6a?=
 =?us-ascii?Q?0FliJDmLS6vZ47/fTFKgdxlfBp6RGjxZ7NvQAGRxiybOcjriZZwhBkuSfC65?=
 =?us-ascii?Q?Sha7ilnhFrOFVT5Uv7MMR95OCFKCmk9NmlrHDKgZV/auJPyq52NigEF9yGXC?=
 =?us-ascii?Q?BSKOd9kfpMIPyh99NAhFscHdwBrVB7pVqN9R6OjKpoj9/v4Lk2Ru2jp7ANnh?=
 =?us-ascii?Q?nlr2pCRsBqkm+G0uWhuAwbzMf/xqByV8J3SDEXR6srW1zj4tpLnQlG53lP/F?=
 =?us-ascii?Q?egyAxVlxcFzIPQPvqbPcLsxeZqkebPvApo65HOvazOJ/Gn3f3jET/vJrXkiA?=
 =?us-ascii?Q?tdxu60Ry9srXeEvJogkpacuI5yyAJSgS0C235nleq3nj5MssQGPLIeIlrWpe?=
 =?us-ascii?Q?0KEUxUwblydMMMWvZ8vbnC46pWKaomT4LAMOMo4FKRcBIU+U8ecYfHTBWbgq?=
 =?us-ascii?Q?HuH9SZqs07b9Z8g17cN5Tos2EG3n5Azx5pGykGh+RXTlsZcNPvqcOx/bc/Xt?=
 =?us-ascii?Q?azjvZXKAa5Zl0hvWOSu61gyvVTWtyr/eJJcBiwZ96bnTzjREI3xzZYJtogPv?=
 =?us-ascii?Q?5LV+6ff97PqYmRY0Dl9GVPkFmRCyVdVacBCPgZ3F6tNYy/4RPqcTdtMgFocO?=
 =?us-ascii?Q?Emt+gl0VeVE1I32XaSgZTWT6v+1VzXQ9f7HcJgvb4YBygYX1qZgB4Gi7Tbus?=
 =?us-ascii?Q?3uKCQWOl+rfMCU2v0XZn3hubLdsALQkC04owAwaTmXuFVc/5lAXd6/17uALl?=
 =?us-ascii?Q?GYrpJaWw58X8lgM0xbGZt5ZdWP21GIVvfWxi2cFruZxn4sj04zXRgBnUKHb1?=
 =?us-ascii?Q?PYoLdXDCezZOZZoK59ZusccjSOdKjsMhXOWiDURPlVNoiAb32C9wj3DANKBT?=
 =?us-ascii?Q?fGgtqhcNRIvHBdWaKLrwl1EXQtvPzTQ5hngpxZ63MhwkCnncSJBuZvQOKiad?=
 =?us-ascii?Q?DPirdJKz2GPGT3K49yt0bBRgy63ckMcQgR5yqRPLfkuNuYJaYo12c0Gz6qp4?=
 =?us-ascii?Q?JJagYov+8lNwp/hqJYQNzJ8r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5409dfa4-8f4d-469b-9ca9-08d9d0f1daaf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 08:52:22.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N5ycNBfUPyIDD6ejpTFaKaJ/add6nEqDmhN4VldNs2VMlLI+aBeTX/i6WWyU5B1eDwrN+8AN8C2/p8Z3z+zMSVAHG4PKjTj4kUjqD041xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=704 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060062
X-Proofpoint-ORIG-GUID: ulfAX4EekwJZ8yckhAFfVSN35uiWlel2
X-Proofpoint-GUID: ulfAX4EekwJZ8yckhAFfVSN35uiWlel2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:25:34PM +0100, Martin Kaiser wrote:
> Remove the private "test" ioctl. It copies data from user space,
> this data is not used.

It also had some memory corruption bugs because of the lack of NUL
termination.

regards,
dan carpenter

