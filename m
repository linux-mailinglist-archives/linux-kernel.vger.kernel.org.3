Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70D4474401
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhLNN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhLNN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:57:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F80C061574;
        Tue, 14 Dec 2021 05:57:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639490265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rX9sx3/Rg0XcX58GUjdtswXYZt0YUczNTsQIoAklfg=;
        b=oc4HTFTol/r89SvaPNWCGhBJ0KP+kxOYyxFWFNlOCt/bXCUziuPWQPOHMFPS3+j0Y8vvS3
        mtRwDeI1K7M7WS+w3RlYx5zgWrJSIHhnHlIbBbzH5bXEFUJ3SQLVkf+W60D1ogEzIk6O7B
        YOzb6QSEjqZbW4ZAEGZyDZaOtjjdhW2CEt6iB1OZWSTmRvrq/Symdtz4i8AQmiIBo+HUNi
        /GXjIUq6hbz2YatEYnY/qaAhZevTbb4Gsprd1UM52/smVMgcB0JNJVu+wLdOjxkUw+bS7p
        GiR9D9xqnsh5YFej1oXYEQyCm+hsxrruBPTeHIui/Xoqh5d5/Z79ws/LllZJTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639490265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rX9sx3/Rg0XcX58GUjdtswXYZt0YUczNTsQIoAklfg=;
        b=KXtFcINluHsAWrxcwLo8lDTAklWFUBm1nf5dgjlOoMONUoPpti0UqI1mOtEUCdezZhMBMJ
        +G66Xq3dp5FpbVCQ==
To:     Joel Daniels <jdaniels@sent.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent
 clock drift
In-Reply-To: <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
 <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
Date:   Tue, 14 Dec 2021 14:57:45 +0100
Message-ID: <8735mvthk6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

On Mon, Dec 13 2021 at 06:39, Joel Daniels wrote:
> On Sat, 11 Dec 2021 14:36 +0100, Thomas Gleixner wrote:
>> Can you please verify that the problem persists with NTP enabled and
>> synchronized?
>
> Yes, I just verified that the problem still exists while
> synchronized to NTP.
...
>     $ chronyc tracking && echo && chronyc sources
>     [...]
>     Ref time (UTC)  : Mon Dec 13 13:30:52 2021
>     System time     : 5.597892284 seconds fast of NTP time

thanks for making sure that this is really a RTC issue on that machine.

> The "if" branch does not apply as I have no clock sources flagged as
> CLOCK_SOURCE_SUSPEND_NONSTOP but the "else if" branch does apply.

Which CPU is in that box?

> The kernel seems to believe that the time spent sleeping is exactly
> the difference of two calls to read_persistent_clock64 with no option
> to adjust for persistent clock drift.

The kernel does not believe. It relies on the accuracy of the CMOS clock
which is usually pretty good.

> I would like to provide a way for user space to inform the kernel
> that the persistent clock drifts so it can make a corresponding
> adjustment when resuming from a long suspend period.
>
> In my use case it would be enough for me to set this parameter on
> boot. In use cases with continuous network access, NTP daemons
> could be enhanced to periodically update this parameter with the
> daemon's best estimate of the persistent clock drift.

That needs some thought. The RTC people (cc'ed now) might have opionions
on that.

Thanks,

        tglx
