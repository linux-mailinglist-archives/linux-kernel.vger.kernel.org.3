Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4573D59C65C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiHVSbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiHVSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:30:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86E48E89;
        Mon, 22 Aug 2022 11:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14F70B816E6;
        Mon, 22 Aug 2022 18:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65407C433C1;
        Mon, 22 Aug 2022 18:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661193043;
        bh=OoTba3ydHbqkNB71cUiP4uky5w7voNgWy8VPUNjG+KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7AO1nBKtRpjLwZAcfu3G3zEiXPS6YHJnnZnepO6S2YOr1eJHx3OXmRXeOOOoIfF5
         s5xZ9MWWQSHPD5zT9oTn66n+h+1T1z00iXRXWvSmfFw6MRjul/AhG5y8Ml+SHlsTDv
         eQc+MI/J17X1T+HdAXaX5yaOKKF1B+riE3rhTjeqI6TFH3U1pubpPLW/Sz5A3bbDT0
         pIqBc2GMAlXklZF4dx+X21nYORgVM2aJsKoN3KyREKeu/AFU9CctSichWE+u+Nbu2i
         WhFnap504LZOq32O0AkLm4PXkDM/83Oq0i+N14ReZzuqFU4JSyOqM5I6j4CGfopjvg
         eftOcZKkj9m7g==
Received: by pali.im (Postfix)
        id 1D03E97B; Mon, 22 Aug 2022 20:30:40 +0200 (CEST)
Date:   Mon, 22 Aug 2022 20:30:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/85xx: DTS: Add CPLD definitions for P1021RDB
 Combo Board CPL Design
Message-ID: <20220822183039.sfpupym236ubkeio@pali>
References: <20220819084433.26011-1-pali@kernel.org>
 <20220822170056.GA4135542-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822170056.GA4135542-robh@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 August 2022 12:00:56 Rob Herring wrote:
> On Fri, Aug 19, 2022 at 10:44:33AM +0200, Pali Rohár wrote:
> > P1021RDB Combo Board CPLD Design is used on following Freescale boards:
> > P1021RDB-PC, P1020RDB-PD, P1020MBG-PC, P1020UTM-PC and P2020RDB-PCA.
> > 
> > Add CPLD definitions for all these boards for which already exist DTS file.
> > 
> > CPLD has bank size 128kB, it is connected via CS3 on LBC and mapped to
> > memory range 0xFFA00000~0xFFA1FFFF.
> > 
> > As CPLD firmware is common on all these boards, use just one compatible
> > string "fsl,p1021rdb-pc-cpld".
> > 
> > In some DTS files is CPLD already defined, but definition is either
> > incomplete or wrong. So fix it.
> > 
> > All these boards have via CPLD connected max6370 watchdog at offset 0x2
> > with GPIO 11, status led at offset 0x8 and reset controller at offset 0xd.
> > Additionally P1020MBG-PC and P1020RDB-PD boards have FXO led at offset 0x9
> > and FXS leds at offset 0xa.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi    | 92 +++++++++++++++++++
> >  arch/powerpc/boot/dts/fsl/p1020mbg-pc_32b.dts |  6 +-
> >  arch/powerpc/boot/dts/fsl/p1020mbg-pc_36b.dts |  6 +-
> >  arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts     | 44 +++++++--
> >  arch/powerpc/boot/dts/fsl/p1020utm-pc.dtsi    | 37 ++++++++
> >  arch/powerpc/boot/dts/fsl/p1020utm-pc_32b.dts |  4 +-
> >  arch/powerpc/boot/dts/fsl/p1020utm-pc_36b.dts |  4 +-
> >  arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi    | 37 ++++++++
> >  arch/powerpc/boot/dts/fsl/p1021rdb-pc_32b.dts |  5 +-
> >  arch/powerpc/boot/dts/fsl/p1021rdb-pc_36b.dts |  5 +-
> >  arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi    | 33 ++++++-
> >  11 files changed, 251 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
> > index a24699cfea9c..c73996dcd809 100644
> > --- a/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/p1020mbg-pc.dtsi
> > @@ -83,6 +83,95 @@
> >  		compatible = "vitesse-7385";
> >  		reg = <0x2 0x0 0x20000>;
> >  	};
> > +
> > +	cpld@3,0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "fsl,p1021rdb-pc-cpld", "simple-bus", "syscon";
> > +		reg = <0x3 0x0 0x20000>;
> > +		ranges = <0x0 0x3 0x0 0x20000>;
> > +
> > +		watchdog@2 {
> > +			compatible = "maxim,max6370";
> > +			reg = <0x2 0x1>;
> > +			gpios = <&gpio 11 1>;
> > +		};
> > +
> > +		led@8 {
> 
> The register-bit-led schema says this should be 'led@8,0'. Did you 
> run 'dtbs_check'? 

No, it does not work and I lost interest to trying setup machine for it again.

> But that's going to conflict with what simple-bus schema says.

Another reason why not try it again. Lot of schemas says that are in
conflict, nobody understand it and when I ask how to do it, I just get
silence or answer which does not work on the real hw. And if there is
some schema error message then it looks like it was generated by random
word generator.

> I don't 
> know that 'simple-bus' is really appropriate here. The CPLD isn't really 
> just a bus. 'simple-mfd' is what's more commonly used with 'syscon'.

Sorry, I do not understand those schemas anymore. And based on previous
failures, I'm not going to try it again.

It is a _bus_ and it was tested that it works as a bus with more
existing drivers.

> > +			compatible = "register-bit-led";
> > +			reg = <0x8 0x1>;
> > +			offset = <0x8>;
> > +			mask = <0x1>;
> > +			active-low;
> > +			default-state = "keep";
> > +			label = "status";
> > +			function = "status";
> > +			color = <6>; /* LED_COLOR_ID_YELLOW */
> > +		};
> 
