Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB430465721
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhLAUcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbhLAUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:31:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597DC061574;
        Wed,  1 Dec 2021 12:28:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638390504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mzoa4SjOrSQOzqlo1a2N+ZukxmXwU7KZxGAKMT8FbgE=;
        b=I2e/pBUR0fuTD9daRGJ1lf5K+XG9PmkRmKBiXw376G/5tn0eDiDy/mq9+lO1psD5mWw+kK
        aa+Gp10puanw6W6XXhTpcYj539K3nbUuF1g9xObrWblmvjGNvXAiYnLoHVcnRSa2L64g2y
        999jRiPhzhKCyECi6GgGcqmZil7PcypbAD4i3quOmut1kJ7d++29Rze6/Wc8Z5Hej7U1ls
        rsx6PKm90AlBMsRo4CBoL6psJo46EjI+5bTBqWKQrr3zme9mrW03ZjM1CYH4AVeh7tJ6ws
        Mym+0FAWnQN3UIAjXK9E9u8e4hrcxM8uSz/my8en+YherRLTd+6oMUp2nn6xzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638390504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mzoa4SjOrSQOzqlo1a2N+ZukxmXwU7KZxGAKMT8FbgE=;
        b=PkMOcLS5r/3YdUOnNBa06XuRyPSVCMxuqVrgi2C8dLqLbO/JevC7TctPKGbT3o6tFurB4o
        J8C5q9Fntwkrb4Ag==
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        paulmck@kernel.org, mtosatti <mtosatti@redhat.com>,
        frederic <frederic@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: Fill the gaps about entry/noinstr
 constraints
In-Reply-To: <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
References: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
 <875ys9dacq.ffs@tglx> <20211130091356.7336e277@gandalf.local.home>
 <878rx5b7i5.ffs@tglx> <YadU1aSE6/0yGWny@FVFF77S0Q05N>
 <87v9088a5q.ffs@tglx> <Yae9tbtZW5mjcBVt@FVFF77S0Q05N>
Date:   Wed, 01 Dec 2021 21:28:23 +0100
Message-ID: <87ee6w83yw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01 2021 at 18:23, Mark Rutland wrote:
> On Wed, Dec 01, 2021 at 07:14:41PM +0100, Thomas Gleixner wrote:
>> Mark,
>> 
>> On Wed, Dec 01 2021 at 10:56, Mark Rutland wrote:
>> > On Tue, Nov 30, 2021 at 11:31:30PM +0100, Thomas Gleixner wrote:
>> >> ---
>> >>  Documentation/core-api/entry.rst |  268 +++++++++++++++++++++++++++++++++++++++
>> >>  Documentation/core-api/index.rst |    8 +
>> >>  kernel/entry/common.c            |    1 
>> >
>> > I think the change to kernel/entry/common.c got included by accident?
>> 
>> That's what I get from doing such things 30 minutes before midnight...
>
> Ah, I had debugged it down to:
>
> nobikeshed void do_rst(struct tglx *tglx);
> {
> 	aargh_rst_enter(tglx);
>
> 	documentation_begin();
> 	invoke_editor(tglx);
>  	documentation_end();
> }
>
> ... where I think we forgot the:
>
> 	enter_from_sleep_mode(tglx);
> 	...
> 	exit_to_sleep_mode(tglx);

ROTFL. You made my day!
