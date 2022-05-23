Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C237530A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiEWH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiEWH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD7E72E3D;
        Mon, 23 May 2022 00:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E344460F4E;
        Mon, 23 May 2022 06:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F074C34119;
        Mon, 23 May 2022 06:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653287299;
        bh=+G6QN37JBeeDecpF0Mn6rMG3fkWXm5EFAcnK5EHnUos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lORFfpXzkhH/bu/UwmD76CQVKYdEetkF8PMqoh8KdzXC0VMmc62qZl5bz0pGOBtMk
         OlWoGM+rHfYdDDQrlrqP/ZCIzgZ2/OP6k4/nZ3skYErVnarM3fFMJlnCX8m8EzICZA
         YKeppLZ4UIAxpT7R1p8RU5w4qwyoCMe1jEPX4nX34te+xaHDPv3a1pu0xaicPobghX
         P212NapsDkC0mqRMplaW4HDz3cHt8uD6QFlROAUg+OEJBqxVtO7RnDl0x47deY7xDr
         PTTyOh0E5Mpew3udOnESmT9kHNDJgPm9nqFDA8eVM3pNzkP9Tx+rfUxyHVhFOvi9qI
         3oEZUaJMLEyNA==
Received: by mail-yb1-f176.google.com with SMTP id q135so23643634ybg.10;
        Sun, 22 May 2022 23:28:19 -0700 (PDT)
X-Gm-Message-State: AOAM532G+rQojoR0syFUuWPDQqemENa3jc/pTAZ7BTIw4SDWiA5UvJn4
        kVbBppkSAIqvvqFNTqJIRgSTGX2oQO7M31BLal8=
X-Google-Smtp-Source: ABdhPJwtNsXeDoCOnv7u39/J737486gnlczLh5EYBIMuDgvFwyVZDTBioltB3E1L75tfs0MX3rEvRGubB3Z9OQf6P5s=
X-Received: by 2002:a25:1e56:0:b0:64e:a226:6f6b with SMTP id
 e83-20020a251e56000000b0064ea2266f6bmr20102847ybe.322.1653287298271; Sun, 22
 May 2022 23:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220519191311.17119-1-logang@deltatee.com>
In-Reply-To: <20220519191311.17119-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 22 May 2022 23:28:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5NPE-kkLdJ74LXa7-udOEf=KwDyep1QeANhTxNoWKZOg@mail.gmail.com>
Message-ID: <CAPhsuW5NPE-kkLdJ74LXa7-udOEf=KwDyep1QeANhTxNoWKZOg@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] Bug fixes for mdadm tests
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 12:13 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> This series includes fixes to fix all the kernel panics in the mdadm
> tests and some, related, sparse issues. The first 10 patches
> clean refactor the raid5-cache code so that the RCU usage of conf->log
> can be cleaned up which is done in patches 11 and 12 -- fixing some
> actual kernel NULL pointer dereference crashes in the mdadm test.
>
> Patch 13 fixes some of the remaining sparse warnings that are just
> missing __rcu annotations.
>
> Patches 14 and 15 fix a couple additional hangs in an mdadm test.
>
> This series also originally included a patch[1] to fix the
> mddev->private=NULL issue in raid0. That bug caused an mdadm tests to
> crash, but it seems Xiao beat me to the fix by a few days. Hopefully,
> this work to improve mdadm tests will mean these types of bugs will
> be caught much sooner, before merging.

Thanks for the fix! The set looks good overall. Please address feedback
from Christoph and Donald. We should be able to ship it soon.

Thanks,
Song

>
> This series will be followed by another series for mdadm which fixes
> the segfaults and annotates some failing tests to make mdadm tests
> runnable fairly reliably, but I'll wait for a stable hash for this
> series to note the kernel version tested against. Following that,
> v3 of my lock contention series will be sent with more confidence
> of its correctness.
>
> This series is based on the current md/md-next branch as of today
> (6ad84d559b8c). A git branch is available here:
>
>   https://github.com/sbates130272/linux-p2pmem md-bug
>
> Thanks,
>
> Logan
>
> [1] https://github.com/sbates130272/linux-p2pmem/commit/5a538f9f48d77cba111773759256bbc3ccaaa74a
>
> --
>
> Logan Gunthorpe (15):
>   md/raid5-log: Drop extern decorators for function prototypes
>   md/raid5-cache: Refactor r5c_is_writeback() to take a struct r5conf
>   md/raid5-cache: Refactor r5l_start() to take a struct r5conf
>   md/raid5-cache: Refactor r5l_flush_stripe_to_raid() to take a struct
>     r5conf
>   md/raid5-cache: Refactor r5l_wake_reclaim() to take a struct r5conf
>   md/raid5-cache: Refactor remaining functions to take a r5conf
>   md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
>   md/raid5-cache: Pass the log through to r5c_finish_cache_stripe()
>   md/raid5-cache: Don't pass conf to r5c_calculate_new_cp()
>   md/raid5-cache: Take struct r5l_log in
>     r5c_log_required_to_flush_cache()
>   md/raid5: Ensure array is suspended for calls to log_exit()
>   md/raid5-cache: Add RCU protection to conf->log accesses
>   md/raid5-cache: Annotate pslot with __rcu notation
>   md: Ensure resync is reported after it starts
>   md: Notify sysfs sync_completed in md_reap_sync_thread()
>
>  drivers/md/md.c          |  13 ++-
>  drivers/md/raid5-cache.c | 240 ++++++++++++++++++++++++---------------
>  drivers/md/raid5-log.h   | 103 ++++++++---------
>  drivers/md/raid5-ppl.c   |   2 +-
>  drivers/md/raid5.c       |  50 ++++----
>  drivers/md/raid5.h       |   2 +-
>  6 files changed, 231 insertions(+), 179 deletions(-)
>
>
> base-commit: 6ad84d559b8cbce9ab27a3a2658c438de867c98e
> --
> 2.30.2
