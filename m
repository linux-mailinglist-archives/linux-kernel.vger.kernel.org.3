Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD34A547CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 01:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiFLXan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 19:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiFLXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 19:30:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6829C54187
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:30:39 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t32so7273738ybt.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSaAxK/sjwEAdJ0xVDT8/xNpyJ/5T+h2sZVRU4bYEY0=;
        b=Wb11KzRC251PpEFgIE6escV9Dfn+eILU3vMR4xh2V6EHTqVDngKlX7COztDCxS1ggA
         VReXCQT6ybasBP5v/TrwZk3CoOssl5lWMUPAzSwkG4wS+tTcl87fWBQtfeaNiBoUHWp+
         zkJh/5j7sPzCi4d5nN9FyNmUSXJyoWJdFuY8AZwRhthG5VB1aW40d12FOhRpQ/vA31GF
         DC6dErIImTLTCgy4atRg3jz94b7jgFzQuC6D8hLNPlBsevC7ceMUB5SLKNXZnhza2ODq
         M04zsGh8o/Q3ZyeDeBIZmE53fDqkqGYl94aCmomHfD33cxrWkQa7ubRxAJ3+Q46wxwfA
         U3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSaAxK/sjwEAdJ0xVDT8/xNpyJ/5T+h2sZVRU4bYEY0=;
        b=5+jeZdujbsUdO7I5XKa630M7zMyk3X6Us6CBqBTQFfjU4see942fQMHHbLSpOje/N3
         e2QVTvcClckvESdMnxA/7YyLeuDmMHuFB/Krs6WqGjVsU0ktB5tKh5iUD2rruDZze/oH
         OAuMHBOM03m/EN3nbe55zy5iFNVXQF1fY/zmu25G366MpIdVyGuaqxlAHRrAIs9TaqEM
         GVg7nlsRJZzM7oRnM60lT7IICw6M5w1eE6a8rHMWXvNaxYq559EqVLKcF2PznMirEIyy
         c4o64sW4fsIKgnt6u4SgQrAYsxDCmPmjLsxbdSZvFXBpJGQIycAg3MH4R6nWdH3hYyjQ
         yHqg==
X-Gm-Message-State: AOAM533bR5jM8O05yQevz/3cksIYC5nVlOA4TnzdwzYlPaEVXXD5cD8j
        DqVugWT4/hCOvmhzRDcf/1r2X337ntn7IOgkEn20OEGp
X-Google-Smtp-Source: ABdhPJwiILPZWUpes4rrwhkafz3EszitYKgpKNG64GltNHkUCTDoiV+uydCymPnlzHVdAWVHOQlqqR5ir/Mu3QHuNNI=
X-Received: by 2002:a25:4544:0:b0:660:63fc:9d41 with SMTP id
 s65-20020a254544000000b0066063fc9d41mr51396747yba.600.1655076638591; Sun, 12
 Jun 2022 16:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de> <CAMdYzYr-Wo713Y4qjboTpoK6GcrYfKCfRJAEizwXw6-=dymVzg@mail.gmail.com>
 <87zgihlbst.fsf@jogness.linutronix.de>
In-Reply-To: <87zgihlbst.fsf@jogness.linutronix.de>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 12 Jun 2022 19:30:27 -0400
Message-ID: <CAMdYzYosXiQc9=t7daPaWWS=rnTVT6nnZvVBXDycBQvfR-1FAA@mail.gmail.com>
Subject: Re: [BUG] Threaded printk breaks early debugging
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 7:08 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2022-06-10, Peter Geis <pgwipeout@gmail.com> wrote:
> > This might be a side effect of the fact that this is on a low powered
> > arm64 board. I noticed with threading enabled during large bursts the
> > console drops an excessive amount of messages. It's especially
> > apparent during the handover from earlycon to the normal console.
>
> I guess you have a very small kernel buffer and are generating unusually
> high amounts of messages? Is there a reason you cannot use a larger
> buffer?

The buffer isn't an issue here, everything is available in dmesg when
userspace becomes available. Instead some messages bound for the
serial console are never output.

>
> Or maybe you are generating a constant amount of messages that a serial
> port could never keep up with unless it was interfering with the system
> in such a way as to slow everything down? This is exactly what printk
> should _not_ be used for.

We run a serial console at 1.5m baud which is significantly higher
than most SoCs which default to 115200. I have noticed some timing
differences since the introduction of the threaded console. A
significant amount of information is dumped very early in the boot
process (between 0 and 4 seconds into boot), as most drivers are
probing during this time. It also happens to be when the earlycon
console hands over to the normal console. There is no abnormal
debugging enabled, the output is a standard (non-quiet) boot log. The
question is why is direct mode not triggering during a panic?

>
> John Ogness
