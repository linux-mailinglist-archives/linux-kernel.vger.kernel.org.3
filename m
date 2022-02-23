Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C614C0E53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiBWIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiBWIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:36:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511116B084
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:35:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EF53C21138;
        Wed, 23 Feb 2022 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645605343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02cl20i2Gq77a/yxNfOu7oH0En+DuGmAqR7Fchia8K0=;
        b=UzvwPXkBd9GmrXx/Os/RtO2ydkyecHnJjjKFIucWXNY6ETW01xsThg3eHy0msviPF3aR5D
        eg+jkY3WePRE4zvxvtOfACRlph9JnzkS0/7zkidwE3BP8x513apnBzIpDMmdzbikRHUiQb
        N7IEkNCLlAqd84+mqfIgEujKsDkATNE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AEC6FA3B81;
        Wed, 23 Feb 2022 08:35:43 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:35:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-ID: <YhXx3yYLMss+Ya4u@dhcp22.suse.cz>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
 <MWHPR1101MB2160B81491FFE4411B18F7ECFD3B9@MWHPR1101MB2160.namprd11.prod.outlook.com>
 <20220222163610.GG3943@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222163610.GG3943@kadam>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-02-22 19:36:10, Dan Carpenter wrote:
> On Tue, Feb 22, 2022 at 04:15:45PM +0000, Schaufler, Casey wrote:
> > > -----Original Message-----
> > > From: Michal Hocko <mhocko@suse.com>
> > > Sent: Monday, February 21, 2022 11:48 PM
> > > To: Mike Kravetz <mike.kravetz@oracle.com>
> > > Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Baolin Wang
> > > <baolin.wang@linux.alibaba.com>; Zhenguo Yao
> > > <yaozhenguo1@gmail.com>; Liu Yuntao <liuyuntao10@huawei.com>; Dan
> > > Carpenter <dan.carpenter@oracle.com>; Andrew Morton <akpm@linux-
> > > foundation.org>
> > > Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
> > > 
> > > On Mon 21-02-22 12:24:25, Mike Kravetz wrote:
> > > > On 2/21/22 00:42, Michal Hocko wrote:
> > > > > On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
> > > > > [...]
> > > > >> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
> > > > >>  			}
> > > > >>  			if (tmp >= nr_online_nodes)
> > > > >>  				goto invalid;
> > > > >> -			node = tmp;
> > > > >> +			node = array_index_nospec(tmp, nr_online_nodes);
> > > > >>  			p += count + 1;
> > > > >>  			/* Parse hugepages */
> > > > >>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> > > > >> @@ -6889,9 +6890,9 @@ static int __init
> > > cmdline_parse_hugetlb_cma(char *p)
> > > > >>  			break;
> > > > >>
> > > > >>  		if (s[count] == ':') {
> > > > >> -			nid = tmp;
> > > > >> -			if (nid < 0 || nid >= MAX_NUMNODES)
> > > > >> +			if (tmp >= MAX_NUMNODES)
> > > > >>  				break;
> > > > >> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
> > > > >>
> > > > >>  			s += count + 1;
> > > > >>  			tmp = memparse(s, &s);
> > > > >
> > > > > This is an early boot code, how is this supposed to be used as a side
> > > > > channel?
> > > >
> > > > I do not have an evil hacker mind, but I can not think of a way this one time
> > > > use of a user specified index could be an issue.  It does add noise to the
> > > > BUILD REGRESSION emails sent to Andrew.
> > > 
> > > Maybe Smack can be taught to ignore __init and other early boot
> > > functions.
> > 
> > Why is Smack getting called out? The relationship is not obvious.
> > 
> 
> He meant Smatch.  It's a really common mistake that I did not anticipate
> in 2002.

Right. My bad.

> I can probably silence the spectre warnings for __init functions.  TBH,
> I don't really understand spectre at all so I mostly ignore those
> warnings.  :/

AFAIU the spectre gadget would need to be called repeatedly to be usable
for a side channel attack. I might be really missing some scenario but
to me it seems that __init functions cannot really be used for that.
-- 
Michal Hocko
SUSE Labs
