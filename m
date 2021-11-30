Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB67462D89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhK3HgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhK3HgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:36:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D6C061574;
        Mon, 29 Nov 2021 23:32:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d24so42342857wra.0;
        Mon, 29 Nov 2021 23:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1BIlK4OUN6YaFPD/kO0sTxOg0m36VUcqmd/sqgmDSs=;
        b=JcISBZlgsa9FfDaaIteo0u6z3gfwkos95vNsWM+4HK8YDQyHMvT5cR6Q2dSrXg74uW
         63BPlo7r/cLozmNtxft/PxDpnvMphmGQUxTa08WObX3EAHFgiMMdYKLSNyRYGqCm4yNQ
         ovMY5aR+T84ZGt18JgFgKXdoncdhpQ/9r+9OvCAfJBnX/W/N132BJE5TtuJUAMnrN+Nb
         g3pMBR22WA8rlF3PSn4ppNqZ+eLXIIL+j7r9IVmyH1FFIvGhBJmeHpvhyG+xMAL4Qcr0
         OHiA60//VqQWUwhauPuyDY3b9xaES3yXewIcd0KpvvKp2KSsipPHE9W74S5+XQsmGFW+
         uybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1BIlK4OUN6YaFPD/kO0sTxOg0m36VUcqmd/sqgmDSs=;
        b=xhbytrzYSauB3XVNdiRjBj++MT0m1GNcujvjP/2plnY40J2o3iSwap0S+N7TlDpD0i
         9nPmBulxtrSglNd5hdE0mRY9KJdCdCNmq4zxQPo48XIvYxsodB30YY0FwxKuno8oaBzZ
         PBIyBV/va3FXRE2ch3dOp+6W5XAzgVnUtyGQOPyIBELRtKK9PcQL9FByz5PkMeezxzVt
         j7DxOO1kjp5pVo3AGfVB03gfB3+s2I07ztrIk1NLVru09O41vS+tCAtDdDbsJ51ars3C
         ILKRtOwWDJBv9cXfoQRIxcJrMvyvx93X34khfuo9oOkj7DAUncVcCQgoAQi5fMrwbz3L
         w5xg==
X-Gm-Message-State: AOAM530koYAYXhzhvnGK8ppHsTFN36hkND1KaCGINhe/VaowrmJ5kcpI
        nFPWi7OIRXdr93UEZHbnYbNX/H5G5caxP6ks2+s=
X-Google-Smtp-Source: ABdhPJzpcjfMhsE9AtGWEcryB9k2QAOJlLHu0MgUXdZgAfpWjJmclo8auyQ10CqITt897YyLaBUf6h9HS91eMmZxefo=
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr37959217wrq.354.1638257570639;
 Mon, 29 Nov 2021 23:32:50 -0800 (PST)
MIME-Version: 1.0
References: <2036923.9o76ZdvQCi@positron.chronox.de> <4641592.OV4Wx5bFTl@positron.chronox.de>
 <CAHmME9oaS4TOpk7rQ73BRKeVLjMUNyt6EFyeOX=hZSkFBPDu0g@mail.gmail.com> <56d2da397bb53f71c0354b102c3b40940e9b4eda.camel@redhat.com>
In-Reply-To: <56d2da397bb53f71c0354b102c3b40940e9b4eda.camel@redhat.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Tue, 30 Nov 2021 15:32:38 +0800
Message-ID: <CACXcFmntNAWYCwQ6CmH5c3pn3fXbxKh=j75GZUeLkuqi3QdS+A@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Simo Sorce <simo@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>,
        Tso Ted <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        John Kelsey <crypto.jmk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:02 PM Simo Sorce <simo@redhat.com> wrote:

> ... with my distribution hat on I
> can say that FIPS is essential for us and any design must include an
> option to be FIPS certifiable.

I think I understand Ted's objections & I'm inclined to agree with
them. See also this comment from Jon Callas:

" The NIST AES_CTR_DRBG is mostly-okay. It's got a few issues
" (see <https://eprint.iacr.org/2020/619.pdf>), but you can get
" around them. I don't like that it takes a simple concept (a good block
" cipher is a good PRP/PRF) and throws enough scaffolding around it
" to make it hard to understand. I understand the reasons .., it just
" bugs me.

That said, people do want compliance with FIPS or various other
standards. That raises a number of questions.

One is for Stephan: would you care to submit patches for the
current driver that ONLY make it FIPS (and/or European standards)
compliant? No jitter, no stuff to allow different crypto, no choice to
replace the driver, ..., just FIPS. Some of those might be good
ideas, but they would not belong in a FIPS patch.

I think that would have a much better chance of acceptance
than your patches to date.

There are also more general questions:

The FIPS requirements for a deterministic RNG include a
whole rat's nest of extras, notably various self-tests, which
Stephan's patches might deal with. Or do any of the vendors
have patches for that?

FIPS defines DRNGs using either a block cipher or a hash,
but we use a stream cipher. According to Wikipedia, several
of the *BSD distros do the same.
https://en.wikipedia.org/wiki/Salsa20#ChaCha20_adoption
This seems reasonable to me, but could we persuade NIST
to add that option? I've added John Kelsey (one of the FIPS
authors) to the cc list in hopes of that.

Failing that, the Blake hash function is based on Chacha
https://en.wikipedia.org/wiki/BLAKE_(hash_function)
Should we use that to get a more easily certified DRNG?
Would that be as fast as Chacha alone?

The FIPS also require that all the entropy inputs to the
DRNG be certified. I think we have a problem there.

I suspect that many of the random number instructions
enabled by CONFIG_ARCH_RANDOM or the hardware
RNGs enabled by CONFIG_HW_RANDOM could be
certified, but that would need to be done by the vendors
and the costs might be substantial. Are any already
certified? Is there any vendor interest?

Apart from those, the current driver gets entropy in
several places. The comments have:

 * The current exported interfaces for gathering environmental noise
 * from the devices are:
 *
 *    void add_device_randomness(const void *buf, unsigned int size);
 *     void add_input_randomness(unsigned int type, unsigned int code,
 *                                unsigned int value);
 *    void add_interrupt_randomness(int irq, int irq_flags);
 *     void add_disk_randomness(struct gendisk *disk);
 *
 * add_device_randomness() is for adding data to the random pool that
 * is likely to differ between two devices (or possibly even per boot).
 * This would be things like MAC addresses or serial numbers, ...
 *
 * add_input_randomness() uses the input layer interrupt timing, as well as
 * the event type information from the hardware.
 *
 * add_interrupt_randomness() uses the interrupt timing as random
 * inputs to the entropy pool. Using the cycle counters and the irq source
 * as inputs, it feeds the randomness roughly once a second.
 *
 * add_disk_randomness() uses what amounts to the seek time of block
 * layer request events, ... Note that high-speed solid state drives with
 * very low seek times do not make for good sources of entropy, ...

I think we should eliminate add_disk_randomness() since it does
not work well on current hardware. Also, FIPS requires that
entropy sources be independent & add_interrupt_randomness()
depends on the same disk events so these sources may not be.

A similar argument could be made for getting rid of
add_input_randomness() but that would lose the event
type information. Does that matter?

The current driver also uses other sources, at least
fast_mix(), add_timer_randomness(), random_get_entropy()
and the gcc latent entropy plugin. Could/should those be
simplified to get more easily audited or certified code?

The driver also allows input of external data which is
mixed into the pool & provides an ioctl to let a user
with root privileges change the pool's entropy estimate.
Do either of those violate the FIPS requirement that
only certified entropy sources be used? I'd be happy
to lose the ioctl (or better, all the entropy estimation
machinery) but those have been part of the system
for decades. I'd definitely want to keep the option to
use external inputs.
