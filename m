Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95B5588818
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiHCHm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiHCHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EB1F613;
        Wed,  3 Aug 2022 00:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E15C61549;
        Wed,  3 Aug 2022 07:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632A1C433D6;
        Wed,  3 Aug 2022 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659512541;
        bh=C1RNQNhb6enxYiFbEUhew2HqPznAB4gqXj2tpJtcyZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2iPDf+eltJE5B21ZIHSKvCu4VABtozVmm1EaM8KjBJlO6+PqP80veFq9Hgf4wits
         Y5lBrNWixQ8rgkdslbeUwr/PlrOJxrcUSOW2ZgNBgTSWtb5wi2JLn7+b7IMk61NXLr
         LnDuqYdx3U+Gz6Xcf6k1OkO/sLctnO6I42CM/mDglsByz/4BkiO+Ft9B428a326Xld
         /uy+rz5gHXFhifH7ESC70NGBPecbwCNrQWzyssI2Ch5zmKIHzjV0nyGrKCOXr9ztHG
         FX7YNUpoWRqTVXoKu4A2U6d1+LJtHsYkfayJYktLOi/1oTeEzyL1rT/GfUdeIKZ1Fl
         Y+eW6JDeqejng==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJ91a-0006mH-JA; Wed, 03 Aug 2022 09:42:39 +0200
Date:   Wed, 3 Aug 2022 09:42:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Revert "usb: dwc3: qcom: Keep power domain on to
 retain controller status"
Message-ID: <Yuom7k3Y4tDhy/QJ@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-3-johan+linaro@kernel.org>
 <3c175fd4-861a-37a9-4cd7-87370c2e46df@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c175fd4-861a-37a9-4cd7-87370c2e46df@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:30:34PM +0530, Krishna Kurapati PSSNV wrote:
> 
> On 8/2/2022 8:43 PM, Johan Hovold wrote:
> > This reverts commit d9be8d5c5b032e5383ff5c404ff4155e9c705429.
> >
> > Generic power-domain flags must be set before the power-domain is
> > initialised and must specifically not be modified by drivers for devices
> > that happen to be in the domain.
> >
> > To make sure that USB power-domains are left enabled during system
> > suspend when a device in the domain is in the wakeup path, the
> > GENPD_FLAG_ACTIVE_WAKEUP flag should instead be set for the domain
> > unconditionally when it is registered.

> In case we need the genpd framework to set the GENPD_FLAG_ACTIVE_WAKEUP
> flag for a particular domain that will be used by a device (which is
> wakeup capable) and hasn't been probed yet , can you help me understand if
> there any dt-flags we  can add to convey the same the genpd  framework
> so that it will set that flag during domain registration ?

This can't be expressed in DT (currently), so what you need is something
like the below:

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 7ff64d4d5920..4ff855269467 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3125,6 +3125,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
        .gdscr = 0xf004,
        .pd = {
                .name = "gcc_usb30_prim_gdsc",
+               .flags = GENPD_FLAG_ACTIVE_WAKEUP,
        },
        .pwrsts = PWRSTS_OFF_ON,
        .flags = VOTABLE,
@@ -3134,6 +3135,7 @@ static struct gdsc gcc_usb30_sec_gdsc = {
        .gdscr = 0x9e004,
        .pd = {
                .name = "gcc_usb30_sec_gdsc",
+               .flags = GENPD_FLAG_ACTIVE_WAKEUP,
        },
        .pwrsts = PWRSTS_OFF_ON,
        .flags = VOTABLE,

to make sure that genpd keeps these domains powered during system
suspend if they are used by devices that are in the wakeup path.

Johan
