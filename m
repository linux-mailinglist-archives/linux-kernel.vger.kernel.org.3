Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031765A571D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH2W2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2W2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778D7D1CF;
        Mon, 29 Aug 2022 15:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5196161281;
        Mon, 29 Aug 2022 22:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B4AC433D6;
        Mon, 29 Aug 2022 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661812108;
        bh=z+mUk1NjhTIAGy3cEjwb1KUhlLSH2+XDdmYg5OYptMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqSoDSS8BbXlQH4MDR+Jr9a5pzuG8o897bU95hwk14qW3siuOgC66shuIjKa5pITE
         M9S6f1MH4VXg54zwmntnRq4mTMI7PIrJKpW/iT0/N4AQ2gix5FZ4hbPA4FScZoFwFq
         LNuyMXk7yNoIstfTQBRNSKncclNODkCpw4cCd8iREo1a5+IpA45OYIyEugveVy4W2l
         DleOC8lwNnc2daYFTG/nV5JfRoj+FQeyU9sDbWOJ9CEaDlIopzgbZ/V71DuWVeyLvu
         3yd5wzJ97hedFhXqF41lKolC7eiTApo2baeE50Pc3SNxpPryfszINc9p6clKQxjBDl
         2HlTfVrvqzCCw==
Date:   Mon, 29 Aug 2022 17:28:26 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: correct ref_aux clock for
 ufs_mem_phy
Message-ID: <20220829222826.xlusmyfrdgzeo3wq@builder.lan>
References: <20220825163755.683843-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825163755.683843-1-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:37:55PM -0400, Brian Masney wrote:
> The first UFS host controller fails to start on the SA8540P automotive
> board (QDrive3) due to the following errors:
> 
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag_retry: query attribute, opcode 5, idn 18, failed
>         with error 253 after 3 retries
> 
> The system eventually fails to boot with the warning:
> 
>     gcc_ufs_phy_axi_clk status stuck at 'off'
> 
> This issue can be worked around by adding clk_ignore_unused to the
> kernel command line since the system firmware sets up this clock for us.
> 
> Let's fix this issue by updating the ref_aux clock on ufs_mem_phy. Note
> that the downstream MSM 5.4 sources list this as ref_clk_parent. With
> this patch, the SA8540P is able to be booted without clk_ignore_unused.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
> ---
> v1 of this patch can be found at
> https://lore.kernel.org/lkml/20220623142837.3140680-1-bmasney@redhat.com/T/#u
> 
> Note that there's also a similar issue with the second UFS controller
> (ufs_card_hc) since it separately fails with:
> 
>     ufshcd-qcom 1da4000.ufs: Controller enable failed
>     ufshcd-qcom 1da4000.ufs: link startup failed 1
>     ...
>     gcc_ufs_card_axi_clk status stuck at 'off'
> 
> We are currently disabling the second UFS host controller (ufs_card_hc) in
> our DTS at the moment. I'm still looking through the downstream code to
> try to track this particular issue down.
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 49ea8b5612fc..4117ec0ffefc 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -892,7 +892,7 @@ ufs_mem_phy: phy@1d87000 {
>  			clock-names = "ref",
>  				      "ref_aux";
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
> -				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +				 <&gcc GCC_UFS_REF_CLKREF_CLK>;

I would expect that "ref" was going to be GCC_UFS_REF_CLKREF_CLK and
"ref_aux" would remain PHY_AUX. But the mapping here is not clear to me.

But does that work for you? (i.e. clocks = <CLKREF>, <PHY_AUX>)

Regards,
Bjorn

>  
>  			resets = <&ufs_mem_hc 0>;
>  			reset-names = "ufsphy";
> -- 
> 2.37.1
> 
