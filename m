Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8464C0E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbiBWIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiBWIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:34:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550847548
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:33:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA0B01F43D;
        Wed, 23 Feb 2022 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645605214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlBp6viB771Oj+TE+GJseCVUxyBgZ+42wgX49Qr/87E=;
        b=QPUslG/i28MwIlcysXokkMrPqi0AIx58bQb8fcJ/5ecPydtBbLiYqJwuc9Jqf40wLKNSA/
        g3TqGHMdafsIBVN11wkdb0YsXqlzjNw2REzPpkCAWsSl7s0V+AO6LOdMEVvK8NCialtwsV
        iRa/nhIBlRMvXpFbISqSNwzUXrZc29A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C360A3B87;
        Wed, 23 Feb 2022 08:33:34 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:33:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-ID: <YhXxXg45loivQF10@dhcp22.suse.cz>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
 <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-02-22 13:53:56, Mike Kravetz wrote:
> On 2/21/22 23:47, Michal Hocko wrote:
> > On Mon 21-02-22 12:24:25, Mike Kravetz wrote:
> >> On 2/21/22 00:42, Michal Hocko wrote:
> >>> On Fri 18-02-22 13:29:46, Mike Kravetz wrote:
> >>> [...]
> >>>> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
> >>>>  			}
> >>>>  			if (tmp >= nr_online_nodes)
> >>>>  				goto invalid;
> >>>> -			node = tmp;
> >>>> +			node = array_index_nospec(tmp, nr_online_nodes);
> >>>>  			p += count + 1;
> >>>>  			/* Parse hugepages */
> >>>>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> >>>> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
> >>>>  			break;
> >>>>  
> >>>>  		if (s[count] == ':') {
> >>>> -			nid = tmp;
> >>>> -			if (nid < 0 || nid >= MAX_NUMNODES)
> >>>> +			if (tmp >= MAX_NUMNODES)
> >>>>  				break;
> >>>> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
> >>>>  
> >>>>  			s += count + 1;
> >>>>  			tmp = memparse(s, &s);
> >>>
> >>> This is an early boot code, how is this supposed to be used as a side
> >>> channel?
> >>
> >> I do not have an evil hacker mind, but I can not think of a way this one time
> >> use of a user specified index could be an issue.  It does add noise to the
> >> BUILD REGRESSION emails sent to Andrew.
> > 
> > Maybe Smack can be taught to ignore __init and other early boot
> > functions.
> > 
> > I do not have any strong objections to using array_index_nospec because
> > it won't do any harm. Except that it makes a security measure a normal
> > comodity so any future changes to array_index_nospec and its users will
> > have to consult additional callers. Whether that is something we should
> > deeply care about, I don't know.
> > 
> > At minimum make sure to be explicit that this can hardly be a Spectre
> > gadget as it is a _one_ time early boot call. If there is a scenario
> > where this could be really abused then it should be mentioned
> > explicitly.
> 
> How about adding this note to the commit message?
> 
> Note: these routines take a user specified value used as an index ONCE
> during the boot process.  As a result, they can not be used as a general
> method of exploitation.  Code changes are being made to eliminate warnings.

This would help but the question whether the change is worth remains.
Does this change have any other advantage than silencing the warning?

-- 
Michal Hocko
SUSE Labs
