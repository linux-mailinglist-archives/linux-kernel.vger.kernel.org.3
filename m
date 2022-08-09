Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4370058D448
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiHIHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHIHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:13:16 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F41F62B;
        Tue,  9 Aug 2022 00:13:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l8so3254796qvr.5;
        Tue, 09 Aug 2022 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zPTedhbdghWkbAG9JyUrOmVThlH8q9Ie9dGXSRthGmQ=;
        b=HsUhyybC49y9dCf7HWcpppvdJ7kITXo6VkL0pR6lG+ODzpWv8VEjlPy4alR1AHYU8j
         THWktyHD/g3dIq4DihicNSdtWiWbwUpl2cuAXWjeVG6EbX/CPhEUGjNoc7vG8W0PR3bG
         PyyPqGq8LGqlXxGw17x9jsg+aQ0zslTgjWkJErZ868fKY1LyIEkq3Is93vrF2FS+KDQK
         xkUxkoBibki92MNpHV8mAMG4rJs49V0Q3fyse0et5fqPpQLNV++iboJlmsQgJX/dPOLE
         SA4DE7o6KMHCcttlxtrFKcafGQHMXKaX2/hiSKJbh2Ml1YnXSae1VnrPujOFHtsIjWa5
         yvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zPTedhbdghWkbAG9JyUrOmVThlH8q9Ie9dGXSRthGmQ=;
        b=f0iI9TBK5BoPHbSPg4OhxDSOrmMcnLZdohBKX6JeL6OaHoKChsO3bDqnhaw9Ry2f8t
         /z4cRnzG10sobI38ZSf4H+N1EhlTpAoorCZcCXaqHYw99y0oH19XOdBuYSwzFCkkkYEH
         zuEdNDF7OsVZ/yv2WR01YBiZ8zaJ60poPacrjkh4f0bc32AH0hPjNk3ASfUBzFxurfmB
         ogDxVIfNpGoGKo7KDxhy6weXPB22pu+yDVoUCqPs/m6FcCSZr4D4zktEq017wqIzYe02
         deNcgPdD4UQiIO9037CgBrlcPXOln5YqiYAoIrzuYMTu4ht+MpD9jiJGBTD3gLJJZjil
         pLyg==
X-Gm-Message-State: ACgBeo3b333hq/TmpfAHnPkPbC4FwCoPIal3SxV2VOA4AI6EgaewcSv9
        O68mTx1wamNjtVTpu1M6gLqL5CqZIr5DPBCV3S4=
X-Google-Smtp-Source: AA6agR7BNOcHLu8z/kWEKsMvH+v2Q46xqzVbeTqdNCpXw5vAce3mB/ZVkoSoEPFvWHUmMNdjfRlGynVh4RzlCpT98iE=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr18847552qvq.64.1660029194573; Tue, 09
 Aug 2022 00:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220808031132.10075-1-luke@ljones.dev> <20220808031132.10075-3-luke@ljones.dev>
 <CAHp75VcjTG=fFBjjHRYT2+ARfE-VHWKJ9aV8sF4JtRVo7Ke2vQ@mail.gmail.com> <F8WBGR.2I3OK4ERR79N3@ljones.dev>
In-Reply-To: <F8WBGR.2I3OK4ERR79N3@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 09:12:37 +0200
Message-ID: <CAHp75Vda5KX5pVrNeueQEODoEy405eTb9SYJtts-Lm9jMNocHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] asus-wmi: Add support for ROG X13 tablet mode
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 5:26 AM Luke Jones <luke@ljones.dev> wrote:

...

> >>  +                       pr_err("This device has lid-flip-rog quirk
> >> but got ENODEV checking it. This is a bug.");
> >
> > dev_err() ?
>
> Okay, changed here and in previous patch to match it.
>
> So that I'm clearer on dev_err(), this doesn't do something like exit
> the module does it? It's just a more detailed error print?

Yes, it's more specific when the user sees it. The pr_err() is global
and anonymous (you can only point to the driver, and not the instance
of the device bound to it), while dev_err() is device specific and the
user will immediately see which device instance is failing. Yet it's
not a problem for this particular driver, because I don't believe one
may have two, but it's a good coding practice in general.

(Note the last sentence: "good coding practice")

...

> >>  +static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi
> >> *asus)
> >>  +{
> >>  +       int result = asus_wmi_get_devstate_simple(asus,
> >> ASUS_WMI_DEVID_LID_FLIP_ROG);
> >>  +
> >>  +       if (result >= 0) {
> >
> > First of all, it's better to decouple assignment and definition, and
> > move assignment closer to its user. This is usual pattern.
>
> I don't fully understand why you would want the separation given how
> short these two blocks are (I'll change in this and previous patch of
> course, I just don't personally understand it).

See above, "good coding practice". Why?

Imagine your code to be in hypothetical v5.10:

  int x = foo(param1, param2, ...);

  if (x)
    return Y;


Now, at v5.12 somebody adds a new feature which touches your code:

  int x = foo(param1, param2, ...);
  struct bar *baz;

  if (we_have_such_feature_disabled)
    return Z;

  if (x)
    return Y;

  baz = ...

And then somebody else in v5.13 does another feature:

  int x = foo(param1, param2, ...);
  struct bar *baz;

  if (we_have_such_feature_disabled)
    return Z;

  /* parameter 1 can be NULL, check it */
  if (!param1)
    return -EINVAL;

  if (x)
    return Y;

  baz = ...

Do you see now an issue? If you emulate this as a sequence of Git
changes the last one is easily missing subtle detail. That's why "good
coding practice".

-- 
With Best Regards,
Andy Shevchenko
