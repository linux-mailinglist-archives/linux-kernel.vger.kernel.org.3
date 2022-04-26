Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A129510BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355636AbiDZWIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbiDZWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:08:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39E639D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1504BB82377
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD6EC385AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651010702;
        bh=f3y+x+jIoq4DGRlS1US0ASYjqXchO+3gcLp/ZetbNsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eoy/L9P/NCGYqnIObNJpoaufykwjGFVGt0pIEzsGKqHwg0McwrnGwdJA2CuNXfb9O
         64FnIgu20MVLggTs66O1QBN5aOh7A5jVcwc5zKwHNaIftS5r1y86BxdIFtBAlNP4mA
         inI6sw4//9kpwnSBKSrt5JLiBp7hOaff4czV7CCE5ojzHp1TPizKnoflwPp+zN+JZv
         /eS4sMJzNBynnIcCc+JBVtG85hboR5eLRxPD75ifbZ9R4aK8gAOO56yvrHsXEZLiNp
         1Aw+hKNhjHW6K66xO4EtgsYBKf6R2sDr2MtFEEOKloop9ta7zqxnCAyYXJRYjEMRe/
         X2i9mxxew5DqA==
Received: by mail-pg1-f174.google.com with SMTP id v10so6057495pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:05:02 -0700 (PDT)
X-Gm-Message-State: AOAM5300UgKJn/PSvl2sFlU5qjCCedCTjl8BZwRp1B28E+nQf8G5+XlZ
        fTG1KLRfghnkqiAo3WIxhzkgSVgKUZgQf2DCuQ==
X-Google-Smtp-Source: ABdhPJyPBtUnTXxk3RT6NLfJXkbbUZFJ459uNsUTNbpTM+9Vq9y+dsVPfv2Yzl1mh6rc7Wui2OvyP81FE6GOokMTqnA=
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id
 d16-20020a056a0010d000b004f75af447b6mr26353448pfu.6.1651010702163; Tue, 26
 Apr 2022 15:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-5-nick.hawkins@hpe.com>
 <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
 <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
 <CAK8P3a2ie8kFYstCYr6FO6+yFw7VxyJjWYyy9b+rUHu_u0YXPg@mail.gmail.com>
 <YmhmXl5IWHmKzAyG@robh.at.kernel.org> <CAK8P3a3+TGSJgJ2-mgj+NjT3k8uuUpesLErwqZ2M_dkNqbMXXQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3+TGSJgJ2-mgj+NjT3k8uuUpesLErwqZ2M_dkNqbMXXQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Apr 2022 17:04:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqB+Fas1NOmAq+ocG8KY6ugOiZ_o6e9=5unzf5-ku5Ag@mail.gmail.com>
Message-ID: <CAL_JsqKqB+Fas1NOmAq+ocG8KY6ugOiZ_o6e9=5unzf5-ku5Ag@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 4:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Apr 26, 2022 at 11:38 PM Rob Herring <robh@kernel.org> wrote:
> > On Tue, Apr 26, 2022 at 08:00:20AM +0200, Arnd Bergmann wrote:
> > > On Mon, Apr 25, 2022 at 10:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > There are multiple ways of doing this that we already discussed
> > > in the thread. The easiest is probably to have a child node without
> > > custom registers in the DT and then use the DT helpers to
> > > populate the linux devices with the correct data.
> >
> > I think that's what the wdt binding is doing, but I don't like that.
> > Maybe it's not a child node, I can't tell.
> >
> > Bindings should not be decided on the *current* driver split on one
> > particular OS. This looks like 1 block, so 1 node.
>
> Fair enough.
>
> > If that doesn't work well or easy for Linux, then we should fix Linux.
>
> Doing a simple platform_device_create_pdata() should work fine here,
> the only problem that might exist is if the wdt driver needs access to
> DT properties, as we can't have both devices refer to the same of_node
> pointer,

Why not? There's even a struct device flag for that.

> which would cause them to be picked up by the timer driver
> again.

Huh?

That's not to say there might be some gotchas. The musb driver didn't
like sharing. But those are issues we should fix rather than
work-around in the binding.

Rob
