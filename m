Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36183585757
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 01:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiG2X3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 19:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiG2X3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 19:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F85721D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 16:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5902B6069A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 23:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7753BC433C1;
        Fri, 29 Jul 2022 23:29:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DFb4EEdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659137355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulXLGvor213yABCbMOZKZFQuoe8+LTI1cfvL7hSAb8M=;
        b=DFb4EEdmnWRveIjLDusFGYOugAfO90LBva8GyMJQ2auUGY/CcSaElQ7hbgsJDZoTzCRWzU
        7t6VARwxu/72tdr2syoIjuMU80ILmM+nm/zO2QCGpm9vK9d7imLh4h54Oss2Kkp/EkQFNb
        QdLOdfFqQX5LO2L9RRJcc3lLLZUUuf0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0d95e382 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 29 Jul 2022 23:29:15 +0000 (UTC)
Date:   Sat, 30 Jul 2022 01:29:12 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2 v2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YuRtSGCfe2qxHrqT@zx2c4.com>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220729154716.429964-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 05:47:16PM +0200, Sebastian Andrzej Siewior wrote:
> +static void fill_ptr_key_workfn(struct work_struct *work)
> +{
> +	int ret;
> +
> +	ret = get_random_bytes_wait(&ptr_key, sizeof(ptr_key));

> +static int vsprintf_init_hashval(void)
> +{
> +	static DECLARE_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
> +
> +	queue_work(system_unbound_wq, &fill_ptr_key_work);
> +	return 0;
> +}
> +subsys_initcall(vsprintf_init_hashval)

I'm unsure how good of an idea this is; it'll wind up setting off the
jitter entropy thing very early in init. It's probably a better idea to
just schedule the worker the first time that the RNG is already
initialized by some other means. Check `in_hardirq()` or something if
you're worried about missing the first message.

Jason
