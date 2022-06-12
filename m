Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009BE547CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 01:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiFLXI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 19:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiFLXIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 19:08:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032B3B002
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:08:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655075330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gh5KW0h/PquKzD84oAIRkbBhQi66jp8WkKcHulSua/k=;
        b=LXRJF3x32FhyA3KD2v/tpwHJZ61XnyDuon/HeOW2u5ZMLOTqik6VSrL5eMhJhdZdrTR8mf
        khCYaXg/hy6GQb2fEKIak2SibfZLEd3U+iQerihw/ft1rxI7NMtX/7vx9DdjWpIDmGf6F9
        PPApFVl2NPDi59PiV8oJforvOe/wPzZCtVN5cD/GDhutTYj9eOnwob/VHcNimthL4WBh6f
        HFViIeucTXfQtMk4xa0y9qfnoOfO3u4YGYjKJqkBM97pcRU8bGjYi52bEd9olLBPgcFEPw
        uGQQI/Vq0yBac6gtYkQwc9K2NeuEUypt8T4DJCvWoCyspxO3DBoEoHC54e7myQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655075330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gh5KW0h/PquKzD84oAIRkbBhQi66jp8WkKcHulSua/k=;
        b=Ro1qFTeELgknkRgH+JuRQwicT7B0kuI9sG4e58oqvTVmKYYWYtwCa550ecBRWeX9964ai2
        rshj6ISbP3Fj7xCg==
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
In-Reply-To: <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
Date:   Mon, 13 Jun 2022 01:14:50 +0206
Message-ID: <87zgihlbst.fsf@jogness.linutronix.de>
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

On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> This might be a side effect of the fact that this is on a low powered
> arm64 board. I noticed with threading enabled during large bursts the
> console drops an excessive amount of messages. It's especially
> apparent during the handover from earlycon to the normal console.

I guess you have a very small kernel buffer and are generating unusually
high amounts of messages? Is there a reason you cannot use a larger
buffer?

Or maybe you are generating a constant amount of messages that a serial
port could never keep up with unless it was interfering with the system
in such a way as to slow everything down? This is exactly what printk
should _not_ be used for.

John Ogness
