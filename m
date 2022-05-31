Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021DB539509
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbiEaQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiEaQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:41:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24CDF91
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:41:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so8790965edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2w/DuMKGkCId0IhL+87Rlw/4m47o1ovVQT6DsHSgIE=;
        b=CjjCxMkG9BjYxKYLC9ComQadGerm0pG7maothy8LMYDfIBQ12DEXm8VahwPd0mZNx8
         v3YImB6YIt4mYYLyzpggxjSKvsKNJF/G32PfqlVOhn2iPGRIukb0lSsOPrkKTbno6a2F
         NHCRaxjzPZuwuhN/j0E7W+vBxTRDLSGYdAdCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2w/DuMKGkCId0IhL+87Rlw/4m47o1ovVQT6DsHSgIE=;
        b=NrVeRdWp6sC8W4kVe7Jd2OA9lgcqxlb4r4DwdDAoMESwg1vqd8MbbGlHCa6wDsxCbo
         bJ1ZovHWw23RXlr4edr+OOV/kn161beI4Wj3STs25roKSD4/iP/wvAhnBmzLbJyoT5V2
         UzvTjUYQKRDY0VwGL6UHvcUajwtI1TN2SLZITDLzwHXEeXlpO6lZWDRUHN3Hb1wV9qNv
         8GDIVVosc83W0e3UO6zhAhTMOH9b4eDGXSlz7syXxfI1UVXcLc9ZuYVBthl8T2I735YY
         socwX9aFe54a3gMlyHxp4ecENg7ZaG3YyB4VgHgKGHLuADSd9D+rSp+NwkeUAmbOyBOR
         iZkA==
X-Gm-Message-State: AOAM531dDrjoz6paqtqukfj/C6YrIw4lBu+YEToyllpyQ2von4GLs5Eu
        wSR7gstPseCW7QGI171nY448+MoOyZPkDAkE
X-Google-Smtp-Source: ABdhPJyA8zzMjQxs0vjZysZwTD2SGAZmQkQussctEHBG/mKCgAD0Z64D0g29P0KXKyUCWIdoQC0Nlg==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr64509909edb.273.1654015302534;
        Tue, 31 May 2022 09:41:42 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402348500b0042ddd08d5f8sm2382392edc.2.2022.05.31.09.41.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 09:41:41 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso1540790wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:41:40 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr24513934wmc.8.1654015300146; Tue, 31 May
 2022 09:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr> <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
In-Reply-To: <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 May 2022 09:41:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
Message-ID: <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Jani Nikula <jani.nikula@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 1:04 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As an experiment: what kind of results would we get when looking
> for packed structures and unions that contain any of these:

Yeah, any atomics or locks should always be aligned, and won't even
work (or might be *very* slow) on multiple architectures. Even x86 -
which does very well on unaligned data - reacts badly to sufficiently
unaligned atomics (ie cacheline crossing).

I don't think we have that. Not only because it would already cause
breakage, but simply because the kinds of structures that people pack
aren't generally the kind that contain these kinds of things.

That said, you might have a struct that is packed, but that
intentionally aligns parts of itself, so it *could* be valid.

But it would probably not be a bad idea to check that packed
structures/unions don't have atomic types or locks in them. I _think_
we're all good, but who knows..

            Linus
