Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4574765F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhLOWdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:33:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhLOWdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:33:12 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639607590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wLjOR/truiw3spglNpgdzWcIOuNDZ50DiBaTN0NPKk=;
        b=g4lNVMEiBdsmsS70bHrFSbfGrJkpcZVhgKzg3oerl6zDK584XIigYe2hIUIFYGMc3vQ01F
        6ntpsZNerL5J8tnkXVqR0lyxOvxuA5D3g8mQw10s+eRb85IkuMS8u0vIS5rUMYsOkPmi48
        6P4IK629TgrDdnMrN8aCYGxphf8dTo7jAKu9z3j7fX05CVpP+U+1zeMz2x8WguqMVBFRnt
        aBBYxRbHMnhhX6TNhxJheqLdvGnlvG3jn5jQYjHumF5rJkQDiT6TR3i/vXn8BZwX4NQqQ2
        dmecYBpxEcmuasSPzX+fvj8MHfU9QUYeGUZiywYrpXp4LAB5f7sc3uDM6paUfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639607590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wLjOR/truiw3spglNpgdzWcIOuNDZ50DiBaTN0NPKk=;
        b=bU2SbwGd4BkXXwrvUdscO2en1CKdqahC4I10BIaDCJOLiL1HN85Tefc7JsdMm0oplfn+z3
        GrRG+qBrAZlKlXAw==
To:     John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Joel Daniels <jdaniels@sent.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent
 clock drift
In-Reply-To: <CALAqxLWe13ZghdWphzWZZsRGa+MeAH58syfem6ktDFHF0WG4Dg@mail.gmail.com>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
 <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
 <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
 <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
 <Ybpe/ND+MQq6tqoR@piout.net>
 <CALAqxLWe13ZghdWphzWZZsRGa+MeAH58syfem6ktDFHF0WG4Dg@mail.gmail.com>
Date:   Wed, 15 Dec 2021 23:33:10 +0100
Message-ID: <87pmpxlcrd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15 2021 at 14:02, John Stultz wrote:
> On Wed, Dec 15, 2021 at 1:32 PM Alexandre Belloni
>> I'd rather lean towards the timekeeping code doing that. The RTC
>
> Heh, touche'!  :)
>
>> subsystem doesn't know which RTC has to be used.
>
> Though the RTC layer *is* the one that tracks which RTC is used, via
> the logic in drivers/rtc/class.c, and the timekeeping core already has
> adjtimex for timekeeping corrections, so if we're correcting
> underlying RTCs it seems such tuning would best be done in the RTC
> layer.
>
> Though how the persistent_clock interface ties into such corrections
> would be a separate thing.

Might be the final trigger to get rid of that leftover from the last
millenium?

Thanks,

        tglx
