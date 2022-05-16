Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD2528DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbiEPTc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiEPTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:32:26 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350D20F4E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:32:25 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so21497275fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=J76YW6Wdlh5XkWvWlzC9gchLSjC+e1zZeLVaSHsN2OQ=;
        b=d9CQktVULUaK6nXZ/QzkDqI6+WbJO6m8jOyWYhqDLe6AiSL43teR7zxEi4j/IT7G28
         i0FvQpprMbKCLYaRtRu6xtCLzfxz4D+9LtFXrKoj5wr4IU1XrPGKgaW1ckZhsBjDGdDf
         NM0oeFrayV7Db9eD5+OCdlhAGV0efJ6ydoh70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=J76YW6Wdlh5XkWvWlzC9gchLSjC+e1zZeLVaSHsN2OQ=;
        b=vfAYqTrA0sPRGfwDzjRjhTll+TL+/1kKg5CD2kassLKnlRB3ZPKXi7VGjEIUjlH52U
         965v8+Dt2u7Y+9jV5kk2k/qmD+sgg1qOb1TroRGU5y7Zck51kNVl7YZZqSBtFxWSCp0c
         u75/1e+SF+i5YTfHmIImBcfsKcZAxfF4xAubz0p3G1baMNty/GcilhSfr2H1XzApRIRT
         fPL87AxpdjoG5hFrY6vxShYqZoCbSxb2QNkWXMPoKRTA0oLn30OxF+8ZJe/RyXURNPOc
         uvt0byC+OGG3T+3faH1gTdFxjy5rXo1M9h7/xFrkYjTmDZWSG7cj62ZrMoNM2uQpQrkC
         hNpw==
X-Gm-Message-State: AOAM533tDr1yotZOPKgaf1aNIrXJfkjo0Oh0qOoub/1xHC9/5CP3J33u
        Z2tBfDJ/ukEr31HbCq0ykmdfwVrTbq0HoqsRJarP0Q==
X-Google-Smtp-Source: ABdhPJzJI92I4I96rEOhysGBJGD/K/e+0SB9aptCslRQ20O4rAnvh5bNk0UoYZG3ZWuAynzOHNF45aylQc9TEohySps=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr880663oap.193.1652729544662; Mon, 16
 May 2022 12:32:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 May 2022 12:32:24 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XfmU1GhXZPvUMoh9dqs8iei6s+0gu6Mve-aQ33A+7m3g@mail.gmail.com>
References: <20220512013921.164637-1-swboyd@chromium.org> <20220512013921.164637-3-swboyd@chromium.org>
 <CAD=FV=XfmU1GhXZPvUMoh9dqs8iei6s+0gu6Mve-aQ33A+7m3g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 16 May 2022 12:32:24 -0700
Message-ID: <CAE-0n53nqrSmxZsnReE=yVzN0OkGw8BaNqFxX6mcRkJyxXyyJg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: cros-ec: Reorganize property availability
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-05-12 16:44:44)
> On Wed, May 11, 2022 at 6:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          not:
> > +            contains:
> > +              const: google,cros-ec-rpmsg
> > +    then:
> > +      properties:
> > +        mediatek,rpmsg-name: false
> > +
> > +      required:
> > +        - reg
> > +        - interrupts
>
> Is it worth having an "else" clause here? to explicitly make
> "mediatek,rpmsg-name" required for mediatek?

I don't know if mediatek,rpmsg-name is required for a generic
google,cros-ec-rpmsg. I would guess it isn't, because it's a vendor
prefixed property. Maybe it could look at the parent node property to
see that it is inside a mediatek remoteproc node but I'd rather leave
that to future work.

>
> In any case, this seems right from my (albeit) limited yaml knowledge
> and seems like an improvement.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
