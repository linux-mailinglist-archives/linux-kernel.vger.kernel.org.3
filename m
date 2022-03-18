Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FE4DE349
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiCRVNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 17:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiCRVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 17:13:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6861A8C24
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 14:12:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z8so10108337oix.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=n34Xs2LUJxel1XU83dIKxQOsnVS224E+z08R602YCdU=;
        b=EvQpHpyMC77rLLEvn9MpsqWL0o8A2T7VFQvNGpeLOEH0VGsDX41YNdLPSvHrSXoRo6
         8X7HcCJbTswjPPlHmbnBc/e+c/N9LwooWCRKufVh9wwI7lJkss7MWzi9Yb8zmdIuwAsO
         JCDIrfe5wxbXu5CDc1/0OP4wu/zSOG7Nsc7DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=n34Xs2LUJxel1XU83dIKxQOsnVS224E+z08R602YCdU=;
        b=kWylai9jvvRr8MZkmc5IvN1tDBtLLn5GHfCx0ht1JLy956l9EhT4lscO5LrvHamA5Q
         BRe8nfqLb7owz7dc7N2/h1+wuQ67cDo9uCzZsDFL9V5S+00j343F3LZ4SuMrfLjQbah5
         Aeq6E0QZ5WG3R907q6b61MIb1RpSPu5hkUi6MotyKND+rOP6osjtaKsBtg4/hJS6HXCX
         jXQ0cf2M+oCTGpHcT9QG+Bgqiy6zqRqdH02eEFaSEdmToFByzQbZC25Iknd4o74jEFgT
         qP1TfqVXYFA+kJtw9/raz6u+LnOoIC3/icY8f1GWDsg+fgoHnSN/PyH9lZW0E8eEhOwk
         Y0YA==
X-Gm-Message-State: AOAM5322GkyDvzPbkJuBVZpFAarsOqA/8ap3T+zyMx5133LxVxev6w9b
        uVo88Xcc/Yu6795fkx3eEl0cE05gG28CbxSogha2VqYYi1g=
X-Google-Smtp-Source: ABdhPJw0zCFmhg5T+KaHMIkI9yocntmnv6XcFAgnwKNk6tLkUngfx+sEnsZubJNjXUqla/UYhwzVdjmiB7FhdH0czNU=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr5152331oif.63.1647637928460; Fri, 18
 Mar 2022 14:12:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Mar 2022 14:12:08 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WV+rssDpUdq0fVuVKf4b7DwTsFgodAX8wi-eLEoxTa3g@mail.gmail.com>
References: <20220318015451.2869388-1-swboyd@chromium.org> <20220318015451.2869388-2-swboyd@chromium.org>
 <CAD=FV=WV+rssDpUdq0fVuVKf4b7DwTsFgodAX8wi-eLEoxTa3g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Mar 2022 14:12:08 -0700
Message-ID: <CAE-0n52Cy3KKUQBuzMUE0+r7DfQKPAFRnYijQHmuA5safhw6mg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: chrome: Add ChromeOS fingerprint binding
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-03-18 13:49:05)
> Hi,
>
> On Thu, Mar 17, 2022 at 6:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Add a binding to describe the fingerprint processor found on Chromebooks
> > with a fingerprint sensor.
>
> It might be worth mentioning that previously these fingerprint devices
> were described using "google,cros-ec-spi" just to provide context?

Sure I squashed it in.

>
>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Craig Hesling <hesling@chromium.org>
> > Cc: Tom Hughes <tomhughes@chromium.org>
> > Cc: Alexandru M Stan <amstan@chromium.org>
> > Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/chrome/google,cros-ec-fp.yaml    | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
