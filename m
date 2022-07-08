Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160AA56C36E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiGHTEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGHTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:04:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1925295
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:04:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657307076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycbHxgjBmZtCvpAyK4XSXGKKv36UVtTn3WZRrsj75eE=;
        b=2ChjxV+at8O99xZnEdzd/9iVpL7m5o79cSG84nkImQkrSOcTO2CCdc24PN2IHTfp9cQc2r
        7uyh0mJyJv4LFkUMU7pzaMofU7eGPb+kPR2c45YfB/j5UY5vXaplHRMz096jOp4nW/8QL1
        fim1iO8CVmoby0iV/s0rhnrdY9cz+OWb+ep2cSZrK3zC8okqmRWLbGkPelyelN6fXh7OZG
        9kOHHhYokRng5m5ByWl/7OBzivF54Gj+Pk9lZXWbRTm39JrarqA1ueafwz0XaM+U0OpUKl
        ooTakEoP1p+oqBIVdlGTebmY8eVDhxkpSVK/lDV8H+bMxGfXyzimqkUNSLnj8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657307076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycbHxgjBmZtCvpAyK4XSXGKKv36UVtTn3WZRrsj75eE=;
        b=6EokXp0+KiMacdaQo5Cmzqcj3EgHNutiemScPCuFRzvsniFepKAz5uFQefqTDjJjBV8nTq
        KxViJ1OArpE6grCw==
To:     Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
In-Reply-To: <YshL2M8VdIEONDdc@alley>
References: <YoeQLxhDeIk4VSmx@chrisdown.name> <YshL2M8VdIEONDdc@alley>
Date:   Fri, 08 Jul 2022 21:10:35 +0206
Message-ID: <87o7xz5su4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-08, Petr Mladek <pmladek@suse.com> wrote:
> The console-specific loglevel might be set by:
>
>   + "console=device,options/loglevel" kernel parameter at boot time

I ask if we avoid the use of "/loglevel" and instead use a generic
scheme of:

console=device,option,option,option

Of course, it would mean that the type of option would need to be
specified. Something like:

console=ttyS0,115200n8,loglevel=3

The reason why I make such a request is because I would like to be able
to support disabling threading for certain consoles. Something like:

console=ttyS0,115200n8,nothread

or when we have atomic consoles that we can specify that they are always
used with a "sync" option:

console=ttyS0,115200n8,sync

This is not the time to discuss what those strings should be. The point
is that we should use a syntax that allows adding more options for the
future.

Linus already [0] showed some approval to this method of option
extending as I suggested the "mute" option to have consoles keep quiet.

John Ogness

P.S. FWIW, I think this is a nice feature. I even mentioned it in my
LPC2019 printk talk, as there were previous efforts [1] to get this
feature implemented.

[0] https://lore.kernel.org/lkml/CAHk-=wif0QueN8ovkm_x7TsOgOHjRrOa4wU-zHgBP=FTAnzvNA@mail.gmail.com

[1] https://lore.kernel.org/lkml/bc1fe800930be76761b2bb4e6108fe5876a005c9.1491345440.git.calvinowens@fb.com
