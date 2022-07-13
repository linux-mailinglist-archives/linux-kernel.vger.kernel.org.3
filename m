Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F6572B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiGMBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiGMBxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:53:42 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762CD26FF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:53:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u9so12759202oiv.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JJxXRTDP7RUQ5bHaHz0PPbxMaAGEn9NGGA9nzJ6F/Go=;
        b=BSxncvGzrTeTmwnlOa64mzOy3FBoNxiHzfgHiY9G4ipi6R1vQdnH8P8m5AJnvKbKjw
         QQbTEDUjXjYdgt8tDokulgM33YY5IVdlP5MRywtv0aoceonuRlDOX+IVneB2SKEFSoNh
         H0beaNZhkyjkZYtcTFn10lSUvcB2QJaO6/sV3hr/iuDQQVP65hET+a6R1r8c/GGJ0uVN
         8+sM95RhpQP8+aGV/lrkj5Q0Yn93IgwHVxTak084J9AL4KfLEvoqIC3QKX0vzwcFgiZ+
         hbsvurEbcVDvCUy6I5jl8krEFwOu2LB5akpvwUWrBqbSESLLKvolxBdV/wGc3PxtTn5t
         TUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JJxXRTDP7RUQ5bHaHz0PPbxMaAGEn9NGGA9nzJ6F/Go=;
        b=QqojCgpVS+/mKDRa9gIgzJAUQqLqZjexebYswIfRkXEv1DR+mbfSTZxS+M5qto8ygM
         O2mYYTmKkSx6xOGHsABLgaWdg+wdL1Dz0EsaIlfoxkD6tTmJCHP2afI2nuMumFG+l3Jl
         1cNORldycVTmaC046q61bixAzugAVY6eJuorN2pjWNf9iBY5qou5XAN4pIkZtFywPSQp
         J7vHCcCM5OFGLwbmD4Jtggzsn7H3Z09YI0z690xVyjHUcZl8M9Us7Gd63vGoXMCCAyfO
         0BiB6kAof20F4mmUTKNDptDGW8YGMp1TILwehvty8GCuiYpnESr47RD+SO7Rk+QTjBET
         Kozw==
X-Gm-Message-State: AJIora+RWJIxDdkG2hajzis25EOTaIW28wjwcdQBTjYkLJxkYMX/RpI6
        K212fNHs03Db0zy2AVuRnwzvAA==
X-Google-Smtp-Source: AGRyM1vDcdE+j8h7alSR0sASPksPrxZUmakTE59zww7W/SuTUE49jBv4y7HCPKShlzAFHmwxXnF+yQ==
X-Received: by 2002:aca:5dc6:0:b0:33a:25e:8d51 with SMTP id r189-20020aca5dc6000000b0033a025e8d51mr616189oib.258.1657677216683;
        Tue, 12 Jul 2022 18:53:36 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e15-20020a9d6e0f000000b0061c29a38b3bsm4343389otr.33.2022.07.12.18.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:53:36 -0700 (PDT)
Date:   Tue, 12 Jul 2022 20:53:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add lost ranges for timer
Message-ID: <Ys4lnuVncPiWkjbH@builder.lan>
References: <20220707160858.3178771-1-bjorn.andersson@linaro.org>
 <Ysvlqw/+eMk5XLRY@hovoldconsulting.com>
 <YszcSgnSrbsncw0J@ripper>
 <Ys2K/BH/kAeTBz5t@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2K/BH/kAeTBz5t@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jul 09:53 CDT 2022, Johan Hovold wrote:

> On Mon, Jul 11, 2022 at 07:28:26PM -0700, Bjorn Andersson wrote:
> > On Mon 11 Jul 01:56 PDT 2022, Johan Hovold wrote:
> > 
> > > On Thu, Jul 07, 2022 at 09:08:58AM -0700, Bjorn Andersson wrote:
> > > > The timer node needs ranges specified to map the 1-cell children to the
> > > > 2-cell address range used in /soc. This addition never made it into the
> > > > patch that was posted and merged, so add it now.
> > > > 
> > > > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > index 2bdb42c88311..37a4cd6f85b6 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > @@ -1667,6 +1667,7 @@ timer@17c20000 {
> > > >  			reg = <0x0 0x17c20000 0x0 0x1000>;
> > > >  			#address-cells = <1>;
> > > >  			#size-cells = <1>;
> > > > +			ranges = <0 0 0 0x20000000>;
> > > 
> > > While addressing the current issue, this looks odd to me. Why not use a
> > > non-zero parent bus address here instead?
> > > 
> > 
> > I guess we could express the frames relative the timer range, but that
> > would imply that anyone porting downstream dts snippets would have to
> > translate these addresses - or more likely would end up just copying the
> > existing cases.
> > 
> > > And please use hex notation consistently for the addresses.
> > 
> > That seems like a reasonable ask, I can fix that up. But on both
> > accounts this matches what I merged for all the other platforms in:
> > 
> > 458ebdbb8e5d ("arm64: dts: qcom: timer should use only 32-bit size")
> > 
> > 
> > So I guess we'll also need to go back and fix up the style of all the
> > other platforms - just because we're not allowed to express the frames
> > in 64-bits according to the binding...
> 
> Would have been easier to just amend the binding. I don't think that
> #size-cells = 1 constraint is set in stone as it was added when
> converting to DT schema.
> 

Rob disagrees with this idea:
https://lore.kernel.org/all/CAL_JsqJMMCBnukFZLJ8X14s1PwqT=VEwKjDVj8mm4h55pZpcuw@mail.gmail.com/

> I also don't think you need to fixup the hex notation elsewhere, it's
> quite inconsistent currently, but no need to make it worse.
> 

I'll prefix the 0s with some 0x in this case and we can care for the
other platforms some other day...

> But you probably should amend the commit message and mention that this
> fixes time keeping. I had recently noticed that something was off
> (journals rotating, and erratic cursor blinking) but didn't realise that
> timers were broken until you posted this.
> 

That sounds like a good idea, thanks for the suggestion.

Regards,
Bjorn
