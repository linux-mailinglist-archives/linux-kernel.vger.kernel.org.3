Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7AE4F9B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiDHRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiDHRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64FB10504D;
        Fri,  8 Apr 2022 10:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F3862175;
        Fri,  8 Apr 2022 17:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E285C385AA;
        Fri,  8 Apr 2022 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649438302;
        bh=MbZ+trhl7zeD1lTZLqOn8O3zllxwQ5hjkWePlpqfncc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tdc1pj5M3xQ4d3BE2ILiOy/9SVR4lC22W57HI2PTiihJ171vzw6AZt7jyp0QRvTj1
         6z0aHHGApwW62oiyq7BpINCnoThD2FFJ4a1/VdVDC/j4jjEPcUjdA9axtw/CaDZl8Q
         LyNpJTQjZAuy0B84rLhfxkDFgiB1HcI4lMPK/fF2e2w2OIsj5d8oIfyQbU/V+M+MOA
         iRp9J8WrpGFGb0ndmQs68J/LmndlE577IoHsPd6iEwLuJiwCtxHjGlupOnl+wbj5Yv
         8/twPKBzA9tiH1AKJoqVOU80NjcUK3ly987H0vmQIUsHV9CMjiyYR6NhXhCoIaZlMR
         vmi7hE6EZrmuA==
Received: by mail-yb1-f177.google.com with SMTP id f38so16277585ybi.3;
        Fri, 08 Apr 2022 10:18:22 -0700 (PDT)
X-Gm-Message-State: AOAM533i5FMDwHnXSoqpu0xJe5Xwyd8lqUprH/OQWGEKqGhpEKJWnr2q
        97XcP3KJtQZe//JoKh5pTFDs2YifDd3usGOutfk=
X-Google-Smtp-Source: ABdhPJx3lRrAf8LzfOfLcw9K6468JToUxW9zoGSZLqq0kwo5P4Vc1Oz8upqdJlDhdaqwdUY/ES0I7SKBi32XaC+iBLQ=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr13416194ybn.259.1649438301674; Fri, 08
 Apr 2022 10:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220407165713.9243-1-logang@deltatee.com>
In-Reply-To: <20220407165713.9243-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Apr 2022 10:18:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4=Ubc6LTmot97Tx2oGzuuBmV2U7yMWuEQMhPzjb+ed=w@mail.gmail.com>
Message-ID: <CAPhsuW4=Ubc6LTmot97Tx2oGzuuBmV2U7yMWuEQMhPzjb+ed=w@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Minor Raid5 Fixes and Cleanup
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 9:57 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> This series contains a few cleanup and minor fixes to the raid5 code
> to make it a bit easier to hack on.
>
> Patch 1 cleans up the error returns in setup_conf() (I had an
> abandonded patch that added another error out and needed this clean
> more sensible).
>
> Patch 2 fixes a sparse warning with the raid5_percpu structure.
>
> Patch 3 through 6 fixes sparse warnings related to missing __rcu
> annotations when using the RCU calls.
>
> Patch 7 just adds some basic __must_hold annotations for the device_lock
> to any function that is called while holding the lock. Sparse doesn't
> really check this, but the annotation makes the locks a little easier
> to analyze.
>
> Thanks,
>
> Logan

Applied to md-next. Thanks!

>
> --
>
> Logan Gunthorpe (7):
>   md/raid5: Cleanup setup_conf() error returns
>   md/raid5: Un-nest struct raid5_percpu definition
>   md/raid5: Add __rcu annotation to struct disk_info
>   md/raid5: Annotate rdev/replacement accesses when nr_pending is
>     elevated
>   md/raid5: Annotate rdev/replacement access when mddev_lock is held
>   md/raid5-ppl: Annotate with rcu_dereference_protected()
>   md/raid5: Annotate functions that hold device_lock with __must_hold
>
>  drivers/md/raid5-ppl.c |  13 ++-
>  drivers/md/raid5.c     | 179 ++++++++++++++++++++++++++---------------
>  drivers/md/raid5.h     |  23 +++---
>  3 files changed, 139 insertions(+), 76 deletions(-)
>
>
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> --
> 2.30.2
