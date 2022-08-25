Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2459E5A1189
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiHYNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiHYNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F9AA2218
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6EF61CB5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0F1C433D6;
        Thu, 25 Aug 2022 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661432967;
        bh=4an2Zm5Z7L3zqjMAq0Mm+lIubANUcp1jxvvwxCkhBqQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GB2nBwzbLyFl6QV4T5ea0q8+U1cvh6HcD7X+45UFPCvEjDsIc2cLyeIss1f/XMq1l
         0WDNk3LxpfGkYyAf2Z2J4gOQynnRqkXMdAG6TQbUbYnV4VI27fFLjIjAH4vEXYqH44
         lAkAwMYfmu5wVkHzJaMFr2105H3JSN9NK/soOCv+NFuLYVneALSJTu3SBqD4WXREg7
         fzNZgrZFT2ZyK/2qvZwyfZQIOb74VToxdlMYZVlnCOmkN4WFp5Q1uW5NFvyrtcQ8ln
         /+DcZg9p1qvlykCQ3d7QxyINzUBOGd8hwEU/Q3M2C+/2RH4s1Rjy5HnOngKsl82WEH
         lAPslG9jHgJRQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220825111922.1368055-1-xiaolei.wang@windriver.com>
References: <20220825111922.1368055-1-xiaolei.wang@windriver.com>
Subject: Re: [v2][PATCH] regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()
Message-Id: <166143296648.103302.14963549343050177347.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 14:09:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 19:19:22 +0800, Xiaolei Wang wrote:
> The pfuze_chip::regulator_descs is an array of size
> PFUZE100_MAX_REGULATOR, the pfuze_chip::pfuze_regulators
> is the pointer to the real regulators of a specific device.
> The number of real regulator is supposed to be less than
> the PFUZE100_MAX_REGULATOR, so we should use the size of
> 'regulator_num * sizeof(struct pfuze_regulator)' in memcpy().
> This fixes the out of bounds access bug reported by KASAN.
>   BUG: KASAN: global-out-of-bounds in pfuze100_regulator_probe+0x380/0x8b8
>   Read of size 3968 at addr c3390640 by task swapper/0/1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pfuze100: Fix the global-out-of-bounds access in pfuze100_regulator_probe()
      commit: 78e1e867f44e6bdc72c0e6a2609a3407642fb30b

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
