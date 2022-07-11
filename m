Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C756FEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiGKKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiGKKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:19:23 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB4DC5944;
        Mon, 11 Jul 2022 02:36:05 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id l26so3392499qkl.10;
        Mon, 11 Jul 2022 02:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVJUGFx3bR67+/E6+DBeYAU8MgftXdOcu6+8ewnr6LE=;
        b=Grb1mICe/KhbwLOEfAkKDySeSxSgknGkd+imBlMn5B3iGw309ODADz+Eg//P2ZT7iV
         3utw/l1fNrnbwYfqGyFeNqmIVrb1YW4A0RehUd3Jk0GqWEl9vMEUrXuDiDgLjJ8WqQN4
         tl7nl721wzrX/YV0tmyyfnAlXAYyhsfSYUxkW/F6nSEyBDTIN1bES3pdoEG5X8McxXhl
         KVLqcUNLmxjPu7OUOtYFaf0gqJmlWuFXBE4Na+rBei5sFi+jgNZPTmTsd1HCpwnocEC0
         IXa8hOazblbkU/dL7jQDX8OcxGEadX1bYWuiWe12nS9l9/etlohe7+q2VT+vj0kpay5u
         njJQ==
X-Gm-Message-State: AJIora/MaWNWJeoWUexTtHx7MFiJuFrAK06DWdFRBoe5IiGQHUGr4Dhd
        LP7hPE4xQQy1AO1kHtb5xGt391qORApzmA==
X-Google-Smtp-Source: AGRyM1vZzBucHiqPQeSQ/wXnca/TSwvQ/zQg9JGqNdFX+0Q2mLUM/6ehODCCxvHYTFcAisSYYK4hAw==
X-Received: by 2002:a05:620a:254f:b0:6a6:313:3ccc with SMTP id s15-20020a05620a254f00b006a603133cccmr10787076qko.716.1657532164248;
        Mon, 11 Jul 2022 02:36:04 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a0f0f00b006a785ba0c25sm5993061qkl.77.2022.07.11.02.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:36:03 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31d85f82f0bso7031027b3.7;
        Mon, 11 Jul 2022 02:36:03 -0700 (PDT)
X-Received: by 2002:a81:9209:0:b0:31c:b1b7:b063 with SMTP id
 j9-20020a819209000000b0031cb1b7b063mr18545635ywg.383.1657532162961; Mon, 11
 Jul 2022 02:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301107.git.geert@linux-m68k.org> <68923c8a129b6c2a70b570103679a1cf7876bbc2.1657301107.git.geert@linux-m68k.org>
 <ef2aada2-96e4-c2e4-645f-39bc9094e93a@suse.de>
In-Reply-To: <ef2aada2-96e4-c2e4-645f-39bc9094e93a@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jul 2022 11:35:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUqo-_5tyhmx_QqPJhqQdoRDE6_Q7b1AJWeBZc67RsBSA@mail.gmail.com>
Message-ID: <CAMuHMdUqo-_5tyhmx_QqPJhqQdoRDE6_Q7b1AJWeBZc67RsBSA@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/modes: Add support for driver-specific named modes
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Thomas,

On Mon, Jul 11, 2022 at 11:03 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 08.07.22 um 20:21 schrieb Geert Uytterhoeven:
> > The mode parsing code recognizes named modes only if they are explicitly
> > listed in the internal whitelist, which is currently limited to "NTSC"
> > and "PAL".
> >
> > Provide a mechanism for drivers to override this list to support custom
> > mode names.
> >
> > Ideally, this list should just come from the driver's actual list of
> > modes, but connector->probed_modes is not yet populated at the time of
> > parsing.
>
> I've looked for code that uses these names, couldn't find any. How is
> this being used in practice? For example, if I say "PAL" on the command
> line, is there DRM code that fills in the PAL mode parameters?

I guess Maxime knows, as he added the whitelist?
Reading the description of commit 3764137906a5acec ("drm/modes:
Introduce a whitelist for the named modes"), it looks like this is
more about preventing the parser from taking any string as a random
mode, than about adding support for "PAL" or "NTSC"?

Note that drivers/gpu/drm/i915/display/intel_tv.c defines an array of
tv_modes[], including "PAL", so perhaps these end up as named modes?

> And another question I have is whether this whitelist belongs into the
> driver at all. Standard modes exist independent from drivers or
> hardware. Shouldn't there simply be a global list of all possible mode
> names? Drivers would filter out the unsupported modes anyway.

For standard modes, I agree.  And these are usually specified by
resolution and refresh rate (e.g. "640x480@60", instead of "480p").

But legacy hardware may have very limited support for programmable
pixel clocks (e.g. Amiga is limited to pixel clocks of 7, 14, or 28
MHz), so the standard modes are a bad match, or may not work at all.
Hence drivers may need to provide their own modes, but it seems wrong
to me to make these non-standard modes global, and possibly pollute
the experience for everyone.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
