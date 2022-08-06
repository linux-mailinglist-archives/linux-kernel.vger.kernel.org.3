Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF458B2EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 02:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiHFAEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 20:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiHFAEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 20:04:36 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94C1EAD6;
        Fri,  5 Aug 2022 17:04:35 -0700 (PDT)
Date:   Fri, 5 Aug 2022 17:04:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659744273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNPSSSNCcsODM6FcDFTB0/QY2xvnSXXiMzXUqFnL7G8=;
        b=FXngCiEGbKvBUUX68HPXzkns0r27XmBrR+fYTljzWMaejRXpC9hRR4viZ8aYC+gc0IktZM
        y3QjaRpKHUXg+3r+d7U67kpVNj7nf2HYBHqBMJuL19JyLOVtve5YQyaSHgqsA/bkihSR28
        5aplmwopU8LWek5bL786EIuMKHeFqfA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
Message-ID: <Yu2wDNcOYE0RdkA3@P9FQF9L96D.corp.robot.car>
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
 <CAHk-=wiOSXvk=70tpR9E1tvDmCf8s-81bT+92aE-iKocxdTsyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOSXvk=70tpR9E1tvDmCf8s-81bT+92aE-iKocxdTsyw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 04:32:34PM -0700, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 1:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > - memcg debug/visibility work from Roman Gushchin
> 
> Well, not just memcg.
> 
> There's that new CONFIG_SHRINKER_DEBUG too.
> 
> Which looks like yet another "people add Kconfig options incorrectly".
> 
> We don't make new features "default y" unless there's some truly
> pressing reason for it (ie "99.9% of all people will want this" or "we
> used to always compile this in, now it's optional").

Hi Linus!

It actually was 'default n' in one of the earlier version of the patchset
and has been switched to 'default y' based on the following feedback from
Dave Chinner (https://lore.kernel.org/lkml/YmiWK56bOHyrr64u@rh/):

    No. The argument that "if we turn it off there's no overhead" means
    one of two things:

    1. nobody turns it on and it never gets tested and so bitrots and is
    useless, or
    2. distro's all turn it on because some tool they ship or customer
    they ship to wants it.

    Either way, hiding it behind a config option is not an acceptible
    solution for mering poorly thought out infrastructure.

Personally I think that the feature is not that useful for the majority
of users (this is why default was n), but it's not adding much of the
overhead, so I had no strong reasons to oppose Dave.
Cc'ing him just in case.

Thanks!
