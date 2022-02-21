Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793104BDDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiBUNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:32:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245412AbiBUNct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:32:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8842CE002
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:32:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 30FC22112A;
        Mon, 21 Feb 2022 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645450345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CP7VUMzZ4gkdONg11YZaPFXMNI/oKfczzggdLkohEnU=;
        b=uFusi8Hu7UzMg+ROxYnvOzXWhN7S44WVxjAsURFq09+M+vGXYBr8D+xgZzuXRfxHqKn5/l
        lmwY2NBLmTXepbLAFS+amw9iFVDdaI4nDo0S127gwjwvsv0tk69NS9wFek0KbK+y1z5wBw
        Wo9/gKRrYQWu/7rjwQfAXZE9swPWur8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 034BDA3B85;
        Mon, 21 Feb 2022 13:32:24 +0000 (UTC)
Date:   Mon, 21 Feb 2022 14:32:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch/x86/mm/numa: Do not initialize nodes twice
Message-ID: <YhOUZfWIthy/08I0@dhcp22.suse.cz>
References: <20220218224302.5282-1-osalvador@suse.de>
 <20220218224302.5282-2-osalvador@suse.de>
 <YhNZQgGSZglGQvcg@dhcp22.suse.cz>
 <YhNfwCO3xTIavi5v@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhNfwCO3xTIavi5v@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-02-22 10:47:44, Oscar Salvador wrote:
> On Mon, Feb 21, 2022 at 10:20:02AM +0100, Michal Hocko wrote:
> > On Fri 18-02-22 23:43:02, Oscar Salvador wrote:
> > > Why setting the node online saves us then? Well, simply because
> > > __try_online_node() backs off when the node is online, meaning
> > > we do not end up calling register_one_node() in the first place.
> > 
> > This is really a mess and a house built on sand. Thanks for looking into
> > it and hopefully this can get cleaned up to a saner state.
> 
> Yes, I am willing to have a deep look into that and see how we can
> improve the situation.
> 
> > This sha1 is from linux-next very likely so it won't be persistent.
> > Please drop it.
> 
> Yes, it is. I guess it is fine to not have a "Fixes" tag here, so I will
> remove it then.

Normally we use sha in Fixes tag and I am not sure how many scripts we
would confuse if there was no but I guess it is good enough to mention
the patch name in the description. Theoretically we could have folded it
to my patch but I think it would be better to have it separate because
a) it gives a nice overview of the mess we should be dealing with and b)
the original patch would likely be more convoluted than necessary.
-- 
Michal Hocko
SUSE Labs
