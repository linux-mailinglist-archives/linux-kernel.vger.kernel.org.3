Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCAB4B4E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbiBNLZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:25:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351100AbiBNLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:24:50 -0500
X-Greylist: delayed 503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 03:00:40 PST
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD93E6A04A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:00:40 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4Jy1JM4G1Nz4x0y4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:52:19 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="LThY4lgU"
Date:   Mon, 14 Feb 2022 10:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1644835934;
        bh=MlZxepE7UcCIx7JdbAa36YidmF6d5y+C8F78t64Xio0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=LThY4lgUqhN8sGqwUbzGNFG1jSZlOqseiQAm9FRwnlotQK8Bibz9NV5fvBRzZkA6e
         AKdMcgVjEBUpigN+wbQqLLFpMpKqwoX4f/XY+4BKYUTk9WLnDIkOhF2IYvOYMxXq4H
         /+su7TPrhRIkglRZdbbO4kQikJA2b6Qjq8D6y/OXk1/hIsJfRqkNgbPpDFTLkhegbZ
         iaoLIMVLTzrHznyG58N/ooRjJnqpJpXq5iboveuFIgQPg4EJtHXoDn2D6MvMkgbJTs
         nms6hiOAFWrVqs6w8Er37CEQVw+JzcW3PYzmzFJVIQyOmoq/+Qd497VPQPxmkUH7FK
         VPZyRvj0tT/IA==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Message-ID: <aW25lLbuIQGCr0FHtnqiM-UB-VYfk-BaLhhwq3Ur9ONgrXyxHspO_JKXCIgAeI0IBhW7hqZwTdACzd9a1b8A9MIBDrn12ymzMGYjbeqcSYE=@emersion.fr>
In-Reply-To: <YgoxFBGNsrezVxmi@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com> <20220211091927.2988283-2-javierm@redhat.com> <YgY6OqN+guBlt/ED@smile.fi.intel.com> <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com> <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com> <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de> <87pmnt7gm3.fsf@intel.com> <YgaDj6Wld4b7S6DF@smile.fi.intel.com> <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de> <YgoxFBGNsrezVxmi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 14th, 2022 at 11:38, Andy Shevchenko <andriy.shevchenko=
@linux.intel.com> wrote:

> > > > IMO *always* prefer a for loop over while or do-while.
> > > >
> > > > The for (i =3D 0; i < N; i++) is such a strong paradigm in C. You
> > > > instantly know how many times you're going to loop, at a glance. No=
t so
> > > > with with the alternatives, which should be used sparingly.
> > >
> > > while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.
> >
> > Naw, that's not true.
>
> In the section 3.5 "Loops - While and For" in "The C Programming
> Language" 2nd by K&R, the authors said:
>
> =09The for statement ... is equivalent to ... while..."
>
> They said that for is equivalent to while, and not otherwise.
>
> Also, syntax sugar by definition declares something that can be written a=
s
> a single line of code, which usually is done using more (not always).

arr[i] is syntaxic sugar for *(arr + i), yet we keep writing the former,
because it's way more readable. The same goes for the for vs. while loops.
It may be obvious for you because you're a C guru, but to me it just obfusc=
ates
the code. Too many C projects end up becoming completely unreadable because=
 of
patterns like these.

Idiomatic C code isn't written by doing pointless micro-optimizations.
