Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8235154A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380357AbiD2TiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbiD2TiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:38:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BAD0824
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:34:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e189so9541305oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=E0Q3EZPBzEkcXpZcFDBM/8hh0PQ3g9tg+K9PcJx+iK8=;
        b=j7Mu2qjwlrTIhzG1/SRWrea/G70nXiVi41rs9h824BDxboFT2bYoOlddcsk05eFR3S
         riShkXFHtHqTtwVtScs1+WWrcvU4L8FTNKZBoRrV4kvxdbTkP877tUBxbeGUJFZFmDGf
         7d2pu/cIMZUBtgibQB7fc9ptmJimpmjFtBhUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=E0Q3EZPBzEkcXpZcFDBM/8hh0PQ3g9tg+K9PcJx+iK8=;
        b=s9UaUPNX5e8neH3Q6IY803T0Nhd8EziR3n6Z7gR0upNQHwPQiYiJcsJRXIkbiA+3M4
         61k0NPLqdY2skQUj+jq2qf6lUR5XhgJ+UcxpsP5Z+Y1ttvYcPo2S6uczDHYWErSZlz9g
         8BFuhyM6+2CNbZvzcj/+QRFgsHW0JFm03r2AqIKtCjwtVPJwWkhH2g7gQdi8y+ioin3B
         4rx8S9ptLE4Y9Yv3UhX7kZUd3HNkwH1bYuwM1AJYvgYKbGHDrEi4k8/h+h4VZLqtUNOt
         YxeCMemJeNAXXmn4Pjp1LUaGmH6YaLViEcP1P9WTSmIDwdDRajDnBh4LmZ2UI7mTieYK
         iydA==
X-Gm-Message-State: AOAM531e56Zy51Ii0bEJQ24XEhuM73JaDTW+4DMNvT3ATMIbA+vKL4z7
        m/1RZP8Hxk7ozmUryqdmHH1UomjzIW/DwMN9kdfb3oOM2yw=
X-Google-Smtp-Source: ABdhPJybWFdvd26gPp93ZZnFPwxpgGugVjji5kYbw3wxJ0sB3egmlQ0aK36Ny0i3uauBxbTztZtUxyMYb/Knjvif090=
X-Received: by 2002:a05:6808:1296:b0:325:8fb:68f3 with SMTP id
 a22-20020a056808129600b0032508fb68f3mr437845oiw.193.1651260897935; Fri, 29
 Apr 2022 12:34:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 Apr 2022 04:34:57 +0900
MIME-Version: 1.0
In-Reply-To: <eb2dd599-f38a-57b2-694e-d91aaadda2b5@kernel.org>
References: <20220427203026.828183-1-swboyd@chromium.org> <20220427203026.828183-2-swboyd@chromium.org>
 <CAD=FV=Vtnj+8FYdBSvsud9fGEbo7N1HSjXA3rH3f8FMJsuVR1A@mail.gmail.com> <eb2dd599-f38a-57b2-694e-d91aaadda2b5@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Sat, 30 Apr 2022 04:34:57 +0900
Message-ID: <CAE-0n52M0yfwMnuO9HTCCuv2pU3oWkGuyxOS4x7_gVN5QFFGMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: google,cros-ec-keyb: Introduce switches
 only compatible
To:     Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-04-29 09:35:58)
> On 29/04/2022 18:31, Doug Anderson wrote:
> >>    - $ref: "/schemas/input/matrix-keymap.yaml#"
> >>
> >>  properties:
> >>    compatible:
> >> -    const: google,cros-ec-keyb
> >> +    oneOf:
> >> +      - items:
> >> +          - const: google,cros-ec-keyb-switches
> >> +          - const: google,cros-ec-keyb
> >> +      - items:
> >> +          - const: google,cros-ec-keyb
> >
> > nit: if I come back and read this binding later I'm not sure it would
> > be obvious which compatible I should pick. Can we give any description
> > here that indicates that the first choice is for devices that _only_
> > have buttons and switches (the google,cros-ec-keyb is just for
> > backward compatibility) and the second choice is for devices that have
> > a physical keyboard and _also_ possibly some buttons/switches?

Sounds fair. I have to figure out how to add a description to the
choices. I guess a comment is the approach?

> >
> > I could also imagine people in the future being confused about whether
> > it's allowed to specify matrix properties even for devices that don't
> > have a matrix keyboard. It might be worth noting that it's allowed (to
> > support old drivers that might still be matching against the
> > google,cros-ec-keyb compatible) but not required.
>
> +1

Sure. I'll work that into the description for the first one with two
compatibles.

>
> >
> >
> >>    google,needs-ghost-filter:
> >>      description:
> >> @@ -50,7 +56,7 @@ examples:
> >>    - |
> >>      #include <dt-bindings/input/input.h>
> >>      cros-ec-keyb {
> >> -        compatible = "google,cros-ec-keyb";
> >> +        compatible = "google,cros-ec-keyb-switches", "google,cros-ec-keyb";
> >
> > Feels like we should create a second example?
>
> +1 as well, because it really would confuse what's the difference
> between them.

Ok.
