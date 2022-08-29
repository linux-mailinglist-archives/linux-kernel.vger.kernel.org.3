Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689A65A55C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2Utl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Utg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:49:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C65923F4;
        Mon, 29 Aug 2022 13:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50FE3B811F9;
        Mon, 29 Aug 2022 20:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64093C433D6;
        Mon, 29 Aug 2022 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661806173;
        bh=niWbYB6lLBHdEWvA5Jwf9iwIi7d5qUvXUnj/NrPAXgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXtuNC5NnL1Lbpi/ZWJI+6LuqMWd92uvkiUcFLp2738E4ul/2PlVQOJasRtVrgRP8
         Q+rjIWobMOPpwHkE6tcbbMuBKP6h7cU1Kgr96Za6z70YmJyZdEyjBd4hrAth+3uQXT
         idqffjo9VeHjdiM1tzxoIn1q9F3Uwt6JoJHzefEYXPp4qnSBy+yiZWndIn0Ps4vzbO
         TekXN8kcTll9ICyTPx5MpTr7a9l01sftAHap5E3W7u0UtIw2ytP8dK9k5XAgoYOilT
         5yl17gdCBF0eHsdpY+9vgyXEyUluAF5TGKXdl4hbAnHbZlyhp1R9Mb7ums3QS/txJ1
         6ZimNaAGVQlFA==
Date:   Mon, 29 Aug 2022 15:49:30 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] soc: qcom: socinfo: create soc_id table from
 bindings
Message-ID: <20220829204930.27wg2htgbq23kgeg@builder.lan>
References: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
 <20220705130300.100882-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705130300.100882-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 03:02:59PM +0200, Krzysztof Kozlowski wrote:
> The Qualcomm SoC ID values are encoded in few places: DTS files,
> Devicetree bindings (both used by some of Qualcomm bootloaders or tools)
> and in soc_id table of socinfo driver.  Do not duplicate the actual
> values in the last one but use the constants from the bindings.
> 
> Tested by comparing output object file (exactly the same).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I didn't have a strong opinion either way on this, so was hoping someone
else would chime in. Doesn't seem like that has happened, but
unfortunately the soc_id[] list has changed.

Would you mind rebasing the two patches to match the latest list?

> ---
>  drivers/soc/qcom/socinfo.c | 259 +++++++++++++++++++------------------
>  1 file changed, 133 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index cee579a267a6..d515d3a97f0e 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -12,11 +12,14 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/string.h>
> +#include <linux/stringify.h>
>  #include <linux/sys_soc.h>
>  #include <linux/types.h>
>  
>  #include <asm/unaligned.h>
>  
> +#include <dt-bindings/arm/qcom,ids.h>
> +
>  /*
>   * SoC version type with major number in the upper 16 bits and minor
>   * number in the lower 16 bits.
> @@ -25,6 +28,10 @@
>  #define SOCINFO_MINOR(ver) ((ver) & 0xffff)
>  #define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
>  
> +/* Helper macros to create soc_id table */
> +#define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
> +#define qcom_board_id2(id, name) QCOM_ID_ ## id, (name)

How about naming this qcom_board_id_named() ?

Regards,
Bjorn
