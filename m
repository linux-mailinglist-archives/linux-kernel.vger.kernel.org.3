Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5325B1157
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiIHAeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiIHAdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:33:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B4D3460
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:32:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy31so34260348ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=yswe5UvynuPJmR7TROq3C4jcUZ2Pkk4MSSkw0eJxwM8=;
        b=RkxT4GcJVYPfiUjCX955mRFINqGAq8VNN+LptWtiNk61ojlzsZX1EH4in57b27Q/LO
         nStb2XViM4M5FE2zTh5UeL8Yq0cwNHwWw0lzxPY5Z4mMTesQbMvgFFVdKGfsapCzipDp
         JcBLTzaFfxQqmZaQswxYLJTgMv1n97y/FFzZHfOs7ewCMYKx9/3y+kLgk+FDt1VsAaaj
         +qyvrpsuSOTexTHnKv6NbvoHXOBnyneEBlNvNbKBvQw+7EFluonjlGWcc7bOVXqgsziq
         KwPlbO4cNU9YW53onLVS7YwSrJTm0Ih/M5fqWDnTXziOeqJkC1QddiOm1NY2oQgFAFCN
         nHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yswe5UvynuPJmR7TROq3C4jcUZ2Pkk4MSSkw0eJxwM8=;
        b=t1ysJMj1FU3vhuTseXstLWlWTtd2N9NqEQUyPYBFLsCch7OQxgyeU2POkR8Eu2wDYj
         B6R1sqMykLHNJtiyMb2tNUMH1LXBS+PDvfnKGrsEAnTrAiLGL5KfeqWt0q21w0g2Gbmd
         rYc3zCeGVR1xCaZ/EtnK/Na5RH1UOU13ay1i8W0N3q/uPq3BurKiXz7EljVw0pYcv8e/
         LJ3DoYcWq9OBvrg1IHRVr9vLwLAzGVu2AUaEPnq8p9JB8FkGPfHcS8EvMmfDgdb/SOds
         RQ7AXIftNHHQ/jVviqazrQl78W9si3wQqD4pG4uKG9o3VCkvE8PneMWKrNqResKakZmP
         MRSg==
X-Gm-Message-State: ACgBeo3y86Dr2wU/DuysHZB4iPAuNeSJ3ZeRPbrg2QG3G5wsL+/uPOBc
        ozdUV4albdxVS37Ly7EwQx7kFHXL6i4W4U3t9nUUCQ==
X-Google-Smtp-Source: AA6agR4uDJOCaTz0FVi+KJnVIm61TPqwATLn4YOd9952FLaly2lRXMCdPQHjmdT6KeTEoCF0irQD994IPBPL2xcbUxQ=
X-Received: by 2002:a17:906:d54e:b0:73d:dcb2:39ac with SMTP id
 cr14-20020a170906d54e00b0073ddcb239acmr4090828ejc.520.1662597147359; Wed, 07
 Sep 2022 17:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
 <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com>
 <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com>
 <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com>
 <CAD=FV=Vg5o-OxyQnemB+XfkGundDA-R31QhkmHJv4RmTMcF2gA@mail.gmail.com> <CAD=FV=Vqs+wPsOUgVK9VyzqDHewBR6HyQgcddQpe9Sd6OG6Nuw@mail.gmail.com>
In-Reply-To: <CAD=FV=Vqs+wPsOUgVK9VyzqDHewBR6HyQgcddQpe9Sd6OG6Nuw@mail.gmail.com>
From:   Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>
Date:   Thu, 8 Sep 2022 08:32:16 +0800
Message-ID: <CAMuczyVbLE0mg9K4NNn=epWE9vVJjFbua=7gDtV+xLGqJ1+Jrw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Doug Anderson <dianders@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Yen <jason.yen@paradetech.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jason.

-Rock

Doug Anderson <dianders@chromium.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi,
>
> On Mon, Aug 22, 2022 at 9:33 AM Doug Anderson <dianders@chromium.org> wro=
te:
> >
> > Hi,
> >
> > On Thu, Aug 18, 2022 at 8:03 AM Doug Anderson <dianders@chromium.org> w=
rote:
> > >
> > > Hi,
> > >
> > > On Wed, Aug 17, 2022 at 8:22 PM Hsin-Yi Wang <hsinyi@chromium.org> wr=
ote:
> > > >
> > > > On Thu, Aug 18, 2022 at 11:19 AM Rock Chiu
> > > > <rock.chiu@paradetech.corp-partner.google.com> wrote:
> > > > >
> > > > > How does T4/T5  impact the real case? We talked previously the T4=
/T5
> > > > > shouldn't cause user impact.
> > > > > Do we have testing data from ODM?
> > > > >
> > > > Please leave comments below the previous comment's headline.
> > > >
> > > > I'm confused. The reason I upstreamed this patch is because this is=
 in
> > > > your application note and you asked us to help upstream it. Now do =
you
> > > > mean that we don't need T4 and T5?
> > >
> > > I think Rock is asking what problems the extra delay is causing. In
> > > other words: why do we care about keeping these delays short?
> > >
> > > The answer is that it affects boot speed and also resume speed of
> > > devices. Adding these two delays here means that there's an extra 100
> > > ms before the user can see something on the screen. That may not seem
> > > like a lot, but those kinds of delays add up quickly. At least on
> > > Chromebooks, booting quickly is always a big goal.
> >
> > While I'm not very happy with this change and I don't really
> > understand why these delays need to be so long, if folks are really
> > certain that we need them and can't make them shorter then I guess we
> > can land it. I'll wait a few more days in case anyone wants to chime
> > in with their thoughts.
>
> I'll continue to grumble, but I did push it.
>
> 55453c0914d9 drm/bridge: ps8640: Add double reset T4 and T5 to power-on s=
equence
>
> I pushed to "drm-misc-next" and not "drm-misc-fixes". It doesn't feel
> massively urgent since apparently we've been without the
> "double-reset" for years and having the extra bake time feels like the
> better way to lean.
>
> -Doug
