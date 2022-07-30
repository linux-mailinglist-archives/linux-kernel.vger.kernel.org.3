Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1854D585C55
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiG3Viq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiG3Vio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:38:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D665E0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 14:38:40 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l188so9271628oia.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Xdhvm8eoxX7grhuuFM3KV4xBso8uFJNDgg1YEG9heJE=;
        b=LfUKbRfyShP6qvVKYq4O8RuV5HzIMOODqi22vj4x0/WStZYM8jHZsASt2zLfs6Ne0Z
         RLpHnNK8f8AJfBH60M6bziRV3lYIV2atepwoes5GYQ0viKygkPA+2RaDVrTUMkt9BLFK
         RR1iHnIKf5JrFeQbBg47oEjG3aNbVTyrizqGamcA0b+788zZWROIaLHJvMCcSMM7hKFD
         IGhAqaOC9af58W6AtvoU0lRXoGkLDFvwp2Oaqj7cwAtZ4Px22icm0w6Udix1NsAIIS8q
         9+aMmwTtiiqihl2NO7oLmxtp09g16nyDJD64ycZQmXtT82BlKzQwpJce43e7GQ2Ht1mA
         uY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Xdhvm8eoxX7grhuuFM3KV4xBso8uFJNDgg1YEG9heJE=;
        b=gy6N0ZUmjrKeVmvTacqYgOnK9PQR5Aii4HIVNVQg+U6IFk8xiOmUpf9ge4OPFBlX5c
         2bTJyZoWqEoCKr1DibqqbfHMUyijNOCr2XxG0mZapAuDDQ+LeHLblbt6f2RoOD0rIjZH
         nhXwb1EPOS3zlTurbFGnis8KeeYS0zM248kNqlYl36wova0CFN3pajQNGPu6dJQcPfVC
         L0JJ6UeK5oSwMvJnXELPDZJQsmlIL+DafFpOLOGxZOnaT+dYf6UO0hr3/ltpyBmusBPN
         r2C4vQTE4iFmTk+RGEp9FaVmWhRsSIv1l+woKpv0ibn2qEmsU5efM6H4AmOquxc7HxS4
         vpkA==
X-Gm-Message-State: AJIora8lo/pjbbTkvwetdTpEKxiFxpyV7RodOxyjL5NfPvTabwTVgP8Z
        KJvFkPOQ94bi9PHyk4omPao=
X-Google-Smtp-Source: AGRyM1s2GfAEsz2vkcTj8XfjilrYJ/E0QXGKhCToRFsM55nJpT/ufYldCRXmAHKNGig+AUW11CuVdQ==
X-Received: by 2002:a05:6808:1442:b0:33b:29f0:b89d with SMTP id x2-20020a056808144200b0033b29f0b89dmr3589089oiv.65.1659217120031;
        Sat, 30 Jul 2022 14:38:40 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id e19-20020a544f13000000b0033b2f70ccc4sm772358oiy.16.2022.07.30.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 14:38:39 -0700 (PDT)
Date:   Sat, 30 Jul 2022 14:38:38 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: Linux 5.19-rc8
Message-ID: <YuWk3titnOiQACzC@yury-laptop>
References: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
 <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
 <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
 <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
 <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
 <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
 <YuDsmmAnOsgNDuWQ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuDsmmAnOsgNDuWQ@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:43:22AM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 26, 2022 at 06:33:55PM -0700, Yury Norov wrote:
> > On Tue, Jul 26, 2022 at 5:15 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Jul 26, 2022 at 01:20:23PM -0700, Linus Torvalds wrote:
> > > > On Tue, Jul 26, 2022 at 12:44 PM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > Overall, I would say it's pretty similar (some generic perform
> > > > > marginally better, some native perform marginally better) with the
> > > > > exception of find_first_bit() being much better with the generic
> > > > > implementation, but find_next_zero_bit() being noticably worse.
> > > >
> > > > The generic _find_first_bit() code is actually sane and simple. It
> > > > loops over words until it finds a non-zero one, and then does trivial
> > > > calculations on that last word.
> > > >
> > > > That explains why the generic code does so much better than your byte-wise asm.
> > > >
> > > > In contrast, the generic _find_next_bit() I find almost offensively
> > > > silly - which in turn explains why your byte-wide asm does better.
> > > >
> > > > I think the generic _find_next_bit() should actually do what the m68k
> > > > find_next_bit code does: handle the first special word itself, and
> > > > then just call find_first_bit() on the rest of it.
> > > >
> > > > And it should *not* try to handle the dynamic "bswap and/or bit sense
> > > > invert" thing at all. That should be just four different (trivial)
> > > > cases for the first word.
> > >
> > > Here's the results for the native version converted to use word loads:
> > >
> > > [   37.319937]
> > >                Start testing find_bit() with random-filled bitmap
> > > [   37.330289] find_next_bit:                 2222703 ns, 163781 iterations
> > > [   37.339186] find_next_zero_bit:            2154375 ns, 163900 iterations
> > > [   37.348118] find_last_bit:                 2208104 ns, 163780 iterations
> > > [   37.372564] find_first_bit:               17722203 ns,  16370 iterations
> > > [   37.737415] find_first_and_bit:          358135191 ns,  32453 iterations
> > > [   37.745420] find_next_and_bit:             1280537 ns,  73644 iterations
> > > [   37.752143]
> > >                Start testing find_bit() with sparse bitmap
> > > [   37.759032] find_next_bit:                   41256 ns,    655 iterations
> > > [   37.769905] find_next_zero_bit:            4148410 ns, 327026 iterations
> > > [   37.776675] find_last_bit:                   48742 ns,    655 iterations
> > > [   37.790961] find_first_bit:                7562371 ns,    655 iterations
> > > [   37.797743] find_first_and_bit:              47366 ns,      1 iterations
> > > [   37.804527] find_next_and_bit:               59924 ns,      1 iterations
> > >
> > > which is generally faster than the generic version, with the exception
> > > of the sparse find_first_bit (generic was:
> > > [   25.657304] find_first_bit:                7328573 ns,    656 iterations)
> > >
> > > find_next_{,zero_}bit() in the sparse case are quite a bit faster than
> > > the generic code.
> > 
> > Look at find_{first,next}_and_bit results. Those two have no arch version
> > and in both cases use generic code. In theory they should be equally fast
> > before and after, but your testing says that generic case is slower even
> > for them, and the difference is comparable with real arch functions numbers.
> > It makes me feel like:
> >  - there's something unrelated, like governor/throttling that affect results;
> >  - the numbers are identical, taking the dispersion into account.
> > 
> > If the difference really concerns you, I'd suggest running the test
> > several times
> > to measure confidence intervals.
> 
> Given that the benchmark is run against random bitmaps and with
> interrupts enabled, there is going to be noise in the results.
> 
> Here's the second run:
> 
> [26234.429389]
>                Start testing find_bit() with random-filled bitmap
> [26234.439722] find_next_bit:                 2206687 ns, 164277 iterations
> [26234.448664] find_next_zero_bit:            2188368 ns, 163404 iterations
> [26234.457612] find_last_bit:                 2223742 ns, 164278 iterations
> [26234.482056] find_first_bit:               17720726 ns,  16384 iterations
> [26234.859374] find_first_and_bit:          370602019 ns,  32877 iterations
> [26234.867379] find_next_and_bit:             1280651 ns,  74091 iterations
> [26234.874107]
>                Start testing find_bit() with sparse bitmap
> [26234.881014] find_next_bit:                   46142 ns,    656 iterations
> [26234.891900] find_next_zero_bit:            4158987 ns, 327025 iterations
> [26234.898672] find_last_bit:                   49727 ns,    656 iterations
> [26234.912504] find_first_bit:                7107862 ns,    656 iterations
> [26234.919290] find_first_and_bit:              52092 ns,      1 iterations
> [26234.926076] find_next_and_bit:               60856 ns,      1 iterations
> 
> And a third run:
> 
> [26459.679524]
>                Start testing find_bit() with random-filled bitmap
> [26459.689871] find_next_bit:                 2199418 ns, 163311 iterations
> [26459.698798] find_next_zero_bit:            2181289 ns, 164370 iterations
> [26459.707738] find_last_bit:                 2213638 ns, 163311 iterations
> [26459.732224] find_first_bit:               17764152 ns,  16429 iterations
> [26460.133823] find_first_and_bit:          394886375 ns,  32672 iterations
> [26460.141818] find_next_and_bit:             1269693 ns,  73485 iterations
> [26460.148545]
>                Start testing find_bit() with sparse bitmap
> [26460.155433] find_next_bit:                   40753 ns,    653 iterations
> [26460.166307] find_next_zero_bit:            4148211 ns, 327028 iterations
> [26460.173078] find_last_bit:                   50017 ns,    653 iterations
> [26460.187007] find_first_bit:                7205325 ns,    653 iterations
> [26460.193790] find_first_and_bit:              49358 ns,      1 iterations
> [26460.200577] find_next_and_bit:               62332 ns,      1 iterations
> 
> My gut feeling is that yes, there is some variance, but not on an
> order that is significant that would allow us to say "there's no
> difference".
> 
> find_next_bit results for random are: 2222703, 2206687, 2199418,
> which is an average of 2209603 and a variance of around 0.5%.
> The difference between this and the single generic figure I have
> is on the order of 20%.
> 
> I'll do the same with find_first_bit for random: 17722203, 17720726,
> and 17764152. Average is 17735694. Variance is around 0.1% or 0.2%.
> The difference between this and the single generic figure I have is
> on the order of 5%. Not so large, but still quite a big difference
> compared to the variance.
> 
> find_first_bit for sparse: 7562371, 7107862, 7205325. Average is
> 7291853. Variance is higher at about 4%. Difference between this and
> the generic figure is 0.5%, so this one is not significantly
> different.
> 
> The best result looks to be find_next_zero_bit for the sparse bitmap
> case. The generic code measures 5.5ms, the native code is sitting
> around 4.1ms. That's a difference of around 34%, and by just looking
> at the range in the figures above we can see this is a significant
> result without needing to do the calculations. Similar is true of
> find_next_bit for the sparse bitmap.
> 
> So, I think the results are significant in most cases and variance
> doesn't account for the differences. The only one which isn't is
> find_first_bit for the sparse case.

Hi Russel,

+ Alexey Klimov <klimov.linux@gmail.com>

This is my testings for native vs generic find_bit operations on a15
and 17.

The raw numbers are collected by Alexey Klimov on Odroid-xu3. All cpu
frequencies were fixed at 1000Mhz. (Thanks a lot!)

For each native/generic @ a15/a7 configuration, the find_bit_benchmark 
was run 5 times, and the results are summarized below:

A15                      Native     Generic       Difference
Dense                        ns          ns       %   sigmas
find_next_bit:          3746929     3231641      14      8.3
find_next_zero_bit:     3935354     3202608      19     10.4
find_last_bit:          3134713     3129717       0      0.1
find_first_bit:        85626542    20498669      76    172.4
find_first_and_bit:   409252997   414820417      -1     -0.2
find_next_and_bit:      1678706     1654420       1      0.4
                                              
Sparse                                        
find_next_bit:          143208        77924      46     29.4
find_next_zero_bit:    6893375      6059177      12     14.3
find_last_bit:           67174        68616      -2     -1.0
find_first_bit:       33689256      8151493      76     47.8
find_first_and_bit:     124758       156974     -26     -1.3
find_next_and_bit:       53391        56716      -6     -0.2

A7                      Native      Generic       Difference
Dense                       ns           ns       %   sigmas
find_next_bit:         4207627      5532764     -31    -14.9
find_next_zero_bit:    4259961      5236880     -23    -10.0
find_last_bit:         4281386      4201025       2      1.5
find_first_bit:      236913620     50970424      78    163.3
find_first_and_bit:  728069762    750580781      -3     -0.7
find_next_and_bit:     2696263      2766077      -3     -0.9

Sparse
find_next_bit:          327241       143776      56     40.7
find_next_zero_bit:    6987249     10235989     -46    -21.8
find_last_bit:           97758        94725       3      0.6
find_first_bit:       94628040     21051964      78     41.8
find_first_and_bit:     248133       241267       3      0.3
find_next_and_bit:      136475       154000     -13     -0.5

The last column is the difference between native and generic code
performance normalized to a standard deviation:
        (mean(native) - mean(generic)) / max(std(native), std(generic))

The results look consistent to me because 'and' subtests that are always
generic differ by less than one sigma.

On A15 generic code is a clear winner. On A7 results are inconsistent
although significant. Maybe it's worth to retest on A7.
 
Regarding the choice between native and generic core - I would prefer
generic version even if it's slightly slower because it is tested and
maintained better. And because the results of the test are at least on
par, to me it's a no-brainer.

Would be really interesting to compare performance of your LDRB->LDR
patch with the generic code using the same procedure.

Thanks,
Yury
