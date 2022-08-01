Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A77586C50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiHANzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHANzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:55:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA6C20F60
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B0CECE16B2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23552C433D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:55:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bN7nb2gQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659362120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+oARml/cELMNRGuLebG0MZUwD+dxqPhqLeWi6zL9E7s=;
        b=bN7nb2gQ/KHqQu7s+Nea/JM6nyaum8clsnYkVoOSyl5pt5SbFg9JPdhhKApDvJa71VlEpv
        VvtTa99vSh+3CG9vbjU5tIi7UnOKthyOQmQQhn5A0atmSq/1VhJY07OnlvU7R2qLiXI6cX
        Wd4RqGTOhwIuu5U2B6NOa8IkTUHb0Y0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fae206de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 1 Aug 2022 13:55:20 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31e7ca45091so109814457b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:55:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo1mo+SOr/yccAmX3C0hwMxOI7xCCMgA0PfV/QqskWqxdPJkQS62
        yqoz0yd4OCVBpCEdZgv7KaY/jLABl1VyBmmIVFk=
X-Google-Smtp-Source: AA6agR7LkYr8ukMzmcXffGxWvqCehRr6SGXAucNJcMvTPI8fBZKLm77LPzwY+bTevEy1TdSrsfEEt+xAC17r6C0dvhc=
X-Received: by 2002:a0d:e649:0:b0:320:2b99:b79f with SMTP id
 p70-20020a0de649000000b003202b99b79fmr13148223ywe.414.1659362117727; Mon, 01
 Aug 2022 06:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:5289:b0:18c:c8f2:d84f with HTTP; Mon, 1 Aug 2022
 06:55:17 -0700 (PDT)
In-Reply-To: <YufZVy5adMfl3n9g@linutronix.de>
References: <YufHN7fF0dROMETj@zx2c4.com> <20220801123945.43081-1-Jason@zx2c4.com>
 <YufLK6hio/v1gfmq@linutronix.de> <YufW4G/A3eQKpdjj@zx2c4.com> <YufZVy5adMfl3n9g@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 1 Aug 2022 15:55:17 +0200
X-Gmail-Original-Message-ID: <CAHmME9qP2ZR6oQY3bf8W42RHW+-DamrzT=Gh1XJ3O7f72NU_bQ@mail.gmail.com>
Message-ID: <CAHmME9qP2ZR6oQY3bf8W42RHW+-DamrzT=Gh1XJ3O7f72NU_bQ@mail.gmail.com>
Subject: Re: [PATCH v4] lib/vsprintf: defer filling siphash key on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 8/1/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> You do remember the warning that poped up in random core with
> CONFIG_PROVE_RAW_LOCK_NESTING enabled? Where I said it does not affect
> !RT it just points out a RT problem in a !RT config?
> If you fix this with one code path for RT and another one for !RT then
> you will have this warning _if_ the caller has a raw_spinlock_t
> acquired.

CONFIG_PROVE_RAW_LOCK_NESTING catches RT issues on non-RT. It doesn't
catch non-RT issues. So lockdep isn't actually warning about something
real as far as non-RT is concerned when CONFIG_PROVE_RAW_LOCK_NESTING
is enabled.

So probably this v4 patch should expand that condition to be:

IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING) || IS_ENABLED(CONFIG_PREEMPT_RT)

That's somewhat distasteful, I realize, but it *does* make the code
actually match reality, which is maybe better.

Jason
