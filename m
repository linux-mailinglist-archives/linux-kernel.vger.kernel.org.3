Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B34ECB71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349731AbiC3SMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbiC3SL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:11:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCD065D4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:10:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648663809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qtJaCzY+T+xK1csO4T4TUHSrom6bLibTb3dD3ufnUw=;
        b=B6UYWLbkHH/qmS5koAOy0DMfPanC65YcTJfZ8pxQx5iIfu87+x8XiMkl5BnSywa4hNB8VM
        z3LvSvs3xATRL4pK2ntUmEZ57yiVmneBqkrSfMZ4OGhtUEq1U3Tu9LhZvG/HxBCnMUuR0k
        MigIoxigmVx505l+TSgdstfSGCayEIAQxcrMAT49FkNwZcnBG93WMr+fTEpKA1tdchuQMN
        Ba5OWXBl0wmTkC8E0906aYAI7DoNyk0LYzT9SjqheOKQMxUcCiX7cw31BbQPKHwNxFZx48
        tNWRpmPPcQMQpFIk8x1ib5agowccC+Pu2RX1ovYCzrHlTdJljz1Ns8JI7pWWBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648663809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qtJaCzY+T+xK1csO4T4TUHSrom6bLibTb3dD3ufnUw=;
        b=ZBN8dEfbGh4d9nsLWhBoBCC2yjE0XLRyH9szIO4/ArIX8fXgxAIWaTmDvW/7TCes2H3xr/
        6TOoCBo5OwI/N4DQ==
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/cpu: use smp_call_function_many() in
 arch_freq_prepare_all()
In-Reply-To: <CANn89iKnyG=3MbKzYKsE92p8Qu0QHie_UmQUxJx9YmHGUhKrQA@mail.gmail.com>
References: <20220311011715.2440601-1-eric.dumazet@gmail.com>
 <87ee2jo2je.ffs@tglx>
 <CANn89i+aCnUQj+UkRQBQ+mkL3xeFCmSkgeCYx+hmMNmko+EZ4Q@mail.gmail.com>
 <87bkxnnzkj.ffs@tglx>
 <CANn89iKnyG=3MbKzYKsE92p8Qu0QHie_UmQUxJx9YmHGUhKrQA@mail.gmail.com>
Date:   Wed, 30 Mar 2022 20:10:08 +0200
Message-ID: <878rsrnwfz.ffs@tglx>
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

On Wed, Mar 30 2022 at 10:05, Eric Dumazet wrote:
> On Wed, Mar 30, 2022 at 10:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Wed, Mar 30 2022 at 09:51, Eric Dumazet wrote:
>> > On Wed, Mar 30, 2022 at 8:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> which I hate with a passion because that allows *unpriviledged* user
>> >> space to inject systemwide IPIs every 10ms just to read these counters
>> >> which are providing not more than some estimate and are of no value for
>> >> the only sane use case of /proc/cpuinfo, i.e. #1 above.
>> >
>> > You do realize that before my patch, this is already happening ?
>> >
>> > My "optimization" simply replace an open loop of individual IPI with
>> > use of the broadcast IPI capability.
>> >
>> > Are you saying we should remove IPI broadcast and use loops
>> > of IPI, one cpu at a time ?
>>
>> I rather have no IPIs at all...
>
> Can you send an actual patch, with a changelog then ?

I can polish up the patch I sent, split it up and add changelogs. Sure.

Thanks,

        tglx
