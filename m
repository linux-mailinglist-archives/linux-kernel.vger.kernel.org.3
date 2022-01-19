Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D77493F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356579AbiASSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:02:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33414 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356584AbiASSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:02:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C4B5B81AD7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 18:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D252C004E1;
        Wed, 19 Jan 2022 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642615363;
        bh=Ejx70INqUp2bNwzG81sAJkFn1eHPuvsr8OaPqGMwytw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ot1iRp1P/g0SAktbGB2rKkL7a9cZYOfuvr2EhM2gRiu3FZDsKdeP3qY2rMFqpwsXG
         z1PtK7M83y7nRBHb6l+E8JyKv+KU1belM8zTSVZdT50wuIptNCdwXbkhO5AsXN4oWW
         00a7aiB7JeGvjSIWSli8mYOwz/mUuGIUE/PqvYXt6EyJDMXd/hHhRzSYmwAhXEEO8a
         vN2PogPrN7IsHIKnRNWq8Khhrp9k3E6zFrbH9YiZAUtWkt+OL6DUqGs+XZ5N9VTirc
         x2Ch7XQPxmSOyqYXKyGks9oI2JIp7ljoE8yCJK9FWx+h7qWtQPTLHLDVSRCrzt+rsu
         6HWS1YiftM6nA==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Watson Chow <watson.chow@avnet.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20220115033603.24473-1-rdunlap@infradead.org>
References: <20220115033603.24473-1-rdunlap@infradead.org>
Subject: Re: [PATCH] regulator: MAX20086: add gpio/consumer.h
Message-Id: <164261536190.2816906.3585022513253702199.b4-ty@kernel.org>
Date:   Wed, 19 Jan 2022 18:02:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 19:36:03 -0800, Randy Dunlap wrote:
> max20086-regulator.c needs <linux/gpio/consumer.h> for an enum, some
> macros, and a function prototype. (seen on ARCH=m68k)
> 
> Adding this header file fixes multiple build errors:
> 
> ../drivers/regulator/max20086-regulator.c: In function 'max20086_i2c_probe':
> ../drivers/regulator/max20086-regulator.c:217:26: error: storage size of 'flags' isn't known
>   217 |         enum gpiod_flags flags;
> ../drivers/regulator/max20086-regulator.c:261:27: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
>   261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>       |                           ^~~~~~~~~~~~~~
> ../drivers/regulator/max20086-regulator.c:261:44: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>   261 |         flags = boot_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
> ../drivers/regulator/max20086-regulator.c:262:27: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>   262 |         chip->ena_gpiod = devm_gpiod_get(chip->dev, "enable", flags);
> ../drivers/regulator/max20086-regulator.c:217:26: warning: unused variable 'flags' [-Wunused-variable]
>   217 |         enum gpiod_flags flags;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-linus

Thanks!

[1/1] regulator: MAX20086: add gpio/consumer.h
      commit: b4c18c18ebf7cf1e602af88c12ef9cb0d6e5ce51

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
