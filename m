Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDC05511B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiFTHoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiFTHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:44:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04A6418
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:44:02 -0700 (PDT)
Date:   Mon, 20 Jun 2022 09:43:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655711037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tva4ntyPqz0jZawiKVHe9/LFqzvlD7thGRd/uzxp3aQ=;
        b=BQkcXel5o+3EitcZszx/LwEAGktHbx37NIWRfldX30Xi6yFks2AukopJv1+FYkLL5A01nj
        JM9tiamiPalesGuUB7oBOz36P0lfyOx9apJMriulEvjcYiW3rE9fYy0D7ZZl9CMdwjqAhy
        5k9vbymyHIYMro4ScOZotzaGCTW8unujDgHFsaXprTJ7WbBcXXXgOAubM+3c3Dj2fIlhIv
        PWexEpIkwpfxjzhHbf3qiIljQUppluylewE4u5b8hWYn0NGdvSg3DSVJL8iFHBpgI5D1rN
        XzwO9WmVt8wh00g/wcVXh+J+srMlRMrnoyWS85mFiVgWwQm4osclJJElEeXxNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655711037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tva4ntyPqz0jZawiKVHe9/LFqzvlD7thGRd/uzxp3aQ=;
        b=ZuXwDhnkaVL3HQjjIZKwc3xjxocOY43gq98f0wYInqdgRh75oOtHcDkUDWTTRuJfuA7N49
        6oAkCXzW800rC0Dg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] random: Fix signal_pending() usage
Message-ID: <YrAlPKeOowD5qv/B@linutronix.de>
References: <20220405163931.1108442-1-jannh@google.com>
 <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de>
 <Yq0EcG9GsAkoiF3H@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yq0EcG9GsAkoiF3H@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-18 00:47:12 [+0200], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> You're a bit late to the thread :). It used to be 256. Now it's page
> size. PAGE_SIZE is also what /dev/zero and others in mem.c use.

Just managed to get to that part of the inbox ;)

> As for your suggestion to drop it entirely: that'd be nice, in that it'd
> add a guarantee that currently doesn't exist. But it can lead to
> somewhat large delays if somebody tries to read 2 gigabytes at a time
> and hits Ctrl+C during it. That seems potentially bad?

So on my x86 box which runs a Debian kernel (based on v5.18.2):

| ~$ dd if=/dev/random of=/dev/null bs=2147483648 count=1
| 0+1 records in
| 0+1 records out
| 2147479552 bytes (2,1 GB, 2,0 GiB) copied, 5,97452 s, 359 MB/s

almost 6 secs. On a smaller box it might take 12s or more. Your
implementation change ensured that it does not block for unpredicted
amount of time. Previously it would block until the random pool is
filled with enough entropy and this could take an unforeseen amount of
time. That read now makes more or less constant progress since it
depends only on CPU time.
Based on that, I don't see a problem dropping that signal check
especially that requests larger than 4KiB are most likely exotic.

> Or that's not bad, which would be quite nice, as I would really love to
> add that guarantee. So if you have an argument that not responding to
> signals for that amount of time is fine, I'd be interested to hear it.

Just my two cents.

> Jason

Sebastian
