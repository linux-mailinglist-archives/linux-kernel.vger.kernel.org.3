Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DC59C3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiHVQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiHVQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:16:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDB932A8D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CC4DB80923
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF83CC433D6;
        Mon, 22 Aug 2022 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661185010;
        bh=UiXb2+IBr/+FeUeGj2fK3A3sBhK3Gk+nK73Gmj2BI44=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OIvi7Hy3Wy7YzQaAFa4txlFtLSxYVbwEEI0bs0/4ELJ42FcyDaSBlaI8vhb0QWTK6
         e3MoT1LExcjjJvlzN9lxCCDPq0+7FLgo4AFgF2QMZ8fhQQkiyvpG7qHnRvrb0SPPRg
         S/NKmgMUqDvzJTcL7RWxXUMz1MfYW8ZTKQzXVNE20IYmO1gGkRPYuHoJVXZpR4Lj9G
         fS0sDNZOP6/DMywzVMdvsH5qk/N8KftQftDdL7+HR5zaBYOOCZEnL58/5pUaLQXUF2
         wp1pwK4fcPBvu+DeCW4UWGWILgr9Wy0aAuyzNzdcwcDAigpQ2fyFNHaiRrVS7Tys0k
         +GQuYvgHiZdsA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Andrew Halaney <ahalaney@redhat.com>
Cc:     dianders@chromium.org, bmasney@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220819194336.382740-1-ahalaney@redhat.com>
References: <20220819194336.382740-1-ahalaney@redhat.com>
Subject: Re: [PATCH] regulator: core: Clean up on enable failure
Message-Id: <166118500944.215002.10320899094541954077.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 17:16:49 +0100
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

On Fri, 19 Aug 2022 14:43:36 -0500, Andrew Halaney wrote:
> If regulator_enable() fails, enable_count is incremented still.
> A consumer, assuming no matching regulator_disable() is necessary on
> failure, will then get this error message upon regulator_put()
> since enable_count is non-zero:
> 
>     [    1.277418] WARNING: CPU: 3 PID: 1 at drivers/regulator/core.c:2304 _regulator_put.part.0+0x168/0x170
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Clean up on enable failure
      commit: c32f1ebfd26bece77141257864ed7b4720da1557

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
