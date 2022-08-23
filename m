Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E259E8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbiHWRMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344383AbiHWRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:10:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132D11ECF6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:37:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EDA11FA9A;
        Tue, 23 Aug 2022 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661261873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhjaqTIa02gbjHj3dH3vOefI9qGPqvEV2QWZ9Mh/sjs=;
        b=duPLv1XkgQcD6lfKvrfqU0p2OHZvlUpiQNuuWjuitpbV7oc6QTN0XBn7I3HjgyxmYmM+DP
        eFR10fKwtQRo3owkbpSxYfP/3Cu4HWF5HRP0aE+8fGt5UL+cDIF6FOG0FPk3F0rEcIIZCL
        NKbqyoESziFyjsAXhJN/I2EDAq4NzVg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DB9513A89;
        Tue, 23 Aug 2022 13:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lXrwFTHYBGPraAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 23 Aug 2022 13:37:53 +0000
Date:   Tue, 23 Aug 2022 15:37:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-ID: <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
 <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-08-22 20:46:43, Liu Shixin wrote:
> On 2022/8/23 15:50, Michal Hocko wrote:
> > On Mon 22-08-22 14:12:07, Andrew Morton wrote:
> >> On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> >>
> >>> The page on pcplist could be used, but not counted into memory free or
> >>> avaliable, and pcp_free is only showed by show_mem() for now. Since commit
> >>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> >>> significant decrease in the display of free memory, with a large number
> >>> of cpus and zones, the number of pages in the percpu list can be very
> >>> large, so it is better to let user to know the pcp count.
> >>>
> >>> On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
> >>> maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
> >>> After the patch, the lists can hold 324MB. It has been observed to be 114MB
> >>> in the idle state after system startup in practice(increased 80 MB).
> >>>
> >> Seems reasonable.
> > I have asked in the previous incarnation of the patch but haven't really
> > received any answer[1]. Is this a _real_ problem? The absolute amount of
> > memory could be perceived as a lot but is this really noticeable wrt
> > overall memory on those systems?
>
> This may not obvious when the memory is sufficient. However, as products monitor the
> memory to plan it. The change has caused warning.

Is it possible that the said monitor is over sensitive and looking at
wrong numbers? Overall free memory doesn't really tell much TBH.
MemAvailable is a very rough estimation as well.

In reality what really matters much more is whether the memory is
readily available when it is required and none of MemFree/MemAvailable
gives you that information in general case.

> We have also considered using /proc/zoneinfo to calculate the total
> number of pcplists. However, we think it is more appropriate to add
> the total number of pcplists to free and available pages. After all,
> this part is also free pages.

Those free pages are not generally available as exaplained. They are
available to a specific CPU, drained under memory pressure and other
events but still there is no guarantee a specific process can harvest
that memory because the pcp caches are replenished all the time.
So in a sense it is a semi-hidden memory.

That being said, I am still not convinced this is actually going to help
all that much. You will see a slightly different numbers which do not
tell much one way or another and if the sole reason for tweaking these
numbers is that some monitor is complaining because X became X-epsilon
then this sounds like a weak justification to me. That epsilon happens
all the time because there are quite some hidden caches that are
released under memory pressure. I am not sure it is maintainable to
consider each one of them and pretend that MemFree/MemAvailable is
somehow precise. It has never been and likely never will be.
-- 
Michal Hocko
SUSE Labs
