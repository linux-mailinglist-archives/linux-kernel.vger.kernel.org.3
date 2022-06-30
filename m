Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2A56193A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbiF3LaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiF3LaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B8B51B28
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50E66B82A1A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71319C34115;
        Thu, 30 Jun 2022 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656588617;
        bh=gzDOHcejGu4JioM05HpcNWxB/O66gnE2CvPqcNhcsQo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CimQvuX/++FtooBdfVaGQKFl2+Pb1O8v4oSpfSojUuL4n7lA57QcJAwfB/aX0vJ+7
         531Q/lRTYXMloZ7tPASrqQ7jUfEb52YRf0uJCXSJoUsUcmnE1gqZ0gen6zjy4nkXO+
         nWgogb8hfvONDEJXmxVhzXV5Ud8aUQ41GYWa+ozWeiOS/0C0bZBQCu4M4QCnAN315j
         AOhGhyHOEnmZrLN2UzJMkrCc2Cb6Tu74bSAOPA54CCrX0VimfEp3dTTRZXJxM9xou/
         qohZ92xNRQkwsRgB/cBiQ14Q93kXQKq8gPKy4dllGSCDZXIql1TDJYwu4Aczu1E4tq
         BHhacON8Ac1Jg==
From:   Mark Brown <broonie@kernel.org>
To:     u0084500@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chiaen_wu@richtek.com, cy_huang@richtek.com,
        matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-mediatek@lists.infradead.org, alice_chen@richtek.com
In-Reply-To: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
References: <1656466861-7737-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 1/2] regulator: mt6370: Use 'fwnode_gpiod_get_index' to fix gpio parsing
Message-Id: <165658861401.321126.9625331227015919731.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 12:30:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 09:41:00 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> From the common binding, 'enable-gpio' or 'enable-gpios' are all well
> for external 'enable' gpio.
> 
> 'gpiod_get_from_of_node' only parse the 'enable' property, it need to
> add the gpio suffix. It's more convenient to use fwnode_gpiod_get_index.
> Although fwnode parsing is not preferred, but 'of_parse_cb' already can
> guarantee the callback will only be used by regulator of_node parsing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: mt6370: Use 'fwnode_gpiod_get_index' to fix gpio parsing
      commit: 4806c991bf4ff959acf921ea72f931a945a968ae
[2/2] regulator: mt6370: Use the correct header for platform_device_id
      commit: 46ae6fb58fd49c4cb2d1ca34e87d603b7c96ba97

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
