Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D374877E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347044AbiAGNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:03:17 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54267 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiAGNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:03:16 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C5DB624000D;
        Fri,  7 Jan 2022 13:03:14 +0000 (UTC)
Date:   Fri, 7 Jan 2022 14:03:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/9] rtc-cmos,rtc-mc146818-lib: fixes
Message-ID: <Ydg6EnPdWjB3Vznc@piout.net>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107124934.159878-1-mat.jonczyk@o2.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/01/2022 13:49:25+0100, Mateusz Jończyk wrote:
> Hello,
> 
> This patch series fixes some issues in the RTC CMOS handling code:
> 
> 1. A missing spin_lock_irq() / spin_unlock_irq() pair in cmos_set_alarm().
> 2. A failing presence check of the RTC: the clock was misdetected as
>    broken since Linux 5.11 on one of our home systems.
> 3. Do not touch the RTC alarm registers when the RTC update is in
>    progress. (On some Intel chipsets, this causes bogus values being
>    read or writes to fail silently.)
> 
> This is my first patch series, so please review carefully.
> 
> v2: Drop the last patch:
>         Revert "rtc: cmos: Replace spin_lock_irqsave with spin_lock in hard IRQ"
> which was made obsolete by mainlining of 
> commit 13be2efc390a ("rtc: cmos: Disable irq around direct invocation of cmos_interrupt()")
> 
> v3: Rework solution to problem 3 (I'd like to thank Greg KH for comment),
> drop x86 refactoring patches (I'll send them later).
> 
> v4: Fixed some issues pointed out by Mr Alexandre Belloni:
>     - do not add strings to rtc-mc146818-lib.c - I moved the error printing
>       code to callers of mc146818_get_time(). This resulted in two new
>       patches in the series,
>     - other small issues.
> 
> v5: Increase maximum accepted duration of the UIP high pulse from 10 to 20ms,
>     in case there are some very slow chips out there.
> 
>     Note: this may cause problems with hpet_rtc_interrupt() if the CMOS
>     RTC stops working while the system is running and RTC update
>     interrupt / RTC alarm interrupt is enabled (which should be rare).
>     In this case, hpet_rtc_interrupt() is executed 64 times per second
>     and takes up to 20ms to complete - which may constantly occupy
>     one CPU. I am not sure if this is likely enough to implement
>     special handling of this case in hpet_rtc_interrupt().
> 

Because v4 has been applied, you'd have to send a series against
rtc-next.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
