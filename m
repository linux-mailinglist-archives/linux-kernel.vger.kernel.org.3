Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1223C570D37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiGKWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKWLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:11:48 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4956248EC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:11:46 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BLpPhT015381;
        Mon, 11 Jul 2022 15:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=x9+kap6gAi8IXk8M7c+L0g4FGJ1lwP/51IE/yUmUlsE=;
 b=edidErxe/wz+r+KVUhHBVZ3YQP/I7R43zHoDCPicc5iIyBzhHkY3mCZe+m2L2n1poX5X
 1nl7PFp7+OX0+iiFy5aKhNnFEPhwd7I6rXpXe42BTN7vLnmsqwSxX6W3EM8YoXRsxhu5
 NiUuFHIClVV/Vhxf3NR169Z2GaRP+OgtcEO3M53wR+UD82ZZWhbtfwuo0RjZMteG1LNd
 Wz4tGHv8FYgshUnZ4SyPKze7BtefJg+BsYv4qhyFrlrSOFnO69HhgP3w++JZBA6ljKf4
 qLZ0Hqj46s9yQfipiDz2iscHe7B98KewVZA9aGws1iB+F4dgaHJyX1GjE2y0jbWBiJRv Ug== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3h74y4sp38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 15:11:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ05i0qgde4gkYTppScCXhCpyvnfNis4cpFyvwnWJEnD6kQN2UlRGNvryQag1KGysAqjr75T0l3+omHR3Zlu7eREsvkrgpvTNRoj/GZE5bMe7KLQgSStVVFClaK89c2wnsV7k4HtTvIWkh5TwQ/55Z7r2Cb9sDJ3qO+DaODOuPnINvHZlKtLfrDE0JVS1o6bEVXZOhGcdi4sSD2IzjgVTbhogTVB1cx3REeObQ/LNqJFm9Rd6Djvt97MhLxzwkfB3HcyCn+t07OQJtzZgfV8/F5O3nLEdQPvIPhyTcWE1bQx4GdthTFUvVB2CSlU/xlFhDl5vKf835TEzsfc8+ZBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9+kap6gAi8IXk8M7c+L0g4FGJ1lwP/51IE/yUmUlsE=;
 b=OIlWurFARdO4tiE/Em9Vczr7fZreWtEhxlnhe1ZCKN3x/Lzr9LAfNJc8mjrQW5UU85tij+wenICRkOwP1Vwu5jcftKD3LLP5OvTCkw6npYNY3cUpBV1i+tgzRHuVloqcSUMt3YfD/TxfkPvNKTubxmMhfaVTWPzZQmfn1cagjtiIfNQdnkWXj0t8oc9DfSFqhLwuhMaKTNUb82uV03pDoYJ0kBLbZY7NJNTV8XWKzqJGEAXj1SpqEIjSL9bLVmoN2WfI4Q2PuaiAw/NZosBGd+6EHKeZF2Ozr3WNpi36H5YUFuITDmaPlPI77+JKdPHM0z16Ppker2PQTFyhq4SbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BYAPR11MB3238.namprd11.prod.outlook.com (2603:10b6:a03:7e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 22:11:21 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::45e5:975f:214a:f0d6%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 22:11:21 +0000
Date:   Mon, 11 Jul 2022 18:11:18 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] coccinelle: Remove script that checks replacing 0/1 with
 false/true in functions returning bool
Message-ID: <20220711221118.GA22897@windriver.com>
References: <20220711164243.092eec75@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711164243.092eec75@gandalf.local.home>
X-ClientProxiedBy: YQBPR0101CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::20) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b451f5-5b71-4139-650d-08da638a494a
X-MS-TrafficTypeDiagnostic: BYAPR11MB3238:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vAbdSjZ1xWGEP5qjZwlPF2+A/F7rjPR7Fi3+Jr/HuUNgVqtOhaD2HIl+5iKmT1Op/1784oe+Sfe9ux9g/Ri5Ib7p0JYKZEWTKPOyCes+DC6XQxQGFhUF8fnj/BG3aVWbk0wYEhxkKwm4mpgCEJVK+UfD20wOdnVkwh9PV51iyPAD8BQTct9gsuez+n+IYgGJ9QZpXrzcllCwsmCf/6hsLJ5qI7MjIySZoLdl+nFTjQyeEys+HQEBu+kCCHubG0o7gzIH80lrCRtn/LCFvDjoGrHMksjhv8affoOAVqe48PE/AaHmXlHy2eJJfjuQqFzzmuj35ygeX7KhlbIl9facagmTEsSVAhtt25oPG2OVZv/t9EfuRdqfMfIV+0X6wKTG1wGtsXfXINBBZhreEXGzjzHuoYw/hT33C/aM/PZuEvrunBrQ7zOq17pNLCKC+6qSrIECK/4L0sR2hO8gBrfV2OFkeCRr10trPUuAWk6EvaMtU8NDgnYJn2NnVFcFBrGInQV7nAoUbJBDivHxZPIb4DuKLzIICFaceYrzVB6fOCqA0g+ntFgJGg8qcigOKxXm75S/9swfoaX/ql6rPvIZVfaL66ysGci65Z8QuBtio3ek4XmOlbIaGL09RTzmcUaKnUl/64Rmxbd3rNnNWYndwvHHHXvK2h+Nrnw4QhCFVHKH5yQf8Sp/JDK0bm24zjdkAtfbiFRYPwKvBm6W4jmTPlWteoZC/gMzKgZREf2EqZa5LOUjPIjSUq3Q/0Krjd42GdDgEMbPs+fqJ4Apd7P2YLkSpzgRUt/1fi3trtB1HADNpLczTIlO6Dsbe2PyEDvP+/lwfqrpsmUhqXm+N356RYlsSj+ukLYPtQjwG/IVcfXt/r+mAzXHuOqEBhYRO9+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(44832011)(36756003)(5660300002)(4326008)(6486002)(8936002)(2906002)(33656002)(966005)(66556008)(8676002)(66946007)(86362001)(66476007)(6916009)(54906003)(316002)(1076003)(52116002)(6512007)(6666004)(41300700001)(6506007)(26005)(478600001)(186003)(83380400001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MwizbRkHFmFJX7FaTcVB7qkldvTLVOdY20hgZB/2J0fv4VbSR/rVMZeXW5f?=
 =?us-ascii?Q?fEryhrIUtcHH6oLdowzioL/rPxBbGzv7D3nZBviz5HXw+SRYFKU16IZntufq?=
 =?us-ascii?Q?B8dFjZftDBsD87FQUQk7mmTEvUtSxbPxCNfcNIVn2D0EM9grls4ZGjt5JOQ8?=
 =?us-ascii?Q?ESZ1a2/H+rU1KAOUN5WiRfABlTHqPUZIpOf87SJ0QUE+voMs0bQwwYcgMQR0?=
 =?us-ascii?Q?l1uW5vQ3SnS+Lu3qtXEvys2cdSpwlqudYjBO6ll7xQmV/D8MW6Lok+7KovHz?=
 =?us-ascii?Q?r1p2kpnKOeFo/UXCq8PDA1jMbrLOeTpkuBmUIPiSCkaWpOuihMmFIFASMhC6?=
 =?us-ascii?Q?883AJgMK64MPkLu9g3zZyqiY+8txdkUTuFj5dOHDlifi+gi+i31mYW0cI/8W?=
 =?us-ascii?Q?ygnWTfhLiA2phbg0SxWdpCF48v7Qz7sjUexhTgXbiF2pPEifx3DPMaEIOSGH?=
 =?us-ascii?Q?ZlwVyjSBFZ6Qi4oZADYIr7dTAqPFNqijnoLDZAhr1KgGu9TZKa3vmp//szNY?=
 =?us-ascii?Q?0cWamicyC8FRwyRiiZ9SvPbaGqVtZUaleO21RDHMyHxcnDzEhkHHiLckT0QI?=
 =?us-ascii?Q?OgvQy6RXcD2KxqtcHo4RXNTk5EpH8LHhNlajSOmDSA1vJ8E5NvYKOmoWb2nu?=
 =?us-ascii?Q?WEx3DkbrHCS9tcqDj3e+tteLfXZf45Eh69ibMvczohP45lD5UcroqSVg/c7M?=
 =?us-ascii?Q?3cm3/mkoy3v1fDtejgYvbrGaN8K3tDGDNgA1l1ZHmni6jQO3CsFSfld1KcwP?=
 =?us-ascii?Q?qhGLqfDZjyypx/hG0tsyFdg3ubN9PjJS5vj03mYhwiNn3c7SQjDlR3NIs6ki?=
 =?us-ascii?Q?pdNM/8XQ8hT0E7SVlynt/vKdjKnbvt51jrONfkmOh6JnqPKPeQSFJw4hgSw/?=
 =?us-ascii?Q?givKPRrLrGI5SCNXxUds4vULEEd4kEBff2IP6UvvP1e4TmyhG7guCgolXNO0?=
 =?us-ascii?Q?n1P1p8q6cbPFT3wKyrIzVJJ/uMnbIjnyEt+kHkxhzWA4cNsdY9THXPhA8M5z?=
 =?us-ascii?Q?n8qFrgLmuotXUpEz1jwzLggeSy1FjrswfHb7QdLs2ZVnnebhoDptvRUSMgxL?=
 =?us-ascii?Q?dJi0SjTHmqzpZndkHByO1rJVVziAZndIzmtX1pUUIIEbvl1hwM4fOZ2JII2M?=
 =?us-ascii?Q?LeRzpZCnwaKbTlDb0uOKZmvs4wl3s152N/vhnmBdJlrhw9Xc65AF+0DnPdT9?=
 =?us-ascii?Q?CbYMYQi+GvRKYigaeFkAOw8pU73ZRU+ziUIUHGrAizc4KnQ9C8fYGfb79XW2?=
 =?us-ascii?Q?ZG3UgzL9uGd1NjCo1BQYODCfrkq3vem96BrleqP19Y5vl6yikErOhsNhXpLb?=
 =?us-ascii?Q?H6AaIaEbsJBIto8Z/MfkaZHFn7O3xkdUfr1Y0kaEI+DgbkjiBh2JOShU3Ru/?=
 =?us-ascii?Q?SIu0eao+yQoyMGjudu0d72G4AoFN9sqV3UEVe03SPoJVx3K93E1A5lIEMJxa?=
 =?us-ascii?Q?x/YdlJuD1bQKanb/XZsY/2/YXxaWTWqbOgzZc0lxgvrwOFuFyMj6jb54m/p9?=
 =?us-ascii?Q?w2nYvQ6IJSu8Es85a84yTCkKOYHwvBEg67nB9AdZkYMYI27uIqlR0+j+V8FY?=
 =?us-ascii?Q?xBEPPZUC1IF7ajGO0LtFDQMW7zGxiPf1hagHpmqmGkVrjcjd2oN5PTZPFpY9?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b451f5-5b71-4139-650d-08da638a494a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 22:11:21.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAgXzrHYWb5NVl3YUgvMSZOr5njUQlDk3HKZmrmtujdDaAliTT5gUeulbS4A9SCPcWjGeKmb47O6INktKDyTLKuVWoZ25akDecq1PjX+9sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3238
X-Proofpoint-GUID: 3P3bWIXpJ9geyqyrEO1bSx2w30oqMcqE
X-Proofpoint-ORIG-GUID: 3P3bWIXpJ9geyqyrEO1bSx2w30oqMcqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_25,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[PATCH] coccinelle: Remove script that checks replacing 0/1 with false/true in functions returning bool] On 11/07/2022 (Mon 16:42) Steven Rostedt wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There is nothing wrong with current code that returns 0 or 1 for a
> function returning bool. It is perfectly acceptable by the C standard.
> 
> To avoid churn of unwanted patches that are constantly sent to maintainers
> who do not care about this change, remove the script that flags it as an
> issue. This issue is not worth the burden on maintainers to accept
> useless patches.

This is long overdue.  Our maintainers are a finite resource and if we
can't even take basic steps to filter them from ground level noise, then
we are letting them down, and then eventually suffering the consequences.

I've watched far too many of these go by on lkml and thought "oh look,
there goes another one".  Not ideal.

I don't think I've ever Ack'd a patch I've not been Cc'd on but this is
different.  It isn't about me -- it is about what we've all seen on lkml.

So...

Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Paul.
--

> 
> Link: https://lore.kernel.org/all/20220705073822.7276-1-jiapeng.chong@linux.alibaba.com/
> Link: https://lore.kernel.org/all/20220429075201.68581-1-jiapeng.chong@linux.alibaba.com/
> Link: https://lore.kernel.org/all/1649236467-29390-1-git-send-email-baihaowen@meizu.com/
> Link: https://lore.kernel.org/all/20220317014740.3138-1-jiapeng.chong@linux.alibaba.com/
> Link: https://lore.kernel.org/all/190b5c2f2f2fb9cc775fce8daed72bf893be48a4.1642065293.git.davidcomponentone@gmail.com/
> Link: https://lore.kernel.org/all/20211214113845.439392-1-deng.changcheng@zte.com.cn/
> Link: https://lore.kernel.org/all/20210824065735.60660-1-deng.changcheng@zte.com.cn/
> Link: https://lore.kernel.org/all/20210824064305.60081-1-deng.changcheng@zte.com.cn/
> Link: https://lore.kernel.org/all/20210824062359.59474-1-deng.changcheng@zte.com.cn/
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  scripts/coccinelle/misc/boolreturn.cocci | 59 ------------------------
>  1 file changed, 59 deletions(-)
>  delete mode 100644 scripts/coccinelle/misc/boolreturn.cocci
> 
> diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
> deleted file mode 100644
> index 29d2bf41e95d..000000000000
> --- a/scripts/coccinelle/misc/boolreturn.cocci
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/// Return statements in functions returning bool should use
> -/// true/false instead of 1/0.
> -//
> -// Confidence: High
> -// Options: --no-includes --include-headers
> -
> -virtual patch
> -virtual report
> -virtual context
> -
> -@r1 depends on patch@
> -identifier fn;
> -typedef bool;
> -symbol false;
> -symbol true;
> -@@
> -
> -bool fn ( ... )
> -{
> -<...
> -return
> -(
> -- 0
> -+ false
> -|
> -- 1
> -+ true
> -)
> -  ;
> -...>
> -}
> -
> -@r2 depends on report || context@
> -identifier fn;
> -position p;
> -@@
> -
> -bool fn ( ... )
> -{
> -<...
> -return
> -(
> -* 0@p
> -|
> -* 1@p
> -)
> -  ;
> -...>
> -}
> -
> -
> -@script:python depends on report@
> -p << r2.p;
> -fn << r2.fn;
> -@@
> -
> -msg = "WARNING: return of 0/1 in function '%s' with return type bool" % fn
> -coccilib.report.print_report(p[0], msg)
> -- 
> 2.35.1
> 
