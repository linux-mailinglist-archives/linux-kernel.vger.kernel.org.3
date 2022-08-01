Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ABB586654
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiHAI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHAI13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:27:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9E33353
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:27:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38C104D5D2;
        Mon,  1 Aug 2022 08:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659342445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SdhTMIjPPoyPm4ytL5iSfFfAavCD7IKkQAlMtSUtLeU=;
        b=cgP3t2tXFUGdDQGWLqEOjh/oS6KIQ81XvO6+x3y60b18u+hx+j67HAFA7Vbz5xDoHKRf8C
        gnx7tOCviWhbwsym7YB9Gl3JwZsRpuwEmE5skkNWIRxxyg01XE8YUGu7CarwfQnNOIgQaU
        BoMnqdhmz5iUu41RCF8W7OZ0i3AoTjM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CBA713A72;
        Mon,  1 Aug 2022 08:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fr5ZAG2O52JqKQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 01 Aug 2022 08:27:25 +0000
Date:   Mon, 1 Aug 2022 10:27:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        quic_pkondeti@quicinc.com, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YueObAiml8c74DLV@dhcp22.suse.cz>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <YuKfQoOHG1celfBK@dhcp22.suse.cz>
 <6b646ff2-b6f6-052e-f3f4-3bf05243f049@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b646ff2-b6f6-052e-f3f4-3bf05243f049@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-07-22 21:17:44, Charan Teja Kalla wrote:
> Thanks Michal for the reviews!!
> 
> On 7/28/2022 8:07 PM, Michal Hocko wrote:
> >> FAQ's:
> >> Q) Should page_ext_[get|put]() needs to be used for every page_ext
> >> access?
> >> A) NO, the synchronization is really not needed in all the paths of
> >> accessing page_ext. One case is where extra refcount is taken on a
> >> page for which memory block, this pages falls into, offline operation is
> >> being performed. This extra refcount makes the offline operation not to
> >> succeed hence the freeing of page_ext.  Another case is where the page
> >> is already being freed and we do reset its page_owner.
> > This is just subtlety and something that can get misunderstood over
> > time. Moreover there is no documentation explaining the difference.
> > What is the reason to have these two different APIs in the first place.
> > RCU read side is almost zero cost. So what is the point?
> Currently not all the places where page_ext is being used is put under
> the rcu_lock. I just used rcu lock in the places where it is possible to
> have the use-after-free of page_ext. You recommend to use rcu lock while
> using with page_ext in all the places?

Yes. Using locking inconsistently just begs for future problems. There
should be a very good reason to use lockless approach in some paths and
that would be where the locking overhead is not really acceptable or
when the locking cannot be used for other reasons.

RCU read lock is essentially zero overhead so the only reason would be
that the critical section would require to sleep. Is any of that the
case?

If there is a real need to have a lockless variant then I would propose
to add __page_ext_get/put which would be lockless and clearly documented
under which contexts it can be used and enfore those condictions (e.g.
reference count assumption).

> My only point here is since there may be a non-atomic context exist
> across page_ext_get/put() and If users are sure that this page's
> page_ext will not be freed by parallel offline operation, they need not
> get the rcu lock.

Existing users are probably easy to check but think about the future.
Most developers (even a large part of the MM community) is not deeply
familiar with the memory hotplug. Not to mention people do not tend to
follow development in that area and assumptions might change.

[...]
> >> @@ -298,9 +300,26 @@ static void __free_page_ext(unsigned long pfn)
> >>  	ms = __pfn_to_section(pfn);
> >>  	if (!ms || !ms->page_ext)
> >>  		return;
> >> -	base = get_entry(ms->page_ext, pfn);
> >> +
> >> +	base = READ_ONCE(ms->page_ext);
> >> +	if (page_ext_invalid(base))
> >> +		base = (void *)base - PAGE_EXT_INVALID;
> > All page_ext accesses should use the same fetched pointer including the
> > ms->page_ext check. Also page_ext_invalid _must_ be true here otherwise
> > something bad is going on so I would go with
> > 	if (WARN_ON_ONCE(!page_ext_invalid(base)))
> > 		return;
> > 	base = (void *)base - PAGE_EXT_INVALID;
> 
> The roll back operation in the online_page_ext(), where we free the
> allocated page_ext's, will not have the PAGE_EXT_INVALID flag thus
> WARN() may not work here. no?

Wouldn't ms->page_ext be NULL in that case?

-- 
Michal Hocko
SUSE Labs
