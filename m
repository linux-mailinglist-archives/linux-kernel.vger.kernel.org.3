Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8576248E175
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiANAYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiANAYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:24:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:24:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m4so29046433edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zmKEUhzCkz1KenuWvpv6GMsWqgprMiy2UAeYsWU8Uk=;
        b=MKzgQXYEkBn98my1ggUaKQwtoDdc4Ha/0Tq8y1bN4ZQIBw6oao22XYluV9S5S76pMc
         HJ92bALDv5rhgmiTUoBcPpzKDMzK4pNhh+mtmHb1whz1YYXDFNVauRKrsIb8FvY5cK7x
         QphfaDxgxqiOouz//N08ARxZlgMpVRnYx1aeOSWuVfXPPGsFuEpPe0I0hleORRgCUP/S
         YAx38PLvGbDE1WQdBH6ZCve53LJudxfuyBMxlXGhntfzSQ76OfhzT3y1Sr9TN4p6xW2/
         P9mugddRxwhrBZFOLbL3RkS6Lf3PeR4PNyfjopp1ow8x+5DhD58jTxmjjscUNRxm7gnp
         ubmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zmKEUhzCkz1KenuWvpv6GMsWqgprMiy2UAeYsWU8Uk=;
        b=WuhrjHLKmwJbPB1OaQrqPcjtmuLl7279GzIoPzqy+N1bKxyZL848ezkvq+ArMWcNfG
         2Szat/h9B5HyeAHcxe4zuovHq8Qh4Uem/NcJikWgNFUjvzWDJYFsuc2oi4GAhv/4+PTV
         I5t6p3kEHOXOiC9v73j2/0mSmc3TUv/Rs4LCSrLkFKTr8z7EfkBPo/5fR6lbPoXPEz8v
         sySWveDlI9zc/WHS6/8GS60emKcCjoHMfOPleyTV8jfkD9ZHX7wcWSmuRq3gLc/zxtpK
         rdu2JEI4y9YPpwiMFbwOR3xftdD2Qf1FLZpVIIfWOoYjSgrPr/8tYH5eocapM4bKvRwn
         Z2Lw==
X-Gm-Message-State: AOAM5302VyrPactRCvvsYpMfd9PfxDDK1cXVrOC8A+p9qzlk/MWWA9Nl
        UOftEiluT4SzvGyDEUXgXI+Ps9JcfUc=
X-Google-Smtp-Source: ABdhPJxIWybHBJq7aJWGhltINrr/sOpNB2KjcfizkU+b7EKNWsouDxXXi9ITIf2kQmcEnv74K+TfRA==
X-Received: by 2002:a17:906:794c:: with SMTP id l12mr5291248ejo.474.1642119856519;
        Thu, 13 Jan 2022 16:24:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h13sm1686173edt.61.2022.01.13.16.24.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jan 2022 16:24:16 -0800 (PST)
Date:   Fri, 14 Jan 2022 00:24:15 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@gentwo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Nico Pache <npache@redhat.com>
Subject: Re: [PATCH v2 2/4] mm: handle uninitialized numa nodes gracefully
Message-ID: <20220114002415.wfhhdp7ixn7kztqk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
 <20211214100732.26335-1-mhocko@kernel.org>
 <20211214100732.26335-3-mhocko@kernel.org>
 <alpine.DEB.2.22.394.2112141131180.370323@gentwo.de>
 <Ybh0NwH1grEyLoe8@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybh0NwH1grEyLoe8@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 11:38:47AM +0100, Michal Hocko wrote:
>On Tue 14-12-21 11:33:41, Christoph Lameter wrote:
>> On Tue, 14 Dec 2021, Michal Hocko wrote:
>> 
>> > This patch takes a different approach (following a lead of [3]) and it
>> > pre allocates pgdat for all possible nodes in an arch indipendent code
>> > - free_area_init. All uninitialized nodes are treated as memoryless
>> > nodes. node_state of the node is not changed because that would lead to
>> > other side effects - e.g. sysfs representation of such a node and from
>> > past discussions [4] it is known that some tools might have problems
>> > digesting that.
>> 
>> Would it be possible to define a pgdat statically and place it in read
>> only memory? Populate with values that ensure that the page allocator
>> does not blow up but does a defined fallback.
>> 
>> Point the pgdat for all nodes not online to that readonly pgdat?
>> 
>> Maybe that would save some memory. When the node comes online then a real
>> pgdat could be allocated.
>
>This is certainly possible but also it is more complex. I aim for as
>simple as possible at this stage. The reason I am not concerned about
>memory overhead so much (even though the pgdat is a large data
>structure) is that these unpopulated nodes are rather rare. We might see
>more of them in the future but we are not quite there yet so I do not
>think this is a major obstacle for now.

Another thing is we still have a chance to get NULL NODE_DATA if we failed to
allocate it. And this is the problem we want to address here.

This is not urgent, while we may need to address this later.

>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
