Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E758B2EF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiHFAIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiHFAH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:07:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A242CE32;
        Fri,  5 Aug 2022 17:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D9F4B82958;
        Sat,  6 Aug 2022 00:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A213CC433D7;
        Sat,  6 Aug 2022 00:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659744474;
        bh=PfJfJYAbTxS2WokCLPTsBpIupwUds+UHgvCXpLuh+R0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lC4FldhtWQsnjCMBN7iciqnBHW0kBte0m7iTQfO9pdgAESNcpbzp/CcU7vnE13h6Y
         h6tExZIJCH525F0pgrgd4t5gc4XiINT4bYz21VxYs5iyNHUcJK5JHfbe9UWiWssqC6
         uFowiDAirlHIIqbuOXpuOVG4NkwOKvN9VbwFNq+U=
Date:   Fri, 5 Aug 2022 17:07:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
Message-Id: <20220805170752.d609551360017d60903e5e75@linux-foundation.org>
In-Reply-To: <Yu2wDNcOYE0RdkA3@P9FQF9L96D.corp.robot.car>
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
        <CAHk-=wiOSXvk=70tpR9E1tvDmCf8s-81bT+92aE-iKocxdTsyw@mail.gmail.com>
        <Yu2wDNcOYE0RdkA3@P9FQF9L96D.corp.robot.car>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 17:04:28 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> On Fri, Aug 05, 2022 at 04:32:34PM -0700, Linus Torvalds wrote:
> > On Wed, Aug 3, 2022 at 1:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > - memcg debug/visibility work from Roman Gushchin
> > 
> > Well, not just memcg.
> > 
> > There's that new CONFIG_SHRINKER_DEBUG too.
> > 
> > Which looks like yet another "people add Kconfig options incorrectly".
> > 
> > We don't make new features "default y" unless there's some truly
> > pressing reason for it (ie "99.9% of all people will want this" or "we
> > used to always compile this in, now it's optional").
> 
> Hi Linus!
> 
> It actually was 'default n' in one of the earlier version of the patchset
> and has been switched to 'default y' based on the following feedback from
> Dave Chinner (https://lore.kernel.org/lkml/YmiWK56bOHyrr64u@rh/):
> 
>     No. The argument that "if we turn it off there's no overhead" means
>     one of two things:
> 
>     1. nobody turns it on and it never gets tested and so bitrots and is
>     useless, or
>     2. distro's all turn it on because some tool they ship or customer
>     they ship to wants it.
> 
>     Either way, hiding it behind a config option is not an acceptible
>     solution for mering poorly thought out infrastructure.
> 
> Personally I think that the feature is not that useful for the majority
> of users (this is why default was n), but it's not adding much of the
> overhead, so I had no strong reasons to oppose Dave.
> Cc'ing him just in case.
> 

We should have changelogged these considerations.

I've asked Joe if checkpatch can get a "default y" detector, to draw
attention to this in the future.
