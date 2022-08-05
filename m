Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78758B038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiHETQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiHETQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:16:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916AC237F7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:16:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tl27so6653825ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=21FAPNKk7R7dtwD16dK5hF3eWna1JT0Lifx6z6IAhts=;
        b=doGf+B4tNfQ0ZutR9Qs8yR0YUtiZy25+mgNHY6RaFA5ng18+jMdvHJ8TCFlgp7+OpR
         DlHieno3fYYbLWFvTmu5z1gwI5+sLHltL0v5gEJbhBquLwYiKyS+Q27yiO4EFfBFWrld
         763b8IL7o1uBog/BhiTujhy79pwTf7igc7kxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=21FAPNKk7R7dtwD16dK5hF3eWna1JT0Lifx6z6IAhts=;
        b=pKgrPmWNf+8wswKW5OuJaXATJ5LSei3ACsDwW1gJ8OqcUUZ/JFVqqbVq1QWp8yoDi7
         I69PMPT7ut8Zw5JpQSTMAsF0G7gICNo0RxLUMcOZFM/XCMeTOdxCCpJwLmLOsjyUyVxS
         iXNrHzReQ/zHpc5h28FP5p2pjk9HI3Ba2Bdj7hTrtatHqLDpQ9D1Znrim45PLeUIBQoe
         hbEtuNs5lakyYrSEGry96SnWUGBVanwyf1F4FgZ1RSak5K6Wk74GTpHtFsl6TVyYVAzp
         ITPCQVkNqOIVu2oe2wE5RDWtG+eQ7Ajh0IFApudlsjeXfWAFz+CS5RKRmi0+9WAbFGXf
         xKmg==
X-Gm-Message-State: ACgBeo33msqKtIp01Hsa4LQZSzIVwKyfPn+lTBZuEApAgNpyP97lgC+O
        VKopWNvf7LTYsNG46zkayhnFFgveFKwq/EjQ
X-Google-Smtp-Source: AA6agR55mznn2DA+nyUqMeLM0wBXWIBb+g5N3quvmkLa9BckoDko9Ggqb1Bu67wkbtRnZGa07YepEw==
X-Received: by 2002:a17:907:2706:b0:730:95df:66ec with SMTP id w6-20020a170907270600b0073095df66ecmr6306663ejk.260.1659726993017;
        Fri, 05 Aug 2022 12:16:33 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id r25-20020a056402019900b0043d7923af6esm300507edv.95.2022.08.05.12.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 12:16:31 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id h34-20020a05600c49a200b003a5165eae0fso1661264wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:16:30 -0700 (PDT)
X-Received: by 2002:a05:600c:5102:b0:3a5:15c9:16d3 with SMTP id
 o2-20020a05600c510200b003a515c916d3mr4691282wms.93.1659726990158; Fri, 05 Aug
 2022 12:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211116012912.723980-1-longman@redhat.com> <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
 <20220719104104.1634-1-hdanton@sina.com> <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
 <20220722115510.2101-1-hdanton@sina.com> <CAD=FV=XS_AqMveo=a2zN+=b3DxM-yJQapd27Dq8dR+kSb2oL_A@mail.gmail.com>
 <20220723001713.2156-1-hdanton@sina.com> <CAD=FV=X7FnrwHSedA=1xJsrfSgQZcqu0YEAKrfoJC6BhDc-gFA@mail.gmail.com>
 <2fcf84e6-168b-4ee7-bc9e-5b1c3c9a3d4e@redhat.com>
In-Reply-To: <2fcf84e6-168b-4ee7-bc9e-5b1c3c9a3d4e@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Aug 2022 12:16:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UyAecgOfiA18WoA+Dd7DxwD7v1RbjrKUs9=LqrZ6C70g@mail.gmail.com>
Message-ID: <CAD=FV=UyAecgOfiA18WoA+Dd7DxwD7v1RbjrKUs9=LqrZ6C70g@mail.gmail.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more consistent
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 5, 2022 at 12:02 PM Waiman Long <longman@redhat.com> wrote:
>
>
> On 8/5/22 13:14, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jul 22, 2022 at 5:17 PM Hillf Danton <hdanton@sina.com> wrote:
> >> On Fri, 22 Jul 2022 07:02:42 -0700 Doug Anderson wrote:
> >>> Thanks! I added this diff to your previous diff and my simple test
> >>> still passes and I don't see your WARN_ON triggered.
> >> Thanks!
> >>> How do we move forward? Are you going to officially submit a patch
> >>> with both of your diffs squashed together? Are we waiting for
> >>> additional review from someone?
> >> Given it is not unusual for us to miss anything important, lets take
> >> a RWSEM_WAIT_TIMEOUT nap now or two.
> > It appears that another fix has landed in the meantime. Commit
> > 6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to ignore handoff
> > bit if not set by first waiter").
> >
> > ...unfortunately with that patch my test cases still hangs. :(
>
> The aim of commit 6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to
> ignore handoff bit if not set by first waiter") is to restore slowpath
> writer behavior to be the same as before commit d257cc8cb8d5
> ("locking/rwsem: Make handoff bit handling more consistent").

Ah, OK. I just saw another fix to the same commit and assumed that
perhaps it was intended to address the same issue.


> If the hang still exists, there may be other cause for it. Could you
> share more information about what the test case is doing and any kernel
> splat that you have?

It's all described in my earlier reply including my full test case:

https://lore.kernel.org/r/CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com

Previously I tested Hillf's patches and they fixed it for me.

-Doug
