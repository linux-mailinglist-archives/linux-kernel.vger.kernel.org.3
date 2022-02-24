Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AA4C2816
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiBXJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiBXJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:32:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A841FBB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:31:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B72E6212B8;
        Thu, 24 Feb 2022 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645695101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nPvKs1oIrJwWVDpcneKVOW7b7d/cdXeZfU3+c7ooSo=;
        b=O4QVF+uy/FlVk3fzEES2po7V50s0tZqU1eMi1aeX7+BsS8jsGrmmWQcmv48eHy5k3hxJXu
        gtaVQsYpEojmMvVya4rCCHCOvSYdYKN1r/5zjAhNjTkCfxGrLnCY5/1VyB5XQfMQomI7Yo
        nggnnnAYM9+UXUv9PPQLYtLszaeRRi4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2682EA3B85;
        Thu, 24 Feb 2022 09:31:41 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:31:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Message-ID: <YhdQfPuOWNy+S8vt@dhcp22.suse.cz>
References: <20220218212946.35441-1-mike.kravetz@oracle.com>
 <YhNQf3LUZzNRD7u0@dhcp22.suse.cz>
 <26565cd7-01b0-197c-6ce9-af92f5bc8563@oracle.com>
 <YhSVGPQ6VIQfBZ9o@dhcp22.suse.cz>
 <4bad1923-354d-3858-0339-82df8c090c3f@oracle.com>
 <YhXxXg45loivQF10@dhcp22.suse.cz>
 <d4f8579f-c6a2-2bd5-2b55-63a05b50b0d2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f8579f-c6a2-2bd5-2b55-63a05b50b0d2@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 10:36:55, Mike Kravetz wrote:
> On 2/23/22 00:33, Michal Hocko wrote:
> > On Tue 22-02-22 13:53:56, Mike Kravetz wrote:
> >> On 2/21/22 23:47, Michal Hocko wrote:
> >> How about adding this note to the commit message?
> >>
> >> Note: these routines take a user specified value used as an index ONCE
> >> during the boot process.  As a result, they can not be used as a general
> >> method of exploitation.  Code changes are being made to eliminate warnings.
> > 
> > This would help but the question whether the change is worth remains.
> > Does this change have any other advantage than silencing the warning?
> > 
> 
> Silencing the warnings was the primary motivation for the change.  If Dan
> has a plan to change smatch so that they are silenced for __init functions,
> then it would be better to not make the changes to use array_index_nospec.
> 
> While making the changes, I shuffled the code a little and did not immediately
> notice that it also 'fixes' an overflow/truncation issue when assigning an
> unsigned long to int as addressed in [1].  We should probably make this change
> whether or not we use array_index_nospec to silence warnings.
> 
> [1] https://lore.kernel.org/linux-mm/20220209134018.8242-1-liuyuntao10@huawei.com/

Yeah, this makes sense to me.
-- 
Michal Hocko
SUSE Labs
