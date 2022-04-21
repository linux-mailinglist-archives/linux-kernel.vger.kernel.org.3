Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC3450A4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390369AbiDUP5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390371AbiDUP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:57:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2068A19C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C00C2B82390
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5451CC385A5;
        Thu, 21 Apr 2022 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650556491;
        bh=078tM71VAQKMQfWKHP1p8B2WKg975cqjBgJd1i002Dw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=btzGiFBDxDIjEOLo3i8V4+fsz3aT6qXnZ1VjaAZUEq96XsnEYIV+cQfAl9m+psEew
         iJjO3zW/F6lT41XTw2kO84ZdS1e38UhfoVrrh17t8vGHPk1+MrIqNPPhnpdPj4yoXh
         GDm44UHSzuTcmSg6gN/cgLMjnXMw2c4/WM1VaUyHpkSoWjZM1C42W/F9CDVAxiIidK
         1XmTUeR8NlIQM0sTlbwFjGqQyQbs9yzDg0SK5V3C/en4pprWapMA3ks39IbjuFg/cg
         QB33W+75n6p/qqzwxujkVhkUof0x5QSDaU7W5S7iwa7lbv9ElIfFzD+qiFeXl/ZIJI
         /ARUtRYM1ThdA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, weiyongjun1@huawei.com
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        Adam.Ward.opensource@diasemi.com, hulkci@huawei.com
In-Reply-To: <20220421090335.1876149-1-weiyongjun1@huawei.com>
References: <20220421090335.1876149-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH] regulator: da9121: Fix uninit-value in da9121_assign_chip_model()
Message-Id: <165055649006.364578.15777391162168231330.b4-ty@kernel.org>
Date:   Thu, 21 Apr 2022 16:54:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 09:03:35 +0000, Wei Yongjun wrote:
> KASAN report slab-out-of-bounds in __regmap_init as follows:
> 
> BUG: KASAN: slab-out-of-bounds in __regmap_init drivers/base/regmap/regmap.c:841
> Read of size 1 at addr ffff88803678cdf1 by task xrun/9137
> 
> CPU: 0 PID: 9137 Comm: xrun Tainted: G        W         5.18.0-rc2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x15a lib/dump_stack.c:88
>  print_report.cold+0xcd/0x69b mm/kasan/report.c:313
>  kasan_report+0x8e/0xc0 mm/kasan/report.c:491
>  __regmap_init+0x4540/0x4ba0 drivers/base/regmap/regmap.c:841
>  __devm_regmap_init+0x7a/0x100 drivers/base/regmap/regmap.c:1266
>  __devm_regmap_init_i2c+0x65/0x80 drivers/base/regmap/regmap-i2c.c:394
>  da9121_i2c_probe+0x386/0x6d1 drivers/regulator/da9121-regulator.c:1039
>  i2c_device_probe+0x959/0xac0 drivers/i2c/i2c-core-base.c:563
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: Fix uninit-value in da9121_assign_chip_model()
      commit: bab76514aca36bc513224525d5598da676938218

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
