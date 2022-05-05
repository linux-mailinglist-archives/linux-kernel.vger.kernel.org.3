Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFA51C394
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbiEEPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381139AbiEEPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:16:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEE47AD8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 091CEB82DBF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC02C385A8;
        Thu,  5 May 2022 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651763544;
        bh=xcOlH7B1feD79PhMdI0xbnMNwi95h9VhpC9qXOyXA1Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=R5R5W7Rm5eajaJmr0IF5IgjrJj+FC3BcGVMjrq4E6XAoXxoijtZVtlWcc8KAkACtY
         4ccvciw59yrH0sjok1VImkgIdqFJL0vJSx/RwzqObaI8cE7C5s4a/gG/w+n6zYRgyL
         rhSuUKTI9pQuIAPTbQLl4yJjrx8S6huEHxX2uZW/LeLyTcbNJB3uNLWoOYbAOzdbYp
         xUkBiUOu6URs1F50Qnmvc/BSIhjrxjb24RMJR2KYym6b1pu3eeJpc9qZq4tWUZ9Ud7
         epsE30TpGGtS4Qc7vIIU4YH8rZ4Xai1G9bi3KE9GnJHBxjxHcJfw4ZZtk0jjv5KDxG
         /gvxwLbQSmKlA==
From:   Mark Brown <broonie@kernel.org>
To:     zev@bewilderbeest.net, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org
In-Reply-To: <20220505043152.12933-1-zev@bewilderbeest.net>
References: <20220505043152.12933-1-zev@bewilderbeest.net>
Subject: Re: [PATCH] regulator: core: Fix enable_count imbalance with EXCLUSIVE_GET
Message-Id: <165176354355.543296.3728962840338389293.b4-ty@kernel.org>
Date:   Thu, 05 May 2022 16:12:23 +0100
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

On Wed, 4 May 2022 21:31:52 -0700, Zev Weiss wrote:
> Since the introduction of regulator->enable_count, a driver that did
> an exclusive get on an already-enabled regulator would end up with
> enable_count initialized to 0 but rdev->use_count initialized to 1.
> With that starting point the regulator is effectively stuck enabled,
> because if the driver attempted to disable it it would fail the
> enable_count underflow check in _regulator_handle_consumer_disable().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix enable_count imbalance with EXCLUSIVE_GET
      commit: c3e3ca05dae37f8f74bb80358efd540911cbc2c8

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
