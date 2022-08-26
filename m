Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0D65A1EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbiHZCkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiHZCkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:40:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF742140FC;
        Thu, 25 Aug 2022 19:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71DE8B82F67;
        Fri, 26 Aug 2022 02:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA6CC433C1;
        Fri, 26 Aug 2022 02:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661481607;
        bh=F/XrCpR9e6lLBg9nz08XniZFdkkOADRu12wJy7b0C1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqRDbFlPCk05E8YnGrrMdNZNjAjJI2WJ01UElGjl4bs9oNqKYy+IH4/hqBpwjCX7+
         1PpPmr70tQkFgqodpDSelmlZTwC0zTYz/IBKzcdiv9awRI/dXeAafwlOuuTcKLibaI
         iawv0wLvrlVzuL0Ktm5agTauZHVAGJR7U493kwVAIPevCJeNODIY/YlYx8ThMXjhZa
         7gDy5M46y7rP4aVIYjfeQOvejxmYepkCHrA0KUvpBPAPLpH+zLFvEUmYKNfj2v7MDc
         zg/rMin0QzFZPD5gsvkoj1CXb7rzDPtJ+fhPZgGUIxvJ1Z91R5cCTn4vdhKeb8E9Cy
         IuDJ/m+MCiChw==
Date:   Thu, 25 Aug 2022 21:40:03 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-clk@vger.kernel.org,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc-sc7180: Keep the USB GDSC always on
Message-ID: <20220826024003.qpqtdmdohdmpcskt@baldur>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:21:58PM -0700, Matthias Kaehlcke wrote:
> When the GDSC is disabled during system suspend USB is broken on
> sc7180 when the system resumes. Mark the GDSC as always on to
> make sure USB still works after system suspend.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Rajendra, where you able to find some time to look into take the GDSC
into retention state? Do you suggest that I merge these two patches for
now?

Thanks,
Bjorn

> ---
> I'm not entirely sure that this is the correct solution. What makes
> me doubt is that only msm8953 sets ALWAYS_ON for the USB GDSC. Is USB
> broken after suspend on all the other QC platforms?
> 
> Changes in v2:
> - set the flags of the GDSC not of the GDSC power domain
> - updated commit message
> 
>  drivers/clk/qcom/gcc-sc7180.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
> index c2ea09945c47..c0d7509a782e 100644
> --- a/drivers/clk/qcom/gcc-sc7180.c
> +++ b/drivers/clk/qcom/gcc-sc7180.c
> @@ -2225,6 +2225,7 @@ static struct gdsc usb30_prim_gdsc = {
>  		.name = "usb30_prim_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = ALWAYS_ON,
>  };
>  
>  static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
