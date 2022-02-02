Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2CE4A6A90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 04:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbiBBDjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 22:39:49 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11866 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbiBBDjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 22:39:47 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HCpa011409;
        Wed, 2 Feb 2022 03:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=a8/2HC4zOOWLOI68iKj5jMZjNqc9tuyWB1LC2Lbeiyk=;
 b=LmVFSCxfz00Pgcxs03NXqVtD1b+mlDQKUzJC0+xd/p8aRgmMxWcUFO1CSK1mRPJr8eqJ
 sE5nc3VdD5p1F389YGuzPVMV0cZ+gGeS00hjLXAzzFrGlv+A63QP+1kX1wDyQYj2Jcvf
 iMORRWuXwbcWSWDhBGDTTsAQxq6qRM8uQFxiS74VF05LZU5X2U3n4YV0PWA/pd0YQccu
 3qi8ncn6Q79kCUgjnY4g9+Iy5EeR/QRjBAqEMpzC5cNlaoMBLNioG50bfG7Zz9BJ4784
 nq9+5sG9z1S1WQKP9fLBMhvaBJc2G1z6KCg67ALpxFNVNwueoZgFugGLtXX8smCJYFwl Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvtyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 03:39:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2123LexO054077;
        Wed, 2 Feb 2022 03:39:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3dvtq1nujw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 03:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfFerxD2rSaeZeH9HjfzhhFO9C4YBajin2TVhTL7NoFpwOY+9aKqMqxTklBSAOfxJf4ed+VTCEwvpN/BchYBR8hYHvfAv924sGoMb85RdVTaN0blMNsy02s/rq0Yyu1fvcQW3Xw287la2k+9eKzPK4faQI9z/4KGhhmlIUpb09bNvhVzmrQawtORN/tFiU88gUe71ZwFoKHTgK2XNsMX9gPC7+NiPLnU5cZBN3g2auaeDm+g8x4b2aJ9od8mUGS9G+DJsdHkrupqM71ELdzXu1B6K5AD8o96FNS+spX2cNCkwjg8WANMgkBCmAcIZQFHvku5zHBis0UiD7eaer0UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8/2HC4zOOWLOI68iKj5jMZjNqc9tuyWB1LC2Lbeiyk=;
 b=PMxjL9epGm2aIoYqOP3RewW00A9CO60ZJ6esFCutuZtvHRaTddzRmFVnlqo/nlOvJ3F01JZ+N1JmNCoiErf0iy095Gpr5D3MqPMoKkPXmOFebKka6R2Gq+Z6cEKfhrefytx+RCZFZbvB+Wo2xSA6miSsfEo+3asPugabx5RQBspfoE+oDeNkY6NWWQF5iGbNLJcExzRSp5R+v4jRGPffvBGT8k71JKD0k3rdZhQHyXoqimWpsoctZEIOh6dZy/VY66PvVyHq5BZosFgzpsm6JwDMb+A3+eEE0Sm8KxTXekQk9/u4VKFQTFFkTetqwSfCtUyAjV9IGPr6DYxtCK6E6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8/2HC4zOOWLOI68iKj5jMZjNqc9tuyWB1LC2Lbeiyk=;
 b=pLJtQg8J1az6baKmzvsM8Se8s+7FiBi8xeGWMA0fmzJ5uIyqLuveimd/liiDzuCmCu2KRYBDqP6Z63Tgom4cFJ1W19EgjItSEdbFjMXOsrNKKj/+KsLgrUHS42L/4VFy54wZFPk0hk8d8MbDZZtJ5yMQ2o4K6Z5qT1SqnTGTSWk=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by BLAPR10MB5153.namprd10.prod.outlook.com (2603:10b6:208:330::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 03:39:08 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::464:77e7:f1b0:995d]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::464:77e7:f1b0:995d%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 03:39:08 +0000
Date:   Tue, 1 Feb 2022 22:39:05 -0500
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, bas smit <bas@baslab.org>,
        Tom??? Glozar <tglozar@gmail.com>,
        Ast-x64 <Ast-x64@protonmail.com>,
        Viktor Malik <viktor.malik@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Jiri Olsa <jolsa@kernel.org>,
        jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
Message-ID: <20220202033905.GK18312@oracle.com>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
 <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
 <878rvk7uv2.fsf@esperi.org.uk>
 <Yfn145FyE3PDBEad@bombadil.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfn145FyE3PDBEad@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b4770af-9708-4d8a-ed27-08d9e5fd9184
X-MS-TrafficTypeDiagnostic: BLAPR10MB5153:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5153DF2E5268741BCED153C1C2279@BLAPR10MB5153.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DncoiYjVf/HWdCem/2Z+XNq057U12gG1cQUZ0yw758qxUfnYZYVguOeXDMZE9kq+32idH2vCs+U/Sr0SEhD8W20B4usQD7O+bXSfjmLoftIVzXk4i3s5YeHKbm+cQNgvHRhqs9YS7wEwJhuvFFLTkLDqhNk+bv/5kqiWSCAsRpFK6TpQrhLM/eoJga+g094k7ewiA1nbuiZ995VyWFmWVCgd7TbX2AIHhHeiypQGA2BaPCLzE7baybLluQBNzvPM/vknmquFaWhq6/JzagNBq8YWZNr+xDDorZgqdhUIMvCqmdfNAVICxJBTnyDGIGsQ3cWyup4Z2EJ5BWwfdgr0jNUUZtJZY19GaveS7EV3UhYbDijn+Z4ghB79U2QPKCVzc7xCWzzZ/NTBa0bIUCH9Tuyn+WKkwBff0ON824oKiHiLZcN7k1yC61QxmwVMINye4ZRZZtYeVqg6vbnkn6fWUnH7WSy4WIw1wCNlJgNz+v1G6MY9OTZrZKIdPIYguliuezBvApC62OKYFQYPM9Qa4l1/UTSqSqrwrPMcNSwKaEq29fu5XBR49F+ydqmuJ8huKbN9EpYXgwVlTelZF/qigTTZ2tmgqz+QPABdizxu8jc33KVb6oSCPAZte4fIErr1+g75VPeM8lF0Ap+qCURsz1h0chFmkyK9WWw5fkVVM7091n7RQI8rSiC4H5JyvIYChYtOK6HCZ/7SGrVKX6BgOHjf0zDo6UKt9RiSsnC3AvHiufQNPcJHGuv5WXhQb+cjaJhx2PjlT3lHnCZrah78RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(86362001)(186003)(6486002)(66946007)(8676002)(7416002)(4326008)(966005)(2906002)(1076003)(2616005)(52116002)(83380400001)(5660300002)(8936002)(66476007)(66556008)(36756003)(54906003)(38100700002)(33656002)(6666004)(6506007)(6512007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHMxd8WVr+3P7DR03GQGE+/AjlsfD3QazLkDYMTBarmvehn+T3OZVGyIkaQM?=
 =?us-ascii?Q?l3ZQd2jllfYsJgptNbRMYGVuNEHg5jWnjhuJlRU/3izURVcrw3bAG0HxzIA2?=
 =?us-ascii?Q?QfEkLLaOCJBtE5velnMkw0eTuF3X7IcCrsmkv/NA38f1pLaHd4kLpZ6qiUHR?=
 =?us-ascii?Q?yj+DXV9Kcm8+41h6tK2bzByzGk/HiYzxdVF0EiV55RL75zCihv5EWwQuIjMq?=
 =?us-ascii?Q?Z/2pRQUvCECrXdyty/23yQw3dbikyyCEUjm/2BsDAhVVQ0ga9vZ0gisohAah?=
 =?us-ascii?Q?ymW1rv610YVo8PrSt/SQZphIuXLWZ20MIfYLiAP4Yj0ejGrE3Ow0wul8zq2m?=
 =?us-ascii?Q?K4rWtrAYm5OpM2/RZ5fLU0k71U3Oqg0TeH/WQ30RYJOO7co4Lo0N/bo/szt8?=
 =?us-ascii?Q?u8R/Ng/hPz/el7a0RRmiiU0rD5Fd9p9agZ0HgL5qVWZFRX/VbfPCTMHn1TNN?=
 =?us-ascii?Q?HJ/0y26m57zEpT0AAvDPDym1Oh1L+k1J5Ncw99awKJ9Lk4sHbhJqyjUrQMgD?=
 =?us-ascii?Q?t/3A7CjsRa0kEC6jkykTS6384H3e6Y3Ef+eDw95ZlAvar4mGkYd/JiOS4vUP?=
 =?us-ascii?Q?ZPT7OLu1MdGog3SsTp/fdEQqGWsuw/7hNPIHb8Vt5NCfVmv4qwLiwZXk4EYV?=
 =?us-ascii?Q?HErslXMo/3FiIbxHANyc6b/Cj1KlRshJWLZydQhyZOD64rCA1t+Whtg85qtp?=
 =?us-ascii?Q?txfUOe2bM1fYHIzfs/iNgmUpeDNfA+afwamF3YeltBfC3L+hrxD/C7TFInCK?=
 =?us-ascii?Q?GySEqGtcE2ehp3dq8IVt0dZlxG5Zch90NMTV/epaDoaIootFt9KL4/UP99S2?=
 =?us-ascii?Q?icjJ34I94FQaaXx+WAKYVOgvW6REJtPK6DObhzPXesKqNncu+2eo682b1vph?=
 =?us-ascii?Q?gcCiUW067WPA9uPZCpqC0PPvZfsNNn5yftcQfss218NXGR1WLitRU+ZJwy9n?=
 =?us-ascii?Q?LbPA2iuFiOCLA8WS5YwQ6q05+YCbGB4T8l1lb1aPselGaBO8tfK3xPtjP8V5?=
 =?us-ascii?Q?kYxYLXEMei3fQtf4buYzt3fWf674YCjiqo9gZAzajjajsB1RNswaNHEu5yi4?=
 =?us-ascii?Q?yW4S9O2fFmX6EA8xbaPwxadNnPTtMERsOTyHHkTqiozIfGSikzOSLY+t/HKM?=
 =?us-ascii?Q?ODIHYLtp9oTuT1dYxkU9NcuEsUdatDXvrYr/Ddvx3LcK9ieDG12JVhDaCU58?=
 =?us-ascii?Q?wIc9GiecuQfL4JYU371acJnMi7/0+wcfgDpnwJn5cH57+MwDUabCnWL6NYRd?=
 =?us-ascii?Q?sM9+uTLeZFHYZzHZ3Qej+zOvP+9EZPzsTqyj4qYBN3xr7+SXXUYpcVVkSPQ8?=
 =?us-ascii?Q?e+liNbd/EdvlHtbX+R6zyZbHIs/174/MX/vosC8lki8JrwawLx/C9hcwgIFl?=
 =?us-ascii?Q?/jswfTISgFvNa4nQRdIKmBaSKLGfwRBoQFCc2UkEa0secKS8lOXjtKRcwqoF?=
 =?us-ascii?Q?NXOG1QEUs8moLTI/46N534T62dj1B4sXv/ZMLYcckq1W1498k2FYhii97uFQ?=
 =?us-ascii?Q?YFjKiV2ptRvI3fdt8bXPMqYvlQXzqZU5TN0btbByc/ltpQzTurdtBoi93ZCO?=
 =?us-ascii?Q?v6Fjp20w3r8b37U7aW/KhM/IJ8cEMaLEvpTuQGayXXR9H9XOTyMBlGWqhp6A?=
 =?us-ascii?Q?HdeVnp59QL483L8l1Qxpdar4rdmeSrCP2RkIJy1Aho6SRfxBLIBsarxJL75k?=
 =?us-ascii?Q?AXr/kDyO2j6UnKN2WD7cZMsGArqM7azsZudt2NmwxRwvKTee?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4770af-9708-4d8a-ed27-08d9e5fd9184
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 03:39:08.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sNCgs0pzZJy6TiRQw0UwDq3xDXYbhQRxTD7jnGpKV9DODgpCwsGj7kfaHAz7kX3AZUf4Sv5eYWC0nHB7aDqbiKhO7/R527GN9rDU2YuJBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5153
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020014
X-Proofpoint-GUID: 8kzHPDI3Q6daoUijO_vt9VhL5ZyuOs-i
X-Proofpoint-ORIG-GUID: 8kzHPDI3Q6daoUijO_vt9VhL5ZyuOs-i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing Steven Rostedt as well since he was part of the original discussion
on the merits of this kallsyms enhancement.

On Tue, Feb 01, 2022 at 07:09:23PM -0800, Luis Chamberlain wrote:
> CC'ing bfptrace folks for feedback.
> 
> I'm pretty reluctant to merge any of this unless we have wide community
> desire to see this. I'm not quite seeing that yet.
> 
> On Wed, Jan 12, 2022 at 04:59:45PM +0000, Nick Alcock wrote:
> > On 12 Jan 2022, Luis Chamberlain stated:
> > 
> > > On Thu, Dec 16, 2021 at 08:19:12PM +0000, Nick Alcock wrote:
> > >> /proc/kallsyms is very useful for tracers and other tools that need to
> > >> map kernel symbols to addresses.
> > >> 
> > >> It would be useful
> > >
> > > It took me digging on archives to see to *who* this is useful to.
> > > The short answer seeme to be dtrace. Can you work on getting use
> > > of this for something (I don't know, maybe kernelshark?) that does
> > > not taint the kernel? Last I checked using dtrace on linux taints the
> > > kernel.
> > 
> > It hasn't tainted the kernel for at least four years :) v1 (with a
> > kernel module) has been GPLv2 since 2017; v2 is pure-BPF and has no
> > DTrace-specific kernel modules,
> 
> I google for dtrace LInux and I end up here:
> 
> https://www.oracle.com/linux/downloads/linux-dtrace.html
> 
> It then has documentation dating back to year 2020, and I can't
> apt-get install any of these "dtrace-utils" or anything with dtrace.
> 
> How do I get running with dtrace on debian? Typically this is a flag
> it has some funky license. You metioned dtrace is GPLv2 since 2017, does
> the same apply to the pure-BPF stuff?
> 
> Note I see a bpftrace effort, can that be made to use your changes?
> At *least* I can install that on a regular distro. And it notes
> "The bpftrace language is inspired by awk and C, and predecessor tracers
> such as DTrace and SystemTap."
> 
> I see on that page it says:
> 
> Note that DTrace requires the Unbreakable Enterprise Kernel (UEK)
> release 5 or higher. 
> 
> > just using some new things we have to
> > add to the kernel, most of which seem plausibly useful to others too
> > (kallmodsyms, waitfd pro tem until pidfd supports ptracers, and CTF).
> 
> All sounds nice, but I'd like to give this all a spin, but I can't
> find anything remotely close to anything sensible to try it out.
> I don't want to run any Oracle kernel. I want to run things upstream.
> 
> > This is not a DTrace-specific feature in any case: all my submissions
> > have noted that it seems likely to be useful to anyone who wants a
> > stable reference to modules that doesn't change whenever the kernel
> > config changes, which probably means most tracers with support for
> > kernel modules which implement anything like a programming language.
> 
> Great! But I'd like things to have tools
> 
> > > Without valid upstream users I see no need to add more complexity to the
> > > kernel. And complexity added by tainting modules or not upstream modules
> > 
> > We don't need any of those any more :) Even CTF is now generated by GCC
> > (once GCC 12 is released) and deduplicated by GNU ld: the CTF patch will
> > be only a few hundred lines long once GCC 12 is out and I drop the
> > DWARF->CTF translator.
> 
> Great!
> 
> > > Without a valid non-taining user being made very clear with a value-add,
> > > I will have to ignore this.
> > 
> > I hope this gives you a reason to not ignore it! Have some links:
> > 
> > DTrace v1 (maintenance mode, fairly hefty GPL kernel module, UPL
> > userspace; fully-functional including fbt, kernel side will shrink):
> > 
> >   https://github.com/oracle/dtrace-linux-kernel v1/5.15
> >   https://github.com/oracle/dtrace-utils 1.x-branch-dev
> > 
> > DTrace v2 based on BPF, in progress, some features still missing (UPL
> > userspace and a few GPL kernel patches, including this one: needs a BPF
> > cross-compiler, which is a new GCC 12 target):
> > 
> >   https://github.com/oracle/dtrace-linux-kernel v2/5.14.9
> >   https://github.com/oracle/dtrace-utils 2.0-branch
> 
> The "The Universal Permissive License (UPL)"? Really ? Anyway it seems
> to be at least GPL compatible. I'm curios why no distro has picked up
> any of this work?
> 
> I don't see much traction based on what you have said on dtrace
> on anything other than Oracle Linux stuff, it would be nice if bpftrace
> folks were excited about your changes and we had support for that
> there.
> 
> > (I'm going to respin all of these kernel branches against 5.17-rc once
> > the merge window closes, and bring the things both kernel trees have in
> > common into sync. I'll drop you a line once that's done.)
> 
> Nice.
> 
> > Config-wise both of these need kernels with CONFIG_KALLMODSYMS,
> > CONFIG_WAITFD and CONFIG_CTF turned on, and a kernel built with a 'make
> > ctf' done after 'make', and the kernel source tree available when DTrace
> > proper is built.
> 
> Thanks for the heads up.
> 
>   Luis
