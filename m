Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE574A7CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbiBCAVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiBCAVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:21:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25856C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:21:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so2125999edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdXalSMLN5MQoDxyTGMqoaaPaAweitgBHjd8kg4ci/8=;
        b=B2ItoGc/UIqEjP1EtvhDX7ho5pmcYfPwRzTzYM+bQgbEfUcNeK98sZ9I90j33tOTH4
         sTIj3xEfRC6Q409RVb61g8PmBPuPA7JSVaaxWUpcflFC7R4afG8Nw0zjg63zdmvYA5zX
         zHvjqW4S9WhZ4E3NQ3fDUOSdhHGfwgdmoIt2jXXw/nxgzlGIh1Nm5VM4s38rMPpFufL9
         jWFAX55PHHLGgFaoqvdBuRIr5QCrGYkSdVICSLzQs2dvQ5QYRRb2uky5165DIoxMB5o/
         OOxJt2hSK9g6GGfSiRvH0l8BZttbowKMFzw1nziIlEErLUAEGTwo8PcgcfVJt6AbK8+6
         GXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdXalSMLN5MQoDxyTGMqoaaPaAweitgBHjd8kg4ci/8=;
        b=nOEmvNytRDs1VHxPctsq3nzL/9j/da+CTjMK5+yYUNHdWbNYOguiZY/jXQf+BW6/sK
         UTK7ts2V7hNyn+ML01BR7qCYPNil3biUJ7v5q/WQEzUu87DOIerjuqguJ0qTHjdzlvHQ
         JhahWXI6zsKbJRXHPJxfWENh7K7uTDK+orDLtb5iFPJr8EugVbGJk35CkeDH3syrUsJT
         B0UZloIFAKrLkV5Mbvix/zreNIXxvYzpC7F3YKh873T2VZ/BV2gyIGqwpWq/og1QuWUx
         5hoz4He+bGnewiK2o32bMQlH7gq9pqiaDO9hstwLwSIqstilH5SjF2Ae6sh+hlXrfEWE
         ZPUA==
X-Gm-Message-State: AOAM532892Rh5I1fFAjp3Gg0rU4OEd//pvQBHY9Wk4RVsHRbsn+KmkXp
        GmDjaWzEMqDvRIlhNthEQFU=
X-Google-Smtp-Source: ABdhPJyuDiD3h5OVCT0rc9EdD17oOKJhIr3vzwxaQcUHZkkDpTyr0U78BDdif6JeY6wVv2fEUYZsog==
X-Received: by 2002:a05:6402:440c:: with SMTP id y12mr32582521eda.75.1643847677599;
        Wed, 02 Feb 2022 16:21:17 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d26sm21522240edy.92.2022.02.02.16.21.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Feb 2022 16:21:17 -0800 (PST)
Date:   Thu, 3 Feb 2022 00:21:16 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <20220203002116.akpk5um5nkpeflve@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
 <20220201024119.2ailcw4rp5thambz@master>
 <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:54:37AM +0100, Michal Hocko wrote:
>On Tue 01-02-22 02:41:19, Wei Yang wrote:
>> On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
>> [...]
>> >> > +			/*
>> >> > +			 * not marking this node online because we do not want to
>> >> > +			 * confuse userspace by sysfs files/directories for node
>> >> > +			 * without any memory attached to it (see topology_init)
>> >> > +			 * The pgdat will get fully initialized when a memory is
>> >> > +			 * hotpluged into it by hotadd_init_pgdat
>> >> > +			 */
>> 
>> Hmm... which following step would mark the node online? On x86, the node is
>> onlined in alloc_node_date(). This is not onlined here.
>
>The comment tries to explain that this happens during the memory
>hotplug. Or maybe I have missed your question?
>

I am not sure for others, while the comment confused me a little.

Currently in kernel, there are two situations for node online:

  * during memory hotplug
  * during sys-init

For memory hotplug, we allocate pgdat and online node. And current hot-add
process has already put them in two steps:

  1. __try_online_node()
  2. node_set_online()

So emphasize "not online" node here, confuse me a little. It is a natural
thing to not online node until it has memory.

But from another point of view, the comment here is reasonable. During
sys-init, we online node at the same time when creating pgdat. And even for
memory-less node on x86, we online them too.

Well, this is all about the comment. I have tried to grab may head but not
come up with a better idea.

Or maybe this is just my personal feeling, don't bother if no-one else feel
like this.

>[...]
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
