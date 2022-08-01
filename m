Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4DE586ADA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiHAMeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiHAMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60174796
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C827F60F0A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A8DC433C1;
        Mon,  1 Aug 2022 12:13:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aCJTOwAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659356023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vKK4CwsZMcxBBLYDvTSS6VPvl8zJxzdWJ8FalxvGj1s=;
        b=aCJTOwAldy5uKRRS+IpDIPZueHqOmexYgjMi/AUB1ARAp5PCzmyR/Swz++s2ZZF41ObSCE
        6y1oaqd+x1HZx6z0kLZKfr1GY8Jf0+3H3vOFSHLE+3Zo0XXS5qlJjH5BD44crZNThzMLGV
        UcrA+2flWhPclzvEu/wNnwkS1ezCZ/0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a057d4aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 12:13:43 +0000 (UTC)
Date:   Mon, 1 Aug 2022 14:13:36 +0200
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
Subject: Re: [PATCH 1/2 v2] lib/vsprintf: Remove static_branch_likely() from
 __ptr_to_hashval().
Message-ID: <YufDcPfth9JH6SaV@zx2c4.com>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220729154716.429964-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also,

On Fri, Jul 29, 2022 at 05:47:15PM +0200, Sebastian Andrzej Siewior wrote:
>  		if (!filled) {
>  			get_random_bytes(&ptr_key, sizeof(ptr_key));
> -			queue_work(system_unbound_wq, &enable_ptr_key_work);
> +			/* Pairs with smp_rmb() before reading ptr_key. */
> +			smp_wmb();
> +			WRITE_ONCE(filled_random_ptr_key, true);
>  			filled = true;

Also, should `filled` be changed there?

Jason
