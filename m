Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B254F1DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383078AbiDDVco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379990AbiDDSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:34:34 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AAD2E0AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:32:37 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649097155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5IsweEeUbsElKZD0uikDx4gCNoAFrfsB9CrofDq2qRE=;
        b=jvMkrX8vqP7/6XUII3CE5QBflW54+SsisBbJkPe+I9km44PwKBiuijeRIo4Jn8SGEEZ+at
        A4iMa9I9uzAuG1/K5DG1GB/g53VoZdXsvlgEdTLthIje6DkcfKwXM+3jyGQbyIT7drTQyg
        bTMXZXLyMwuc9NcwlLIpbjYJKVDTYzg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dave Chinner <david@fromorbit.com>, MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
Message-ID: <Yks5vmptVnVFopnr@carbon.dhcp.thefacebook.com>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404051442.5419-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404051442.5419-1-hdanton@sina.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:14:42PM +0800, Hillf Danton wrote:
> On Mon, 4 Apr 2022 11:09:48 +1000 Dave Chinner wrote:
> > On Sun, Apr 03, 2022 at 08:56:18AM +0800, Hillf Danton wrote:
> > > On Sat, 2 Apr 2022 10:54:36 -0700 Roman Gushchin wrote:
> > > > Hello Hillf!
> > > > 
> > > Hello Roman,
> > > 
> > > > Thank you for sharing it, really interesting! I=E2=80=99m actually working o=
> > > > n the same problem.=20
> > > 
> > > Good to know you have some interest in it.
> > > Feel free to let me know you would like to take it over to avoid
> > > repeated works on both sides.

Only if you've something more exciting to work on. It seems like at this
point it's not really clear what exactly we need to do and how to approach it,
so I don't think we're doing any repeated work. The more
ideas/opinions/suggestions, then better.

> > > 
> > > > 
> > > > No code to share yet, but here are some of my thoughts:
> > > > 1) If there is a =E2=80=9Cnatural=E2=80=9D memory pressure, no additional sl=
> > > > ab scanning is needed.
> > > 
> > > Agree - the periodic shrinker can be canceled once kswapd wakes up.
> > 
> > I think we should be waking up per-node kswapd to do the periodic
> > shrinking, not adding yet another way of executing (thousands of)
> > shrinkers (across hundreds of nodes) from a single threaded context.
> 
> Kswapd is majorly responsible for keeping the high water mark, a
> different target from cold slab objects - I am inclined to staying a
> safe distance from any code churn in that area.

The problem is that kswapd is also doing slab shrinking and we can't
simple ignore it, so it has to interact in some way.

Thanks!
