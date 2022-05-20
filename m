Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0452F4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353564AbiETVGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353567AbiETVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:06:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B756EC7F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:06:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f21so4073736ejh.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMT8P8zbRfIHS8dDyJlM5Ic+rmYHYWgIa37DnbflAwE=;
        b=OmDFcvlzW70+WKeNegTYuDop8HPEyPvaHb2R4UR+jYAORC80RbpoYFWn8oCQE2tMGF
         vEtq78hodjiIWMwDJXJ0S5GZ7bWf4EY1GEx+VPBjrrs8uN+fxVsbI5lcMg33Mtr3OdaS
         W196e1Lj6N0eOtybtKFZoydcm1332KktdJdxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMT8P8zbRfIHS8dDyJlM5Ic+rmYHYWgIa37DnbflAwE=;
        b=Tke67gCXJMSakoSP3QAT2RAylFEe888P+NQ5xZq8acVx+ilmYPnTqnJo+7uguJp4cs
         v2P1p0oiKmwi6w8zLA7imaiD59yjEYgRpdIyr4ETk+begNsinkB7fscIXTohIMslytmJ
         h0JErxpiqAe/77nu8Jfko8icwfJTb5jKNDTBIKxCKJkKdDG3rXaO9IIQDGwGSMY7i5BF
         q0V826SUeE7UiehAYpCk2qK7zFMAHXsA7S4N/x/AGxFl/n7TP1B7H3VSo0Eav/ElJUtw
         BKR2No6sbXG804z520aplua21LpUwpTkVNRDRBDzT6X6IICiqDzYaVYGK9gGC/VQgFAc
         w9iQ==
X-Gm-Message-State: AOAM533wnMPX1P1iZhI7ZakG1KANhJjNZHJK4IEhe5gHFaLYSBY21YuN
        myWTymDuXO3OIFlnEbPwlrlH6iBH9Xezi8ad8AA=
X-Google-Smtp-Source: ABdhPJw8oX7P0qJ76JEaZb7VKnqF1n/8TPvoGz6YyQ0kjdrPkpTSwrr/j3axc/NoXBisGseM2ArvHw==
X-Received: by 2002:a17:907:7d8d:b0:6fe:b83f:802b with SMTP id oz13-20020a1709077d8d00b006feb83f802bmr1803330ejc.187.1653080762216;
        Fri, 20 May 2022 14:06:02 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id h6-20020a1709070b0600b006fe8c2b66e4sm3152096ejl.135.2022.05.20.14.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 14:06:00 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id v191-20020a1cacc8000000b00397001398c0so7470156wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:05:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3482:b0:397:caa:9e68 with SMTP id
 a2-20020a05600c348200b003970caa9e68mr10274850wmq.118.1653080759084; Fri, 20
 May 2022 14:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220520161004.1141554-1-judyhsiao@chromium.org>
 <20220520161004.1141554-2-judyhsiao@chromium.org> <CAE-0n53e0bq_MbfgZYdxatP8CpGVMKkBKOnSDOV+MvbBFB6wOA@mail.gmail.com>
 <CAD=FV=VX_dr+hrNEGyC7GxcYcbMeL-uMaVLEJ5EgKnb76HVoDA@mail.gmail.com> <CAE-0n53x6KJPz_Jc7terJB2AtLAHFo4kKZ98kAbUi8xckeCs_A@mail.gmail.com>
In-Reply-To: <CAE-0n53x6KJPz_Jc7terJB2AtLAHFo4kKZ98kAbUi8xckeCs_A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 14:05:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wr=tUb_Z2sgsJFE8oMykkmcKd+XUxmCohbgxOsvmVGoA@mail.gmail.com>
Message-ID: <CAD=FV=Wr=tUb_Z2sgsJFE8oMykkmcKd+XUxmCohbgxOsvmVGoA@mail.gmail.com>
Subject: Re: [v2 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf
 settings for mi2s1
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 2:01 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2022-05-20 13:39:21)
> > On Fri, May 20, 2022 at 1:38 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Judy Hsiao (2022-05-20 09:10:02)
> > > > +};
> > > > +
> > > > +&mi2s1_sclk {
> > > > +       drive-strength = <6>;
> > > > +       bias-disable;
> > >
> > > Is there an external pull on this line? If so please add that details as
> > > a comment like we do for other external pulls.
> >
> > Actually, I think they are output lines, which is why they have a
> > drive-strength. I think for output lines we don't usually comment
> > about why we're disabling the pulls, only for input lines?
>
> Ok makes sense. Even for an open drain signal it would be an "input" so
> that rule still applies?

I think open drain is mostly used for bidirectional signals, like i2c
lines. In that case then you're right, you can have a drive-strength
and a pull. ...I thought i2s was not bidirectoinal and not open-drain,
but I certainly could be wrong.

-Doug
