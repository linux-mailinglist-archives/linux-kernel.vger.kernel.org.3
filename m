Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBBA522E96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiEKIjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbiEKIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:39:26 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A911C363;
        Wed, 11 May 2022 01:39:22 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BD5F9205ED;
        Wed, 11 May 2022 10:39:19 +0200 (CEST)
Date:   Wed, 11 May 2022 10:39:17 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH 2/4] leds: qcom-lpg: Add PM660L configuration and
 compatible
Message-ID: <20220511083917.5xhseah7tuzmrn6f@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
References: <20220507221123.2201668-1-marijn.suijten@somainline.org>
 <20220507221123.2201668-2-marijn.suijten@somainline.org>
 <YnszX1wdQhUSkgyH@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnszX1wdQhUSkgyH@builder.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 22:54:07, Bjorn Andersson wrote:
> On Sat 07 May 17:11 CDT 2022, Marijn Suijten wrote:
> 
> > Inherit PM660L PMIC LPG/triled block configuration from downstream
> > drivers and DT sources, consisting of a triled block with automatic
> > trickle charge control and source selection, three colored led channels
> > belonging to the synchronized triled block and one loose PWM channel.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  drivers/leds/rgb/leds-qcom-lpg.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> > index cfa3362b2457..30c12ac8eed4 100644
> > --- a/drivers/leds/rgb/leds-qcom-lpg.c
> > +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> > @@ -1271,6 +1271,23 @@ static int lpg_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static const struct lpg_data pm660l_lpg_data = {
> > +	.lut_base = 0xb000,
> > +	.lut_size = 0x100,
> 
> The documentation tells me that you have 49 entries of LUT on the
> PM660L.

Downstream DT sources report the full 0x100 range starting at 0xb000 is
used, before the first channel starts at 0xb100:

    https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/LA.UM.8.2.1.r1-06200-sdm660.0/arch/arm64/boot/dts/qcom/pm660l.dtsi#L84-85

However, every LUT entry appears to be two bytes in size so this should
at least be halved.

The driver does seem to add another 0x42 on top of this base address:

    https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/LA.UM.8.2.1.r1-06200-sdm660.0/drivers/pwm/pwm-qti-lpg.c#L104

(Your LPG driver adds 0x40 - I've seen both used in our downstream
driver) yet that leaves (0x100-0x42) / 2 = 95 spots.

This is still significantly higher than 49.  Is part of this register
range used for something else, inaccesible for LUT-value readings or is
the counter hardware in the LPG limiting this?

The driver codes in a max length of 47:

    https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/LA.UM.8.2.1.r1-06200-sdm660.0/drivers/pwm/pwm-qti-lpg.c#L108

If you're confident about this I'll bump it down to 49 or try validating
what happens if higher registers are used.

> > +
> > +	.triled_base = 0xd000,
> > +	.triled_has_atc_ctl = true,
> > +	.triled_has_src_sel = true,
> > +
> > +	.num_channels = 4,
> > +	.channels = (struct lpg_channel_data[]) {
> 
> This can be const

Thanks for spotting!

- Marijn

> 
> Regards,
> Bjorn
> 
> > +		{ .base = 0xb100, .triled_mask = BIT(5) },
> > +		{ .base = 0xb200, .triled_mask = BIT(6) },
> > +		{ .base = 0xb300, .triled_mask = BIT(7) },
> > +		{ .base = 0xb400 },
> > +	},
> > +};
> > +
> >  static const struct lpg_data pm8916_pwm_data = {
> >  	.num_channels = 1,
> >  	.channels = (const struct lpg_channel_data[]) {
> > @@ -1391,6 +1408,7 @@ static const struct lpg_data pm8350c_pwm_data = {
> >  };
> >  
> >  static const struct of_device_id lpg_of_table[] = {
> > +	{ .compatible = "qcom,pm660l-lpg", .data = &pm660l_lpg_data },
> >  	{ .compatible = "qcom,pm8150b-lpg", .data = &pm8150b_lpg_data },
> >  	{ .compatible = "qcom,pm8150l-lpg", .data = &pm8150l_lpg_data },
> >  	{ .compatible = "qcom,pm8350c-pwm", .data = &pm8350c_pwm_data },
> > -- 
> > 2.36.0
> > 
