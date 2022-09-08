Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F55B22CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiIHPvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiIHPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:50:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C0F1F37;
        Thu,  8 Sep 2022 08:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0542AB8211C;
        Thu,  8 Sep 2022 15:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B5AC433C1;
        Thu,  8 Sep 2022 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662652255;
        bh=5/+ZIXNie4VnekxYHQs89+aKR6HkS+PDbD6+ARuWepU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t5wYePL63GetzwQFLIZa2kHBN+Rp6d6l9Lg8s3SQ8lfpGptLzdYeXmfocUnSq7Hzh
         7EQLwKm2W7LySJQh4Qk4J2tfF00bEjv08opKP6oRz9dZgoRWyX4/cN9tdYbABdc4Eh
         1xqPRJVm/moL4kWXSy8SjKfQfkiviwNysuJjBJc6grnJOd3SpEjc3shWh+kQskjdE0
         D+U544D4FlqwUymi0UT+Zea9mGXOcTd6o8hOzVTeqSxF7VN0qXJBK0cKzeCOZ2nRde
         hOInzGSdglm3wqO9S59xrhpgd26MkP254Fqjz6KcC5ZMOBO0QfyNIhF9iKtFUc4jEV
         EUypIR/XMYnVw==
From:   Mark Brown <broonie@kernel.org>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+kernel@kernel.org>
In-Reply-To: <20220907204924.173030-1-ahalaney@redhat.com>
References: <20220907204924.173030-1-ahalaney@redhat.com>
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies
Message-Id: <166265225292.288960.8055654025711906863.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 16:50:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 15:49:24 -0500, Andrew Halaney wrote:
> For RPMH regulators it doesn't make sense to indicate
> regulator-allow-set-load without saying what modes you can switch to,
> so be sure to indicate a dependency on regulator-allowed-modes.
> 
> In general this is true for any regulators that are setting modes
> instead of setting a load directly, for example RPMH regulators. A
> counter example would be RPM based regulators, which set a load
> change directly instead of a mode change. In the RPM case
> regulator-allow-set-load alone is sufficient to describe the regulator
> (the regulator can change its output current, here's the new load),
> but in the RPMH case what valid operating modes exist must also be
> stated to properly describe the regulator (the new load is this, what
> is the optimum mode for this regulator with that load, let's change to
> that mode now).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies
      commit: 08865c2150392f67769a9d6e0b02800be226a990

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
