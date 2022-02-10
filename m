Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645AB4B03DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiBJDWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:22:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiBJDWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:22:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6DF1EAFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:22:34 -0800 (PST)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JvMV23K00zccjp;
        Thu, 10 Feb 2022 11:21:30 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (7.193.23.74) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 11:22:31 +0800
Received: from huawei.com (10.174.177.28) by kwepemm600012.china.huawei.com
 (7.193.23.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Feb
 2022 11:22:30 +0800
From:   liuyuntao <liuyuntao10@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <fangchuangchuang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <liuyuntao10@huawei.com>, <windspectator@gmail.com>,
        <wuxu.wu@huawei.com>, <yaozhenguo1@gmail.com>
Subject: Re: [PATCH] hugetlbfs: fix a truncation issue in hugepages parameter
Date:   Thu, 10 Feb 2022 11:22:26 +0800
Message-ID: <20220210032226.9043-1-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <95d1dc4e-fc3b-fe3c-5d85-218a7410e966@oracle.com>
References: <95d1dc4e-fc3b-fe3c-5d85-218a7410e966@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-10  0:43 UTC, Mike Kravetz wrote:
> On 2/9/22 05:40, liuyuntao wrote:
> > From: Liu Yuntao <liuyuntao10@huawei.com>
> > 
> > When we specify a large number for node in hugepages parameter,
> > it may be parsed to another number due to truncation in this statement:
> > 	node = tmp;
> > 
> > For example, add following parameter in command line:
> > 	hugepagesz=1G hugepages=4294967297:5
> > and kernel will allocate 5 hugepages for node 1 instead of ignoring it.
> > 
> > I move the validation check earlier to fix this issue, and slightly
> > simplifies the condition here.
> > 
> > Fixes: b5389086ad7be0 ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> > Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> > ---
> >  mm/hugetlb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 61895cc01d09..0929547f6ad6 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4159,10 +4159,10 @@ static int __init hugepages_setup(char *s)
> >  				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
> >  				return 0;
> >  			}
> > +			if (tmp >= nr_online_nodes)
> > +				goto invalid;
> >  			node = tmp;
> 
> I am surprised none of the automated checking complained about that
> assignment.

I think such assignments may be very common in kernel, and thus automated
checks just ignore them.

> 
> >  			p += count + 1;
> > -			if (node < 0 || node >= nr_online_nodes)
> 
> I can't remember, but I think that check for node < 0 was added to handle
> overflow during the above assignment.  Do you remember Zhenguo Yao?

No, I don't. I took a look and found that the check for node < 0 has been
there since his first version of patch.

>    
> > -				goto invalid;
> >  			/* Parse hugepages */
> >  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> >  				goto invalid;
> 
> Thanks,
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> -- 
> Mike Kravetz

--
Liu Yuntao
