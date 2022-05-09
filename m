Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236F5201BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiEIQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbiEIQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:00:01 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4F1B0932;
        Mon,  9 May 2022 08:56:06 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f83983782fso149857317b3.6;
        Mon, 09 May 2022 08:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4TLCMYI42941hu3ardgVNqgp3gOumPVU61RkHYS5Zo=;
        b=sn3Mhl0wMW621CEwMwN8w8qSd4SHwc4oGozgpTKr2Ek902IBSZnoI9oJvPKW5py9bd
         hsY4Kknw6e48KQJ25vFu+DC2k+x4Q4fd80IlqOh5P1nqi+JuSsxD0vNh+6OCMuMCaeOG
         ToAgVN9cUTKr4K57AQXhYYFkh/XPZ76vHRk2ibCzhim2zphWIWtmyx1VL2wjdEoC+f9Q
         e6Gx4/driHtWCwgMpIObECLkCaHwdNIUL1g1/K17wAfLC5fXwrmLDJhEiDiqyzuRmTnN
         reTsI1qN31yxigaNwFptvTebEJOoymflLbRwm5bGcKEDmM2rMgV5JGwESvEXLja7cvCa
         xf4Q==
X-Gm-Message-State: AOAM531iZl/i/MW795G7HEtdfbhxUq5VfKJfY0UCBT9Fqvq+4vzKHvVQ
        AEMNm6X5+ei13zsJ6vGPRGyVB+Eygn90mTTu+Jk=
X-Google-Smtp-Source: ABdhPJykTRc8ByXs8MiW26QtWaD2ITyXljqBAAa8dnV15VuG3RPnVvquFy7o4B7o2Wjt8qMW54k8wmdXh/2Aml2TzXg=
X-Received: by 2002:a0d:e2ca:0:b0:2f6:6586:df36 with SMTP id
 l193-20020a0de2ca000000b002f66586df36mr15212846ywe.433.1652111765263; Mon, 09
 May 2022 08:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <YmlMGx6+uigkGiZ0@zx2c4.com> <Ym3ZM1P+uYYABtRm@mit.edu>
 <Ym5sICj5iBMn2w/E@zx2c4.com> <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
In-Reply-To: <CAMvzKsiA52Si=PzOJXYwGSA1WUz-1S0A8cpgRJWDzpMkfFbX+Q@mail.gmail.com>
From:   Yevgeniy Dodis <dodis@cs.nyu.edu>
Date:   Mon, 9 May 2022 11:55:53 -0400
Message-ID: <CAMvzKsiMY_+8HZqeFqD3tR65a3-JB0LG=+0jBBy1zF4GanrsGA@mail.gmail.com>
Subject: Re: is "premature next" a real world rng concern, or just an academic exercise?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso <tytso@mit.edu>, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Noah Stephens-Dawidowitz <noahsd@gmail.com>,
        Stefano Tessaro <tessaro@cs.washington.edu>,
        torvalds@linux-foundation.org, "D. J. Bernstein" <djb@cr.yp.to>,
        jeanphilippe.aumasson@gmail.com, jann@thejh.net,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        Peter Schwabe <peter@cryptojedi.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resending in plain text... (hope got it right)

On Mon, May 9, 2022 at 11:15 AM Yevgeniy Dodis <dodis@cs.nyu.edu> wrote:
>
> Hi Jason and all.
>
> Thank you for starting this fascinating discussion. I generally agree with everything Jason said. In particular, I am not
> 100% convinced that the extra cost of the premature next defense is justified.(Although Windows and MacOS are adamant it is
> worth it :).)
>
> But let me give some meta points to at least convince you this is not as obvious as Jason makes it sound.
>
> 1) Attacking RNGs in any model is really hard. Heck, everybody knew for years that /dev/random is a mess
> (and we published it formally in 2013, although this was folklore knowledge),  but in all these years nobody
> (even Nadya's group :)) managed to find a practical attack. So just because the attack seems far-fetched, I do not think we should
> lower our standards and do ugly stuff. Otherwise, just leave /dev/random the way it was before Jason started his awesome work.
>
> 2) As Jason says, there are two distinct attack vectors needed to make the premature next attack.
> A) compromising the state
> B) (nearly) continuously observing RNG outputs
>
> I agree with Jason's point that finding places where
> -- A)+B) is possible, but
> --- A)+A) is not possible,
> is tricky. Although Nadya kind of indicated a place like that. VM1 and VM2 start with the same RNG state (for whatever
> reason). VM1 is insecure, so can leak the state via A). VM2 is more secure, but obviously allows for B) through system
> interface. This does not seem so hypothetical for me, especially in light of my mega-point 1) above -- almost any real-world
> RNG attack is hard.
>
> But I want to look at it from a different angle here. Let's ask if RNGs should be secure against A) or B) individually.
>
> I think everybody agrees protection from B) is a must. This is the most basic definition of RNG! So let's just take itas
> an axiom.
>
> Protection against A) is trickier. But my read of Jason's email is that all his criticism comes exactly from this point.
> If your system allows for state compromise, you have bigger problems than the premature next, etc. But let's ask ourselves
> the question. Are we ready to design RNGs without recovery from state compromise? I believe nobody on this list would
> be comfortable saying "yes". Because this would mean we don;t need to accumulate entropy beyond system start-up.
> Once we reach the point of good initial state, and state compromise is not an issue, just use straight ChaCha or whatever other
> stream cipher.
>
> The point is, despite all arguments Jason puts, we all would feel extremely uncomfortable/uneasy to let continuous
> entropy accumulation go, right?
>
> This means we all hopefully agree that we need protection against A) and B) individually.
>
> 3) Now comes the question. If we want to design a sound RNG using tools of modern cryptography, and we allow
> the attacker an individual capability to enforce A) or B) individually, are we comfortable with the design where we:
> * offer protection against A)
> * offer protection against B)
> * do NOT offer protection against A)+B), because we think it's too expensive given A)+B) is so rare?
>
> I do not have a convincing answer to this question, but it is at least not obvious to me. On a good note, one worry
> we might have is how to even have a definition protecting A), protecting B), but not protecting A)+B).
> Fortunately, our papers resolve this question (although there are still theoretical annoyances which I do not
> want to get into in this email). So, at least from this perspective, we are good. We have a definition with
> exactly these (suboptimal) properties.
>
> Anyway, these are my 2c.
> Thoughts?
>
> Yevgeniy
>
> On Sun, May 1, 2022 at 7:17 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>
>> Hi Ted,
>>
>> That's a useful analysis; thanks for that.
>>
>> On Sat, Apr 30, 2022 at 05:49:55PM -0700, tytso wrote:
>> > On Wed, Apr 27, 2022 at 03:58:51PM +0200, Jason A. Donenfeld wrote:
>> > >
>> > > 3) More broadly speaking, what kernel infoleak is actually acceptable to
>> > >    the degree that anybody would feel okay in the first place about the
>> > >    system continuing to run after it's been compromised?
>> >
>> > A one-time kernel infoleak where this might seem most likely is one
>> > where memory is read while the system is suspended/hibernated, or if
>> > you have a VM which is frozen and then replicated.  A related version
>> > is one where a VM is getting migrated from one host to another, and
>> > the attacker is able to grab the system memory from the source "host"
>> > after the VM is migrated to the destination "host".
>>
>> You've identified ~two places where compromises happen, but it's not an
>> attack that can just be repeated simply by re-running `./sploit > state`.
>>
>> 1) Virtual machines:
>>
>> It seems like after a VM state compromise during migration, or during
>> snapshotting, the name of the game is getting entropy into the RNG in a
>> usable way _as soon as possible_, and not delaying that. This is
>> Nadia's point. There's some inherent tension between waiting some amount
>> of time to use all available entropy -- the premature next requirement
>> -- and using everything you can as fast as you can because your output
>> stream is compromised/duplicated and that's very bad and should be
>> mitigated ASAP at any expense.
>>
>> [I'm also CC'ing Tom Risenpart, who's been following this thread, as he
>>  did some work regarding VM snapshots and compromise, and what RNG
>>  recovery in that context looks like, and arrived at pretty similar
>>  points.]
>>
>> You mentioned virtio-rng as a mitigation for this. That works, but only
>> if the data read from it are actually used rather quickly. So probably
>> /waiting/ to use that is suboptimal.
>>
>> One of the things added for 5.18 is this new "vmgenid" driver, which
>> responds to fork/snapshot notifications from hypervisors, so that VMs
>> can do something _immediately_ upon resumption/migration/etc. That's
>> probably the best general solution to that problem.
>>
>> Though vmgenid is supported by QEMU, VMware, Hyper-V, and hopefully soon
>> Firecracker, there'll still be people that don't have it for one reason
>> or another (and it has to be enabled manually in QEMU with `-device
>> vmgenid,guid=auto`; perhaps I should send a patch adding that to some
>> default machine types). Maybe that's their problem, but I take as your
>> point that we can still try to be less bad than otherwise by using more
>> entropy more often, and not delaying as the premature next model
>> requirements would have us do.
>>
>> 2) Suspend / hibernation:
>>
>> This is kind of the same situation as virtual machines, but the
>> particulars are a little bit different:
>>
>>   - There's no hypervisor giving us new seed material on resumption like
>>     we have with VM snapshots and vmgenid; but
>>
>>   - We also always know when it happens, because it's not transparent to
>>     the OS, so at least we can attempt to do something immediately like
>>     we do with the vmgenid driver.
>>
>> Fortunately, most systems that are doing suspend or hibernation these
>> days also have a RDRAND-like thing. It seems like it'd be a good idea
>> for me to add a PM notifier, mix into the pool both
>> ktime_get_boottime_ns() and ktime_get(), in addition to whatever type
>> info I get from the notifier block (suspend vs hibernate vs whatever
>> else) to account for the amount of time in the sleeping state, and then
>> immediately reseed the crng, which will pull in a bunch of
>> RDSEED/RDRAND/RDTSC values. This way on resumption, the system is always
>> in a good place.
>>
>> I did this years ago in WireGuard -- clearing key material before
>> suspend -- and there are some details around autosuspend (see
>> wg_pm_notification() in drivers/net/wireguard/device.c), but it's not
>> that hard to get right, so I'll give it a stab and send a patch.
>>
>> > But if the attacker can actually obtain internal state from one
>> > reconstituted VM, and use that to attack another reconstituted VM, and
>> > the attacker also knows what the nonce or time seed that was used so
>> > that different reconstituted VMs will have unique CRNG streams, this
>> > might be a place where the "premature next" attack might come into
>> > play.
>>
>> This is the place where it matters, I guess. It's also where the
>> tradeoff's from Nadia's argument come into play. System state gets
>> compromised during VM migration / hibernation. It comes back online and
>> starts doling out compromised random numbers. Worst case scenario is
>> there's no RDRAND or vmgenid or virtio-rng, and we've just got the good
>> old interrupt handler mangling cycle counters. Choices: A) recover from
>> the compromise /slowly/ in order to mitigate premature next, or B)
>> recover from the compromise /quickly/ in order to prevent things like
>> nonce reuse.
>>
>> What is more likely? That an attacker who compromised this state at one
>> point in time doesn't have the means to do it again elsewhere in the
>> pipeline, will use a high bandwidth /dev/urandom output stream to mount
>> a premature next attack, and is going after a high value target that
>> inexplicably doesn't have RDRAND/vmgenid/virtio-rng enabled? Or that
>> Nadia's group (or that large building in Utah) will get an Internet tap
>> and simply start looking for repeated nonces to break?
>>
>> Jason
