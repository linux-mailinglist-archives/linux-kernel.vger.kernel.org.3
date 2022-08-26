Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497855A2193
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbiHZHQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244493AbiHZHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80587688;
        Fri, 26 Aug 2022 00:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD26B61CC3;
        Fri, 26 Aug 2022 07:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F75C433C1;
        Fri, 26 Aug 2022 07:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661498190;
        bh=wqk1HzXb2rBovh/rKpl4Yg9KEE+WbiP1hgGfqq5MXss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eVJrRYxISVuTY3gzomQfPWUtggymAdcCxg6rwKwbVorTkbRqw1o9eeupvktWZ7nff
         1jPNWAUuQnH2NyN21SeSNDa/gXMvuDUPkHgxubXZzsekGyCz7L6ZBTKTmL83TLaKso
         JmcUYh9cKrHMx2jJGHTLyL0W6jfErD4zzjlfeamj/n7BuhxgX6QL7IU4rJ8JY0eqPQ
         CkvBfeLNxDeMaxeMq0xSUQtvMQuzMuvfE4W1lLsG9DEwtzOq1i3ah5QzAubkbpeqbK
         tFFMBeEIDJu1Zk0E2anNPQRqiIKshhkqP0e2nRSFF/lH89TVa4q9UUhQ7TsrkFT/TZ
         LFlMB+9TnV46A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oRTa2-0000qb-31; Fri, 26 Aug 2022 09:16:38 +0200
Date:   Fri, 26 Aug 2022 09:16:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-clk@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: gcc-sc7280: Keep the USB GDSCs always
 on
Message-ID: <YwhzVlTZLMCAbZi7@hovoldconsulting.com>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220825182152.v2.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825182152.v2.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:21:59PM -0700, Matthias Kaehlcke wrote:
> When the GDSC is disabled during system suspend USB is broken on
> sc7280 when the system resumes. Mark the GDSC as always on to
> make sure USB still works after system suspend.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2:
> - set the flags of the GDSC not of the GDSC power domain
> - updated commit message
> 
>  drivers/clk/qcom/gcc-sc7280.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
> index 7ff64d4d5920..adef68d2cb0b 100644
> --- a/drivers/clk/qcom/gcc-sc7280.c
> +++ b/drivers/clk/qcom/gcc-sc7280.c

Perhaps you can add a comment here about why this is needed similar to
what I did for sc8280xp:

	https://lore.kernel.org/all/20220805121250.10347-3-johan+linaro@kernel.org/

> @@ -3127,7 +3127,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
>  		.name = "gcc_usb30_prim_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = VOTABLE,
> +	.flags = VOTABLE | ALWAYS_ON,
>  };
>  
>  static struct gdsc gcc_usb30_sec_gdsc = {

Look good otherwise. For both patches:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
