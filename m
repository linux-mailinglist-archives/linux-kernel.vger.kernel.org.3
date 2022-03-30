Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4C4ECA45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349179AbiC3RHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbiC3RHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:07:10 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892FDFB1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:05:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2e6650cde1bso225761147b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnsMD3FeYrTSlZn/a95b13cN6i0RSdBp2eSDDvoNOW0=;
        b=m55c1Vo4NWO0XDeAhLWxHXUHuwrAsIGj84rayCYgL6T0n1akynub8GAmHZSisi9osc
         PPTJ3l+EEy5cwXW1L6B6dBQWmIKry6b825eb1HSbDaPVq3gsJKj9pIFTrSWD26JXY5zf
         lUMszNHBX65MANiU/Js2C8PbuB5ZFme/bUMfH+D2qaaO/J+2FHXjb8MmlO1qPq+Cl1gZ
         NCqcrCgG4jooxaNWO3iEkYNP0TUO335EFU7W5pTqyKXCtlfS+Onm4iDnvAJTnFrH7epu
         192bba5ezqTQh4FkbVBy1bOOgyPItROWRnKxaIFgDnCo4MgS2Dp9qNDdysOo77ttlCM7
         Ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnsMD3FeYrTSlZn/a95b13cN6i0RSdBp2eSDDvoNOW0=;
        b=huMkR5mpL5ZDzxAJHI1LlRWgdzT+DYVtYDK+HOTOCpaj7uut7Duw9rVM8l42sX0jpp
         LWbnVnR+8KiAwMrlOZqCvrY08WUtueVVwQf2Kytfjzt0T/7A4ETfVx4bX3mhi5U9Dss3
         8QPorTM//GSiZ1K02g1UdYkQL+Quljk18X6fCnyIxuHvucju3HgN+LiAJWstHwMJ5pIQ
         EI9BbbhEBzDhEyVwwC+KMlHVNfqozkjRDMBi/KwMFtVrKxkWLJ6CvN6YoDDSUwLFff9r
         ynEKRaD6TQ6uWscEIPDkSgVdaySWRIxu73jDaOUObZkL1EqTbu181QnkIUG35NO8UY0c
         y8yA==
X-Gm-Message-State: AOAM532OhqTF6n3yfwi0+YlT+xYvR5IV/LM2OYm7Yq8z/qmHTqaJugUQ
        65CM/V4RcS5wuHyzJq+sMh80zYsBw7PRpdqN3I2U6g==
X-Google-Smtp-Source: ABdhPJz32aJueOZgkKLfvPFmTlmVPA1/UHHHoFUDQWBSedXE1xVeQq6hAhVxGzYPOXM9ST+h1IUfbxPABosm4dr9p0o=
X-Received: by 2002:a81:1693:0:b0:2e5:874a:c060 with SMTP id
 141-20020a811693000000b002e5874ac060mr593477yww.489.1648659923411; Wed, 30
 Mar 2022 10:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220311011715.2440601-1-eric.dumazet@gmail.com>
 <87ee2jo2je.ffs@tglx> <CANn89i+aCnUQj+UkRQBQ+mkL3xeFCmSkgeCYx+hmMNmko+EZ4Q@mail.gmail.com>
 <87bkxnnzkj.ffs@tglx>
In-Reply-To: <87bkxnnzkj.ffs@tglx>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Mar 2022 10:05:12 -0700
Message-ID: <CANn89iKnyG=3MbKzYKsE92p8Qu0QHie_UmQUxJx9YmHGUhKrQA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: use smp_call_function_many() in arch_freq_prepare_all()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Mar 30 2022 at 09:51, Eric Dumazet wrote:
> > On Wed, Mar 30, 2022 at 8:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> which I hate with a passion because that allows *unpriviledged* user
> >> space to inject systemwide IPIs every 10ms just to read these counters
> >> which are providing not more than some estimate and are of no value for
> >> the only sane use case of /proc/cpuinfo, i.e. #1 above.
> >
> > You do realize that before my patch, this is already happening ?
> >
> > My "optimization" simply replace an open loop of individual IPI with
> > use of the broadcast IPI capability.
> >
> > Are you saying we should remove IPI broadcast and use loops
> > of IPI, one cpu at a time ?
>
> I rather have no IPIs at all...

Can you send an actual patch, with a changelog then ?

I saw kind of a rant about my patch, which was fine IMO.

Sorry.
