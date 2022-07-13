Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E857389B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiGMOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiGMOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAFCDF5C;
        Wed, 13 Jul 2022 07:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBA5761DB6;
        Wed, 13 Jul 2022 14:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DDEC341C6;
        Wed, 13 Jul 2022 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657721996;
        bh=WuEoWieyTwj6+RKhD3ZFRC0p3grukYXOxpZAw0ePNeA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sUjAuKdLWRDsKQ6UITHibhUBhDQp7WcwWAQv9U1xzBDjJ9dLPw9zwAkilIFC/TbmG
         xQoNR0fyDu3QFIng6WfuVO69ZxKZGCRkl3jLwSbFeUWaY+Z5FoRrVaMqEewiNn6bno
         B8jkUKrv/xt+V7fzERk4pv1gWdF7FGVZBMOWrU3P5LN4kJ25n4ux67C/Ee9dK7N+/m
         MY1YFe3wxIkDtr0J4mtxmK9ew/ILaIhBQFCHWfOQciXL8JWf8l8PRcVvwWn7MFmd9g
         zTFdy/LeCd42rRSJdI3dhqZqKS0jrVWXqo4sI2s2xeXkKUT3qg/8ruq0fHRDZ7GgFG
         1ZOk+Ol6T9BAA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangyingliang@huawei.com
In-Reply-To: <20220712135504.1055688-1-yangyingliang@huawei.com>
References: <20220712135504.1055688-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] Revert "spi: simplify devm_spi_register_controller"
Message-Id: <165772199528.105087.12960448484286200331.b4-ty@kernel.org>
Date:   Wed, 13 Jul 2022 15:19:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 21:55:04 +0800, Yang Yingliang wrote:
> This reverts commit 59ebbe40fb51e307032ae7f63b2749fad2d4635a.
> 
> If devm_add_action() fails in devm_add_action_or_reset(),
> devm_spi_unregister() will be called, it decreases the
> refcount of 'ctlr->dev' to 0, then it will cause uaf in
> the drivers that calling spi_put_controller() in error path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] Revert "spi: simplify devm_spi_register_controller"
      commit: 43cc5a0afe4184a7fafe1eba32b5a11bb69c9ce0

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
