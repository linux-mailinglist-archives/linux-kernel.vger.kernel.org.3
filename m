Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0124F8B12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiDHAX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiDHAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:23:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149116C0A0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:21:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n6so14041444ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AEJnP5mTsYddtMXtuB9PzpAwm62Zr/93tws7knCoTY=;
        b=FrYI2nBdk+yG/OOXXygzXyvL+ZpcWJWtKe8unV3SbCy1rXBwNnk84WeXyNP/2VlDJy
         Kg/uBh0NPlU2+DivSPdwyS8dsLdPzD8+y5xmEtYYC5jD30jJr5S+ozejI/3/UdKogkht
         sWSHEixJSYchJR9gauZlQDTuFx098SCzhXo+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AEJnP5mTsYddtMXtuB9PzpAwm62Zr/93tws7knCoTY=;
        b=kqPswapqbc4I2gpnfeXYteR7qevnzjLnUtG6H3ZG3ugPc98ackbeIRdYyX6Xe+hSV6
         n6DvPSwpdJ9EjLeIbpvqO646WhqVBQVugJWaZGx8bCcW9u/tw1Zm0oQYncHSh/rppPV7
         w3Dv+zN1hKet7YU5vAv56Vp3hlZmBq2y/Er9GCcGRRYmDoyEwMPwAoqp4iDw2wwuPR4h
         hP5Avtk1lpT5BfczZ+FoxmndM0xJk6VGA6eRmSeaoQ/s5qd61bYLiIeWsq+3zebX5l7k
         pece7RzQnOi388MUBZjhSBCefgdew9zQVwII/AsAJVwTVQlW7NGzY2+Xa8XQPluYeJ51
         z7tw==
X-Gm-Message-State: AOAM531gE3Bs1k2mx7y+0i89mtu80InAMvVXVG4+7w1Pcn5v5eNFw3f6
        497mdfqUObuFRZO6Dhy13h5q+Ro5VjIVP6FLq3I=
X-Google-Smtp-Source: ABdhPJykfaLzH5EN5GzXNWfluoyfpgmY+WSMpNI4cjKY15n1374yS/wpAUBahCbHrZ3qRD+favcLiA==
X-Received: by 2002:a17:907:7fa9:b0:6e4:ba80:3799 with SMTP id qk41-20020a1709077fa900b006e4ba803799mr16242772ejc.564.1649377281306;
        Thu, 07 Apr 2022 17:21:21 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090626da00b006e7cb663277sm5691921ejc.90.2022.04.07.17.21.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 17:21:19 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id m30so10574786wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:21:19 -0700 (PDT)
X-Received: by 2002:a5d:568e:0:b0:207:8d1a:46c6 with SMTP id
 f14-20020a5d568e000000b002078d1a46c6mr3186227wrv.422.1649377278855; Thu, 07
 Apr 2022 17:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
 <392b933f-760c-3c81-1040-c514045df3da@linaro.org> <CAD=FV=W4PYK-t607yjRbfjDjjEZX0KdgHDRukw_vSH8E8EDH6w@mail.gmail.com>
 <CAA8EJppt9XONbgtKfmHmN+==QNqiVJeb8GKJFdZm=yyY-tgmHQ@mail.gmail.com>
 <CAD=FV=U5-sTDLYdkeJWLAOG-0wgxR49VxtwUyUO7z2PuibLGsg@mail.gmail.com>
 <CAA8EJppgfYgQjG8A4LsR-1wmBj3Ku3eO8cKfAYhxjWXL7e3eHg@mail.gmail.com>
 <CAD=FV=V=a1CnT8fqTJR40WoS3BaDQ3xZ=HnHVHqZh=MEmVUZBA@mail.gmail.com>
 <3e5fa57f-d636-879a-b98f-77323d07c156@linaro.org> <CAD=FV=Uibu-kZyix7K4_WVc-+C8xpzTqU4WFy7O=6sukMZrX5g@mail.gmail.com>
 <MW4PR02MB7186245772DAC3E04FA8D1C0E1E69@MW4PR02MB7186.namprd02.prod.outlook.com>
 <CAD=FV=Wk3U7_bVdiCPp8iQ4bcCA_Botemu4pwHeRtgBa3Xk6KQ@mail.gmail.com>
 <c4f086ce-c56f-f7c9-4092-7f2432330d50@quicinc.com> <CAD=FV=UmU_BVUaL_X75yOEvQPtGUBTR5-jiVWBHq7uSRt6HM4Q@mail.gmail.com>
 <225d2c0a-42ec-28ad-688c-e7e9e2035ee1@quicinc.com> <CAD=FV=W=WjSACHvRDFBnkLUp-LU2c4XMu3=FTzTx=zexNF5PAw@mail.gmail.com>
 <CAA8EJpqLZ9up4euGEbhf5QyBqm4tJuLcHi7D+0Si7ak9Jej52w@mail.gmail.com>
In-Reply-To: <CAA8EJpqLZ9up4euGEbhf5QyBqm4tJuLcHi7D+0Si7ak9Jej52w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Apr 2022 17:21:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XwOzsRf7RnvyBjr5TtedMhC0LJFKoK9tp-kw1eEyuJmQ@mail.gmail.com>
Message-ID: <CAD=FV=XwOzsRf7RnvyBjr5TtedMhC0LJFKoK9tp-kw1eEyuJmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 7, 2022 at 4:46 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > The way I'm arguing it should work is that:
> >
> > 1. A whole bunch of the DP init code should move to the DP driver's
> > probe function. This includes parsing the DT, acquiring clocks,
> > getting a handle to our PHY, and IO mapping registers. As far as I
> > know, there's no reason to wait on all the components being probed in
> > order to do this stuff.
>
> Yes. And that's one of the reasons I tried to stay away from the DP
> driver. Each time I open the source code, my hands itch to start
> refactoring the code.
>
> >
> > 2. Once we have done the above things, it should be possible to do AUX
> > transfers, correct? ...and then we can populate the AUX bus from the
> > probe function too.
>
> No. In the DP case the AUX bus is inaccessible until the dongle is
> plugged (see all the HPD handling, phy_init()/phy_power_on() is hidden
> somewhere in that path)

I guess my thought was that in DP you could still create the AUX bus
at probe time. Then for DP you just return an instant "transfer
failed" from the AUX bus if HPD isn't asserted. For eDP (as discussed
elsewhere) when we try to do an AUX transfer then we delay until HPD
is there.

So we can still acquire resources (clocks, PHY, io maps, etc) at probe
time for DP and create the AUX bus, right? It will just return
"-ENODEV" if HPD isn't asserted and you're DP?

-Doug
