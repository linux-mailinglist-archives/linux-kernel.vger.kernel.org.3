Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED7547D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiFMCX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiFMCXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:23:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE55F89
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 19:23:52 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655087030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4pUhakLpeWdRTQcLyq5yzn64tbD6Lu4RAFJSVoJmmo=;
        b=TPSgRqSxJKpUzMpRDYleQ+mW3mGgo2s7Z6qJlxG0rDJaxuUCiy4IJ7yCEQfSCtsVj7tvu9
        WVWVNOjTbBWN1cLTJa0xaA4sERf/1/MLNxpRxXETrtwP8Uue73f3uOvhC2r1YLl9dHSzeu
        d9vC9L1doE5A611uE+RClgTZzdveCUbt1Stdyd66VN8J4ia+dGBd+Xp4QZfXCUR3Jer5mN
        AhHohhx4EYiDNIR+GYjwKIkKMB/blVxQCCP+rslP6cHoa1mw67ZQpYtx0Ytv0oYIUBGUvA
        AsBAsS30junXnmCxU3BqCN6KiagBWANSZ/4jyqj0hcLKYrCeOYJeLMl5ETXgiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655087030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4pUhakLpeWdRTQcLyq5yzn64tbD6Lu4RAFJSVoJmmo=;
        b=oq26gIIX/4R1s70Vh5UkPEYUPdDHS1kl8SGMOhIP6rqLLgnvjq3GF/kVztoroIA5H3JgUy
        DaJGTklOUb5xc8Ag==
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
In-Reply-To: <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de>
 <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
 <87zgihlbst.fsf@jogness.linutronix.de>
 <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
Date:   Mon, 13 Jun 2022 04:29:50 +0206
Message-ID: <87sfo9l2rt.fsf@jogness.linutronix.de>
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

On 2022-06-12, Peter Geis <pgwipeout@gmail.com> wrote:
> The buffer isn't an issue here, everything is available in dmesg when
> userspace becomes available. Instead some messages bound for the
> serial console are never output.

OK. Good to know.

> We run a serial console at 1.5m baud which is significantly higher
> than most SoCs which default to 115200. I have noticed some timing
> differences since the introduction of the threaded console. A
> significant amount of information is dumped very early in the boot
> process (between 0 and 4 seconds into boot), as most drivers are
> probing during this time. It also happens to be when the earlycon
> console hands over to the normal console. There is no abnormal
> debugging enabled, the output is a standard (non-quiet) boot log. The
> question is why is direct mode not triggering during a panic?

Just to be clear, you are not losing any intermediate messages. Only the
tail end of the kernel log was never printed. Is this correct?

This may be the same issue being discussed here [0].

John Ogness

[0] https://lore.kernel.org/all/87v8t5l39z.fsf@jogness.linutronix.de
