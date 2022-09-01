Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B235A89F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiIAAry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIAArv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:47:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231BFEA88B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEAA1B82149
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A12C4347C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661993267;
        bh=8TtrzEUYcTXrbSMvbPpUN1sNEwmJ5oI3rmo8szseH7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eZ5bBQmnf/WjM7gj2RIm0Qga7vpv4b793kawGgvIV/q+W4A0RSY6pXWBBmUskCOc7
         rmjd2PmdIjreon3nshdFG24v3AWm7AEbznGmYIPm//h1+1Ffk6TYeLixGPkdyCfv0N
         LR6QRUHOAA45vtUYd76PEVjj1Gof9ILK0ID3GtaT8jkQvRwP/5xfVRL4cGSk+mla/a
         vlgauD/UgTAtz8c+eA0APimpOn31kufY0PDnNnuhQmQrst0OoP6N/yPGdjNiu4N18h
         333TUkpwoK+W6EwnlAPbDQjfQiqgwmGwLcCEtkI1wulrrwc5EekCRY9zhYOqiUjDJM
         YiRq7NMfdm/XQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3376851fe13so322772017b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:47:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo3qkSya8c/CyiNPiwj7xahCaTJnH3vETzA9cfIjhxPQtnvpbugn
        O4SRWX3S7pbFJAbwygJL+3Z7Z+FlSBA48w9izJU=
X-Google-Smtp-Source: AA6agR76MRlOJDBg7OBvdr2IqlIMjdntMxlk3Mo1tO4Jwz0AEWnVUfZGx6koTK3buPquKIY+TgZlzOPC7dvbWzCsTRc=
X-Received: by 2002:a81:7489:0:b0:33e:dca7:9750 with SMTP id
 p131-20020a817489000000b0033edca79750mr20866790ywc.73.1661993266323; Wed, 31
 Aug 2022 17:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220831052734.3423079-1-song@kernel.org> <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
In-Reply-To: <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 31 Aug 2022 17:47:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
Message-ID: <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Baoquan He <bhe@redhat.com>
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

On Wed, Aug 31, 2022 at 4:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 30 Aug 2022 22:27:34 -0700 Song Liu <song@kernel.org> wrote:
>
> > find_vmap_lowest_match() is now able to handle different roots. Make
> > similar changes to find_vmap_lowest_match_check() and
> > find_vmap_lowest_linear_match() to handle different trees.
>
> What are the runtime effects of this change?

The code is gated by DEBUG_AUGMENT_LOWEST_MATCH_CHECK. It
is only compiled when the developer enables it explicitly. Therefore,
there isn't
any runtime effect.

Thanks,
Song
