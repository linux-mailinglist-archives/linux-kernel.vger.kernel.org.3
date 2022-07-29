Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C34584F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiG2KvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiG2KvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:51:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FEEDF27
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:51:18 -0700 (PDT)
Date:   Fri, 29 Jul 2022 12:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659091876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVT0gX+sjhINrg63wCZePpCeJDQ5FLRBslXE3pXrKFA=;
        b=NnZTBBsfckoHY4uBEsfyzgjPArktQXWcZ6w3wHj0mgYBrCkoMJbT9N95e9YgFcfcjzLsmc
        T2UFUwfUI6ER/1GOSOEm5lBMsWg8iP+b/l19dEIBNrsR23khbKIblzN18uAoz0A1ZPO9WX
        OzbCtOmEGTc6G2rR5A4WTD65vF/DuNa0N8EDrk471cdUWTX1zy1RQued68RyLO7FkVVYMk
        xyd4t1vlft8/gCz5Y8iDom3QYoEKhxZKKN3f2gaFht/QtkfU+Y5efkFq3Viu19SvP+POZT
        QFLynKqWhx2tp9W/ew/fdVsBT83QtZ4kPGOnWB6R1EhkJ4g6/jsbbd7smsBbfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659091876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVT0gX+sjhINrg63wCZePpCeJDQ5FLRBslXE3pXrKFA=;
        b=SWNCbpgPqlmjIe2gJlja5zeTrL4YpAOMxUokWQquj9LbgjXwunFFgffU0+bXyyf7CM5Xx0
        BjUVDZ4KVmBVvEDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Initialize vsprintf's pointer hash once the
 random core is ready.
Message-ID: <YuO7ommLFTSLQQ6h@linutronix.de>
References: <YuOf6qu453dOkR+S@linutronix.de>
 <YuOyeJu8PPAVnXiN@zx2c4.com>
 <YuO0p8lMhVmQj/K2@linutronix.de>
 <YuO4jj8rg9hjHErN@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YuO4jj8rg9hjHErN@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-29 12:38:06 [+0200], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> On Fri, Jul 29, 2022 at 12:21:27PM +0200, Sebastian Andrzej Siewior wrote:
> > So launching a worker to obtain the random data? That would mean that
> > the first %p print won't have nothing, right? I could do it as part of
>=20
> "First" isn't very meaningful here. If the rng isn't initialized by
> add_bootloader_randomness() or similar, then it'll almost miss some
> amount of %p anyway.

only if that printk happens during boot. But it could happen much later.
In that case !RT won't lose that pointer but RT will.

> But anyway, it sounds like you only need to hoist into a worker IF
> you're `IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq()`, right? So just
> conditionalize it on that, and this should have pretty minimal impact.

I need always to hoist into a worker because there could warning in a
preempt-off region leading to this error.
Maybe I am putting too much importance into this. Let me do what you
suggest and always lose that first pointer and if someone complains than
maybe we think about something else=E2=80=A6

> I don't think this patch will require touching random.c.
>=20
> Jason

Sebastian
