Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB784FE92A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiDLT6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiDLT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A97164BF8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A25B61BEF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F43C385A8;
        Tue, 12 Apr 2022 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649793031;
        bh=IRI4XQzYsqIKVLc2NQrdZWqO6svmByi3NwsEZjTI4Ec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ryqm5rbZis+FFXwbyX/l4pcJVazcSof7fjiTGpUNx23iA53Mz/FjEhu47CoObzWTv
         C/R2VleP0rYfA4s1i1quH0zWaDOabVflye42WXNSpra/ycdPdSYhpOJCK8B9eBf9DH
         4vC5gQ8nIXJqrv/nvbs6klhOOe2gN38v9tOz2XY9kvb28MpJfDNcHGWcMqqGNCM/aZ
         Nu9/DRNV8TssvpsdJqYO/sJAJwzaXyyFvdaMEmv701gRA7CgNhr9eLPrCVDsDYcBaw
         U4nfnw8o6+FpsOI/8yvGxRaRUNBn89T4H7AKNxvBspH2JgEjUiDVJdq7DP7r35jc/2
         a+ppXOb2mO1PQ==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220412163927.1303470-1-rf@opensource.cirrus.com>
References: <20220412163927.1303470-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Fix overrun of unterminated control name string
Message-Id: <164979303081.449327.16793414512968400823.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 20:50:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 17:39:27 +0100, Richard Fitzgerald wrote:
> For wmfw format v2 and later the coefficient name strings have a length
> field and are NOT null-terminated. Use kasprintf() to convert the
> unterminated string into a null-terminated string in an allocated buffer.
> 
> The previous code handled this duplication incorrectly using kmemdup()
> and getting the length from a strlen() of the (unterminated) source string.
> This resulted in creating a string that continued up to the next byte in
> the firmware file that just happened to be 0x00.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Fix overrun of unterminated control name string
      commit: 5b933c7262c5b0ea11ea3c3b3ea81add04895954

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
