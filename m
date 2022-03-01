Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3794C8F85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiCAP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiCAP7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:59:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0A52610A;
        Tue,  1 Mar 2022 07:59:00 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:58:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646150339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olozTMEtw7DSBnZAX6uhB+q7ita0MNNnbjrwWbcm+f8=;
        b=UxQgf+lRCB4ogKSWz2pAPxXQw430mRW+XsO2K+VFGAKKR+XkFVhxQjAaGkO2MtrcVQBtCg
        nybkLJFEJp47oWQVAaD4BbVzqbPsP3sSuXcDg5jLBztLySl1mRyNPHHJZoalkP+cmFeHlm
        0xV/rYmFzqkrPaPUgQ53HigQnSliIwRYqA5n/isuIFYlihzTbnIH3hZz4nz6z0SLULXjZB
        1t6WP4I9dFosdjcDaXohbFoIUGSM885WjbtI5wds5T8FIuXPAGw79LXJifK6TkPp4WdpFQ
        sdo+FaE6JsG6TtV0cNFWMbhUgw3QhYxgP52Z7JBh8Um5PDSQP2uyHaf74xrLxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646150339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olozTMEtw7DSBnZAX6uhB+q7ita0MNNnbjrwWbcm+f8=;
        b=TCvZiXR63kHpNETkgEEew+jXDBybQtKVrbGiJmemC69/yDYC6nEVmjZgxpljJJq4af63Ee
        OiB8yf6mKim25wAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: RFC: Intervals to schedule the worker for
 mix_interrupt_randomness().
Message-ID: <Yh5CwQgsdNefs2ZW@linutronix.de>
References: <Yh0QlQ8aqttjlnKt@linutronix.de>
 <CAHmME9rqhUcVD+rE5NEcvRu6G79aNkf8RZwXZnWtHNmTf3rfaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHmME9rqhUcVD+rE5NEcvRu6G79aNkf8RZwXZnWtHNmTf3rfaw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-28 19:58:05 [+0100], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi Jason,

> I'm actually trying quite hard not to change the details of entropy
> gathering for 5.18. There are lots of little arguments for why each
=E2=80=A6
> random.c. So I'd like to minimize changes to the semantics. Right now,
> those semantics are:
>=20
> A) crng_init=3D=3D0: pre_init_inject after 64 interrupts.
> B) crng_init!=3D0: mix_pool_bytes after 64 interrupts OR after 1 second
> has elapsed.

Yes. I double checked, that it was not a recent change during that
rework. So yes, lets keep it as is, I just wanted to point that out.
=E2=80=A6
> But all this brings me to what I'm really wondering when reading your
> email: do your observations matter? Are you observing a performance or
> reliability issue or something like that with those workqueues
> pending? Is this whole workqueue approach a mistake and we should
> revert it? Or is it still okay, but you were just idly wondering about
> that time limit? As you can tell, I'm mostly concerned with not
> breaking something by accident.

I noticed it because I backported the required patches (not everything
=66rom your queue, just the patches I needed to drop mine and have
everything working). During testing I noticed that the worker is
scheduled more often than I expected and I looked that it is scheduled
and not accidentally stops due to a backport that went wrong. And since
I got the condition wrong=E2=80=A6

But you are asking for performance. I run b.sh which does:
- unpack a kernel to /dev/shm
- build allmodconfig

and then invoked it with "perf stat -r 5 -a --table ./b.sh" to get some
numbers. I applied your complete queue on top of v5.17-rc6, and the
result was:

| Performance counter stats for 'system wide' (5 runs):
|
|     45.502.822,32 msec cpu-clock                 #   32,014 CPUs utilized=
            ( +-  0,05% )
|         9.479.371      context-switches          #  208,419 /sec         =
            ( +-  0,08% )
|           839.380      cpu-migrations            #   18,455 /sec         =
            ( +-  0,38% )
|       624.839.341      page-faults               #   13,738 K/sec        =
            ( +-  0,00% )
|105.297.794.633.131      cycles                    #    2,315 GHz         =
             ( +-  0,01% )
|77.238.191.940.405      stalled-cycles-frontend   #   73,37% frontend cycl=
es idle     ( +-  0,01% )
|56.724.314.805.475      stalled-cycles-backend    #   53,89% backend cycle=
s idle      ( +-  0,02% )
|69.889.082.499.264      instructions              #    0,66  insn per cycl=
e        =20
|                                                  #    1,10  stalled cycle=
s per insn  ( +-  0,00% )
|14.670.304.314.265      branches                  #  322,550 M/sec        =
            ( +-  0,00% )
|   561.326.606.978      branch-misses             #    3,83% of all branch=
es          ( +-  0,02% )
|
|          # Table of individual measurements:
|          1419,113 (-2,247) #
|          1422,552 (+1,192) #
|          1420,773 (-0,587) #
|          1422,362 (+1,002) #
|          1422,001 (+0,641) #
|
|          # Final result:
|          1421,360 +- 0,641 seconds time elapsed  ( +-  0,05% )

Checked a few commit earlier, before the workqueue rework started
  "random: rewrite header introductory comment":
| Performance counter stats for 'system wide' (5 runs):
|
|     45.508.013,44 msec cpu-clock                 #   32,034 CPUs utilized=
            ( +-  0,05% )
|         9.456.280      context-switches          #  208,017 /sec         =
            ( +-  0,11% )
|           837.148      cpu-migrations            #   18,415 /sec         =
            ( +-  0,30% )
|       624.851.749      page-faults               #   13,745 K/sec        =
            ( +-  0,00% )
|105.289.268.852.002      cycles                    #    2,316 GHz         =
             ( +-  0,01% )
|77.233.457.186.415      stalled-cycles-frontend   #   73,38% frontend cycl=
es idle     ( +-  0,02% )
|56.740.014.447.074      stalled-cycles-backend    #   53,91% backend cycle=
s idle      ( +-  0,02% )
|69.882.802.096.982      instructions              #    0,66  insn per cycle
|                                                  #    1,10  stalled cycle=
s per insn  ( +-  0,00% )
|14.670.395.601.080      branches                  #  322,716 M/sec        =
            ( +-  0,00% )
|   560.846.203.691      branch-misses             #    3,82% of all branch=
es          ( +-  0,01% )
|
|          # Table of individual measurements:
|          1418,288 (-2,347) #
|          1420,425 (-0,210) #
|          1420,633 (-0,001) #
|          1421,665 (+1,030) #
|          1422,162 (+1,528) #
|
|          # Final result:
|          1420,635 +- 0,669 seconds time elapsed  ( +-  0,05% )

and then on v5.17-rc6:
| Performance counter stats for 'system wide' (5 runs):
|
|     45.459.406,05 msec cpu-clock                 #   32,009 CPUs utilized=
            ( +-  0,04% )
|         9.460.380      context-switches          #  208,171 /sec         =
            ( +-  0,10% )
|           837.571      cpu-migrations            #   18,430 /sec         =
            ( +-  0,30% )
|       624.859.326      page-faults               #   13,750 K/sec        =
            ( +-  0,00% )
|105.247.262.852.106      cycles                    #    2,316 GHz         =
             ( +-  0,01% )
|77.185.603.119.285      stalled-cycles-frontend   #   73,34% frontend cycl=
es idle     ( +-  0,01% )
|56.688.996.383.094      stalled-cycles-backend    #   53,87% backend cycle=
s idle      ( +-  0,02% )
|69.883.077.705.602      instructions              #    0,66  insn per cycl=
e        =20
|                                                  #    1,10  stalled cycle=
s per insn  ( +-  0,00% )
|14.670.347.661.094      branches                  #  322,813 M/sec        =
            ( +-  0,00% )
|   561.066.414.554      branch-misses             #    3,82% of all branch=
es          ( +-  0,01% )
|
|          # Table of individual measurements:
|          1418,142 (-2,061) #
|          1420,187 (-0,016) #
|          1421,242 (+1,039) #
|          1420,800 (+0,597) #
|          1420,644 (+0,441) #
|
|          # Final result:
|          1420,203 +- 0,542 seconds time elapsed  ( +-  0,04% )

It does not appear that something stands out.

> Regards,
> Jason

Sebastian
