Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8316F5A60A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiH3KXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiH3KWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CB540BE7;
        Tue, 30 Aug 2022 03:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B275A612B9;
        Tue, 30 Aug 2022 10:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F313BC433C1;
        Tue, 30 Aug 2022 10:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661854893;
        bh=hN4IvqLBUwQ7LA2EASNAfcsy15aflmpkS+M3B+PyQbA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eJLXCcY+LXCaNpPgZPN24kpSvkPulyeIQZIVp9JV8OF7C7LjRMK66t9FRpGN/7obJ
         iCO02vd1Td2RvzA0zKkkkUet3HNvczHQSJInTBG0MtwUGBqiQYbJTv5+czIHCVmc7w
         mefwBz2tXDRi3YfGEBjZzdvEOlJSyaRhQNbkHhmYkfGULZDEGzLAuFDG78SnPqCzQ2
         6RTPHo+lE2K+H5NaUoGGRk76F3iSiyyVjekbSfxhw37YZ9KtKqqDTBJ6BeeBpc0n3s
         hIguvnC9X58mmbEyYTkwZwQBp82FXITyyDSqaNpCSgivsYejyt5r0Eisl3+TCXX5pr
         pS9EM/5Kek4nQ==
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
In-Reply-To: <20220829220334.6379-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220829220334.6379-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] dt-bindings: spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings
Message-Id: <166185489065.1123097.6582178011318784987.b4-ty@kernel.org>
Date:   Tue, 30 Aug 2022 11:21:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 23:03:34 +0100, Lad Prabhakar wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings when running dtbs_check:
> 
> arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: spi@e6e90000: Unevaluated properties are not allowed ('power-domains', 'resets' were unexpected)
> 	From schema: Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> 
> The main problem is that SoC DTSI's include power-domains and resets
> property, whereas the renesas,sh-msiof.yaml has 'unevaluatedProperties:
> false'. So just add optional power-domains and resets properties.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings
      commit: f4d381038700361f92d157288b0e18d87fab6c6d

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
