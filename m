Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C955A215F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbiHZHCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244686AbiHZHCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C076BA9EB;
        Fri, 26 Aug 2022 00:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A3261C2F;
        Fri, 26 Aug 2022 07:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C527C433D6;
        Fri, 26 Aug 2022 07:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661497370;
        bh=9H+D7s1IwU51jZwiF9ZOTedbH+3hTtzpcIr/Dur84VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JstaSn+QgEaGDQbdq6Q7htpbmrxCHa0yGlZYxNMMPk1pykNs0xJEPzQez8wldYe7a
         GCQ+xmhwgBDxVbC20XN8FP3AZGaVsq+bBqax3U4ABYiT7VRFBsZ8fUhiH8Ajw7z4s5
         ai/hkkZRyDwdFx6gpJXKZUGiUMTG3ubNBIYJUU2/l7/lSVqNLf/5Q84tQRe2Q2BgTP
         6X4bx0BuQPj9m1TdCOW4ItHDQ0fM/ylo326q1r5c7Os8sQhfNk021O3lZsIuhtSby7
         EFRwhU/GjCQViWCmS+WGl2smpYvFm95BXn7RH2SaOf58unI30wN7Z8rlP5bw3Ml8zH
         b+HK/AE6vAeqg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oRTMn-0000jW-DY; Fri, 26 Aug 2022 09:02:57 +0200
Date:   Fri, 26 Aug 2022 09:02:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] arm64: dts: qcom: Fix broken regulator spec on RPMH
 boards
Message-ID: <YwhwIX+Ib8epUYWS@hovoldconsulting.com>
References: <20220825164205.4060647-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825164205.4060647-1-dianders@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:41:58AM -0700, Douglas Anderson wrote:
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") several boards were able to
> change their regulator mode even though they had nothing listed in
> "regulator-allowed-modes". After that commit (and fixes [1]) we'll be
> stuck at the initial mode. Discussion of this (again, see [1]) has
> resulted in the decision that the old dts files were wrong and should
> be fixed to fully restore old functionality.
> 
> This series attempts to fix everyone. I've kept each board in a
> separate patch to make stable / backports work easier.
> 
> Affected boards were found with:
>   rpmh_users=$(git grep -l -i rpmh -- arch/arm*/boot/dts/qcom)
>   set_modes=$(grep -l regulator-allow-set-load ${rpmh_users})
>   but_no_allowed_modes=$(grep -l -v regulator-allowed-modes ${set_modes})
> 
> Fix was applied with:
>   for f in ${but_no_allowed_modes}; do
>     sed -i~ -e \
>       's/^\(\s*\)regulator-allow-set-load;/\1regulator-allow-set-load;\n\1regulator-allowed-modes =\n\1    <RPMH_REGULATOR_MODE_LPM\n\1     RPMH_REGULATOR_MODE_HPM>;/'\
>       $f
>   done
> 
> Then results were manually inspected. In one board I removed a
> "regulator-allow-set-load" from a fixed regulator since that was
> clearly wrong.
> 
> [1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid
> 
> 
> Douglas Anderson (7):
>   arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed

>   arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
>   arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed

These two should be rebased on

	https://lore.kernel.org/all/20220803121942.30236-1-johan+linaro@kernel.org/

which disallows mode-switching for all but the UFS regulators (this
series addresses the DP PHY LPM regression we've discussed elsewhere).

>   arm64: dts: qcom: sc8280xp-thinkpad-x13s: Specify which LDO modes are
>     allowed

And this one should not be needed at all with the above series applied.

>   arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are
>     allowed
>   arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are
>     allowed
>   arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed

Johan
