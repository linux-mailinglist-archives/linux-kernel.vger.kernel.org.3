Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5056A809
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiGGQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiGGQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:26:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F84D174;
        Thu,  7 Jul 2022 09:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42DB7623C3;
        Thu,  7 Jul 2022 16:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD17C3411E;
        Thu,  7 Jul 2022 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657211195;
        bh=PP+pZtnbEBoGFSDAfTiA1TASPGKOktDeMzuTB5Z2rCE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nOCCoy1LGzU9IP2Pah/a04c4P1c/hO3gLEb+bQsaETT48tR32wsNsg/0awhoSZdkE
         g5lmimcwAhXnCU4eDIZw663mZwBzY2gt1XKd4hU/cinmFdyNvKlpsFtI/1AdO12nKz
         GtiX1Tmb/uPP0L7I/BEGMKTHJejBkIGuV4dCGigrHwqkBlk/P5ExAtOJC2bgxsHIzt
         J470O4XO8suFpEf/YC5cRIRUdvsHa7rhVAQBFYzkrcACVQrzp7P8nhiAn2imrQEdBg
         eamvVxZDt/kqC7V6iUkh0xpNpkcTPMvHLnwgPYJKXsEJNVagNW2uubSpkFNjkc59aJ
         1l5HQ5vgoH8SA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v8] ath9k: let sleep be interrupted when unregistering hwrng
References: <Yrw5f8GN2fh2orid@zx2c4.com>
        <20220629114240.946411-1-Jason@zx2c4.com>
Date:   Thu, 07 Jul 2022 19:26:27 +0300
In-Reply-To: <20220629114240.946411-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Wed, 29 Jun 2022 13:42:40 +0200")
Message-ID: <87v8s8ubws.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> There are two deadlock scenarios that need addressing, which cause
> problems when the computer goes to sleep, the interface is set down, and
> hwrng_unregister() is called. When the deadlock is hit, sleep is delayed
> for tens of seconds, causing it to fail. These scenarios are:
>
> 1) The hwrng kthread can't be stopped while it's sleeping, because it
>    uses msleep_interruptible() instead of schedule_timeout_interruptible(=
).
>    The fix is a simple moving to the correct function. At the same time,
>    we should cleanup a common and useless dmesg splat in the same area.
>
> 2) A normal user thread can't be interrupted by hwrng_unregister() while
>    it's sleeping, because hwrng_unregister() is called from elsewhere.
>    The solution here is to keep track of which thread is currently
>    reading, and asleep, and signal that thread when it's time to
>    unregister. There's a bit of book keeping required to prevent
>    lifetime issues on current.
>
> Reported-by: Gregory Erwin <gregerwin256@gmail.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Rui Salvaterra <rsalvaterra@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: stable@vger.kernel.org
> Fixes: fcd09c90c3c5 ("ath9k: use hw_random API instead of directly dumpin=
g into random.c")
> Link: https://lore.kernel.org/all/CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsF=
GTEjs0c00giw@mail.gmail.com/
> Link: https://lore.kernel.org/lkml/CAO+Okf5k+C+SE6pMVfPf-d8MfVPVq4PO7EY8H=
ys_DVXtent3HA@mail.gmail.com/
> Link: https://bugs.archlinux.org/task/75138
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Changes v7->v8:
> - Add a missing export_symbol.
>
>  drivers/char/hw_random/core.c        | 30 ++++++++++++++++++++++++----
>  drivers/net/wireless/ath/ath9k/rng.c | 19 +++++++-----------
>  kernel/sched/core.c                  |  1 +
>  3 files changed, 34 insertions(+), 16 deletions(-)

I don't see any acks for the hw_random and the scheduler change, adding more
people to CC. Full patch here:

https://patchwork.kernel.org/project/linux-wireless/patch/20220629114240.94=
6411-1-Jason@zx2c4.com/

Are everyone ok if I take this patch via wireless-next?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
