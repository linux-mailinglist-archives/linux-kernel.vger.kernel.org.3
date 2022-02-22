Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6604BF2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiBVHsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBVHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:48:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226243968D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:47:38 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AD318212C5;
        Tue, 22 Feb 2022 07:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645516056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqbKLfETHquQ//zH4sZBb/82594i7vrpZQI+kAgZZqo=;
        b=Ohsx3hUek/PGfa0AeORpHGURrKbjTevTEyxTe83vBBnN5JQxIft9Z0FTgbEQHc+XOeevQl
        APddYYsaRPnxB8nbR1jsqLlIDldZ6KEFSCbZDIexVwkp2QuNtNFjKf/w2tD559IcVYYyzU
        mJgnGqUTkxSliFbu/F3x7eI9mocqHn8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 875C5A3B9A;
        Tue, 22 Feb 2022 07:47:36 +0000 (UTC)
Date:   Tue, 22 Feb 2022 08:47:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-ID: <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-02-22 12:24:25, Mike Kravetz wrote:
> On 2/21/22 00:42, Michal Hocko wrote:
> > On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
> > [...]
> >> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
> >>  			}
> >>  			if (tmp >= nr_online_nodes)
> >>  				goto invalid;
> >> -			node = tmp;
> >> +			node = array_index_nospec(tmp, nr_online_nodes);
> >>  			p += count + 1;
> >>  			/* Parse hugepages */
> >>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> >> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
> >>  			break;
> >>  
> >>  		if (s[count] == ':') {
> >> -			nid = tmp;
> >> -			if (nid < 0 || nid >= MAX_NUMNODES)
> >> +			if (tmp >= MAX_NUMNODES)
> >>  				break;
> >> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
> >>  
> >>  			s += count + 1;
> >>  			tmp = memparse(s, &s);
> > 
> > This is an early boot code, how is this supposed to be used as a side
> > channel?
> 
> I do not have an evil hacker mind, but I can not think of a way this one time
> use of a user specified index could be an issue.  It does add noise to the
> BUILD REGRESSION emails sent to Andrew.

Maybe Smack can be taught to ignore __init and other early boot
functions.

I do not have any strong objections to using array_index_nospec because
it won't do any harm. Except that it makes a security measure a normal
comodity so any future changes to array_index_nospec and its users will
have to consult additional callers. Whether that is something we should
deeply care about, I don't know.

At minimum make sure to be explicit that this can hardly be a Spectre
gadget as it is a _one_ time early boot call. If there is a scenario
where this could be really abused then it should be mentioned
explicitly.
-- 
Michal Hocko
SUSE Labs
