Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2568E528F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiEPUjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347378AbiEPUZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:25:59 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC84BB88;
        Mon, 16 May 2022 13:10:19 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 790ADC77E6;
        Mon, 16 May 2022 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1652731787; bh=n3KNc/SOocoBncfkRYrY0TOgCH0gJ+eKHj2WvbuIB3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NRUUgsnHwtW8aASLKkBWkdcWUDFz8pZ3h0gi84MBp8qz+D9ilRjeM5RJWfNjwPyqM
         qAmBlRqxyNNOoviG85T98fDlnY2+aKS96dcCCk3vrEyenaRyaOuOkP8h2IxsDVl8xy
         66vDh8UiKYZjHfS9BcDKiG+RIIogqF7I67BKVd6o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: Add LPG node to pm8941
Date:   Mon, 16 May 2022 22:09:47 +0200
Message-ID: <2629354.mvXUDI8C0e@g550jk>
In-Reply-To: <YnSazu3rcBMFPxYw@builder.lan>
References: <20220504205411.1510667-1-bjorn.andersson@linaro.org> <12122358.O9o76ZdvQC@g550jk> <YnSazu3rcBMFPxYw@builder.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Freitag, 6. Mai 2022 05:49:34 CEST Bjorn Andersson wrote:
> On Thu 05 May 03:01 CDT 2022, Luca Weiss wrote:
> > Hi Bjorn,
> > 
> > On Mittwoch, 4. Mai 2022 22:54:10 CEST Bjorn Andersson wrote:
> > > The PM8941 contains 8 LPG channels, as well as TRILED and LUT blocks.
> > > Add a node for these.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > > 
> > >  arch/arm/boot/dts/qcom-pm8941.dtsi | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi
> > > b/arch/arm/boot/dts/qcom-pm8941.dtsi index cdd2bdb77b32..7881a071b372
> > > 100644
> > > --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> > > @@ -144,6 +144,15 @@ pm8941_1: pm8941@1 {
> > > 
> > >  		#address-cells = <1>;
> > >  		#size-cells = <0>;
> > > 
> > > +		pm8941_lpg: lpg {
> > > +			compatible = "qcom,pm8941-lpg";
> > > +
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > 
> > Just curious, why doesn't pm8941 have #pwm-cells = <2>; like the other lpg
> > nodes in [0]?
> 
> I guess I didn't have a need for the lpg to be a pwm-chip on this pmic,
> yet. This could be added now, or at a later point when someone has a
> usecase for the pwm-chip.

While I don't know the use case for using the lpg as pwm on consumer hardware, 
it's maybe a good idea to add now?

> 
> > Other than that, the node works fine on pm8941. Will send a patch for
> > enabling notification LED on msm8974-FP2 soon.
> 
> If you turn that into a Tested-by, and preferably a Reviewed-by, I would
> have what I need to merge the two changes.

In any case:

Tested-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca

> 
> Looking forward to the FP2 patch.
> 
> Thanks,
> Bjorn
> 
> > Regards
> > Luca
> > 
> > [0]
> > https://lore.kernel.org/linux-arm-msm/20220505022706.1692554-2-bjorn.ande
> > rsson@linaro.org/> 
> > > +
> > > +			status = "disabled";
> > > +		};
> > > +
> > > 
> > >  		pm8941_wled: wled@d800 {
> > >  		
> > >  			compatible = "qcom,pm8941-wled";
> > >  			reg = <0xd800>;




