Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2E35951A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiHPFEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiHPFDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:03:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24EAC6E94
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:01:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-328303afa6eso103160407b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=elGV48BlDszZRuy8S9+m13PY1kqIqtWfREXP+EXFmrg=;
        b=r8NjbapBTS67+vpVF7+sCFfdYsvuzVpSbreXNSPasBnVSUXsEkW2Tdiy0vBzbOigcM
         qkHezPAEwRYmAfuMzU7q6qw4S5wZy3KRTtCpEP69ti5057pFT/Te3P5tEFe+xNHwZC+m
         Tf3GeanOn8C43ORFxDvYPY4oID2CctIoeScmjdwsfdlI5xtnUMR9bJ2JRxwTzOdhN6B/
         Q2jJ//9GPDv5iPdQrFBgt1hXlMV7dlgnVz+CxBkfIXZqtN0HMa5iF1fqfIMMDJHs3IbN
         gHVjl6QzTSIciKflXKOAYtOtwqyjwYxUfM2HGX2gXXOcMk2jxDLBXTVALHOUX/KDTSv6
         vfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=elGV48BlDszZRuy8S9+m13PY1kqIqtWfREXP+EXFmrg=;
        b=er0MNSwHxh146w7ofhi63PZ7AckI5qyNucqSmj2fpjSHAS20GLSt7FNqw5jp52p0U3
         cgoLr2+iZ9VhQNnynAHQVcrf5FaGecpVAVXx2MVqYT0hYfg0jkqxmsXM7VEGCwTauJYd
         KKeLAkUl0rZ30/Zwplw37fLEGlkkmxtw36mWT63M+wlHosIXQskD9RNyt0d1amRuB+bP
         KQPIlS/gb75r4//iuXIqaTl8SflDfqwUjXrz8vBrw4MFxlkf2cjE20srBsf4qgAVxKm0
         bJenNPAW9rYfy5Y77fzDxOlMrVKbvhQj6D+sZPz4NggkJIunnvKSG0ROs8fiDkhWHghL
         mtvA==
X-Gm-Message-State: ACgBeo3MHfrr7hvGDf11tbXPen4AKUowhE/jvjxltXVIb1D8BPzl+wso
        3avvCBR4R0phyzFy7jlAMzmA3yPOgOkp8MOaJRf0SQ==
X-Google-Smtp-Source: AA6agR41q4yHanMi1A+gXLO08ia/kXxxT1OUdvxPqS+JZ3AYLwYDjl7erHXWMxbaY8NeTp1jebE8Ei5/XTiAHc+ZS+o=
X-Received: by 2002:a25:6612:0:b0:670:7c81:3aa6 with SMTP id
 a18-20020a256612000000b006707c813aa6mr13305548ybc.530.1660597293043; Mon, 15
 Aug 2022 14:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com> <20220810060040.321697-10-saravanak@google.com>
 <YvYhoGdemyKEx++d@atomide.com> <CAGETcx_SdxJKV56jGSx8GbmA4y_zaoP6z8n8xKZGZbCcmewvDQ@mail.gmail.com>
 <YvoglKDbsDLHq2S0@atomide.com>
In-Reply-To: <YvoglKDbsDLHq2S0@atomide.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Aug 2022 14:00:57 -0700
Message-ID: <CAGETcx-wz0k13K2fOjTN9RfuMzUPti=UQqY5Mq9XYLK8vudYng@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] of: property: Simplify of_link_to_phandle()
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Mon, Aug 15, 2022 at 3:31 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Saravana Kannan <saravanak@google.com> [220813 00:30]:
> > On Fri, Aug 12, 2022 at 2:47 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hi,
> > >
> > > * Saravana Kannan <saravanak@google.com> [220810 05:54]:
> > > > The driver core now:
> > > > - Has the parent device of a supplier pick up the consumers if the
> > > >   supplier never has a device created for it.
> > > > - Ignores a supplier if the supplier has no parent device and will never
> > > >   be probed by a driver
> > > >
> > > > And already prevents creating a device link with the consumer as a
> > > > supplier of a parent.
> > > >
> > > > So, we no longer need to find the "compatible" node of the supplier or
> > > > do any other checks in of_link_to_phandle(). We simply need to make sure
> > > > that the supplier is available in DT.
> > >
> > > This patch fixes booting for me, so it should be applied as a fix and
> > > tagged with:
> > >
> > > Fixes: 5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")
> > >
> > > If there are dependencies to the other patches in this series, it might
> > > make sense to revert commit 5a46079a9645 instead.
> >
> > Yes, there are dependencies on the rest of the patches in this series.
> > For linux-next, I think we should pick up this series once we get more
> > Tested-bys.
> >
> >  So if 5a46079a9645 is causing any regression in stable branches, we
> > should pick up the revert series [1] instead of this series we are
> > replying to.
>
> Agreed we should apply the reverts in [1] for v6.0-rc series. At least
> several generations of the TI 32-bit ARM SoCs are failing to boot
> otherwise.

Actually I wasn't clear in my earlier email. I meant to say "releases
branches", as in 5.19.xxx and not "stable branches". So for 5.19.xxx
we'd pick up these reverts.

And for v6.0-rc if my other patch series [1] fixes the issue, I'd
rather apply [1] than this series. Because this series is meant to be
temporary (I'll be reverting this in the future).

-Saravana

[1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
