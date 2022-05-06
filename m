Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7087B51CF3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388431AbiEFDHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbiEFDHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:07:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02A63BC8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:04:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id m11so6279137oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T++gZ2GI7rq41AMjJrvK3co4NPdoI+yV6w7aO84fVJk=;
        b=VuqvPsHxP9tDS82aa7pO4+SreMiPD6SY4GAOI9HhlashyhESlXufqa2tFCTofCaEMn
         b3sRfxVJoypGDNDf1wLRw4Ej8lDn5c8WBbuthGMJPSBztmg661hcSw6xxC0mH1PJmjQC
         0icl6ft+6DhZxiR8yqT21jkrI+c+AmQfHXb2GPN/mdk5SjSg1BH2rcoecyIATmlCMxKS
         1cBpPhjXH5DBxOzUIZ07Nm/8es4FCdPSKa6xDqesXNFNoq4j2X3yC/AJF30EttGmjimz
         b5EBkv8dmQjs6IOXmROdN586Z0XAVxXNsd8qSmCgpYLBRPPbvsJzZz+Fzlh5MefQAes+
         9ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T++gZ2GI7rq41AMjJrvK3co4NPdoI+yV6w7aO84fVJk=;
        b=7V19+3CPEavbdcyPWW4FnbF3aHZJMDHm14i/Bnv7Zgm4IC7vKQoXx9suXyg2i22eoF
         yROOrHUJQ35hEP48fiX3eGU0wyteDxfV/kE/YDMlaTLrFBOLkKW2RJoZyxrEcU4/RvUy
         GY8OsWOpiTH/5Cq1EhYbsJ5w2XGGgJWVjAWmCoL1o1S92GjBC9/57IbDJDpliF/1Kpwg
         H43tNrmgRF+e6zPCpz9XTMaZYlCbiQyBzq6e+3Ri0OGEqahhiTVWek/5Bg1JXh6O2Gc6
         e/R7osUiRjFamDEwfyF+iPrXrvqhoOVF/UVnwsZFGM2uXcsuRj7GpZBCgV6xx9ypixPy
         DT1A==
X-Gm-Message-State: AOAM530ksJBztqWjEl3hbzo+0/agiX6yuKzRBNNoQDLPpYRA+AJuGrbt
        e2a8ZfQ8JIW7Az3dYMjQtFIf2Q==
X-Google-Smtp-Source: ABdhPJy74g37LCcwt+8/1z9SyKM1QQtosMJIVHLs8RT7vbfXrKpL4PQ3bb+tUbcjg26/ZZguL1eolw==
X-Received: by 2002:a05:6808:1244:b0:2f9:e450:4bc4 with SMTP id o4-20020a056808124400b002f9e4504bc4mr607932oiv.290.1651806244880;
        Thu, 05 May 2022 20:04:04 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 42-20020a9d012d000000b006060322124dsm1217775otu.29.2022.05.05.20.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:04:04 -0700 (PDT)
Date:   Thu, 5 May 2022 20:06:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
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
Message-ID: <YnSQvyAN3v69an8k@ripper>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
 <1651079383-7665-5-git-send-email-quic_srivasam@quicinc.com>
 <YmsrB6Q89II5w1+9@google.com>
 <CAD=FV=XxeZsiOVVBDK_vmx0nhT7roB2FqcaPXsH3+jzTHFXMxw@mail.gmail.com>
 <YnKyzxPEolSVUhqD@builder.lan>
 <CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com>
 <YnRvyICa9kxFc/nE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnRvyICa9kxFc/nE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 May 17:46 PDT 2022, Matthias Kaehlcke wrote:

> On Thu, May 05, 2022 at 05:06:08PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Wed, May 4, 2022 at 10:07 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Fri 29 Apr 11:10 CDT 2022, Doug Anderson wrote:
> > >
> > > > Hi,
> > > >
> > > > On Thu, Apr 28, 2022 at 5:02 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > >
> > > > > On Wed, Apr 27, 2022 at 10:39:43PM +0530, Srinivasa Rao Mandadapu wrote:
> > > > > > Add LPASS LPI pinctrl properties, which are required for Audio
> > > > > > functionality on herobrine based platforms of rev5+
> > > > > > (aka CRD 3.0/3.1) boards.
> > > > > >
> > > > > > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > > > > > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > > > > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > > > >
> > > > > I'm not super firm in pinctrl territory, a few maybe silly questions
> > > > > below.
> > > > >
> > > > > >  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 84 +++++++++++++++++++++++
> > > > > >  1 file changed, 84 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > > > > > index deaea3a..dfc42df 100644
> > > > > > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> > > > > > @@ -111,6 +111,90 @@ ap_ts_pen_1v8: &i2c13 {
> > > > > >   * - If a pin is not hooked up on Qcard, it gets no name.
> > > > > >   */
> > > > > >
> > > > > > +&lpass_dmic01 {
> > > > > > +     clk {
> > > > > > +             drive-strength = <8>;
> > > > > > +     };
> > > >
> > > > Ugh, I've been distracted and I hadn't realized we were back to the
> > > > two-level syntax. Definitely not my favorite for all the reasons I
> > > > talked about [1]. I guess you took Bjorn's silence to my response to
> > > > mean that you should switch back to this way? :(
> > > >
> > > > Bjorn: can you clarify?
> > > >
> > >
> > > I didn't think through the fact that &mi2s0_state was specified in the
> > > .dtsi and as such will be partially be overridden by the baord dts.
> > >
> > >
> > > I do prefer the two level style and describing full "states", but as you
> > > say whenever we provide something that will have to be overwritten it's
> > > suboptimal.
> > >
> > > As such, I think your flattened model is preferred in this case
> > 
> > How about for future patches we just provided labels at both levels
> > (I'm not suggesting we churn this patch series more):
> > 
> > lpass_dmic01_sleep: dmic01-sleep {
> 
> is the outer label ('lpass_dmic01_sleep') actually needed if we don't
> intend to replicate the hierarchy?
> 

Yes, that's what we put in the pinctrl-N reference from the device node.

> >   lpass_dmic01_sleep_clk: clk {
> >     pins = "gpio6";
> >     function = "dmic1_clk";
> >   };
> > 
> >   lpass_dmic01_sleep_data: data {
> >     pins = "gpio7";
> >     function = "dmic1_data";
> >   };
> > };
> > 

I like this suggestion.

> > Then you can in your pinctrl reference you can just reference the
> > top-level node but boards can override without having to replicate
> > hierarchy...
> > 
> > > but it
> > > makes me dislike the partial definition between the dtsi and dts even
> > > more (but I don't have any better suggestion).
> > 
> > One other proposal I'd make is that maybe we should change the rules
> > about never putting drive strength in the soc.dtsi file. While it
> > should still be OK for boards to override the drive strength, it seems
> > like a whole lot of biolerplate code to have every board override
> > every pin and say that its drive strength is 2. Similarly, if there's
> > a high speed interface (like eMMC) where a drive strength of 2 is
> > nonsense for any board, it doesn't seem ridiculous to specify a
> > default drive strength of something higher in the soc.dtsi file.
> 
> Indeed, that could make sense.
> 

Sounds good to me.

> > I would like to say the same thing goes for for pulls, but it's
> > unfortunately uglier for pulls. :( For instance, nearly everyone has
> > an external pullup for i2c busses. The strength of the pullup needs to
> > be tuned for the i2c bus speed and the impedance of the line. Thus, it
> > would ideally make sense to specify this in the soc.dtsi file.
> > Unfortunately, if we do that and some board _wants_ to use the
> > internal pulls (maybe they're running at a really low speed and/or
> > forgot to add external pulls) then they have to do an ugly
> > "/delete-property/ bias-disable" because adding the "bias-pull-up"
> > doesn't delete the other property and you end up with both. :( That
> > seems bad, so I guess I'd vote to keep banning bias definitions in the
> > soc.dtsi file.
> 
> I agree, having to use 'delete-property' to change a pull setting
> doesn't seem a good idea.

Same.

Regards,
Bjorn
