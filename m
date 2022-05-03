Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A1518943
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiECQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbiECQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:07:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E624193C1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:04:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B23861F74D;
        Tue,  3 May 2022 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651593856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gg2obvCP4uGseNM46DcVy8f8HF/W6yCP38YvJGSTCWY=;
        b=WXl7GwcbpZMOrdvBuHPm05ZIolsnfWDVcyxt2pJJi0NW3TbhVom0xDX1WuJcSWvlq7cthf
        HuG8d5ra9EZ6ufcEt75ipkmTdfbDXvguUtiKRCMACmKu2b/d7XPJpKtX09Cmxt/tKazh8q
        0ucBzIOCAnyRPUM0uDZsr6B1ghqIOZk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DAB3B2C145;
        Tue,  3 May 2022 16:04:15 +0000 (UTC)
Date:   Tue, 3 May 2022 18:04:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     liam.howlett@oracle.com, willy@infradead.org, walken.cr@gmail.com,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
> Hello!
> 
> Just following up from off-list discussions yesterday.
> 
> The requirements to allocate on an RCU-protected speculative fastpath
> seem to be as follows:
> 
> 1.	Never sleep.
> 2.	Never reclaim.
> 3.	Leave emergency pools alone.
> 
> Any others?
> 
> If those rules suffice, and if my understanding of the GFP flags is
> correct (ha!!!), then the following GFP flags should cover this:
> 
> 	__GFP_NOMEMALLOC | __GFP_NOWARN

GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN
 
> Or is this just a fancy way of always returning NULL or some such?  ;-)

It could fail quite easily. We would also want to guarantee (by
documenting I guess) that the page allocator never does anything that
would depend or invoke rcu_synchronize or something like that.

I believe this is the case currently.
-- 
Michal Hocko
SUSE Labs
