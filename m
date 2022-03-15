Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE84D934A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbiCOEWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCOEWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:22:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80848385;
        Mon, 14 Mar 2022 21:21:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22F3WUGm021992;
        Tue, 15 Mar 2022 04:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=smR3UdEtYLzxtfUpHTLl7WgqCG0UxSkvC1QnOhJ5NRI=;
 b=ZP/06JhHmnIprq5wTsB4oneyAWIeQqpIXVueTRH27KxgQzxx5hy0oePq9htymIfKt1GK
 Far0sIeDYpEaP1GMfCa2F2JgCa4Ms4ElEjfJnso/+q5HDOOufL+YdkyvcJxbChSpzIkA
 C3lYl+i+6e1zcmiY6alOXaCYrBP2lUufXXnz9tScO+htp54XcdHhmEgNrEWTZB7E7+LS
 W09Fb4xfQNkOe5oE/fOws1m1p2EUTOXkjzGlF1/Y5hnLeHN15EHzubs6ATerMzlpyg6t
 Y3kv2fyuFABNNjWDry3NBnGr7A9o21qPpnr+XfuGB7N2gZuSsc8NEBHN2H1ZRGG+U7nv ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60r9wd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 04:21:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22F4GvMt187839;
        Tue, 15 Mar 2022 04:21:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by userp3020.oracle.com with ESMTP id 3et6578bc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 04:21:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfIdyO9s5L0RFrLc/DvfKRLddDLvPrFPsxsI7yPR1bOuTSezHlPSg468DlAFowSGA8/fif9A7RRk4jz3X+BPdenpHg+0rufgEzIhKN1uNvcQfqEjxKA2DvgJBdoHu1KJTgFcjraX8oHQTjYQhIRSlGsu4Rf942FJNC5us398azJmWkqTCexZ7FFSUU3oUqbxlg/O3e029EiuWve2xO3iuvnLBnqsC+IXyr/yJAyS4uIZDvG5+IOocrDymo2zbZ8d4CGclPNAvtrYB6YWHYyJoZtfOaMdxjzGsXvyQRG7DRAjFVgAWvXDXY8lycb3BH638IVNEnhwkJfgHqQtIZ7AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smR3UdEtYLzxtfUpHTLl7WgqCG0UxSkvC1QnOhJ5NRI=;
 b=VFL9sRtTKajFzJARR9/gIQVtfjR1rarJDLV5TY1wQRdmVawbr3bZRNP+43FKISaeDnIOXHRcEMdddufgwQAFvtLsxrhNwgceuVArX+EZ0CV3wruiwc0csrGKS55/AJtEBcYlaGiUqUyQN232c/CdMyXrxeeLIw0JFgDos+GmtJp1vcqynfD13tsmKJ+0Wd4YIlRxwL6Xf+AASHVDo6a/w/Xs5zQaVnEMPX65hr585MXQpmcIw4T5Rbf2uFQLNG7moNoFmIIOtTJLFMLxa6drkcbjyfyiry0+GRK0L4dohjTeGjSaAVW6mMYNzkUZIlkTP56aepnhcRjuYl9f+j6uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smR3UdEtYLzxtfUpHTLl7WgqCG0UxSkvC1QnOhJ5NRI=;
 b=I59K1/ryK0JZYjR/ktglOVaTWvZW5la0nZ60aHvWy8cTJTqXOlP+HkzumO7Fj5Xn4Egs0A2i1mgnDkFc/WV94T0TPNXkxP7LNK68oUz3UZ6ob8pv2ahJLlwNHXMDOWhlOO+2ThJ8BAElNbklb/uHgNAU7kWYirdV/2WCHv1rJE8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 04:21:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::48e3:d153:6df4:fbed%4]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 04:21:13 +0000
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
Subject: Re: [PATCH v3 0/3] scsi:iscsi: handle iscsi_cls_conn device with
 sysfs correctly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bky7dexf.fsf@ca-mkp.ca.oracle.com>
References: <20220310015759.3296841-1-haowenchao@huawei.com>
Date:   Tue, 15 Mar 2022 00:21:11 -0400
In-Reply-To: <20220310015759.3296841-1-haowenchao@huawei.com> (Wenchao Hao's
        message of "Wed, 9 Mar 2022 20:57:56 -0500")
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73533df6-555c-434b-1a92-08da063b3da4
X-MS-TrafficTypeDiagnostic: SA2PR10MB4457:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4457CFEA144FD78978CA99F98E109@SA2PR10MB4457.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLCeCeHHvnetXn3vo2mUiy2rpAKiO1h4uCNyNdyVc21BebeGKKTV0+FievSU62b+jMbpAHwlt1vUDUyxuo9y7knLAGTKyi0zr/nDoVULklWglCbwW1u/i+qexWbGZA28H7RhFmD/UZHGmrJeZpkbZsFq5oDyYtXUKlNXQvSKA6hx3gzFpTZU8vWDy8eURfsJSoEWMMeSiBtGeAdELAn4xTz8eIQlDogy/FNS9f74ftIeXYLxk3I7Dja4y8LYsPTwzST8Dg166tJDVhLcVeevFaveD1l3qk7zkIilMn+M4Q3uSVWDFXffy7FmR0OplfainhYyn0p9fAlyRPte0lnNuoVIw+da9EwNZ99Pc3nLbJeXrZYj+TIXiBjZ2g2k/CEoAToT3m14tL/Dv0LDwWnEwMvvqRUJjltzDYpa/WHCGirvQqSbL3ohrGD0mEti3cnTfDy+fVC+TOx5yvBdjpgHhe3ArLkjHqW0NOj4uAWJq8jt5jb3fXGSlCrS0dbUoeu2ZSlzYJ7NAsiivrGrtbcqnEChorDaaCst1yC3Jopfc7AhQqSaBGNVBYe9NwOTQjOP4O63jNw5WzQVmskIkKzekE4CnmoCQUbxxCn9k/q21xNW7Bqg7db9fWhSHNg/pgPDX7ZVGg0BzsbM8nigvT21lN1u8WH8uGFk+JBIA2lw/WufipmAdt9+DE9zMOc8bZloFHqebqhsRIqrRr3fjTEBtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(7416002)(66556008)(66946007)(66476007)(8676002)(4326008)(5660300002)(6916009)(54906003)(558084003)(8936002)(186003)(26005)(508600001)(6512007)(86362001)(6486002)(36916002)(38350700002)(52116002)(2906002)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAuUl2osm+0ivgabXbF64mu5wWpJTzyq+d4exCIsrAjMmsHC1cWz4B4X+qIK?=
 =?us-ascii?Q?6MoL5Rp5r280lUfkHJtrJZfoJ1Me+/8fKRkPP//pwWu//wi7flNf5zVcalAp?=
 =?us-ascii?Q?SqCJRDWN64DPRI1S0beoMMtqOAWqhhJJqToIW/kQ/WKduftxc8vdKbFUGPRa?=
 =?us-ascii?Q?SCqPFhWvyKMSqiOn48O6HAKtZ8EzUeIlqYx97WhdvvYz/2V2FpRZHN75An/K?=
 =?us-ascii?Q?+eTuDjvhz5sB8nP+dkhj800UM8Yx3lF7da7fcRj3AtHm1eh+Br4cQ3rlJOtq?=
 =?us-ascii?Q?dxEDajp5mJxU8HbTqRyPjz5wRSu+AGpsROasDQn8J8TxdwOXbOC9O/d7YCHP?=
 =?us-ascii?Q?LCQWfU8whOuNZGkt6hENLq0ufJvJ0jzRzQDs9IrthjN0N1/62EZBYinoa7er?=
 =?us-ascii?Q?+Q7xEIfwcj8jOFg2FiDdWRatRBhrf76sGwCzUoEoFKcchgJhNSIo3mij4wjh?=
 =?us-ascii?Q?haDCMMOokMjIZWcWoeiybXxDpyE6ebq6Q5kD9DYW83N2h6skixlePTBYpEyI?=
 =?us-ascii?Q?P+7x8ns/T5DflwVqrc53OEF+wsaY0ZdF0HG3ENDQxJRr/CO4DaaNHRkEs0KY?=
 =?us-ascii?Q?2rhR4AHGn6RRgZR12ywZcHqXqdLGgvEen9AHeEiDX1G6vttdcMrU2Kz88pxO?=
 =?us-ascii?Q?Mz6oKkUIKOY8JMVL3pyQP0Bq9+nd6FF1CqR0y84+rUldCZ3Lw42FulejF3c3?=
 =?us-ascii?Q?sY9YF5dsirE07eEl6zijkNdCxvmg6CobYvU3AnXLl4sIJBYd1U+79+vT4wz4?=
 =?us-ascii?Q?XaOV5INEdagAL++JYu5a2ckLvqGrTs9YeRfbiqRBd2Z0Fzhe36oOO3kTCaia?=
 =?us-ascii?Q?qkcXmKEfJ0pTsrstpEvKJv8HnQHR6Uij6tcLYGbSE0Pxoroc65/NEFk6NjS5?=
 =?us-ascii?Q?g9669TY+/ujH2XSQMgSL22CpIKdVIEyHfJMlZnXgAECIwouyObcJ9P+8gk2H?=
 =?us-ascii?Q?IKXUIiuN4VYuvuM+VW+Xd/NL4mQCtDHmjMGc597WfhwRKxcCNDhn6Z5XpJN2?=
 =?us-ascii?Q?tyYYa2Zktkk5OK7Rn+b0fnoBW5bds5pdJ3vSNND5433wzljVBAUVDNLDsmWw?=
 =?us-ascii?Q?BiNVVwmyQWU4FOlfgQ1Dnj5mW9JYgo02k8ecTBPQBbkHEeNNx54UK9HNt5Fx?=
 =?us-ascii?Q?Zl7v3CyctLv0GEYJeDf9gehdZzwI/U5N6NyXoG5I9PQmaGoJKcmjWO2vy/6C?=
 =?us-ascii?Q?h2GqlIpuueMANxI1wIExMoB9cb8B/IdaeucbXOkdmXXXuY+f3bxQme0rrrOO?=
 =?us-ascii?Q?cPOBTFgh2NJevlUzd2Wpzc2/7NklxDwa8BbrYFubqKJRUQ2pGpADmNI8rpI8?=
 =?us-ascii?Q?M8QeZZDob54iDqN4gDdnkIxNC8IAKXdD4HXHoonfEbxtTC/CWmUCV6wbzSjM?=
 =?us-ascii?Q?/9dPSVc6QF/iweIIHyD4T+UjXbwyf830AQlztHOTRyEigLZRYSQUR8V5mhJ6?=
 =?us-ascii?Q?pjA3ODo+LMTSPwEkQ6kK0N8vWqS5rxJC/NcUcO+SHvUtNTJC8iJCXg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73533df6-555c-434b-1a92-08da063b3da4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 04:21:13.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEExHLrMOXSnMcwS6DgxlUEilyEtc98FGyVNPdrXtgMjjarpSUKfQXa+kvmOFTfpIZSG6cxmfXGGWIdZzwymj/8a0g6P+ClZstcAtU3ZQtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=604
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150026
X-Proofpoint-GUID: 9NezOOlrLRAO4y65L6504En3FzBFe6Sj
X-Proofpoint-ORIG-GUID: 9NezOOlrLRAO4y65L6504En3FzBFe6Sj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenchao,

> We found a NULL pointer dereference in iscsi_sw_tcp_conn_get_param(),
> the root reason is we did sysfs addition wrong.

Applied to 5.18/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
