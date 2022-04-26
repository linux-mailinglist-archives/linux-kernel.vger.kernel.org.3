Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1CB50F170
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiDZGsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbiDZGsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:48:32 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374718377
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:45:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b189so12505776qkf.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MQ9dtvdJK0z0zhJFlFZM7oq2kiOyOiaW5cufIP3GQV0=;
        b=l0lYcW6xy7au958Hz/ON5dnKwiVeVa18RE8GXQzkMzEKk1XRRJ4rTtgzBZVNtiAyEE
         dzfIUeLpD+1qi6G0vjo35uRSQ2mB+0JwKL1HXu8fJ/q+nDva08jslODqx0fOYDbL7zqq
         TmQfF7iqQgqVRGcwEDsMB3BozeNa4n/1ve940SXCQC/BzNY56gxMHcVZ9qG7rXIEp4rx
         6Ox0Og7oAly62R5iyql6afVbG3KUc0XlSSD+3XBNUqu/3kkq5x+oPxDDma5Ss7Knoq09
         qCmv2x85AMCM1jgGkPeI+0xkj3j5HXJaeUkbQC8Nd+Yf06mLCaFVuXPRIGVyjkCwCYw+
         wNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQ9dtvdJK0z0zhJFlFZM7oq2kiOyOiaW5cufIP3GQV0=;
        b=bRa4TSyg6zuBjFa8aWhB9sqo9sekYooKPA1oUjH8N8QexXj0mpnur94DQX9DM8a5t3
         kfG/wcE7jCYmMVHwNHLJhddXXqHcpzpMQRQmtapcj+GxuKrkw3eUjFgSORahDZ+s87TD
         ZfyV9ZU0l+YoAIdj7XlCW9gw5WAZBGlZM8FHMQrCy/6SqaZvOavAvVgfLEAGsXsEPIP7
         LtpUZ4hZn0Y4QRC0tG1gaB5Z7kldZH5m4Si1/yZw23N0hOwWfwSJYmtszB4qnIroqq/Q
         grdnSOAGsjQucN86YqG4ouXQ5W3g+8QgCXU+Ah9CE3VjbQoPM/f9SY8lCS5NJfcLrHup
         3QGA==
X-Gm-Message-State: AOAM5323pqK//XM6jNPhNT3W+wbsIuz2YGtHCalR20HVeXqFF8uoihdl
        PM+colahKANMhWrAgOzDyA==
X-Google-Smtp-Source: ABdhPJwc7Th8OZSfKbfOkfTf8hlqSNKxqeAy81FsRzBt8CAETVLTfEx01J5uG/u4wg8eBjnumyQ/Fg==
X-Received: by 2002:a37:a108:0:b0:69f:8208:368d with SMTP id k8-20020a37a108000000b0069f8208368dmr98408qke.263.1650955524843;
        Mon, 25 Apr 2022 23:45:24 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b129-20020a376787000000b0069f66fd4a4asm2011814qkc.133.2022.04.25.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:45:24 -0700 (PDT)
Date:   Tue, 26 Apr 2022 02:45:22 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <20220426064522.gojso44l3mfgq7wi@moria.home.lan>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <YmeK6/eZYaMo2Ltm@rh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmeK6/eZYaMo2Ltm@rh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:02:19PM +1000, Dave Chinner wrote:
> This just seems like a solution looking for a problem to solve.
> Can you please describe the problem this infrastructure is going
> to solve?

A point I was making over VC is that memcg is completely irrelevant to debugging
most of these issues; all the issues we've been talking about can be easily
reproduced in a single test VM without memcg.

Yet we don't even have the tooling to debug the simple stuff.

Why are we trying to make big and complicated stuff when we can't even debug the
simple cases? And I've been getting _really_ tired of the stock answer of "that
use case isn't interesting to the big cloud providers".

A: If you're a Linux kernel developer at this level, you have earned a great
deal of trust and it is incumbent upon you to be a good steward of the code you
have been entrusted with, instead of just spending all your time chasing fat
bonuses from your employer while ignoring what's good for the codebase as a
whole. That's pissing all over the commons that came long before you and will
hopefully still be around long after you.

B: Even aside from that, it's incredibly shortsighted and a poor use of time and
resources. When I was at Google I saw, over and over again, people rushing to do
something big and complicated and new because that was how they could get a
promotion, instead of working on basic stuff like refactoring core IO paths (and
it's been my experience over and over again that when you just try to make code
saner and more understandable, you almost always find big performance
improvements along the way... but that's not as exciting as rushing to find the
biggest coolest optimization or all-the-bells-and-whistles interface).

So yeah, this patchset screams of someone looking for a promotion to me.

Meanwhile, the status of visibility into the _basics_ of what goes on in MM is
utter dogshit. There's just too many _basic_ questions that are a pain in the
ass to answer - even just profiling memory usage by file:line number is a
shitshow.

One thing that I run into a lot is people rush to say "tracepoints!" for a lot
of problems - but tracepoints aren't a good answer for a lot of problems because
having them on all the time is problematic.

What I would like to see is more lighter weight collection of statistics, and
some basic library code for things like latency measurements of important
operations broken out by quantiles, with rate & frequence - this is something
that's helped in bcachefs. If anyone's interested, the code for that starts
here:

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/bcachefs.h#n322

Specifically for shrinkers, I'd like if we had rolling averages over the past
few seconds for e.g. _rate_ of objects requested to be freed vs. actually freed.
If we collect those kinds of rate measurements (and perhaps latency too, to show
stalls) at various places in the MM code, perhaps we'd be able to see what's
getting stuck when we OOM.

We should have rate of objects getting added, too, and we should be collecting
data from the list_lru code as well, like you were mentioning the other night.

And if we collect this data in such a way that it can be displayed in sysfs, but
done with the to_text() methods I've been talking about, it'll also be trivial
to include that in the show_mem() report when we OOM.

Anyways, that's my two cents.... I can't claim to have any brilliant insights
here, but I hope Roman will start taking ideas from more people (and Dave's been
a real wealth of information on this topic! I'd pick his brain if I were you,
Roman).
