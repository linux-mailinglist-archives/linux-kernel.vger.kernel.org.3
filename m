Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967E159E610
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiHWPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbiHWPdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:33:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D0123E3E;
        Tue, 23 Aug 2022 04:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9BF4B81CD8;
        Tue, 23 Aug 2022 11:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E8C433C1;
        Tue, 23 Aug 2022 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661253396;
        bh=Ep3tpjrrxWT1Qx2K5Gp8IwXhWLY5DWjXZ1k5FABJM54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsYEIyPUFV/6I2LYR9H7uqGHswFY6tmplpVg9BWJIelsDapunuO6MpzkCl9ySNDs4
         VQ7e5g/ncJ7t96b7FX6UNi6hMfTNExc3CeomJPAjt9VGEp0D0dOscF2WfayPrG5sDN
         D0TrsR9CWqGUeX9oC5JL9JzOsPXiDlX9ki0kifGMykq+XLlGKN0aAwCqR3FOHT1Tfo
         eBFe9Q8mRpSW9xkHxZE5gMJoQigOEdu6AkPY4186l6mUwGx2kVHLuGUC6Pj2jTYvwt
         vkGeVzp/yO3Sj6gl4YNz+MtCfWMh6oSbZEnaTMUI7FmHHElvcKXrdPB8Q1Oa6QjI2t
         HDUcDftk4lo/Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQRtc-0002Il-GZ; Tue, 23 Aug 2022 13:16:36 +0200
Date:   Tue, 23 Aug 2022 13:16:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sc7280: Keep USB GDSC power domains
 on when USB wakeup is enabled
Message-ID: <YwS3FCOqIeajMEgz@hovoldconsulting.com>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 11:53:11AM -0700, Matthias Kaehlcke wrote:
> Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domains of SC7280.
> 
> Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  drivers/clk/qcom/gcc-sc7280.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 7ff64d4d5920..4ff855269467 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c
> @@ -3125,6 +3125,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
>  	.gdscr = 0xf004,
>  	.pd = {
>  		.name = "gcc_usb30_prim_gdsc",
> +		.flags = GENPD_FLAG_ACTIVE_WAKEUP,

Have you verified that the power-domain doesn't need to remain on also
when USB isn't used for wakeup?

This is the case for sc8280xp and indicates that there are further
missing pieces here (at least for that platform).

Johan
