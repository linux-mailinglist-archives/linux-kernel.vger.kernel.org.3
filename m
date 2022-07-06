Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101335685C5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiGFKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGFKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:39:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E619036;
        Wed,  6 Jul 2022 03:39:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so5360488edc.4;
        Wed, 06 Jul 2022 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=430yAFLJrEHI3Rx/2SsFVVThDkyR0pxUFGx2a++8q3I=;
        b=mHdZ1luLBV1AcVBcm0nq5FtyTuIZz53+0tLTlZY3rsYSvLa7yMj+x2CPTvM0JdhWQN
         bli0bbawZ6sfiIvWjbo7KEbV5nstk5SuZoGi5KntG8LFhPgp6GgwNzFV94Floq92taHG
         uOZIQNkG/S+9PkvKFkRbzNwInWx86beXfOUU4Dr2gVZbn7X2UjEwBI2ty+SdkJuoBiG5
         7LJmf079ba+bjL2kOv/Tf03pg7o11p8f1dW7ZK93NGnImaqBI5rFeiNALcvzt3eFIdmz
         pQMVepzJ75u/ACOWQC0+DlewdD0JfDmeTDTzS5ZEbLT/VXwinTLXRkhBvAlKJGATIzL3
         ZCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=430yAFLJrEHI3Rx/2SsFVVThDkyR0pxUFGx2a++8q3I=;
        b=wyADctdu2HeM8HufoXhrIHyLlPBKPcte142V/gSTLMkx1lIZUn+LXhOJgFn73iwcBd
         aKjZqP4TTQjIE+XCpsfqzNgpcIHJu+OKmQliFPzZ9clDgTF5nCAiVrWm0XPbq5VZOXjv
         +irdEWFkKcO/F8kuefDm+fTFocfrd8Jys434UJqteRgBDMrJqOGlQKiqaB/4jqtk19Dk
         MUUrKFoGNZ8lu3wRtmegf16MQ8hfgkj+f50TCZeoEAwkbtZfOWyqISSKwJNNPagjE6+0
         S5ZxyMuddnRSVjAueeBplQVTobFbxp8dSDQOJVIk+uwZNu5Q24L3oEmSV2SBaYvHgLr3
         8zug==
X-Gm-Message-State: AJIora8OsM+7oMiRYicbl0zShmTOOlaQhJHDU0H/Kzo+EDq2y2KwOBU9
        5nkJzBO8PZtpZs/BZHQiLv3I9UM3fxo=
X-Google-Smtp-Source: AGRyM1sc7SMB5gkjwZdEYxPzDbMrn3QRowjGxNNzpaubJdLP2URu+xdw0K8H2xLZvVqYTMjgQAyn8g==
X-Received: by 2002:a05:6402:950:b0:43a:5194:174c with SMTP id h16-20020a056402095000b0043a5194174cmr21692441edz.145.1657103960487;
        Wed, 06 Jul 2022 03:39:20 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id v8-20020aa7d648000000b004377151dfbdsm22344355edr.50.2022.07.06.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:39:20 -0700 (PDT)
Message-ID: <62c56658.1c69fb81.87c41.6b07@mx.google.com>
X-Google-Original-Message-ID: <YsVic8J7VNpBzaWn@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:22:43 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ARM: dts: qcom: add pxo/cxo clock-output-names for
 ipq8064
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-5-ansuelsmth@gmail.com>
 <CAA8EJppTCZRpi8EqmRSJQiSmaANr=5+q5Rb5KsMYZROSNGpGqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppTCZRpi8EqmRSJQiSmaANr=5+q5Rb5KsMYZROSNGpGqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:29:09AM +0300, Dmitry Baryshkov wrote:
> On Tue, 5 Jul 2022 at 23:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Drivers expect to call pxo/cxo_board clock as pxo/cxo.
> > Use clock-output-names to set the correct naming for these fixed clock
> > to save drivers that are migrating to parent_data and still use
> > parent_names.
> 
> Please no. There is no reason to add these names. Let's follow the
> example of other platforms.
>

Okok... just don't like the '_board' suffix but will drop...

> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index 1425a4e4283f..720e27e29627 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -302,12 +302,14 @@ cxo_board: cxo_board {
> >                         compatible = "fixed-clock";
> >                         #clock-cells = <0>;
> >                         clock-frequency = <25000000>;
> > +                       clock-output-names = "cxo";
> >                 };
> >
> >                 pxo_board: pxo_board {
> >                         compatible = "fixed-clock";
> >                         #clock-cells = <0>;
> >                         clock-frequency = <25000000>;
> > +                       clock-output-names = "pxo";
> >                 };
> >
> >                 sleep_clk: sleep_clk {
> > --
> > 2.36.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
