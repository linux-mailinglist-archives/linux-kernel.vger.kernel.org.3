Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D840F51ABCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 19:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359048AbiEDR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359482AbiEDRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:44:21 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BDD532D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:07:33 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-deb9295679so1804611fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XsBuK9C0iTZ23AvndsVmxmsweL3NkKIVBO/JwZ4kCTI=;
        b=HicliRiyqx34J8hoRZNyl8nYFnYudMYsszZHmDL17H5hi9vPEYGzOyzPs6BR5Pf5kO
         rBpUH2oNEE4Y4kgNyxxsvzyEXS/GeLs3pWr9Vdrr//YevpnvzD+eaWLcTeRg7aHoHJtf
         qmDSMskOLukbvAdTNrra//dYt366Ni/xN36gJogRiKRMhVrEnNZR50LASXSAD/U9zbAJ
         o7uvjn04PXd/FL9jVgGi0ncdDbjomr+FGZP91wN4hIJbJOnQMnyUDaZems1B1CPxWI7H
         W9jJdGHFTUbgkcxxCT5VqA7usqgnpdK268BTLf74J0PSu6hvcGONIkUQXWbo5dm6K6bo
         bqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XsBuK9C0iTZ23AvndsVmxmsweL3NkKIVBO/JwZ4kCTI=;
        b=v/T7wIwaY/IVdtV+L622v55WD86hRmS3ddNYCvgAG/2sCghMfINUlkTjFET7gkOl6q
         ++9gzx23XiicxG3kXOFBGu4xU4xU5PCCOpWquS/lx+cAEGG+7qMT/x5kzF9aNxXGDW+7
         pMom3vGG4vvUTGROmVuWqnFA7nc4rcP3ujwfQVvEUZWWxUjyakUjfk+brPZDA7AWrem4
         qmQwvpnHKjCj79ekmzcFhVTWBQRATwqFZfGqtZIRcGmyrA9HFSkSavGp5SVzH/PnZEbj
         3HNBi/WoFmTvgb9xTJIYqGR51GNLJRp0hRnHUxZvvE33aldvQy47DzBvS0EUBwna2CzL
         yH5A==
X-Gm-Message-State: AOAM532N3ni9Zhl/VjopxPW0424w7eLN1ldWdtui0gaHIkFijfKJKcuY
        Yt3gt5WN/CAipqRGv7SBFDAHsQ==
X-Google-Smtp-Source: ABdhPJxg9/v0pCSGZ8BwTRKwaGvr6w8CT865Zhn8XA0POsMWJXyMxLfaaotxF7Mh9pvucduHkgRFdw==
X-Received: by 2002:a05:6870:7084:b0:ed:d709:34be with SMTP id v4-20020a056870708400b000edd70934bemr236034oae.4.1651684052484;
        Wed, 04 May 2022 10:07:32 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e63-20020a9d2ac5000000b006060322124fsm5232500otb.31.2022.05.04.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:07:31 -0700 (PDT)
Date:   Wed, 4 May 2022 12:07:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_rohkumar@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v12 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi
 pinmux properties for CRD 3.0/3.1
Message-ID: <YnKyzxPEolSVUhqD@builder.lan>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
 <1651079383-7665-5-git-send-email-quic_srivasam@quicinc.com>
 <YmsrB6Q89II5w1+9@google.com>
 <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Apr 11:10 CDT 2022, Doug Anderson wrote:

> Hi,
> 
> On Thu, Apr 28, 2022 at 5:02 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 10:39:43PM +0530, Srinivasa Rao Mandadapu wrote:
> > > Add LPASS LPI pinctrl properties, which are required for Audio
> > > functionality on herobrine based platforms of rev5+
> > > (aka CRD 3.0/3.1) boards.
> > >
> > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> >
> > I'm not super firm in pinctrl territory, a few maybe silly questions
> > below.
> >
> > >  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 84 +++++++++++++++++++++++
> > >  1 file changed, 84 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > > index deaea3a..dfc42df 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > > @@ -111,6 +111,90 @@ ap_ts_pen_1v8: &i2c13 {
> > >   * - If a pin is not hooked up on Qcard, it gets no name.
> > >   */
> > >
> > > +&lpass_dmic01 {
> > > +     clk {
> > > +             drive-strength = <8>;
> > > +     };
> 
> Ugh, I've been distracted and I hadn't realized we were back to the
> two-level syntax. Definitely not my favorite for all the reasons I
> talked about [1]. I guess you took Bjorn's silence to my response to
> mean that you should switch back to this way? :(
> 
> Bjorn: can you clarify?
> 

I didn't think through the fact that &mi2s0_state was specified in the
.dtsi and as such will be partially be overridden by the baord dts.


I do prefer the two level style and describing full "states", but as you
say whenever we provide something that will have to be overwritten it's
suboptimal.

As such, I think your flattened model is preferred in this case - but it
makes me dislike the partial definition between the dtsi and dts even
more (but I don't have any better suggestion).

Regards,
Bjorn

> [1] https://lore.kernel.org/r/CAD=FV=VicFiX6QkBksZs1KLwJ5x4eCte6j5RWOBPN+WwiXm2Cw@mail.gmail.com/
> 
> > > +};
> > > +
> > > +&lpass_dmic01_sleep {
> > > +     clk {
> > > +             drive-strength = <2>;
> >
> > Does the drive strength really matter in the sleep state, is the SoC actively
> > driving the pin?
> 
> My understanding is that if a pin is left as an output in sleep state
> that there is a slight benefit to switching it to drive-strength 2.
> 
> 
> > > +             bias-disable;
> >
> > What should this be in active/default state? If I understand correctly
> > after a transition from 'sleep' to 'default' this setting will remain,
> > since the default config doesn't specify a setting for bias.
> 
> Your understanding matches mine but I haven't tested it and I remember
> sometimes being surprised in this corner of pinmux before. I think
> it's better to put the bias in the default state if it should be that
> way all the time, or have a bias in both the default and sleep state
> if they need to be different.
