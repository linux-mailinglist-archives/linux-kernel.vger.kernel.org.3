Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74659C58C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiHVR4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbiHVR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:56:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506A4455C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:56:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z2so14968909edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ruv6/x2zxiBtuZTzNW3ZFqdO19u7NmO0/moPhHRrrEI=;
        b=bQCdaGEcjhM1WRYlDQ8CWkjVbQtO0d4RmkzIk66Y0ZAoAu6Ebor9tE8stwHQSPPtnx
         MyTnjWvWjBP1rmlw1Cb3MXkE9/riCIzTMqENjyeUPS7bGlPdAspMKUSfWkpVMcOdwLhb
         TWb3lUIjvCnporY09y1Z38hmrv/CJswmP9VcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ruv6/x2zxiBtuZTzNW3ZFqdO19u7NmO0/moPhHRrrEI=;
        b=RWJpwvQbuiPWumkAMs6tNeDPTiwjgo/7AzpN49uBpj2ZUFMe3cGmtn1mpl8IeRZ+SB
         r4weoqXCqzocG5CchBcb84TZUiN4LTLAQU/bQVX9cxVGkuF9jr4fDsNDHya9ZX/osa1/
         5r+SHDpbEX60wpGY1v/DJcqy6dDNQQAFaxEMLzSCVZVktqd+AEcgz3nm8wIq0x+7PGi7
         7wUJQBPKtNBMsr3ddlOKkpMQG2QJTxxvntRQh/5fTsghJaw9K0IgCTPEq7qK5Urr0W2S
         hrosQWnNgt6SZdsrIOZ594q4kEgRIiDU2n0UT57D09qVb57N60eCS1KWxqnrE80Ag7WT
         HreA==
X-Gm-Message-State: ACgBeo3oi/XUZPk8CR55DFEtEurGzHmwoEmvKIxfvxotVkuVuKnXCeTf
        jjRBFqe6bXUPok8d6KtGjpF9yq9eYiUcBTH8
X-Google-Smtp-Source: AA6agR5X6E+g/y4Rv9ockUaMo2ZCUrgu0im1amUgJ3aAPkD80IQ5/EVu8Vu0tLpSOyyOY27zr7JwQg==
X-Received: by 2002:a05:6402:3509:b0:43e:d80b:44a8 with SMTP id b9-20020a056402350900b0043ed80b44a8mr262153edd.255.1661191007545;
        Mon, 22 Aug 2022 10:56:47 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ss28-20020a170907c01c00b00730a18a8b68sm6453255ejc.130.2022.08.22.10.56.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:56:46 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id k9so14203379wri.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:56:45 -0700 (PDT)
X-Received: by 2002:a5d:6881:0:b0:225:28cb:332f with SMTP id
 h1-20020a5d6881000000b0022528cb332fmr11427575wru.405.1661191005432; Mon, 22
 Aug 2022 10:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711075202.21775-1-johan+linaro@kernel.org>
 <YtpyeCHojFovBKxv@hovoldconsulting.com> <YwOGCPFTx0+MNfN2@hovoldconsulting.com>
 <CAD=FV=XRjpbeMnh_dtLh1hb-zfWOk6UJwqFBr+otk=sq9vjm3A@mail.gmail.com>
In-Reply-To: <CAD=FV=XRjpbeMnh_dtLh1hb-zfWOk6UJwqFBr+otk=sq9vjm3A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Aug 2022 10:56:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vzi-1XhGPpUE7=CDF6V36JkUVuOwX2+-r4UhHWOKO9Mg@mail.gmail.com>
Message-ID: <CAD=FV=Vzi-1XhGPpUE7=CDF6V36JkUVuOwX2+-r4UhHWOKO9Mg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: add AUO B133UAN02.1 panel entry
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 22, 2022 at 10:33 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Aug 22, 2022 at 6:35 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Jul 22, 2022 at 11:48:40AM +0200, Johan Hovold wrote:
> > > On Mon, Jul 11, 2022 at 09:52:02AM +0200, Johan Hovold wrote:
> > > > Add an eDP panel entry for AUO B133UAN02.1.
> > > >
> > > > Due to lack of documentation, use the delay_200_500_e50 timings like
> > > > some other AUO entries for now.
> > > >
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > >
> > > Any comments to this one?
> > >
> > > It looks like it hasn't shown up in the dri-devel patchwork and just
> > > want to make sure it isn't lost.
> > >
> > > Rob Clark mentioned something about a spam filter on IRC.
> >
> > This one still hasn't been picked up.
> >
> > Is this something you can do, Doug? I noticed you applied a couple of
> > patches to this driver recently.
> >
> > Or who is really responsible for this driver?
>
> Officially it falls within this section of maintainers:
>
> DRM PANEL DRIVERS
> M:      Thierry Reding <thierry.reding@gmail.com>
> R:      Sam Ravnborg <sam@ravnborg.org>
> L:      dri-devel@lists.freedesktop.org
> S:      Maintained
> T:      git git://anongit.freedesktop.org/drm/drm-misc
> F:      Documentation/devicetree/bindings/display/panel/
> F:      drivers/gpu/drm/drm_panel.c
> F:      drivers/gpu/drm/panel/
> F:      include/drm/drm_panel.h
>
> ...and then you just have to know that if the "tree" is drm-misc that
> it falls under drm-misc rules. That means that anyone who is a
> drm-misc-next committer can commit it.
>
> I've been trying to keep an eye on panel-edp ever since I split it out
> from panel-simple, though. I'll post up a MAINTAINERS entry to try to
> make that more official.

Posted a patch to add myself in MAINTAINERS:

https://lore.kernel.org/r/20220822105340.1.I66a9a5577f9b0af66492ef13c47bc78ed85e5d6b@changeid

...though I had a brain-fail and didn't CC anyone on it. ;-)

-Doug
