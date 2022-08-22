Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4A59BA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiHVH1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHVH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:27:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C829CB4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:27:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43E8C5C8E3;
        Mon, 22 Aug 2022 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661153237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOSZ1gao5/3E8NwCd+xFOFyj6wHAE0KqY6dM+F15eTY=;
        b=D1v7Rzn8hkS/j8FC79rIDlh6LSkmKqTkZElaHBNiKH8zFdkA5fyDxbpTGYkfW7HGNMe9lV
        /yAxxvRie+Snh4pL4dY1J2t5JZGLWQbVvsEnyyWkh3gmUjR+2komdG4sqBwfye7m17JkPh
        SktY9C9jZl3ReOdmsRG0x8HWTPxXHUQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22C1E13523;
        Mon, 22 Aug 2022 07:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eRsjBtUvA2MuIQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 22 Aug 2022 07:27:17 +0000
Date:   Mon, 22 Aug 2022 09:27:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Message-ID: <YwMv1A1rVNZQuuOo@dhcp22.suse.cz>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <CAC=cRTN=vbrgOsH7PNNMV+Coyabp=H_XF99MUL00kfET=K-32w@mail.gmail.com>
 <578084e8-bdc3-6e4e-f390-4202a8bc7c1d@huawei.com>
 <Yv8+bxiZ8+Rw+wu3@ziqianlu-Dell-Optiplex7000>
 <31718e40-51e9-c14d-f7f5-526ba26d0db8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31718e40-51e9-c14d-f7f5-526ba26d0db8@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-08-22 17:53:27, Liu Shixin wrote:
> 
> 
> On 2022/8/19 15:40, Aaron Lu wrote:
> > On Tue, Aug 16, 2022 at 05:24:07PM +0800, Kefeng Wang wrote:
> >> On 2022/8/16 16:48, huang ying wrote:
> >>> On Tue, Aug 16, 2022 at 4:38 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>>> From: Liu Shixin <liushixin2@huawei.com>
> >>>>
> >>>> The page on pcplist could be used, but not counted into memory free or
> >>>> avaliable, and pcp_free is only showed by show_mem(). Since commit
> >>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> >>>> significant decrease in the display of free memory, with a large number
> >>>> of cpus and nodes, the number of pages in the percpu list can be very
> >>>> large, so it is better to let user to know the pcp count.
> >>> Can you show some data?
> >> 80M+ with 72cpus/2node

I would expect that such system would have quite some memory as well and
80MB wouldn't be a really noticeable. What is that amount in %tage 

> > 80M+ for a 2 node system doesn't sound like a significant number.
> >
> >>> Another choice is to count PCP free pages in MemFree.  Is that OK for
> >>> your use case too?
> >> Yes, the user will make policy according to MemFree, we think count PCP free
> >> pages
> >>
> >> in MemFree is better, but don't know whether it is right way.
> >>
> > Is there a real problem where user makes a sub-optimal policy due to the
> > not accounted 80M+ free memory?
> I need to explain that 80M+ is the increased after patch d8a759b57035. Actually in my test,
> the pcplist is about 114M after system startup, and in high load scenarios, the pcplist memory
> can reach 300M+.
> The downstream has sensed the memory change after the kernel is updated, which has an
> actual impact on them. That's why I sent this patch to ask if should count this
> part of memory.

It would be really great to be more explicit about this. Because if this
is really runtime noticeable then we might need to consider an improved
tunning or way to manually configure the pcp batch sizes. Reporting the
amount on its own is unlikely going to help without being able to do
anything about that.

-- 
Michal Hocko
SUSE Labs
