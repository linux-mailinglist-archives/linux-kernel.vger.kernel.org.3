Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DAF510EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357141AbiD0CWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352940AbiD0CWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:22:13 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D081191
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:19:02 -0700 (PDT)
Date:   Tue, 26 Apr 2022 19:18:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651025940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKjMvPM+2MJ2yRO8Ts8TLANuj83FMCxVybjtRrJhsDw=;
        b=OBTgeN3lChLzxmMfe4teyWHnkTWxurZczcrbXhakAoxuwu0Dp8CYE/eOIPWEE9rYYndeHM
        zHg1uAH9G8HSBO5U1KhcGIemGGBiahWklJBS4q86wiTWQ+2tV248ivfCkUSy1UaUOaYX/2
        JtmsAyowfVd2PozU/7V3CBiWosXJ9vw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <YmioDchdnpIh8HlC@carbon>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <YmeK6/eZYaMo2Ltm@rh>
 <Ymggvr4Boc5JIf9j@carbon>
 <Ymia75Bh/sn/FQdV@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymia75Bh/sn/FQdV@rh>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:22:55AM +1000, Dave Chinner wrote:
> On Tue, Apr 26, 2022 at 09:41:34AM -0700, Roman Gushchin wrote:
> > Can you, please, summarize your position, because it's a bit unclear.
> > You made a lot of good points about some details (e.g. shrinkers naming,
> > and I totally agree there; machines with hundreds of nodes etc), then
> > you said the active scanning is useless and then said the whole thing
> > is useless and we're fine with what we have regarding shrinkers debugging.
> 
> Better introspection the first thing we need. Work on improving
> that. I've been making suggestions to help improve introspection
> infrastructure.
> 
> Before anything else, we need to improve introspection so we can
> gain better insight into the problems we have. Once we understand
> the problems better and have evidence to back up where the problems
> lie and we have a plan to solve them, then we can talk about whether
> we need other user accessible shrinker APIs.

Ok, at least we do agree here.

This is exactly why I've started with this debugfs stuff.

> 
> For the moment, exposing shrinker control interfaces to userspace
> could potentially be very bad because it exposes internal
> architectural and implementation details to a user API.  Just
> because it is in /sys/kernel/debug it doesn't mean applications
> won't start to use it and build dependencies on it.
> 
> That doesn't mean I'm opposed to exposing a shrinker control
> mechanism to debugfs - I'm still on the fence on that one. However,
> I definitely think that an API that directly exposes the internal
> implementation to userspace is the wrong way to go about this.

Ok, if it's about having memcg-aware and other interfaces, I can
agree here as well.

I actually made an attempt to unify memcg-aware and system-wide
shrinker scanning, not very successful yet, but it's definitely
on my todo list. I'm pretty sure we're iterating over and over
some empty root-level shrinkers without benefiting the bitmap
infrastructure which works for memory cgroups.

> 
> Fine grained shrinker control is not necessary to improve shrinker
> introspection and OOM debugging capability, so if you want/need
> control interfaces then I think you should separate those out into a
> separate line of development where it doesn't derail the discussion
> on how to improve shrinker/OOM introspection.

Ok, no problems here. Btw, tem OOM debugging is a separate topic brought
in by Kent, I'd keep it separate too, as it comes with many OOM-specific
complications.

From your another email:
> So, yeah, you need to think about how to do fine-grained access to
> shrinker stats effectively. That might require a complete change of
> presentation API. For example, changing the filesystem layout to be
> memcg centric rather than shrinker instance centric would make an
> awful lot of this file parsing problem go away.
>
> e.g:
>
> /sys/kernel/debug/mm/memcg/<memcg instance>/shrinker/<shrinker instance>/stats

The problem with this approach (I though about it) is that it comes
with a high memory overhead especially on that machine with thousands cgroups
and mount points. And beside the memory overhead, it's really expensive to
collect system-wide data and get a big picture, as it requires opening
and reading of thousand of files.

Actually, you wrote recently:
"I've thought about it, too, and can see where it could be useful.
However, when I consider the list_lru memcg integration, I suspect
it becomes a "can't see the forest for the trees" problem. We're
going to end up with millions of sysfs objects with no obvious way
to navigate, iterate or search them if we just take the naive "sysfs
object + stats per list_lru instance" approach."

It all makes me think we need both: a way to iterate over all memcgs and dump
all the numbers at once and a way to get a specific per-memcg (per-node) count.

Thanks!
