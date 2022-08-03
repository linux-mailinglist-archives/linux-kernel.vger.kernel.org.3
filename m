Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21C4589277
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiHCSw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiHCSwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:52:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18374AD77
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:52:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id b7so12231409qvq.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Y+G+jrXUwx1OFVkRbsD9P0MjCdrC773UGz0YrZMAGHM=;
        b=Qg4toq1WD1Uy2p1uAeLCrkr1oBD2+u39M0rQvmgxPk9IkeLEwYJsu0vvypnj9MfQrW
         wSumPzl0GmbYt9H1v+tjt7bs1cNk3LpB57pbUsVKRCztpU4EYsrUtDNxnlHGA6H+IGU4
         wie1eavYiB0lBQXiN461/VNCdXdyDvmSKmEOx9XfkVpodVME7840n5Dk+h+XlP8OYkN/
         Bg/puWBeQiyhMFdtGmnfWQZENx41uSP3gMEDcan8BwW6aPZ982q2c2J7/7JhWEdM7UvU
         8TScbKXM/QjcDxh41gH7tzKO8EwZFHfi2E8Zi9KtCO0GJljeYsL7rH3kVsmV6q9HAb5G
         pF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Y+G+jrXUwx1OFVkRbsD9P0MjCdrC773UGz0YrZMAGHM=;
        b=08EekGmihkAkQmyOy/dNxn8XTDHhBt+w04KKIt73aw8307IQClmEtPYDFg0osBZHCZ
         5sGbS4+kYOpCcbC0GHstYjNRwX+hqPOOBIK/uDdmlHy0M3KRDzGqS9Omp3Ap7HMVWu5I
         cphH6A8mpeyvgkk4iyf1zBn6EtvKbfXTXH6LdjFuMbWPSRTz9fED3noJj0V6TJoOGPiK
         xZK+TtL1WdBWZXiP9dvlmS1XNyiKI2mzVoXcTjr5qvCvFohiWhZBIN/3V+gpwXET2u2V
         IuV6lF/2qk0MJH2QP6ie4xG3QjVDIthXAtKjbVq8EVB+ZCkoXt39yL4f15a2oegorGkv
         c8vg==
X-Gm-Message-State: ACgBeo1DvaPKaCQMzmcYR6WdqrlGQxsJ4jubU7oneTbHrC9RmS2B79J8
        BpU8Yf148Q9UBoR6PkdM63JphCO9y30=
X-Google-Smtp-Source: AA6agR74ppXCaKEHgk4+1cmsF7Ddh8DdWtEaLMZBLJKNeaLHmfuwX1rZqctyKztkkOwksHzPmT+BJg==
X-Received: by 2002:ad4:5ba5:0:b0:476:dcb9:684e with SMTP id 5-20020ad45ba5000000b00476dcb9684emr7798710qvq.83.1659552771857;
        Wed, 03 Aug 2022 11:52:51 -0700 (PDT)
Received: from localhost ([2601:c4:c432:f9:ee0c:bfa:a55f:3217])
        by smtp.gmail.com with ESMTPSA id h6-20020ac846c6000000b0033b6f4895afsm2910488qto.42.2022.08.03.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:52:51 -0700 (PDT)
Date:   Wed, 3 Aug 2022 11:52:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Neel Natu <neelnatu@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, cpumask: don't leak impossible cpus via
 for_each_cpu_wrap().
Message-ID: <YurEAU5SlQaZ85vZ@yury-laptop>
References: <20220802214041.2656586-1-neelnatu@google.com>
 <CAAH8bW_z3TjjafPRJPZmzDdOFjmU7xTLxOinw8D4nsZ2B6WN4w@mail.gmail.com>
 <CAJDe-O+8G=hyqWcaNk8_YP9S-R9-Xnn2_cLt8Loz9ru8V24K_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDe-O+8G=hyqWcaNk8_YP9S-R9-Xnn2_cLt8Loz9ru8V24K_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 10:49:57AM -0700, Neel Natu wrote:
> On Tue, Aug 2, 2022 at 6:22 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Tue, Aug 2, 2022 at 2:41 PM Neel Natu <neelnatu@google.com> wrote:
> > >
> > > The value of 'nr_cpumask_bits' is dependent on CONFIG_CPUMASK_OFFSTACK.
> > > This in turn can change the set of cpus visited by for_each_cpu_wrap()
> > > with a mask that has bits set in the range [nr_cpu_ids, NR_CPUS).
> > >
> > > Specifically on !CONFIG_CPUMASK_OFFSTACK kernels the API can iterate
> > > over cpus outside the 'cpu_possible_mask'.
> > >
> > > Fix this to make its behavior match for_each_cpu() which always limits
> > > the iteration to the range [0, nr_cpu_ids).
> > >
> > > Signed-off-by: Neel Natu <neelnatu@google.com>
> >
> > The patch itself doesn't look correct because it randomly switches a piece
> > of cpumask API from nr_cpumask_bits to nr_cpu_ids, and doesn't touch
> > others.
> >
> > However...
> >
> > I don't know the story behind having 2 variables holding the max possible
> > number of cpus, and it looks like it dates back to prehistoric times.  In
> > modern kernel, there are 2 cases where nr_cpumask_bits == nr_cpu_ids
> > for sure: it's CONFIG_CPUMASK_OFFSTACK=y and
> > CONFIG_HOTPLUG_CPU=y. At least one of those is enabled in defconfig
> > of every popular architecture.
> >
> 
> Hmm, in a kernel with CONFIG_HOTPLUG_CPU=y but not CONFIG_CPUMASK_OFFSTACK
> I see "nr_cpu_ids = 20, nr_cpumask_bits = 512". FYI since it doesn't
> match the observation
> above that nr_cpumask_bits == nr_cpu_ids when CONFIG_HOTPLUG_CPU=y.

I said this because the comment in include/linux/cpumaks.h says:
 *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
 *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
 *  ACPI reports present at boot.

And because of the code that sets nr_cpu_ids:

void __init setup_nr_cpu_ids(void)
{
        nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
}

Some arches override it, so it may be an issue. Are you running x86,
or maybe you have "nr_cpus" boot parameter?

But anyways, I feel like this should be investigated for more... Can you
please share the config of your system and boot params?
 
> > In case of HOTPLUG is off, I don't understand why we should have nr_cpu_ids
> > and nr_cpumask_bits different - what case should it cover?... Interestingly, in
> > comments to cpumask functions and in the code those two are referred
> > interchangeably.
> >
> > Even more interestingly, we have a function bitmap_setall() that sets all bits
> > up to nr_cpumask_bits, and it could trigger the problem that you described,
> 
> I think you mean cpumask_setall() that in turn calls
> bitmap_fill(nr_cpumask_bits)?

Yes, sorry.

> > so that someone would complain. (Are there any other valid reasons to set
> > bits behind nr_cpu_ids intentionally?)
> >
> 
> I don't know of any although this wasn't the case that trigger in my case.
> 
> > Can you share more details about how you triggered that? If you observe
> > those bits set, something else is probably already wrong...
> 
> The non-intuitive behavior of for_each_cpu_wrap() was triggered when iterating
> over a cpumask passed by userspace that set a bit in the [nr_cpu_ids,
> nr_cpumask_bits)
> range.

If you receive bitmap from userspace, you need to copy it with
bitmap_copy_clear_tail(), or bitmap_from_arr{32,64}, as appropriate.
That will clear unneeded bits.

For user-to-kernel communications, I'd recommend passing bitmaps in a
human-readable formats - hex string or bitmap list. Check the functions
cpumask_parse_user() and cpumask_parselist_user(). This would help to
avoid all possible issues related to endianness and 32/64 word length
mismatch.

> The kernel code is out of tree but open source so happy to provide a
> pointer if needed.

Yes please

> I considered ANDing the user supplied mask with 'cpu_possible_mask'
> but that felt
> like working around an inconsistency in the kernel API (hence the proposed fix).
> 
> > So, if there is no real case in modern kernel to have nr_cpumask_bits and
> > nr_cpu_ids different, the proper fix would be to just drop the first.
> >
> 
> I'll let other people more knowledgable than me in this area chime in.
> I'll be happy either
> way if that fixes the problem at hand.
> 
> best
> Neel
> 
> > If there is such a case, this is probably your case, and we'd know more
> > details to understand how to deal with that.
> >
> > Thanks,
> > Yury
