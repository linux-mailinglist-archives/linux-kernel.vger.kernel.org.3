Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C190F4A59A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiBAKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:11:09 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:19935 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiBAKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:11:08 -0500
Date:   Tue, 01 Feb 2022 10:11:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643710266;
        bh=Cj1qxOlZvMvcG0id2FOYw/2KPREH0TiCSehxgo3VmiU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=m5MZah3Rwj/cERTecrIm+SliL8b9cYACUr65ayL0BavnHMDJ2u7DQiCkKeDYDIc1s
         sdi/2df/Ej34+Q/PHdhyOBKdWQRj6g3HMgmxoo6tq/ZxzobYrSx1Z8P5P7taBEKbSg
         kg4RhcWnjYuSzEvWKGwtTGmP3zczQYnbitF9RQhRe0WdGa/5rCGEhroZaeNf+KMkpr
         Z4YXxC1I3Iw/5boMPEMHOIXCstJ3P2PHWLsgq2IhsuaOTXwzlxhJI25RgRIyoUBUhz
         vZYi5qYQGfmHgYyRI1hnI9mNmEzqJG6defBTDf0TMqV+TdCw+XZ8TYOxi3xlNvycAE
         SPOlFDlPso4Ng==
To:     Thomas Zimmermann <tzimmermann@suse.de>
From:   Simon Ser <contact@emersion.fr>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Message-ID: <csqnu2U_Kr-XE5p7ObjXsYbWDrfxh-j9CQE60lMJSxK0tF0SjlbZQkdjmAWpPRKYJoRLOCKtBgY-0AeIGdbr-SKjuyDKUTOTcI_PPV_bsWk=@emersion.fr>
In-Reply-To: <ce283de9-7412-472e-f72c-cb6a35ede426@suse.de>
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr> <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr> <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com> <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr> <CAMuHMdUHhUkPhq8M0d=p5EgH8bBz6EtH4drajKtQHE0121V1uQ@mail.gmail.com> <ce283de9-7412-472e-f72c-cb6a35ede426@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,T_SCC_BODY_TEXT_LINE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 1st, 2022 at 11:08, Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:

> Am 01.02.22 um 09:36 schrieb Geert Uytterhoeven:
>
> > I'd expect 8-bit grayscale to be Y8 instead.
>
> I like this naming, but DRM_FORMAT_R8 is uapi already. :/ If anything,
> we could add Yn formats in addition to existing Rn formats.

Need to be a bit careful, e.g. Y210 exists and isn't a grayscale format.
This could be confusing.
