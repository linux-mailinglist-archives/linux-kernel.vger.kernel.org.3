Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840EC5995A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbiHSHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346900AbiHSHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63A10F3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 031A8616C0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEA0C433C1;
        Fri, 19 Aug 2022 07:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660892408;
        bh=Fomsv0BQOlfFABkgeVMy8iE6dqos9WYdeT4WeiUNgg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2Xm0/MEWRf62OGBVR1J8rwK1Yt1KVGW8+7vZ06cdO96N+YrZ17G8LJLAi57zN34C
         oVgg8hz4UWhJqRwQ2DAkemt6kjX5Gq4jhtg9WY5sUwHaLrr857XIeLVLZZ4bkXct+P
         u7fuMOBGJMTNT+qqjgRyvSASToQ6alU3dRRaJLKw=
Date:   Fri, 19 Aug 2022 09:00:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        lee.schermerhorn@hp.com
Subject: Re: [PATCH] mm: hugetlb: simplify per-node sysfs creation and removal
Message-ID: <Yv809bLzdI2f6cl1@kroah.com>
References: <20220819052137.7985-1-songmuchun@bytedance.com>
 <Yv8umgIXfbpMFukB@kroah.com>
 <A0353CE2-D014-4B35-95F1-40345D1B66E6@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0353CE2-D014-4B35-95F1-40345D1B66E6@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 02:44:13PM +0800, Muchun Song wrote:
> 
> 
> > On Aug 19, 2022, at 14:32, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Fri, Aug 19, 2022 at 01:21:37PM +0800, Muchun Song wrote:
> >> The following commit offload per-node sysfs creation and removal to a kworker and
> >> did not say why it is needed.  And it also said "I don't know that this is
> >> absolutely required".  It seems like the author was not sure as well.  Since it
> >> only complicates the code, this patch will revert the changes to simplify the code.
> >> 
> >>  39da08cb074c ("hugetlb: offload per node attribute registrations")
> > 
> > Any specific reason why you did not cc: the original author of this
> > commit, or anyone else on the patch?
> 
> OK. Cc Lee Schermerhorn.

He can't see the patch here, so there is no context.  Please resend the
whole thing.  You also didn't copy the people who signed off on it (i.e.
Andi), any reason why?

> >> We could use memory hotplug notifier to do per-node sysfs creation and removal
> >> instead of inserting those operations to node registration and unregistration.
> >> Then, it can reduce the code coupling between node.c and hugetlb.c.  Also, it can
> >> simplify the code.
> > 
> > I do not think we had memory hotplug notifier back in 2009 when this
> > commit was first written.
> 
> Maybe not. Commit 39da08cb074c is merger in 2009. However, hotplug notifier mechanism
> is merged in 2006. The document is updated in 2007 (see commit 10020ca246c5).
> 
> > 
> > How did you test this?  Did you use a HUGETLBFS system and verify that
> > everything still works properly?  You are deleting a lot of code (always
> > nice), but making sure everything is still operating the same is a good
> > thing.
> 
> I really did the test (through a VM), it works properly.

How about on real hardware?  On a HUGE system with real hardware?  On a
small system?

thanks,

greg k-h
