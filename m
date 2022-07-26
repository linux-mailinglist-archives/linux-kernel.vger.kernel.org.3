Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47275813D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiGZNIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiGZNHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D726102
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EB0361582
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E9DC341C0;
        Tue, 26 Jul 2022 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840867;
        bh=dSmDXJUqNOMAFilZ+Yo373MXwK4W8pbN9LFwqUL7CpY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=V+y6d0yY1brKzbMHRAgS/myYzJM3MMpRVCLp5QM0nAH5G2UQDH2gi35JOqJ1NIBRt
         VHKcpK+snUJvj75Mc6mRedfatsrfR1QunsVSp4Qo4MsiDYMUwYM3HUnMaHBhX1gDYP
         R4xaDLawkgL/bg3C6D/JLPAzHYT2Pmb6Vqq/RmgBRovpRmL+TOqh3Ayq7Re3I7BvHZ
         2MMIgsgG5NxoyGDFkEFGNV90iRtf4jN468YZaKOeLx8uYY3iqBtpuwLN8hwLnRe/76
         HePniEUJtFYpp8guZ1LHdc4WkCeK08XVtg+r8AkjLH3QZX0U4qn8Jd5PONP5sY4BNa
         sJOeUNWhE/tyg==
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Tom Rix <trix@redhat.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, llvm@lists.linux.dev
In-Reply-To: <20220725180539.1315066-1-nathan@kernel.org>
References: <20220725180539.1315066-1-nathan@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Fix initialization of ext_intr_stat1 in i2s_irq_handler()
Message-Id: <165884086589.21705.8710449314865501400.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 14:07:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 11:05:39 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   ../sound/soc/amd/acp/acp-platform.c:117:19: error: variable 'ext_intr_stat1' is uninitialized when used here [-Werror,-Wuninitialized]
>                           if (stream && (ext_intr_stat1 & stream->irq_bit)) {
>                                          ^~~~~~~~~~~~~~
>   ../sound/soc/amd/acp/acp-platform.c:97:35: note: initialize the variable 'ext_intr_stat1' to silence this warning
>           u32 ext_intr_stat, ext_intr_stat1, i;
>                                            ^
>                                             = 0
>   1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix initialization of ext_intr_stat1 in i2s_irq_handler()
      commit: d81677410f172c2b946393c09b46ff9e8dc1b6ec

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
