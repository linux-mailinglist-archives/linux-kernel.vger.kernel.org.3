Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418935530EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbiFULfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFULfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:35:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF91AF0A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:35:35 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655811331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRR+VIP54qAipl6tCkuIBM7tblExjyxMWMduPdccz6w=;
        b=Xxygc4k7zvydCJOiBQDYetRRx2dro61hC9179fn0DBlZ8NbxnBox0sr+Owzhuc4qZ+GxOl
        x2rkNNlRakazP3FYLb0InB78IErnz+NrJbrVlPoB1yDVKke3kF1XJJqwOPvpBAwunDnU6F
        7y/l/GLX7vyFVfoKzlYgJ68gBN3tGfDSEWv3QtEb+NM/CnPMuSZeoaa7s4Xjsdw2iMYLRm
        BNeIyEJi4Y/F7W9PBAaocbcWYS8KqRIMKC2kO6yJjgFyAxD6kw6sRLD2XEzpF5auxQiCu6
        5rbMLitBmfJ+IQoJ7aLNkiY+If73R1Npo7tJ7qMI9f2Vz15tSxSuZ07E6+0vUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655811331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRR+VIP54qAipl6tCkuIBM7tblExjyxMWMduPdccz6w=;
        b=FN9gMQcfMrbSJMdwyN2Dl04Oj7J0dzFWmpIPvl4alHTxdSI/m7BzykfmlBkw0GVBSlNAMt
        DaC+c7+drEyQ3RAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
In-Reply-To: <20220621090900.GB7891@pathway.suse.cz>
References: <20220621090900.GB7891@pathway.suse.cz>
Date:   Tue, 21 Jun 2022 13:41:30 +0206
Message-ID: <877d5az1tp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-21, Petr Mladek <pmladek@suse.com> wrote:
> Threaded console printing does not take into consideration that boot
> consoles may be accessing the same hardware as normal consoles and thus
> must not be called in parallel.
>
> Since it is currently not possible to identify which consoles are
> accessing the same hardware, delay threaded console printing activation
> until it is known that there are no boot consoles registered.
>
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@sams=
ung.com
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Reported-by: Marek Beh=C3=BAn <kabel@kernel.org>
> [john.ogness@linutronix.de: Better description of the problem.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
