Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863159329F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiHOP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiHOP6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:58:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537441A39F;
        Mon, 15 Aug 2022 08:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC806CE1133;
        Mon, 15 Aug 2022 15:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E24C433D7;
        Mon, 15 Aug 2022 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660579096;
        bh=Xll3IkIxBjiF1B8vRKiJcIQi9zLqt7tUfHw5YzZpG2Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=J7uH8gNYf+IYFzx8eVAofdoI205VmbyiDM67xP7shkD06Uu/I3vEwdG4lT60l62pC
         RzCINt7f0PRVfDm5amIBAUYFE7+NrpKPbkyxkvxHp072BU+0qFKNumstAvKkeI8jyI
         Z0napo85jEc7tX0I5MfuNa1F336qFzq+zU26zX78tBVNdpYN+yVrBH/U9reMisa/ef
         COY3eeGBs9A3jg2NsoZC3g6LefWuaTC2Wpe5m+IhmQ+V7REJhoV3sT0wBzRrDMPYrK
         n18rAl9PTK04Ys7sXR0swu0eDiAQyF45MGAP/MdKCXmoHcPto+evnlFDoPOJR4UHRt
         PNuBcaI/YXMbw==
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
References: <28324d8622da80461cce35a82859b003d6f6c4b0.1659538737.git.robin.murphy@arm.com>
Subject: Re: [PATCH] spi: bitbang: Fix lsb-first Rx
Message-Id: <166057909518.724953.5652976277254413733.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:58:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 15:58:57 +0100, Robin Murphy wrote:
> Shifting the recieved bit by "bits" inserts it at the top of the
> *currently remaining* Tx data, so we end up accumulating the whole
> transfer into bit 0 of the output word. Oops.
> 
> For the algorithm to work as intended, we need to remember where the
> top of the *original* word was, and shift Rx to there.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bitbang: Fix lsb-first Rx
      commit: 46f7ac3d7892e808c9ba01c39da6bb85cda26ecd

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
