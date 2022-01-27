Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27F449DD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiA0JJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:09:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34474 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiA0JJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:09:08 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643274547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUdeV9VjSeLqvfWhftH1z7hD4K58sO8RSwPTTMJM3Go=;
        b=Dyq2k1eq2r2miWQ+6o64QEPL3eIhCxMRbJeJeM9mKnQgdwSrNkz7Zkq049MzNSApaGy/kR
        Ih5ovkuqy6ohDfaZQ8d26QPWbH1LkdakRw8+Y1kQmhcihb85eEyPntqzpe6zDIbzz3r4oK
        bKyh8De2XU6D7EOdbAYPt/Cex5b8sz4gySs1kfRYu/ztD9HCxLjzhQb3mjZnk6f+AGsApH
        TJhGI8CNaUUvCcu9CpEsLfwS2mhnC66GJD5th1KzN6jbGiOsioshsQX9c/SmEM3tkyX3Sm
        CjDc8fOsP6R4HH64o+c2snZEjszI4yB8eJMVEtWpNyX2AFRUhc+3WYrsusRmTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643274547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUdeV9VjSeLqvfWhftH1z7hD4K58sO8RSwPTTMJM3Go=;
        b=Uc3Xn44AI9Oo7QLfIRGKvNOYywHexzL8g5BlbiiVILKLR3lFv00BegohSvfKW5rFmz8vzz
        LlvOlmHfHaWSggBg==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
In-Reply-To: <YfJFjHdg/khNXiRd@google.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com> <87r18un83x.fsf@jogness.linutronix.de>
 <YfEdNKWI7GqKr9P/@google.com> <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
 <YfJFjHdg/khNXiRd@google.com>
Date:   Thu, 27 Jan 2022 10:15:05 +0106
Message-ID: <87ilu5pmtq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> Right. So I also thought about placing panic_in_progress() somewhere in
> console_trylock() and make it fail for anything that is not a panic
> CPU.

I think this is a good idea and console_trylock() is the correct place
for that.

> Back in the days we also had this idea of "detaching" non-panic CPUs from
> printk() by overwriting their printk function pointers.

We need to keep in mind that printk() is no longer the problem. The
records are stored locklessly. The problem is the
console_trylock()/console_unlock() within vprintk_emit(). IMHO adding a
panic check in console_trylock() should solve that race sufficiently.

John
