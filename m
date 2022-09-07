Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E75B0EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIGU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIGU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AF4AD9B9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBAD61A8A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F69C433C1;
        Wed,  7 Sep 2022 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662584353;
        bh=FniondtFbpoxyTfBIT/tD9EaOffiZzbj+1i6uXyMxKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMug+Taf20KbZ8zIj/PQfrkYE8FfrIMY8WMjII3yQUm0cPgAuy8hk+xQnzsiM52qV
         DXpqiSjYvWK1tzW8Y0q19Tn4gDBPbAodLlmF2dfNmnyXssKSOt5CuzcLe/ZBkqXfyX
         gcji/ukWAB/IstDYNQCtfr7j2+fzjdJPGhjJtguAeOYlE4cHfTR8TAP/jv414jx8xG
         7zdxa/bSlZrTRuL0rBQJTCS3HrGItneKuIuHKO08hWAclQUacwdBwoldEJOEDnWOUB
         JT+5Y/GZfww+TsV3oUD13RME09kRA/jLjR0+YUy1Qn6j3tnGiwZqlpRLomUpZbJ8k+
         vEZ7HQjbFXJLA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: Re: [PATCH] mm/damon: Remove duplicate get_monitoring_region() definitions
Date:   Wed,  7 Sep 2022 20:59:11 +0000
Message-Id: <20220907205911.62483-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907172712.61006-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 17:27:12 +0000 SeongJae Park <sj@kernel.org> wrote:

[...]
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index b1335de200e7..01938f33038d 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -172,3 +172,31 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> > 
> >  	return hotness;
> >  }
> > +
> > +static inline int walk_system_ram(struct resource *res, void *arg)
> > +{
> > +	struct damon_addr_range *a = arg;
> > +
> > +	if (a->end - a->start < resource_size(res)) {
> > +		a->start = res->start;
> > +		a->end = res->end;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Find biggest 'System RAM' resource and store its start and end address in
> > + * @start and @end, respectively.  If no System RAM is found, returns false.
> > + */
> > +bool get_monitoring_region(unsigned long *start, unsigned long *end)
> > +{
> > +	struct damon_addr_range arg = {};
> > +
> > +	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
> > +	if (arg.end <= arg.start)
> > +		return false;
> > +
> > +	*start = arg.start;
> > +	*end = arg.end;
> > +	return true;
> > +}
> 
> 'ops-common.c' is for code that common in monitoring operations
> implementations.  I'd prefer to have yet another source file for the DAMON
> modules including reclaim and lru_sort, say, 'modules-common.c'.

Or, putting it in damon/core.c might make more sense.


Thanks,
SJ

[...]
