Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFE4A9AFC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359314AbiBDOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:30:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28522 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359309AbiBDOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:30:58 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214D5Kxw032163;
        Fri, 4 Feb 2022 14:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=ut+Zgv0lFYz4U1Z1HRLs/9hqAmg2eZgnjUZlPt2KKXE=;
 b=p19hCcqtGh+wkhJ5VITpi+0UjQ00UnJ/ZdxKkOmqF9AQ6gDJnL/T9JbWU5VsXfSj8NdB
 x7NlIZD5LPTbiFYBL0HnS/4agyB9/3dOgxccfGl4SiaiIhyXvob+rkNPNOWCJUij0TTt
 y1PdI3caMeVPwRwSIDtLahmdaG+2d/ekoGFQQ3vzPh+G/vAblGIKx/3BnWeep8kIYQvu
 nDgee5ucvdDrVhwfU9ICWvq/P+Mxc5Hbrtn6BAEk8gfQNbj4ccl3F4qrpEDh2tjFXjHC
 p1ufr3qB/bhp3jtHcZmDbMKbV3MXKcUvKvhrJDHLdcYd6xgkd/tZMue6i3nBMNJxZtiP 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfwarxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 14:30:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214EFpk0094190;
        Fri, 4 Feb 2022 14:30:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3dvumnju6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 14:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dez294nrsjFqwAtglxo/zlpO3Kk6UZkhb1Mg7bwqJDY/sVz1PYCYnO7D89KMVUbXjBejR0y0sL1EsSiy8ncOAQk1liPu46aU18UwyNZ55q/L1vPOWbwF2GgdwkjOyxtzpQOJhKEEUon3wgT49+uzmQxZjwCfawpcafp/lSogGhlBI7f7Zc33M+IJPN7NgXENzVxJzr1v92uj3XXQZ+TE9Ca5Qqzz4xIqhEIjvbHLuTWGqMluFLxf0ZPKLyxb23LdlvrC1X/ovwHiX8bD0xJ5SCXkIOQeQt1s2x1GqPOs6bytGI/aWohuEbh3g+E6hwHtoV+vsAbcbMmS9k21yaaagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iM9nHlFEmk0VURjM3/1ouYJA5TNlGUYle1M38HMzyE=;
 b=c0WdAoI2/h7qmajthADQWcYWXuhEszrSAdHLwovLP9EQCKrkHuxKebiUMqWKY5WNIgzFgF0geTO3pyAqu0Z/TYVdyxlnIsZelqQsAIgs3Wp9wIh+KDR5/UVamLL7qWRdgyEZMblofSOQ3qJvV6cXf3OCW9MVc264dWl2QjJ3V2rsLtHDY+mNW9gKedRH3BmM0CwPQ15miJoNIcY8bH1AFDf/DUPCRZca6don2Uz1nR2qdz+/NhvO7+u7+NeTio3sz0D3vYauJZ0W1ZAuaW8Yx6rt8gplgozPZQ1aqLuG0baosxywMsQjxj9sG77HU6ql3IY8iV7pBa3XoEWwGFAPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iM9nHlFEmk0VURjM3/1ouYJA5TNlGUYle1M38HMzyE=;
 b=hanxOfdxvT4NkVdPPGwphmCr8K1hzOtHryoHA+tBzAyHZm3NsSM/rpZSNCo9HXH9PuFiMU1AfgX7/cZacM7WUCWMBJPn/oKMcPe33sy4DxTX/pNzUI4n4BeZZYPYcmgsfl2/OM0v019Z/7CQKBcwv7hB83TpwVx2ftzKohImQrU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4384.namprd10.prod.outlook.com
 (2603:10b6:208:198::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 14:30:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.023; Fri, 4 Feb 2022
 14:30:37 +0000
Date:   Fri, 4 Feb 2022 17:30:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [kbuild] arch/powerpc/net/bpf_jit_comp.c:225
 bpf_int_jit_compile() error: uninitialized symbol 'pass'.
Message-ID: <20220204143008.GK1978@kadam>
References: <202202040124.7MMKaXXV-lkp@intel.com>
 <45bd66d4-14b8-bdb0-7d6c-096d6d7cddb6@csgroup.eu>
 <20220204141459.GJ1978@kadam>
 <0ede8979-2a7c-ab16-b97b-11c5678ae045@csgroup.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ede8979-2a7c-ab16-b97b-11c5678ae045@csgroup.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7e69ab5-0aa4-4f42-415d-08d9e7eae908
X-MS-TrafficTypeDiagnostic: MN2PR10MB4384:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4384AF0D208D46628351F64F8E299@MN2PR10MB4384.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaFbjnRzCZSVTY/kPCgSpukzuq+8yS7erEDEZRpNNtg1r32TnWLdcWhhzqHUp2EoLdSWSjQhR6OgeaRwCEui87aY62jjJB6+SWCYkSRMwjvzIihB83iDxIdK+YDUcAKc2GtbVkr9iJwxMcIfI6b83cw9KivlbqWA49UUyEND10utIwQdJ4190CeI4nEJRMJtPGlHR2O9iaiivuFWSKHsJ8q1djMm3G4/PoqkyZvq+o0aa8di8gIpLVfRjNb87X688vMvY1EA00F0cKG50eEklFbXFklsS/e7zRlv3/kJajKKt9WBoB0Img/q15xYkq/5Hn4konycn9w3ObYgo9wqvUbh/Q5vXjEQzey1Ns8mj81wX8XzLKk3Fiol0hkDADvaL2TlREcuSM6/2r5/JkrU9b8vGRz8ARSi6IKjEje2O/re/MGcZeoB4JLg7GmIHnTM+2rajM/Z00snQ8dIB4TOBhXiOyI7nRUn9dpuTDiL4kz4lx/SRW5UUD3sMgKnEBhLNSVW+/QBwK6t/DspuxHPtzYYXAoVKTJy0kPx0q1TgHtFqMrUHAG8uncjCXhkUy166eGLWD/2yByIlH6NayZbKsk2mf7fgDfa2oMGC9CGdjsUWvG6O9ciSSaKvsFuJZos8aIxpmlU6gvCQNGx2fFqJxjF7tTPVU/C/lpAS1D4oyPbwixJWj6dyovAeRFhzXRgF1COcrqtBFRyQcIYTi/2AjNyMFla3pmWH07pG+2wnwZzc3CILzoodPTrrGwGDl5YfMtPQ+NgES0ZQ/bDEL6q+t+20yX4bTBKAMn9a/iGt+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(966005)(38350700002)(38100700002)(5660300002)(508600001)(6486002)(44832011)(33656002)(86362001)(66556008)(8676002)(186003)(2906002)(6916009)(83380400001)(316002)(4326008)(26005)(66476007)(6506007)(1076003)(9686003)(8936002)(6512007)(52116002)(6666004)(66574015)(33716001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fonM6Wz8Uf7PAL4ZdfNrSpVyS6QWOERjkZPxMpIEAWE4RmHwyGzaaoBHMp?=
 =?iso-8859-1?Q?euS1Gi/14F6utO+/iDnMFQJQOMkQQuo07vvAeRcrI6W6vhWwTa0UlJR64v?=
 =?iso-8859-1?Q?hBmwJUayTZedsdFDSfAi2QmKxEaxMEg+0Arok7IbRVrrlng3CI2Oinqp/b?=
 =?iso-8859-1?Q?r/4RUTtJd8EB/leq7t8fIp3TdWsmh5YTzNfT/3IE3/kRNv2ngXQxobbQw0?=
 =?iso-8859-1?Q?qrFoJe9LWQDK0xiiSFIOqNZh5dbTMy/huW0eJnGB2rkdwB64oOcfK7QW9i?=
 =?iso-8859-1?Q?ykeiSDSy90luL/Rk92LBmZlb5ePSOrNTG7AwiFBxBIpx4I5HWK3SQuXDmv?=
 =?iso-8859-1?Q?NJ5xe2OADXLHCxr+wZb+CsKIRK7gd/5/+DNam0wDrg10RgHpyYNuoZ2n7w?=
 =?iso-8859-1?Q?dIIU1/y+JTgQmiHuQtjDXRjglV+8tZPD/QM3cFPM/owXlh4NRoihwZ6mwJ?=
 =?iso-8859-1?Q?p5AQE6jz8RaJ6O3EQ0Pt3TgffDe/C7R7Kokk3V8m5RhDUUmiMmtxepVLvG?=
 =?iso-8859-1?Q?9fLIewo+hDbd6Qe3Kx8oSQ/Z59QwLFNzi0VaTSOYyEd0ST+ZFn18EBGunn?=
 =?iso-8859-1?Q?cqBBtECxBd21gXzeRQvGLp8aNslCqTi3wH4p/me9ntsrql3MxbPfTrPATY?=
 =?iso-8859-1?Q?S1C73CFhbrvsAeEKTW7cVTue4byoI0rkbV43iqlxpP8Qg5BNLpRbR9+rQi?=
 =?iso-8859-1?Q?gerR+rYxOUU17YHJIzdGmty6Kq10W9dHUNRBSUz5RFyAtHw/pgzq+Tju/r?=
 =?iso-8859-1?Q?p0qA2rIZrLxS/6480z6rUwoIugBBwM7fIX4pdXvsl3c+/7qfYxLRdWNvZ6?=
 =?iso-8859-1?Q?6eXQy/RO0WOxv70CVI2Val4P8LJWoWlYNGcS/b948RoxPu0nvFcvMkx2iZ?=
 =?iso-8859-1?Q?ZCbSVO2YjpH2L1qOHpMtnCCEKm1HvUhOHlbbTK0nQdOb/sHOXS94uvYcG9?=
 =?iso-8859-1?Q?oib4g7XcS2JANZf4kJwwVClXHrADfGKlz2/DpXEDaJ0Hf0I+OFqUEbRvvE?=
 =?iso-8859-1?Q?Bjt88xb65blieC7q1K8F95tVcxfRjz7bVghIwAYWVH6bDJRgUZHqkJXtig?=
 =?iso-8859-1?Q?KGQUM1BbdN4zMBIsGwhR9gQM+4Bg/ryT1zmmhPHlhnBwOW2suqVM9RR9KU?=
 =?iso-8859-1?Q?+opAU1keiNsoXHEZ+BCJTAQJlHGw7eo43CWQ6Zfz2NBCndo8cFLx/DhcIv?=
 =?iso-8859-1?Q?ER0JQzy/Hao/wQDMkkYqZLAwss9DMJzO2uFtFHwsJbiieu9M/Y45TVceec?=
 =?iso-8859-1?Q?FCNkiWIPu6pzMHXHRhO3vcbnF66ahKivA1zVXdpUs0QX8ULeEhi9mW+A8e?=
 =?iso-8859-1?Q?AxSlO1rKh5jWvmtHCX7sQC87u2iD4TCl4+70XEkbXdDYtInQpk3M5Da/zj?=
 =?iso-8859-1?Q?7xxxHAO4U2otyBUqIpsgmDtEra+KzMND3bJ6iM0zJyDKIW55dr1gP+qi1T?=
 =?iso-8859-1?Q?H3k4X4yNFyL/ywOrIVM9dGcWrLDDf+Nk7za7xgFEmi6mQz23e6mhD5sR3q?=
 =?iso-8859-1?Q?C4cBwT6WBYYVjVFFr5tl1XyEv9Jjo4WKlKKMBEDgUEFCUN7j2iT6BCAjiV?=
 =?iso-8859-1?Q?X5cHRjJFakdIKNVuVi34SquF0TklVfs2QUwDERzQNQkh3EQIbwqs4ccpba?=
 =?iso-8859-1?Q?exGyc8sjmXnolp7/TA6djXv71gEjcmK0vIqe0Z252D60IYyLNzxlyAozB6?=
 =?iso-8859-1?Q?f28j4Bg8xdOB3Vdk650+66KntPO2atkrIH75AIeuQ7+40TOpw0AklhKz4z?=
 =?iso-8859-1?Q?6bHw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e69ab5-0aa4-4f42-415d-08d9e7eae908
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 14:30:37.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrHfMb9RJ5PiiWI8mIIdciIXpvTc0ncYGpnjBI3z3qIYFX4gLbBE6V5atrmmEYzqinLIadvqNSG6Dm3p9lvlnGuVUN1FtisuMvB11rubotg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040081
X-Proofpoint-ORIG-GUID: Z4Vkgi7Iwc7W6FqOcW6ar-WQNrPQwHHY
X-Proofpoint-GUID: Z4Vkgi7Iwc7W6FqOcW6ar-WQNrPQwHHY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:24:50PM +0000, Christophe Leroy wrote:
> 
> 
> Le 04/02/2022 à 15:14, Dan Carpenter a écrit :
> > On Fri, Feb 04, 2022 at 01:18:24PM +0000, Christophe Leroy wrote:
> >> Hi Dan,
> >>
> >> Le 04/02/2022 à 11:37, Dan Carpenter a écrit :
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git    master
> >>> head:   88808fbbead481aedb46640a5ace69c58287f56a
> >>> commit: 51c66ad849a703d9bbfd7704c941827aed0fd9fd powerpc/bpf: Implement extended BPF on PPC32
> >>
> >> As far as I can see, it's been there long before that.
> >>
> >> Seems it comes from 025dceb0fab3 ("bpf: powerpc64: optimize JIT passes
> >> for bpf function calls")
> > 
> > These emails are auto generated by bot.  I just look over the email and
> > verify it looks reasonable.  Moving the code around sometimes makes it
> > show up as a new bug.  Also changes to the Kconfig file can affect which
> > code is checked.
> > 
> > The commit that you mention does not generate a warning.  The warning
> > started in commit 025dceb0fab3 ("bpf: powerpc64: optimize JIT passes for
> > bpf function calls").
> > 
> 
> ???
> 
> Didn't I mention commit 025dceb0fab3 ("bpf: powerpc64: optimize JIT 
> passes for bpf function calls") ?
> 

Oh...  I'm not sure what I was looking at.  :P  Must be time for me to
knock off for the weekend.

regards,
dan carpenter
