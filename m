Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E959C50D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiHVReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiHVRd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:33:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162B1F2C4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:33:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d21so3330332eje.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i/ov1Fd0UK/G3QEuwXc0gcm83RKp3BYtJaImDo4MAf4=;
        b=hzycMOPSp8UyNEagfTDlZw2qlyUREyCmxKqD2S30ANxSwRUEghi32rK6rpJbv+PzA4
         2+O7uODbHg/27AKfr0gVEamTvKk75ZkAs5aG9j+6bRnvDvUWMeozTOEdKvuFBve7arJg
         j5WKWOtoAxGmRpRN7WmCQJ9720ExQK98nTUCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i/ov1Fd0UK/G3QEuwXc0gcm83RKp3BYtJaImDo4MAf4=;
        b=nBOJHs5C3+YXVY2sh8hdyt3e7yZPjphupnwUgLQN9E8l6FYNd8RqlTNeQis0JK1Lx8
         gECfEmWZbezXubsFzInFfMMawtf1uFcnx3F17BrtvKIEViJf7KnP5F1mdhqIa6GfkOTV
         NG/NPr0olR50xXMBhxvqrA6KrwNTZKNKB91nu3ZU7n+rifb0S5ad3p4cWjsYHB1Numyx
         kZplVyBLX86Gdcw3h6wxq94ApHzE6WTwwzV9Dvh57VaHQWzF7fm5rXCZ2zpoULBpf+8t
         gt/FrYg2VpE1DcQq6ewhdg2VDYz34DbJjEh266wMArwlEhCdxMiY5D3W/LhKyDFgD+4J
         Pv4Q==
X-Gm-Message-State: ACgBeo2u+UgIYCbdQmmtjq1dj4H9CrgylWWvQNU8UXS39LEC6DEUKKeE
        fcO/6Zkj/BaNrCON/1ZlXlBA1M6H14jTLrmc
X-Google-Smtp-Source: AA6agR5InuxQRs/QqPhoiX4mark0KyN9U9p3+DIgq/mOG/qKUlRtO3l4bTwZthqR8zEZEmVW+VXIhg==
X-Received: by 2002:a17:906:99c1:b0:6fe:b01d:134 with SMTP id s1-20020a17090699c100b006feb01d0134mr13125411ejn.598.1661189635561;
        Mon, 22 Aug 2022 10:33:55 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0043bbb3535d6sm30269edx.66.2022.08.22.10.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:33:53 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id ay12so5962260wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:33:53 -0700 (PDT)
X-Received: by 2002:a05:600c:5008:b0:3a6:1cd8:570d with SMTP id
 n8-20020a05600c500800b003a61cd8570dmr12921599wmr.57.1661189633154; Mon, 22
 Aug 2022 10:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220711075202.21775-1-johan+linaro@kernel.org>
 <YtpyeCHojFovBKxv@hovoldconsulting.com> <YwOGCPFTx0+MNfN2@hovoldconsulting.com>
In-Reply-To: <YwOGCPFTx0+MNfN2@hovoldconsulting.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Aug 2022 10:33:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRjpbeMnh_dtLh1hb-zfWOk6UJwqFBr+otk=sq9vjm3A@mail.gmail.com>
Message-ID: <CAD=FV=XRjpbeMnh_dtLh1hb-zfWOk6UJwqFBr+otk=sq9vjm3A@mail.gmail.com>
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

On Mon, Aug 22, 2022 at 6:35 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 11:48:40AM +0200, Johan Hovold wrote:
> > On Mon, Jul 11, 2022 at 09:52:02AM +0200, Johan Hovold wrote:
> > > Add an eDP panel entry for AUO B133UAN02.1.
> > >
> > > Due to lack of documentation, use the delay_200_500_e50 timings like
> > > some other AUO entries for now.
> > >
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >
> > Any comments to this one?
> >
> > It looks like it hasn't shown up in the dri-devel patchwork and just
> > want to make sure it isn't lost.
> >
> > Rob Clark mentioned something about a spam filter on IRC.
>
> This one still hasn't been picked up.
>
> Is this something you can do, Doug? I noticed you applied a couple of
> patches to this driver recently.
>
> Or who is really responsible for this driver?

Officially it falls within this section of maintainers:

DRM PANEL DRIVERS
M:      Thierry Reding <thierry.reding@gmail.com>
R:      Sam Ravnborg <sam@ravnborg.org>
L:      dri-devel@lists.freedesktop.org
S:      Maintained
T:      git git://anongit.freedesktop.org/drm/drm-misc
F:      Documentation/devicetree/bindings/display/panel/
F:      drivers/gpu/drm/drm_panel.c
F:      drivers/gpu/drm/panel/
F:      include/drm/drm_panel.h

...and then you just have to know that if the "tree" is drm-misc that
it falls under drm-misc rules. That means that anyone who is a
drm-misc-next committer can commit it.

I've been trying to keep an eye on panel-edp ever since I split it out
from panel-simple, though. I'll post up a MAINTAINERS entry to try to
make that more official.

In any case, I've landed this on drm-misc-next:

ee50b0024408 drm/panel-edp: add AUO B133UAN02.1 panel entry

-Doug
