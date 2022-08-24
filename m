Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6705A044D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiHXWxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHXWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:53:11 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F66556F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:53:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u14so21173550oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BYUw2X0viByhVZ/+dJN6TRVhaDQVcxTsg6s3mNZcPzI=;
        b=Lm01p74xrqBcxKJsjDjmcucfAHutDbuK+nPJXyCnINMFTyOQwJ8XySPJW8aGyWepjK
         ARHLH/cyCEvzbqYs0FjFYKy4ebX+ajtVXTKy2dbvSUe2W2rFvUMWwFUq9RCYcUHf8RP6
         AH+lrrUu7zDQ20WoBr5pKKStComzIX9PB5UPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BYUw2X0viByhVZ/+dJN6TRVhaDQVcxTsg6s3mNZcPzI=;
        b=4P5XNzyP+vUUB1V2QupFu1JB1q9CpCQ4BmtFHl9VndnEGvgZhnUfh258UJfdKBfuSB
         9U1S+dW/XZAF0TidSVnbeifEOhmI1h4ov8B3djWH1dR4VcaU+kYhh0wlNoLjCPZgH048
         4kjAU6El2nV+VfYcKlPhN0/+rz4dzBYbKBjjqc0p6i4CO2cFNAiG8PfraZ5RwDmfqxNU
         U3qmlz4IkznXmj7bmLQwB2ejRSoUcmISrznUD+Fg7TV2UHeyFe4jSI7wZu0N1v3fIwPK
         sGQpGLH6cvaKY14Yx9827iYRGrI3U/bESD8/NcuZqAH8hw1csw4II0aaxnmAWwDEyU4D
         MLvA==
X-Gm-Message-State: ACgBeo3gvucV+Kby9J+haEYPk/t+YNsoNrrOB+F8TA6XYfL9X44m6nUZ
        FIiaEVXeWigZKdtXh1qX1wDVBLrkoKzJ4Q==
X-Google-Smtp-Source: AA6agR6/g6Thw966/mdrYr7k4HWUBdP5WTQK3asvGF1C1m5GtJNJBXpg+yXLoCBM3VTZnYiHf3wRNA==
X-Received: by 2002:a05:6808:1487:b0:344:ad43:fe30 with SMTP id e7-20020a056808148700b00344ad43fe30mr585858oiw.258.1661381590240;
        Wed, 24 Aug 2022 15:53:10 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id k17-20020a056870351100b000fb2aa6eef2sm4988515oah.32.2022.08.24.15.53.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 15:53:09 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so12750829otd.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:53:08 -0700 (PDT)
X-Received: by 2002:a05:6830:58:b0:637:1974:140a with SMTP id
 d24-20020a056830005800b006371974140amr364549otp.362.1661381588181; Wed, 24
 Aug 2022 15:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20220112211258.21115-8-chang.seok.bae@intel.com> <CAE=gft4P2iGJDiYJccZFR1VnNomQB7Uo522r2gvrfNY9oKz5jg@mail.gmail.com>
 <763bddd2-2fc3-a857-0dff-a5ae4ae1f298@intel.com>
In-Reply-To: <763bddd2-2fc3-a857-0dff-a5ae4ae1f298@intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 24 Aug 2022 15:52:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft5VajfoAT6hVxiCzAMYiDV+pHRbC-F7s4+qK94qa0og5w@mail.gmail.com>
Message-ID: <CAE=gft5VajfoAT6hVxiCzAMYiDV+pHRbC-F7s4+qK94qa0og5w@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 3:21 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> On 8/23/2022 8:49 AM, Evan Green wrote:
> > On Wed, Jan 12, 2022 at 1:21 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>
> <snip>
> >> +
> >> +static void __init load_keylocker(void)
> >
> > I am late to this party by 6 months, but:
> > load_keylocker() cannot be __init, as it gets called during SMP core onlining.
>
> Yeah, it looks like the case with this patch only.
>
> But the next patch [1] limits the call during boot time only:
>
>         if (c == &boot_cpu_data) {
>                 ...
>                 load_keylocker();
>                 ...
>         } else {
>                 ...
>                 if (!kl_setup.initialized) {
>                         load_keylocker();
>                 } else if (valid_kl) {
>                         rc = copy_keylocker();
>                         ...
>                 }
>         }
>
> kl_setup.initialized is set by native_smp_cpus_done() ->
> destroy_keylocker_data() when CPUs are booted. Then load_keylocker() is
> not called because the root key (aka IWKey) is no longer available in
> memory.
>
> Now this 'valid_kl' flag should be always on unless the root key backup
> is corrupted. Then copy_keylocker() loads the root key from the backup
> in the platform state.
>
> So I think the onlining CPU won't call it.
>
> Maybe this bit can be much clarified in a separate (new) patch, instead
> of being part of another like [1].

Whatever we ended up landing in the ChromeOS tree (which I think was
v4 of this series) actively hit this bug in hibernation, which is how
I found it. I couldn't get a full backtrace because the backtracing
code tripped over itself as well for some reason. If the next patch in
this series is different from what we landed in ChromeOS, then maybe
your description is correct, but I haven't dug in to understand the
delta.

-Evan
