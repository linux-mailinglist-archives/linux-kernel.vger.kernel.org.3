Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36505468F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbiFJPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiFJPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:05:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4B63504
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:05:17 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654873515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/irLIUiOU3R1KbdYEek7Nb2Y14nGCRWA/qsrIaXAgY=;
        b=Eqh6khc+lVpttb+8is7HqjuKWhoj/qFv8BYfDRbkiNecbpTxYYbcErvSA+lNQB5h7j0OLD
        1R+jqBiPibSohGo1WPoO1GX8S6M140BdX7oEnnbRMrKjc7qHjET1xol/+4EFqKOkGgM0HE
        CRj19Hxhpcc544QcVw6wwCe/muc4MkPjRhnIbp4B6Rye7+kLG1ugyvYlxIxbQBUAjNgeZZ
        B1hv1RLGy3NYGvgc/2zcaZMy7CxcfB+AyK7z6zis9xBqbQbFETrowv/H8tdZUS7CAL67SI
        2DEfYiT5jknalJ9TUWsKY4hEtWUDnnallyRmts37TSutS+h2UJNSbFQgbM857w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654873515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/irLIUiOU3R1KbdYEek7Nb2Y14nGCRWA/qsrIaXAgY=;
        b=+lRnT2ox4AONfHl8lL1FxwRMHR0+vmqWE6twbUeEw1YLaFKBMH0DWjSeKd5tf7aNXVbWLm
        kR5ZCP2f2PBbA1Ag==
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
In-Reply-To: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
Date:   Fri, 10 Jun 2022 17:11:15 +0206
Message-ID: <87y1y48spg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> However I've run into an issue debugging early boot issues. Anything
> that causes the kernel threading system to die (for example here, a
> NPE) causes the boot console to halt before it outputs the error.

A null pointer exception should trigger a panic, which will cause printk
to enter direct mode for the oops. It should be just as effective as
before introducing the printing kthreads.

Can you please provide a test case or patch that will trigger the
problem you refer to?

> Would it be possible to have both a kconfig option and a runtime
> option to toggle printk_fallback_preferred_direct()? Currently I've
> had to force it at all times while debugging.

It would be trivial to provide a boot parameter for this behavior, but I
think we first need to see a real problem and also see if we can fix
that problem.

John Ogness
