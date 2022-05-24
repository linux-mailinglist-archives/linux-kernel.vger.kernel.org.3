Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1C5328D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbiEXLXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiEXLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:23:03 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D2D78938;
        Tue, 24 May 2022 04:23:02 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p190so3384985ybg.4;
        Tue, 24 May 2022 04:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdTkIZ3cEsqyS10dEEw3qiwYJ3AMdVC2sCz6/B71Tw0=;
        b=mbsbl191nHbeBRIDJPNVwHmnsKKwAtwGjxnGSzhT/9nNy72Gv5Z0g3ELlVbBj/lo+r
         uQZ0XTFOhgMDCQTTrb3yRP9A2hAl/YmodG/8gcb54sTNwR9mvgepuvJFaHxxhmHLykO5
         8Kl2NwNX1BzDhl/YHH797ZOzcoXSlVR+DpZYI+e939GnCeWboNwXtCXT8YcRc7dvQUg2
         Hvcukg2x4VBTCCHS6YgQbSWSRw2mG6JUCwzF1ofITSxkwQg7AOkLGPOwFQFPpkTtkFm5
         dP2HWk/oqrqetHssQXR4ZqGvKEgtdnV7MnLetTKfCmZSbainjU4xEvkh4sK0TjveHrSm
         X95w==
X-Gm-Message-State: AOAM5339hcKYjdinqu2hy89ugVn3LOF3919vQXbsqwA1Z46ekifvqvP8
        JBXqh25VqiSw7IrnTnYV7/lrarfvy5BoXQPC7g5dREQq
X-Google-Smtp-Source: ABdhPJywm05sHExLPJfaIzwnfVzXEpryHpUEg01Nq4kNbJkzFYRZyu1r7sKlh2Hs3HTf2DwMPDnpgOpS7TEcMFZg+BI=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr23234419ybm.153.1653391381638; Tue, 24
 May 2022 04:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7> <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
 <20220512065623.q4aa6y52pst3zpxu@vireshk-i7> <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
 <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7> <20220524111456.hw4qugsvt4bm7reh@vireshk-i7>
In-Reply-To: <20220524111456.hw4qugsvt4bm7reh@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 May 2022 13:22:50 +0200
Message-ID: <CAJZ5v0i_qpcaUwdZY=KR_e=HC6MZUw2aDGL=hxgo866dF1zwOA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Tue, May 24, 2022 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 13-05-22, 09:57, Viresh Kumar wrote:
> > On 12-05-22, 12:49, Rafael J. Wysocki wrote:
> > > > > Moreover, I'm not sure why the locking dance in store() is necessary.
> > > >
> > > > commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")
> > >
> > > I get that, but I'm wondering if locking CPU hotplug from store() is
> > > needed at all.  I mean, if we are in store(), we are holding an active
> > > reference to the policy kobject, so the policy cannot go away until we
> > > are done anyway.  Thus it should be sufficient to use the policy rwsem
> > > for synchronization.
> >
> > I think after the current patchset is applied and we have the inactive
> > policy check in store(), we won't required the dance after all.
>
> I was writing a patch for this and then thought maybe look at mails
> around this time, when you sent the patch, and found the reason why we
> need the locking dance :)
>
> https://lore.kernel.org/lkml/20150729091136.GN7557@n2100.arm.linux.org.uk/
>
> I will add a comment for this now.

Well, again, if we are in store(), we are holding a reference to the
policy kobject, so this is not initialization time.
