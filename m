Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0981A51F964
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiEIKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiEIKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:11:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F32230BE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:07:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652090503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gt+cvbCbyLotyPdsbicw1w5GlF7vpXCKgcu2KrPitAs=;
        b=0yW2QJjKbh6RIXg/TYy6onbYbjrDa7jADEB++j1Q6Dp4zsctEuJP9tNdyO4ObDLUMraguX
        J5+Nh0sjYRx6LBQH/tgPqL5/ntUHPaY3ytX+f2ejusaTjZZzbNuZ1w7rhlv2MsbaDgTgaG
        88n7J5r8j8mgWkr+ZGY29irknJE10DxF5HggrYm0gJcAS+/fBqyHDPf6NbB5/3BFi+cdEv
        dcOkd/HtVMyoOfHSxRCs+C2jYj5SNZyhT92gE6KfnZ8lXlehJx0OyQt5m5FI+GMbHu+lm0
        RquHkM2H/ZPiMn6LofLwlGNge+ywzO3h6nBzDHStzqPMX8aSk3xSQD7Dyw9O0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652090503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gt+cvbCbyLotyPdsbicw1w5GlF7vpXCKgcu2KrPitAs=;
        b=Mf4/N4Q2KwfTw7g6yTvX49DKOcIQGYdAZdhWwcBEGASiC9CJIgmdsnIkcW7JacLpzhBKX9
        n6XD3pyvwBDUNZAg==
To:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rui.zhang@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH] x86/tsc: Add option to force HW timer based recalibration
In-Reply-To: <20220509073003.GB40730@shbuild999.sh.intel.com>
References: <20220508144733.91343-1-feng.tang@intel.com>
 <20220509045839.GA40730@shbuild999.sh.intel.com>
 <20220509071652.GE76023@worktop.programming.kicks-ass.net>
 <20220509073003.GB40730@shbuild999.sh.intel.com>
Date:   Mon, 09 May 2022 12:01:42 +0200
Message-ID: <87h75zrpmh.ffs@tglx>
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

Feng,

On Mon, May 09 2022 at 15:30, Feng Tang wrote:
> On Mon, May 09, 2022 at 09:16:52AM +0200, Peter Zijlstra wrote:
>> On Mon, May 09, 2022 at 12:58:39PM +0800, Feng Tang wrote:
>> > And there is still very few corner case that the freq info is not
>> > accurate enough with small deviation from the actual value, like on
>> > a product with early buggy version of firmware or on some
>> > pre-production hardware.
>> >
>> > Add an option 'recalibrate' for 'tsc' kernel parameter to force the
>> > tsc freq recalibration with HPET/PM_TIMER, and warn if the deviation
>> > from previous value is more than about 500 PPM.
>> > 
>> > Signed-off-by: Feng Tang <feng.tang@intel.com>
>> 
>> Why isn't 'tsc_early_khz=' not working for you? Afaict that will
>> override calibrate_tsc() when provided and as such can be used on these
>> early platforms for provide the right value until such time that the
>> firmware is fixed.
>
> For the early platforms, the problem we met is we don't know what
> is the 'correct' tsc-freq, and the value from MSR/CUPID could be wrong. 
>
> And there was some generation, that after enabling some feature, each
> instance of HW will have slightly different frequency, so there is
> no central "one for all" value to set for 'tsc_early_khz'.
>
> This option is more like a way to double-check the correctness of
> tsc-freq got from MSR/CPUID(0x15).

If at all it's a workaround for the inability and ignorance of firmware
people. The crystal frequency and the TSC/crystal ratio _are_ known to
the system designer and firmware people. It's really not asked too much
to put the correct values into CPUID(0x15) and have proper quality
control to ensure the correctness.

The whole argument about early firmware and pre-production hardware is
bogus. It's 2022 and we are debating this problem for more than a decade
now and still hardware and firmware people think they can do what they
want and it all can be "fixed" in software. It's not rocket science to
get this straight.

Aside of that HPET has become unrealiable and PM timer is not guaranteed
to be there either. So we really do not need a mechanism to enforce
recalibration against something which is not guaranteed to provide
sensible information.

Thanks,

        tglx
