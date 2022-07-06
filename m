Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0FA568918
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiGFNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFNNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:13:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B018B205FB;
        Wed,  6 Jul 2022 06:13:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m16so3742235edb.11;
        Wed, 06 Jul 2022 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=tz1OH9dY7H/mCELNT2HvP/qa+IhAYUEkLGRiUHfIoDw=;
        b=CP3oj1/tEMc0jScYrEhT9iJR8MnFIRQQr4ZN60ltqz10Yy7KBpRgRPRmbg7rwhxGQF
         +6c0e+lgbPgmx582/b1As5PjF5DjeeUx/L99i0VP31AGdTNdiZGIXH2a2wqWralB7VFB
         sWFukuzzQdPZLFvAk2id8AfopNyYRjH0HCyDAJTqYEX9yoewC0m8lPctdGcdObRXonw5
         zt8Wa4tI3X3PSaJKJsW2GDsfO45hajBGf6i8t7WrUNXUJJfwrTYepN2iLeon6rqzo1ox
         e+OUjagLaw93s9fIOcDAvPHX+HRgOyeqf52wbbS7YUV7q3MZsgeXqKCVKADLPLtYXx/H
         EqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=tz1OH9dY7H/mCELNT2HvP/qa+IhAYUEkLGRiUHfIoDw=;
        b=Zwf45i65BN5kl50ac6nUtFis0JF4KERIjb6KNjoMjjs3lsxlHxcrZng/7YlaqPEVG3
         7Cook8AnDS8RcgpsPJa/3pfuGIWO7ljJD4a8Wfki0vHP26TFmPcOXz7Vk5rLM4ZY6H2u
         uyV5U2S2eP5Q9te51bePnP6rnvHlIr/iZZSBCangc2DHryrfC4x7wlj+FXUAd651KjbY
         EU5r2XNiZ/huahcLO8W4W9TIHHISfqPwpDStEHo6YKl3OJxmRYvrM6IjxxvQnyXGqEBU
         swsx+fjpqKbGhF24oZnJtVjjfZXFw5X1Bs5gXt25PgXyxBITFpc2w2jDhwb/RqvjgQIl
         Ytdw==
X-Gm-Message-State: AJIora87vRy5M0zFNNKtAUQ6KPQqN9gjGfGSo50McFOA7i3hYPU/Mx0I
        rm2CnJQMFcToLsXlKNsA804=
X-Google-Smtp-Source: AGRyM1tdRp8VQxMu6lPUKZZuuY7tnzIpWG4sHFf8GtVhskX9iVa/cyLXBcIir2AD31AsmvafpWrKUQ==
X-Received: by 2002:a05:6402:358c:b0:435:9daf:e825 with SMTP id y12-20020a056402358c00b004359dafe825mr54134935edc.375.1657113185232;
        Wed, 06 Jul 2022 06:13:05 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090605c400b00706242d297fsm17147042ejt.212.2022.07.06.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:13:04 -0700 (PDT)
Message-ID: <62c58a60.1c69fb81.25b26.e72a@mx.google.com>
X-Google-Original-Message-ID: <YsWGe/Ufbb/AR+aR@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 14:56:27 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-5-ansuelsmth@gmail.com>
 <8a394fa3-92fb-d162-b4ee-df010a09aed0@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a394fa3-92fb-d162-b4ee-df010a09aed0@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:03:32PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.07.2022 15:39, Christian Marangi wrote:
> > Mikrotik RB3011 have a special configuration where the regulators are
> > not the common smb208 controlled by RPM but they use a TPS563900
> > controlled via i2c. Disable the smb208 for this specific device.
> Ok, so that answers my question from the previous email.
> Please define the SMB208 regulators only in the DTs of
> boards that actually use it, as it is not a SoC component as
> far as I can tell.
> 
> Konrad

This was already discuessed, rb3011 is the exception, qcom for ipq8064
recommends to use smb208 but gives the option to implement it in their
own way. So again we have 28 device with smb208 and 1 device that use
its own special way...

Wonder if a separate dtsi can be used for this if we really can't put
smb208 in ipq8064 dtsi?

> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Jonathan McDowell <noodles@earth.li>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> > index 9034f00f2bd8..f651e813d75a 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> > +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> > @@ -218,6 +218,10 @@ led@7 {
> >  	};
> >  };
> >  
> > +&smb208_regulators {
> > +	status = "disabled";
> > +};
> > +
> >  &adm_dma {
> >  	status = "okay";
> >  };

-- 
	Ansuel
