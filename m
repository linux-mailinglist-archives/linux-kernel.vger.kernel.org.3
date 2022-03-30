Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0E4ECA39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349144AbiC3RE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349138AbiC3REY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:04:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF3C488B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:02:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648659757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4HjF8/EEYc7Qx+mvuP9ifg+mqgvsb+oEMyBioEmW6nc=;
        b=kO+RqmOXnqYmJEMczxoFdEqVkoniRtqA8/zZxb2AsPhyvmuiWefvxcKM7/A/qOV0vIMYFn
        4Bgy6Ma8LRO2u7znLvagAP7vRoZ7G9zHiAAtRtdKkqnKoj5EA3ZrROQ/fk7fASDRYT1lm0
        mzF93h5pKP1Zs1ED0Rp9vsv/31MB7qXAcUolgJ5Hiht4hMtQ4A8fmm5+4zVB9CzD1T0fK6
        EkD8xkbY3H8LLi3xG8YOm3UgsmEjFXkdMpD+rGdRR+nbSMABItPDBbL7MKOivtFqItIhX+
        xuPmMcs88F5H3INLyliV9PMl1gIEOKjEKrFZuTkawKzGDQg1P1oCwltFaeKYPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648659757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4HjF8/EEYc7Qx+mvuP9ifg+mqgvsb+oEMyBioEmW6nc=;
        b=g0Hr6sVaQs/x5J1LC4lK9pRbIX0IACYyRm4nQ8iNDDsCwHAEwSH+vRK3ITKBK3D+bmPGpQ
        wFmc0knzcyu3QpBQ==
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
In-Reply-To: <CANn89i+aCnUQj+UkRQBQ+mkL3xeFCmSkgeCYx+hmMNmko+EZ4Q@mail.gmail.com>
References: <20220311011715.2440601-1-eric.dumazet@gmail.com>
 <87ee2jo2je.ffs@tglx>
 <CANn89i+aCnUQj+UkRQBQ+mkL3xeFCmSkgeCYx+hmMNmko+EZ4Q@mail.gmail.com>
Date:   Wed, 30 Mar 2022 19:02:36 +0200
Message-ID: <87bkxnnzkj.ffs@tglx>
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

On Wed, Mar 30 2022 at 09:51, Eric Dumazet wrote:
> On Wed, Mar 30, 2022 at 8:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> which I hate with a passion because that allows *unpriviledged* user
>> space to inject systemwide IPIs every 10ms just to read these counters
>> which are providing not more than some estimate and are of no value for
>> the only sane use case of /proc/cpuinfo, i.e. #1 above.
>
> You do realize that before my patch, this is already happening ?
>
> My "optimization" simply replace an open loop of individual IPI with
> use of the broadcast IPI capability.
>
> Are you saying we should remove IPI broadcast and use loops
> of IPI, one cpu at a time ?

I rather have no IPIs at all...
