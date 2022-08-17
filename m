Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE6597003
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiHQNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiHQNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC4B53
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66B2861377
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B65EC433B5;
        Wed, 17 Aug 2022 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660743298;
        bh=QLXlYBZJzXqk7q5dD7T1jSZjDh4uZpi5mNwKJPNxq/4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ebEeARR/WGOWNtUAoqEus4kkW6VLRq5PRXIAGSJSPZJIn8UHvzFVej0JMxu1gJ6OG
         EGJCChIwq5/HKq7GT9omSODM8H6Uf7Zd4vhh5A16taYnLkyNWHjRQDMF9kXQhRCHmE
         NsJea7aGI5AkcEuZjD874c/dRO3GSn7hhD2Za0EcaX1Xo5eUePW9ba8gEwkdrCR6F5
         Mod/Ab36VqpUxXfRahfNYx5cHOdATMQFrm9e1IPCp8jCgCc3MBz3uxG3halmBsV+NO
         lafWL8okhQ/J2kEZRaIdxLBzgxoEquYJp4iSMC9g6Zl6zWESA593WIxxMiU0qN2PUO
         6pMLZzIhTXBwg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220816130823.97903-1-linus.walleij@linaro.org>
References: <20220816130823.97903-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v3] regmap: Support accelerated noinc operations
Message-Id: <166074329804.125185.14608415593957538233.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 14:34:58 +0100
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

On Tue, 16 Aug 2022 15:08:22 +0200, Linus Walleij wrote:
> Several architectures have accelerated operations for MMIO
> operations writing to a single register, such as writesb, writesw,
> writesl, writesq, readsb, readsw, readsl and readsq but regmap
> currently cannot use them because we have no hooks for providing
> an accelerated noinc back-end for MMIO.
> 
> Solve this by providing reg_[read/write]_noinc callbacks for
> the bus abstraction, so that the regmap-mmio bus can use this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Support accelerated noinc operations
      commit: c20cc099b30abd50f563e422aa72edcd7f92da55
[2/2] regmap: mmio: Support accelerared noinc operations
      commit: 81c0386c1376da54f05d6916936db5220df9f97d

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
