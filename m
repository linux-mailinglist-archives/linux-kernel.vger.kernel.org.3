Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683C4E5681
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiCWQdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiCWQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:33:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E47CDC1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:31:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g8so1471149qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J3AvCzI63JEnokrUC4Iwv6N5EWlCu1QJfFBDdd/unKY=;
        b=jL8Up4A9KJl86VW8bp2LwyPe3GAoSvY02FH4VZGMRf6L8+fy2IzjDosZj2yZefYHQB
         wzL15TdotJDVuRXcBuocyR5w36bv7gZ8tf4g1MKYFQR6D7UvEyM5LvpeCOBYCYYqtvVO
         QyYconNt0ojQtvQjwvpbahs23JDp7wBTIn6N690sGkiHGnQM8LJ1X418m2IoldJjuiqS
         RfOsRcA7Ab18vaKZ5C7r2Iy6XbYC7agVkkPu12ogJSZffaAcXR5qVLo/l8Cx2lD2Vb53
         EVDKvyQLlG7Zlg+SF2t2YhCjoaTPBYzz/XzH9IByKiPCqA5OV8uON5z0miITLmXSIb3V
         4LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3AvCzI63JEnokrUC4Iwv6N5EWlCu1QJfFBDdd/unKY=;
        b=xoiW3dVPv/S2/zD3GuFSGaqi5ts5MfkxswUYEAP8gjr/vO67Ve/F32LiQqGPu68/tG
         FvauuBn2aiu3eIXNQ+yzUan8BuJTaak4BXMzDQrmxqZX5DAjis5Y8mGNg8yWe/BmMTa2
         Ao3L+8QRgiHdenK/mDb4QlQ3dzc3l8+1558q+sWqKClQiMplDlkYFFG+c1ZYYl9nwhjR
         sXVc0jhi9qqADmV96oP7QRurnsGV7BAMCPICQ3o0pxZACoj7aChcGBJCrV6V0C81y9Q9
         071A2W7nUQvGMzU1FCxWsU52vkUSjhKdrBLn+fr2w/jJD4XEtbharDlyZW0z/CVxNHT7
         pClA==
X-Gm-Message-State: AOAM533SfFfya01OiHt77vpq1DgAUAxVN9K6KpSARsDc7flZE65TX41C
        ikRRo72eUYJOYg/la0fW7N1kmQ==
X-Google-Smtp-Source: ABdhPJw6RSABU5Oon1xMFEywJpe1TUJiBcWQJAx1x5CGutfzgTfUsftf7dysku23cafQK2qtN0k/DQ==
X-Received: by 2002:a05:620a:d8d:b0:67b:e95:2975 with SMTP id q13-20020a05620a0d8d00b0067b0e952975mr475429qkl.115.1648053108858;
        Wed, 23 Mar 2022 09:31:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a6-20020ae9e806000000b0067ba5a8a2a7sm210602qkg.134.2022.03.23.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:31:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nX3ti-004xOm-Q4; Wed, 23 Mar 2022 13:31:46 -0300
Date:   Wed, 23 Mar 2022 13:31:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Juergen Gross <jgross@suse.com>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: blocking vs. non-blocking mmu notifiers
Message-ID: <20220323163146.GI64706@ziepe.ca>
References: <8e8ec786-74db-157b-a290-b1537941e91d@suse.com>
 <YjrsOnxaPYc3rbdj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjrsOnxaPYc3rbdj@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:45:30AM +0100, Michal Hocko wrote:
> [Let me add more people to the CC list - I am not really sure who is the
>  most familiar with all the tricks that mmu notifiers might do]
> 
> On Wed 23-03-22 09:43:59, Juergen Gross wrote:
> > Hi,
> > 
> > during analysis of a customer's problem on a 4.12 based kernel
> > (deadlock due to a blocking mmu notifier in a Xen driver) I came
> > across upstream patches 93065ac753e4 ("mm, oom: distinguish
> > blockable mode for mmu notifiers") et al.
> > 
> > The backtrace of the blocked tasks was typically something like:
> > 
> >  #0 [ffffc9004222f228] __schedule at ffffffff817223e2
> >  #1 [ffffc9004222f2b8] schedule at ffffffff81722a02
> >  #2 [ffffc9004222f2c8] schedule_preempt_disabled at ffffffff81722d0a
> >  #3 [ffffc9004222f2d0] __mutex_lock at ffffffff81724104
> >  #4 [ffffc9004222f360] mn_invl_range_start at ffffffffc01fd398 [xen_gntdev]
> >  #5 [ffffc9004222f398] __mmu_notifier_invalidate_page at ffffffff8123375a
> >  #6 [ffffc9004222f3c0] try_to_unmap_one at ffffffff812112cb
> >  #7 [ffffc9004222f478] rmap_walk_file at ffffffff812105cd
> >  #8 [ffffc9004222f4d0] try_to_unmap at ffffffff81212450
> >  #9 [ffffc9004222f508] shrink_page_list at ffffffff811e0755
> > #10 [ffffc9004222f5c8] shrink_inactive_list at ffffffff811e13cf
> > #11 [ffffc9004222f6a8] shrink_node_memcg at ffffffff811e241f
> > #12 [ffffc9004222f790] shrink_node at ffffffff811e29c5
> > #13 [ffffc9004222f808] do_try_to_free_pages at ffffffff811e2ee1
> > #14 [ffffc9004222f868] try_to_free_pages at ffffffff811e3248
> > #15 [ffffc9004222f8e8] __alloc_pages_slowpath at ffffffff81262c37
> > #16 [ffffc9004222f9f0] __alloc_pages_nodemask at ffffffff8121afc1
> > #17 [ffffc9004222fa48] alloc_pages_current at ffffffff8122f350
> > #18 [ffffc9004222fa78] __get_free_pages at ffffffff8121685a
> > #19 [ffffc9004222fa80] __pollwait at ffffffff8127e795
> > #20 [ffffc9004222faa8] evtchn_poll at ffffffffc00e802b [xen_evtchn]
> > #21 [ffffc9004222fab8] do_sys_poll at ffffffff8127f953
> > #22 [ffffc9004222fec8] sys_ppoll at ffffffff81280478
> > #23 [ffffc9004222ff30] do_syscall_64 at ffffffff81004954
> > #24 [ffffc9004222ff50] entry_SYSCALL_64_after_hwframe at ffffffff818000b6
> > 
> > It was found that the notifier of the Xen gntdev driver was using a
> > mutex resulting in the deadlock.

The bug here is that prior to commit a81461b0546c ("xen/gntdev: update
to new mmu_notifier semantic") wired the mn_invl_range_start() which
takes a mutex to invalidate_page, which is defined to run in an atomic
context.

> > Michal Hocko suggested that backporting above mentioned patch might
> > help, as the mmu notifier call is happening in atomic context.

IIRC "blocking" was not supposed to be about atomic context or not, but
more about time to completion/guarenteed completion as it is used from
a memory reclaim path.

> Just to be more explicit. The current upstream code calls
> mmu_notifier_invalidate_range while the page table locks are held.
> Are there any notifiers which could sleep in those? 

There should not be, that would be a bug that lockdep would find.

> In other words should we use the nonblock start/stop in
> try_to_unmap?

AFAICT, no.

Jason
