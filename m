Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9074A5551
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiBAClX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBAClW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:41:22 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30EC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:41:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id o12so49214540eju.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBboR6NMs3rfClr1WGtx+v5BC14P+XGf6fU8ruxde28=;
        b=eqLMZ9TbfiCUCzLajbShK/Zaj2Qx7V7DjsdhPjGSfhMc5/ZAhy4U3MMW4vv9zS6C6v
         979iyRc0PalLjoqBCnQ82krl15sSJROJvXN1tqj+vfesD8ulyizdA4+Ru7+4dvE9+q4A
         NJPChH/bo0h08TeX7pda7ywhAHWbV7Rdcm7OXEXn3wNHDqfg/Z4Y/NJ7wTnNLswDgmY7
         eQsVIf6dZVyXcZs0eeZj8wGUvuBZf1hBbCWZOFGiqeYkMTpMO3Bjh1shA0e9K4sZtg0S
         7DWKbfBDaeQePtDXrsZB2tIbiMhKxc04nQM0yHQxgBmdhu1H9/WcGs+iJGL77CirBo81
         lUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBboR6NMs3rfClr1WGtx+v5BC14P+XGf6fU8ruxde28=;
        b=VG8FXDs9xbSD7o5ElJ4+fata7iQgJBvdxYlfMrecqyqsxPDmSfA/TEKDk206OSj1oR
         HhDgxuRX0gC7Z0KuEDnlNKrm9b6jwu5ayFstINaw+3q48W5Bl8bpfw7hMuKe/VniIhv4
         6GYlRjRZ3BjdMRtkgSvzmOtz+GHn/gCRza6LakJwt85GFebSI8V16GkYVpZjT9tLg65t
         F9es3aU2sPNt6bDieSph03tJDrZ3funyk5Cl9Na1Lv08BsNj7mC16wI9s57i8cDNkXXK
         f4IfD/9WTSEIMHMdpRuKfGQtAhKdwHDccwcuELIOwyXcPzYpHFuN53gsYVTTepOF/b7g
         KOfQ==
X-Gm-Message-State: AOAM530jfc8c/NBXeexpj9acdOtKDDD42OT9BiOba6TIAODN3oxt6qOa
        uPPBHESGi+Zs7txsOzeMH90=
X-Google-Smtp-Source: ABdhPJxUm2mRvsCAG6hyhgD9bxBygoYt1vckh9c/7kCKF+FloEXzbFo6u6ytKjWl4DrxibuhVfiQjg==
X-Received: by 2002:a17:906:7945:: with SMTP id l5mr19594805ejo.104.1643683280660;
        Mon, 31 Jan 2022 18:41:20 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e19sm12937073ejl.225.2022.01.31.18.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 18:41:20 -0800 (PST)
Date:   Tue, 1 Feb 2022 02:41:19 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <20220201024119.2ailcw4rp5thambz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:47:40PM +0100, Michal Hocko wrote:
>[...]
>> > +
>> > +			/* Allocator not initialized yet */
>> > +			pgdat = arch_alloc_nodedata(nid);
>> > +			if (!pgdat) {
>> > +				pr_err("Cannot allocate %zuB for node %d.\n",
>> > +						sizeof(*pgdat), nid);
>> > +				continue;
>> > +			}
>> > +			arch_refresh_nodedata(nid, pgdat);
>> > +			free_area_init_memoryless_node(nid);

free_area_init_memoryless_node() seems to be defined used out side
page_alloc.c? It just call free_area_init_node() directly. We want to use the
name to reflect the effect?

>> > +			/*
>> > +			 * not marking this node online because we do not want to
>> > +			 * confuse userspace by sysfs files/directories for node
>> > +			 * without any memory attached to it (see topology_init)
>> > +			 * The pgdat will get fully initialized when a memory is
>> > +			 * hotpluged into it by hotadd_init_pgdat
>> > +			 */

Hmm... which following step would mark the node online? On x86, the node is
onlined in alloc_node_date(). This is not onlined here.

>> > +			continue;
>> 
>> This can be made slightly more concise if we fall through after
>> arch_refresh_nodedata(), e.g. something like
>> 
>> 			...
>> 
>> 			arch_refresh_nodedata(nid, pgdat);
>> 		}
>> 
>> 		pgdat = NODE_DATA(nid);
>> 		free_area_init_node(nid);
>> 
>> 		/*
>> 		 * Do not mark memoryless node online because we do not want to
>> 		 * confuse userspace by sysfs files/directories for node
>> 		 * without any memory attached to it (see topology_init)
>> 		 * The pgdat will get fully initialized when a memory is
>> 		 * hotpluged into it by hotadd_init_pgdat
>> 		 */
>> 		if (!pgdat->node_present_pages)
>> 			continue;
>> 
>> but I don't feel strongly about it.
>
>I do not have strong preference either way. Unless this is considered
>better by more people I would stick with what I have.

I agree with Mike.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
