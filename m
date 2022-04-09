Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993754FAAC7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbiDIUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiDIUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:34:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391745AE6;
        Sat,  9 Apr 2022 13:32:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649536342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrPf0+S1knIjo0YCldm5OkHv9rC/AGfoKQ6vSzGlETw=;
        b=SJcP4aci0JFXn44WOamvT3qz25BCgp49re/dmYwuVNH//hqCtFxOWxfSgTOyn3BCj8O8/+
        PnHdbSaCIBvZun0SpRSjOdmLG7H62YBMDqIaHnUY2vPJAoONhSDmfkpd/hl4pywhGUXrCh
        Uny8yvRqhuh+uIRWpAmpIyCT/ZimFDhg0i/0xo4Wx1XWkf2RflCbAmBoibfpkeJsQXzWT2
        atsWHIrxosf5N7zmj47M2PN2UzjsYdk5eAxJnm3Pp0fEXXG4XpFwS6zJ01w2SUGtH4MPIV
        msYbqGi7HXPqx0i2TkNOlJW3LB/pW42PNikWaLouiX5I0+Nmsd8ZeeoIP0PDTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649536342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrPf0+S1knIjo0YCldm5OkHv9rC/AGfoKQ6vSzGlETw=;
        b=qF7MC8UIhIzVZHBqEPSqQQ76ATc4GAU2jdxwkwXdXXdk6rzw3M7++6m2AaBegOeVruoCrd
        Z0x6FkayFMZuvDDg==
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [PATCH 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220409081300.4762-2-kurt@linutronix.de>
References: <20220409081300.4762-1-kurt@linutronix.de>
 <20220409081300.4762-2-kurt@linutronix.de>
Date:   Sat, 09 Apr 2022 22:32:21 +0200
Message-ID: <874k32huay.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09 2022 at 10:12, Kurt Kanzenbach wrote:
> Introduce fast/NMI safe accessor to clock tai for tracing. The Linux kernel
> tracing infrastructure has support for using different clocks to generate
> timestamps for trace events. Especially in TSN networks it's useful to have TAI
> as trace clock, because the application scheduling is done in accordance to the
> network time, which is based on TAI. With a tai trace_clock in place, it becomes
> very convenient to correlate network activity with Linux kernel application
> traces.
>
> Use the same implementation as ktime_get_boot_fast_ns() does by reading the
> monotonic time and adding the TAI offset. The same limitations as for the fast
> boot implementation apply. The TAI offset may change at run time e.g., by
> setting the time or using adjtimex() with an offset. However, these kind of
> offset changes are rare events. Nevertheless, the user has to be aware and deal
> with it in post processing.
>
> An alternative approach would be to use the same implementation as
> ktime_get_real_fast_ns() does. However, this requires to add an additional u64
> member to the tk_read_base struct. This struct together with a seqcount is
> designed to fit into a single cache line on 64 bit architectures. Adding a new
> member would violate this constraint.
>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Nice changelog!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
