Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7938A57AA08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiGSWtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbiGSWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:49:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B9560532
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:49:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k30so21556369edk.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7PK6D+h+8OxcoWXpNYlUYth9TT/PlFLZBalPC3jKAK8=;
        b=EHnKpW8uMagKdXxRMch4+SfbCXYeOqLlfUQ+anvZ2PvnHM8fiRWUFq5iPyxi9IJKiD
         77b7i9+MJjJ7vLhXCmbjGaD98rqpdTmcS2w6p0mubl9uVAc2ifyn2SPc5z1cEP0D5S75
         pUqCQLKhrJ3SeMLUWYEPqxUKjsMtBBkPB6494=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7PK6D+h+8OxcoWXpNYlUYth9TT/PlFLZBalPC3jKAK8=;
        b=i8bY3KwKawD7hYVERDU7dBbVErT8NMdJTyTjzC8cF2q8sRoT+f/1r4ke5hz/Na7qst
         qOsRs/w4/mkA84x1cNsCaKfZcpHYkLT4xHVcrsFky7DQh5g0s/6Rw3x6ouOs5hnOTBm9
         KsScznkPqRMrM4qsKSbPj2cewX1mAdHVKEGhISW9LewKzgrSG9cQOMB0pEp3NqHK0TK4
         5g5H8Us7cgLX1UEdFHQwYIKGKnE/hcGnzo5kgIrPI8Z5LKz649lB67p64Lw2jDssiahR
         4QE6UuWrWQ6K6MBa4tpBN54wpGHLD4HO769yUduk0v+WeefczmmxaSb1MgJL5pqyNYZ/
         WHhA==
X-Gm-Message-State: AJIora8R5RbQrfmL/dvhLlqcU32Gpq+hMMJouFUTvHe3bBwVMzprHiHk
        UFiGG0g2CpJ/6DBD5RXbg6V+gMKujGu3ycWXDrk=
X-Google-Smtp-Source: AGRyM1vJvtaMCdrAohRdkjqBBWTcnHKjViey3zFzEpRt5YTPTsE7peck6pf/yyrhOdVQpOqS0yCR3Q==
X-Received: by 2002:a05:6402:11c9:b0:43a:b054:52ba with SMTP id j9-20020a05640211c900b0043ab05452bamr47688418edw.344.1658270982430;
        Tue, 19 Jul 2022 15:49:42 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id dx24-20020a170906a85800b006fed93bf71fsm7313423ejb.18.2022.07.19.15.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 15:49:39 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so233519wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:49:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8d:b0:3a1:2e4d:1dd2 with SMTP id
 f13-20020a05600c4e8d00b003a12e4d1dd2mr1180998wmq.85.1658270978565; Tue, 19
 Jul 2022 15:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220719203857.1488831-1-nfraprado@collabora.com>
 <20220719203857.1488831-4-nfraprado@collabora.com> <CAD=FV=X0End8u3nNNXSMVhuJo0KWmJYRNg3yeC9yQ+5bLKTmYg@mail.gmail.com>
In-Reply-To: <CAD=FV=X0End8u3nNNXSMVhuJo0KWmJYRNg3yeC9yQ+5bLKTmYg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Jul 2022 15:49:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VtfnrqUOACfnVfkZE20O4diPQpHYYC5p1iX3vt9ESPYg@mail.gmail.com>
Message-ID: <CAD=FV=VtfnrqUOACfnVfkZE20O4diPQpHYYC5p1iX3vt9ESPYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel-edp: Fix variable typo when saving hpd
 absent delay from DT
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 19, 2022 at 3:45 PM Doug Anderson <dianders@chromium.org> wrote=
:
>
> Hi,
>
> On Tue, Jul 19, 2022 at 1:39 PM N=C3=ADcolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > The value read from the "hpd-absent-delay-ms" property in DT was being
> > saved to the wrong variable, overriding the hpd_reliable delay. Fix the
> > typo.
> >
> > Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s pro=
bed by EDID")
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 152e00eb846f..b3536d8600f4 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -738,7 +738,7 @@ static int generic_edp_panel_probe(struct device *d=
ev, struct panel_edp *panel)
> >         of_property_read_u32(dev->of_node, "hpd-reliable-delay-ms", &re=
liable_ms);
> >         desc->delay.hpd_reliable =3D reliable_ms;
> >         of_property_read_u32(dev->of_node, "hpd-absent-delay-ms", &abse=
nt_ms);
> > -       desc->delay.hpd_reliable =3D absent_ms;
> > +       desc->delay.hpd_absent =3D absent_ms;
>
> Well that's embarrassing. In the end I never used any of these
> properties for anything shipping since HPD was always hooked up on
> later boards and the only board that needed "hpd_reliable" never ended
> up switching to the generic "edp-panel".
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll apply this right away to drm-misc-fixes.

ef2084a8388b drm/panel-edp: Fix variable typo when saving hpd absent
delay from DT
