Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678C50C690
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiDWCck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDWCcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:32:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EEA22CA98;
        Fri, 22 Apr 2022 19:29:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x80so9644371pfc.1;
        Fri, 22 Apr 2022 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=viXXWgWXVo95+o/9NZZA7H7Wid1vy02UHZgXcnwGRG0=;
        b=gPj64rNyAU5X7R2GnB5ivbb2GkOtZwpkeSL7PXb1I4pG9+VwTbZebtgmrNmy2h9xyZ
         Do+gaWYFMCm7y1fKMksrcse9C+iAW/8dF7Y3W9cUP0T6MkW4hRZELHDvqfCVk2MiWyYs
         x7UVyWVSC2kVmWuLTsd22vCDGi+rT0cKczrLmptm3Uf6P1i4i3a9NUoDuF0Qh4xAWkVC
         hNHnlAwDVqqzW9IdKnpRxa59naX3DoWYZXvOcb3S4WnvS2joavGB4772Y7uwKNyYygtv
         kyVrUNQ/jG3FdBhNYsgaDmoxcQXYIjeluqBuZsoqaOKR9B29Cmd13gp0t7lpRYPblAqA
         ROyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=viXXWgWXVo95+o/9NZZA7H7Wid1vy02UHZgXcnwGRG0=;
        b=h0FoIZR0G5o7olkluQm834109/qeSDgCzX3DoU4d5hBMQpYWEIFxNVhXkxMnjjM8aH
         jZh2+8BWzL2bQwL29wgYfMmP5X1cAcmEopp7y0pMmf99e+m8YlzVHG6QQPvXV/Yw4C5U
         dQIcQkY0mAwpbePEV9Fcmv6/vCSBPAC68ErxcOf+jNmBT5tv7nOq47giG3xElma6UiuR
         A/Y9F3PbIKzFe6Rk0y/Dgz3/ZlzuHPBTPBX6wwiRJyqVq/enatAbPlRrAm5/AkpBhL4z
         +AF2bZ7zMLGn9KmvjPcpAmMhOfJqNrswTJhNfZ167amHQsINITnn1YYvvmwPFqHVcrxJ
         RW+g==
X-Gm-Message-State: AOAM531gC4vMXyBslc3EPk9PVFh36xDscyl3PuLLJAF4Ke5jsGOXFU8n
        P73DJeaPjFBtczmsGvjYxuQ=
X-Google-Smtp-Source: ABdhPJztIe86JJ+KtDnEBTYYIG/4bg02fLjWPTWYqhxTWgo34Soe/HW+co69m4YhCUGpvIxt+6fyEQ==
X-Received: by 2002:a05:6a00:2444:b0:4fd:db81:cbdd with SMTP id d4-20020a056a00244400b004fddb81cbddmr7857701pfj.32.1650680976716;
        Fri, 22 Apr 2022 19:29:36 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id g9-20020a056a00078900b0050a4bae652fsm3701750pfu.131.2022.04.22.19.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 19:29:36 -0700 (PDT)
Date:   Sat, 23 Apr 2022 12:29:30 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re:
To:     Michael Ellerman <mpe@ellerman.id.au>, paulmck@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     =?iso-8859-1?q?Daniel=0A?= Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rcu <rcu@vger.kernel.org>,
        =?iso-8859-1?q?Viresh=0A?= Kumar <viresh.kumar@linaro.org>
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
        <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
        <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
        <87pmls6nt7.fsf@mpe.ellerman.id.au> <87k0bz7i1s.fsf@mpe.ellerman.id.au>
        <1649818529.j46672mh2p.astroid@bobo.none> <87fsm55d3f.ffs@tglx>
In-Reply-To: <87fsm55d3f.ffs@tglx>
MIME-Version: 1.0
Message-Id: <1650680264.0sj0tnkzx7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Thomas Gleixner's message of April 23, 2022 1:53 am:
> On Wed, Apr 13 2022 at 15:11, Nicholas Piggin wrote:
>> So we traced the problem down to possibly a misunderstanding between=20
>> decrementer clock event device and core code.
>>
>> The decrementer is only oneshot*ish*. It actually needs to either be=20
>> reprogrammed or shut down otherwise it just continues to cause=20
>> interrupts.
>=20
> I always thought that PPC had sane timers. That's really disillusioning.

My comment was probably a bit misleading explanation of the whole
situation. This weirdness is actually in software in the powerpc
clock event driver due to a recent change I made assuming the clock=20
event goes to oneshot-stopped.

The hardware is relatively sane I think, global synchronized constant
rate high frequency clock distributed to the CPUs so reads don't
go off-core. And per-CPU "decrementer" event interrupt at the same
frequency as the clock -- program it to a +ve value and it decrements
until zero then creates basically a level triggered interrupt.

Before my change, the decrementer interrupt would always clear the
interrupt at entry. The event_handler usually programs another
timer in so I tried to avoid that first clear counting on the
oneshot_stopped callback to clear the interrupt if there was no
other timer.

>> Before commit 35de589cb879, it was sort of two-shot. The initial=20
>> interrupt at the programmed time would set its internal next_tb variable=
=20
>> to ~0 and call the ->event_handler(). If that did not set_next_event or=20
>> stop the timer, the interrupt will fire again immediately, notice=20
>> next_tb is ~0, and only then stop the decrementer interrupt.
>>
>> So that was already kind of ugly, this patch just turned it into a hang.
>>
>> The problem happens when the tick is stopped with an event still=20
>> pending, then tick_nohz_handler() is called, but it bails out because=20
>> tick_stopped =3D=3D 1 so the device never gets programmed again, and so =
it=20
>> keeps firing.
>>
>> How to fix it? Before commit a7cba02deced, powerpc's decrementer was=20
>> really oneshot, but we would like to avoid doing that because it require=
s=20
>> additional programming of the hardware on each timer interrupt. We have=20
>> the ONESHOT_STOPPED state which seems to be just about what we want.
>>
>> Did the ONESHOT_STOPPED patch just miss this case, or is there a reason=20
>> we don't stop it here? This patch seems to fix the hang (not heavily
>> tested though).
>=20
> This was definitely overlooked, but it's arguable it is is not required
> for real oneshot clockevent devices. This should only handle the case
> where the interrupt was already pending.
>=20
> The ONESHOT_STOPPED state was introduced to handle the case where the
> last timer gets canceled, so the already programmed event does not fire.
>=20
> It was not necessarily meant to "fix" clockevent devices which are
> pretending to be ONESHOT, but keep firing over and over.
>=20
> That, said. I'm fine with the change along with a big fat comment why
> this is required.

Thanks for taking a look and confirming. I just sent a patch with a
comment and what looks like another missed case. Hopefully it's okay.

Thanks,
Nick
