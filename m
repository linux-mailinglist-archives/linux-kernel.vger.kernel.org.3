Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA94BB2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiBRGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:53:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiBRGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:53:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738564EC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:52:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21I40cAo014586;
        Fri, 18 Feb 2022 06:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JaeNQQbs3Kcj356KJb+QfrR3oTp++/Mw0RtYqcRa1KI=;
 b=yLk9hf/f7WV5iB8ukJLpnnqwWRPtYnONYi1IHWQ3Fv/nmJp/Nrx5hibiWGcqIhTI2VlG
 +Wc3p9mK295gA+5r7p87d7998u9okDXxaTbEMDYeF9QhuewUNjuhOrUMKEYmFY3di+V5
 /8FsiLeeg7D+TZm+EQucJfGj1eFmyPHpTxKf7Vb3O26ruC3dwTqsiEuBc6JjcNmjYWXU
 gQvID4R5WFyM8TA0PYek1K+kBOWPlZvA3bIaf2DFgEA1IraiI+5/+k7bo2yDn0bLXHB1
 jf8AqsJSVfeA3ao34O6CutnfN/lmvidlfY06yhpXmPNwLKqcSJv7TbMguiHUAtl19bCu GA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3r239-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 06:52:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21I6kqpn148138;
        Fri, 18 Feb 2022 06:52:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3020.oracle.com with ESMTP id 3e8n4wysd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 06:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrnlSO7Mh+RLiOe3GcqPQ0vUXQg8L26/uf2qlrM424ptaw5tGSCupeiNxBTS7kjPkRCPjdlduypsL5XLIvYDGptDb9PpY5zIBThQzol41JGqtu9hVPW+IzOF9TJRatVTvzEtdSkFvNM66+nAYsoZCOnXSdbyJbRmmjP02x/6b+4kGgkOPAgPRmHI5QQlmTkzGJow1o/p3fhta9Z6C4JwxEUEQAJkdA1whLWpGgxAf4MZxrxLHwdo6NOm8dz667eB6SsFgW8iRApYhsIpCkZW4M2uyinxs5VVvMCgzIrOWZbiGSt5T0TYBu8t6bQ/18GOJte3EfPkkKh99MFQ0U0Qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaeNQQbs3Kcj356KJb+QfrR3oTp++/Mw0RtYqcRa1KI=;
 b=GQO/5o24lfC2JQbr73P2Cjptle4ZeW2v5Ky88CGBL3najM/owRwyEFeXlDttlxLvSn2vOl48zISYK2Rhp6wlhCnifkg9GGCw4Xjv/oBtnljv7zyL3rEJZcQPtoB9g3kS57vGI4et3BYBpsW3seZfDd4yr2kYwdts9vx/mV9LxPvflQz5gnXdehYk1g0+evPTHw32wx8ak7PoFG0+pkFQ/Tm1Qs1V/M/WTKhwyRitAmxM8d2M/a3/BPv29G7bKGJPx3jUeaETj0B0To+RENZjSmypSmtWIA8PYJK3eg1ZFzmUxO+Jji+xrobCr5CbB+wsoOLWRNfDj9dY6pI68VDgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaeNQQbs3Kcj356KJb+QfrR3oTp++/Mw0RtYqcRa1KI=;
 b=DS4KTyw4jXozp7iwCW1sfHJ9gsjCYdzo89bGDBHBSnXOPzL1LuTo70H/P1J7y4jY/WfpwFoT4gSdsOJ6K6sh6QnQjONfEHoKUvlQFyYlvTgH15TLKnShZxZ78JgYhoEZspSa9fYCv3YyIYraPzrp1uD4dIGlzHjZ5nFPDWngq2w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5690.namprd10.prod.outlook.com
 (2603:10b6:303:19b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 06:52:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 06:52:28 +0000
Date:   Fri, 18 Feb 2022 09:52:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     liuyuntao <liuyuntao10@huawei.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yaozhenguo1@gmail.com
Subject: Re: [PATCH] hugetlb: clean up potential spectre issue warnings
Message-ID: <20220218065210.GD2467@kadam>
References: <20220217234218.192885-1-mike.kravetz@oracle.com>
 <20220218034025.17687-1-liuyuntao10@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218034025.17687-1-liuyuntao10@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0057.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2843a23-cd51-49a5-2e31-08d9f2ab3a6a
X-MS-TrafficTypeDiagnostic: MW5PR10MB5690:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB56903F2C4B521A95B25CC02E8E379@MW5PR10MB5690.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLLq7gKZFBIXQUZGvst5EyEOOt6RGSe76P6Cbbe8XaEIAo77gp92hvKLjVw1pU17AN5QL4Dn4WSrJ6zVoKWXRamSp7PpE5yRTwyCZUrB5nQdHZNaRidJDtg/LXPk/04PHsEYNQsD4UumZdW+tqX5/OSWXOg1Y36PzE7K0cFBRXip7RqlEwgJGHCMjNu5xcE5zyyySkgKcdpWpZ7CEnBHqPU08tGEtXjqO9JgeY1LMfL68S3UxHO3b8yEx323Ad1WIKJFMu1GMdBvxxNrnKM/B9uswrjZ/ATvczxuJo5bxZ4mSqJhX3kgXXKmqK4rRS4FGseR04qGKAB46+9O0Ha4u5bELNsNo9o78p+if6XPbx2cIAWjvWKHrO9R0siPFAdMIJmLzPUcyYrnGJfqebs14rWAGMcLwRNQk2w16IV5tfZDWzAAmkz0a52WU0/iIJfe+T9cgWg64xT6ZAzfDnvk5JFh3BvoWiYtedhZEirPUTlLP7stBV2Mw9FqZEwnbaPBZeByN9Efv79Pf8cMI2Zs0zf4B3Ux0MPkNi1k+Sht+teaLCHnbSaO6/FEeSsHme9MQXeeTuVdIQFMutQ38xg2u1ILX8BCCobj8UNUThbaDMwH889MTaxVHNcSiaJpcQEjwVz594NxKASEy4rjPa9Pf9jPuRPPMlUPoZNxOO5vN7hc71+srVZ5UMxM0XF2Pe8gcGvOfpRWx4riTSADsbbZ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8676002)(38100700002)(2906002)(44832011)(38350700002)(33716001)(8936002)(5660300002)(33656002)(6666004)(53546011)(52116002)(186003)(86362001)(66476007)(66556008)(66946007)(1076003)(6512007)(26005)(9686003)(4326008)(508600001)(6916009)(316002)(6506007)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hogEFMn+VaSAktoIavsTudNloOHnU1Yu0mBBrxKjbeuAYWnAjT/HgwBCRz6D?=
 =?us-ascii?Q?Tg01nOkZRKRngN+cDvpaI2+HioHC38e14wX8TPFpkwUF6KLeiIqyYMIlbfKb?=
 =?us-ascii?Q?DwBLfutonMwkRI9i45ERYW5lRhkRAHF53Ag3z/GLHWvwe9YFBzyInjUweLRo?=
 =?us-ascii?Q?cRpA3JKQ8ty91ghc/VGiPnwh2FapvF5KRs4yfOGuqi06iocuRQsB826kzsPT?=
 =?us-ascii?Q?rxj2bcWhObds2VXQ09ZAA3po77R6N2WotGBj17/4bIhbTmWmElul22TODLmk?=
 =?us-ascii?Q?rAJXQhM0vCILZbu+5l0KRiU8efHFyoHHdsijax/z2NZVpnuvo4yM/lyDKM3i?=
 =?us-ascii?Q?L1Tkc/glVmRfOg1LefhD1BpZpriIn07uT2w+hYfRuKlGxjbJdy3MruSB2ylB?=
 =?us-ascii?Q?JS0faKmYiTBxnv249zRyAwYtOTiwqMJL15huGIiOA+yA5xEZr8zBAuFcoo05?=
 =?us-ascii?Q?jcshmTqr6D7WZXx+2DCyHAVTCWBOJ4k9RNzy42msJFEWbkOEOlU3RFKdrS4i?=
 =?us-ascii?Q?Am2oKO9uoiH820L5Bo36ZJJVVRUIVVcS/mJlTvlsktJFHt6xB9DAS4vZKfgG?=
 =?us-ascii?Q?50ZYCoMq+q4VWimEIaYX4ZGVK4+EOPwIQAyYXUMoj6otk/78Uuz7/Gfq1pwx?=
 =?us-ascii?Q?3zncDwyjvRriZ2YHh2HHwGayvVfRhIwBrNUK10t9tMe91lQ0lPVjAhl2WiM5?=
 =?us-ascii?Q?1zy9SdfgS0SlctiBV5jCvOn8P9txQD+D7fTZvbnfRkHH7vCV1Q1L07nDLM+3?=
 =?us-ascii?Q?iBzHM7kj3zOPcD8spLvY7X7yJUbg6AopArVdFdfLrFabaTcPI3W45Zce6cMP?=
 =?us-ascii?Q?VyabkIk2pTjl0syZ/qKqFyS+qoDdVkfV/hHuOWptft6yGNo/Vvmm6xY5mfyu?=
 =?us-ascii?Q?oJCOCJhuJOmcnJPKPGxqMwNPGdDWB6tHCiJ8CQQjgE07+3NLhkKdnysjooyQ?=
 =?us-ascii?Q?dhl8wCOIIcyFvJVGGWYcuOO+28C9xUCC+VtyTYYPHIGfBrVje2xQ1SAjxvnZ?=
 =?us-ascii?Q?6PLtBejGqW61CP5+ovaSZFOZZ4dR56Za5IWTWboTLMnXdEkFVCOT7J1yBjXJ?=
 =?us-ascii?Q?QNSf5cAi2HYCuYRXkQ0L2nwwWPiBz9Q5OxJMrHAhaSXLC8xaCvPy9hc0IEmf?=
 =?us-ascii?Q?kuNDYJnDyfIfQAEdp6JUSAHdtKJaKfydf4g5JDzn1n+DChKfuI4mDMACUIYV?=
 =?us-ascii?Q?/d24aulp22UfGAu43Scf2h1r/uzC8IAYbXwxymhtWcDrtlVXtIewB9AtGutA?=
 =?us-ascii?Q?NlFWE3It4CqjaV0NbR+skurWINibjDNd/AZ72+nbTudIj60pdzWrjK5oHeLJ?=
 =?us-ascii?Q?AxvCQy+O/y5MvFMF5x1NQ48uQXGx/y9eLW9FRqoKfFr9XBZ0ceBKhlJ5G5RA?=
 =?us-ascii?Q?PDaAPwzgk99u+5uBrh3e/c/xzIpNtLgtZxmMDheopNFLeZsZvBoQNXyk8Ya8?=
 =?us-ascii?Q?VJ4T2jeUTCw+Etv+yizCJWMvzzEJ1vPrHpZg8DRlxGGLpi+gdJHq7CamtYys?=
 =?us-ascii?Q?8pUxUE8Z6xfmUhgxR1ys4S8Remj79YSRvjQYPnIJmxbrVRSGQ9U4hBj5aZZh?=
 =?us-ascii?Q?ga7vbNQbthLVUlfQHq2tCVTPBnsEm6rFbkEQao/GbcxNlx9H+h2ylOFyXyAF?=
 =?us-ascii?Q?NgDn3jeupzC7jDIXTvao2fwp4adKAI1UF7wdhmJqZwLQVqBglQlXpOEedkgF?=
 =?us-ascii?Q?A1G66w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2843a23-cd51-49a5-2e31-08d9f2ab3a6a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 06:52:28.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qi0gH3QDaeyOh4qe2P3cCs/3OCc4NNwGMD3MhlS3FyPmjleTUtDQP48daqq1QnxVoAiMTdhUfSrvmVKFOtvzg8Nd0Agmm9uvfIySU9QO3W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5690
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180040
X-Proofpoint-GUID: ZiuUeCTyQwF8MCqYkpw7ghLRXnH8-uzM
X-Proofpoint-ORIG-GUID: ZiuUeCTyQwF8MCqYkpw7ghLRXnH8-uzM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 11:40:25AM +0800, liuyuntao wrote:
> On 17 Feb 2022 15:42:18 -0800, Mike Kravetz wrote:
> > Recently introduced code allows numa nodes to be specified on the
> > kernel command line for hugetlb allocations or CMA reservations.  The
> > node values are user specified and used as indicies into arrays.  This
> > generated the following smatch warnings:
> > 
> > mm/hugetlb.c:4170 hugepages_setup() warn: potential spectre issue 'default_hugepages_in_node' [w]
> > mm/hugetlb.c:4172 hugepages_setup() warn: potential spectre issue 'parsed_hstate->max_huge_pages_node' [w]
> > mm/hugetlb.c:6898 cmdline_parse_hugetlb_cma() warn: potential spectre issue 'hugetlb_cma_size_in_node' [w] (local cap)
> > 
> > Clean up by using array_index_nospec to sanitize array indicies.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 1f0cca036f7f..6b14d0791cb4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/llist.h>
> >  #include <linux/cma.h>
> >  #include <linux/migrate.h>
> > +#include <linux/nospec.h>
> >  
> >  #include <asm/page.h>
> >  #include <asm/pgalloc.h>
> > @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
> >  			}
> >  			if (tmp >= nr_online_nodes)
> >  				goto invalid;
> > -			node = tmp;
> > +			node = array_index_nospec(tmp, nr_online_nodes);
> >  			p += count + 1;
> >  			/* Parse hugepages */
> >  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> > @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
> >  			break;
> >  
> >  		if (s[count] == ':') {
> > -			nid = tmp;
> > -			if (nid < 0 || nid >= MAX_NUMNODES)
> > +			if (tmp < 0 || tmp >= MAX_NUMNODES)
> 
> Here tmp is unsigned, no need to check if less than 0.
> Do we really have any automated checking? lol
> 

Smatch ignores checks for negative when it's part of a clamp test.  In
this situation the check for negative is obviously harmless so a warning
is a false positive.

If you wrote it the other way:

		if (tmp >= MAX_NUMNODES || tmp < 0)

then Smatch would print a warning because I try not to get involved with
style debates but I really don't like that style...  :P

regards,
dan carpenter
