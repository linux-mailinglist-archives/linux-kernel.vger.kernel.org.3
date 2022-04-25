Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E350EC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiDYXKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiDYXKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB6344EA;
        Mon, 25 Apr 2022 16:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489716159F;
        Mon, 25 Apr 2022 23:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC25CC385A4;
        Mon, 25 Apr 2022 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650928044;
        bh=Ut2ZRekUxD3QDPwVjN7a9GtFeGn15HzJsW2Jd7x6WHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SrLeQ7BYOQV3gbx/xV6FBPbDdBrkKBK7gIyk2aOVaxRiHXr5YCy1Vgmzb8N3zAe7e
         Pr4qwqQtO95puqyNoDNSVZpTcrmwpArWj/kNV2cIXLykpj+wmPFT7Pecc5bdOQZDx4
         v1vv/cDEERdRWM/5yTCzzKCSy5Kg15moSEFzpo1X2qEvV1pR5EHCoF8FP9dMpZZok2
         MLwhOLpWBt4oAUKVAMXd+1Sb8DA+j+pnVYw9KsNC137J7Q1RkFqTI/YXRnm53+HtvM
         B9XV3FddnfsO+Oi3jxnsjTVhJIk16NaE5ap57ek2mTjN8ZMq96tRBfXdUGtzi5YvCS
         qvOE52J3jJkgw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f7b815ac06so88986357b3.3;
        Mon, 25 Apr 2022 16:07:24 -0700 (PDT)
X-Gm-Message-State: AOAM530D+oGJZCg7cFneD2UXLUY5pei2U5KsSQipwWAKtBbCj7iFN2sA
        VFgCc/e6k31XjXgzP/p6nfeMZUV+fdHZ05spjFg=
X-Google-Smtp-Source: ABdhPJyKbwPs2SJGQho7ABhnYBSNq5EWScjCubZCtYQyvJvyuOOf86BcYUT1UWFghtLaFZJt5OTZVbMz3mw3nawntkY=
X-Received: by 2002:a81:9b57:0:b0:2f1:49eb:1ad9 with SMTP id
 s84-20020a819b57000000b002f149eb1ad9mr19571548ywg.130.1650928043709; Mon, 25
 Apr 2022 16:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220420195425.34911-1-logang@deltatee.com>
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 25 Apr 2022 16:07:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6j7UYn-jH9-kmBfe5h+PJ_HjP9v6dW+VDKiMW+t+XUhA@mail.gmail.com>
Message-ID: <CAPhsuW6j7UYn-jH9-kmBfe5h+PJ_HjP9v6dW+VDKiMW+t+XUhA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Improve Raid5 Lock Contention
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:55 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> This is v2 of this series which addresses Christoph's feedback and
> fixes some bugs. The first posting is at [1]. A git branch is
> available at [2].
>
> --
>
> I've been doing some work trying to improve the bulk write performance
> of raid5 on large systems with fast NVMe drives. The bottleneck appears
> largely to be lock contention on the hash_lock and device_lock. This
> series improves the situation slightly by addressing a couple of low
> hanging fruit ways to take the lock fewer times in the request path.
>
> Patch 9 adjusts how batching works by keeping a reference to the
> previous stripe_head in raid5_make_request(). Under most situtations,
> this removes the need to take the hash_lock in stripe_add_to_batch_list()
> which should reduce the number of times the lock is taken by a factor of
> about 2.
>
> Patch 12 pivots the way raid5_make_request() works. Before the patch, the
> code must find the stripe_head for every 4KB page in the request, so each
> stripe head must be found once for every data disk. The patch changes this
> so that all the data disks can be added to a stripe_head at once and the
> number of times the stripe_head must be found (and thus the number of
> times the hash_lock is taken) should be reduced by a factor roughly equal
> to the number of data disks.
>
> The remaining patches are just cleanup and prep patches for those two
> patches.
>
> Doing apples to apples testing this series on a small VM with 5 ram
> disks, I saw a bandwidth increase of roughly 14% and lock contentions
> on the hash_lock (as reported by lock stat) reduced by more than a factor
> of 5 (though it is still significantly contended).
>
> Testing on larger systems with NVMe drives saw similar small bandwidth
> increases from 3% to 20% depending on the parameters. Oddly small arrays
> had larger gains, likely due to them having lower starting bandwidths; I
> would have expected larger gains with larger arrays (seeing there
> should have been even fewer locks taken in raid5_make_request()).
>
> Logan
>
> [1] https://lkml.kernel.org/r/20220407164511.8472-1-logang@deltatee.com
> [2] https://github.com/sbates130272/linux-p2pmem raid5_lock_cont_v2
>

The set looks good to me overall. Thanks everyone for the review and feedback.

Logan, please incorporate feedback and send v3.

Thanks,
Song
