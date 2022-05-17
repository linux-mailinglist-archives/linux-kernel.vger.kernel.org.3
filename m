Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD452A77D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiEQP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350715AbiEQP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6282049F8C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B308BB81AB1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB2FC34116;
        Tue, 17 May 2022 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803170;
        bh=HhBecZ0/0C++sVEsHjpIv1pbIB0KELfp5GVr+V5tmag=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DxItctP5gYRBhGRnJYuIlPvB+JbtsBMJ0TnVwULf86ngLiQ9TJRpgqOb2Zomc8zxE
         bveWrVURMhsqD4oLrADLkO6FEOlXltAniwgUzlo/L+ythhY07hNVYlbZXtRl88Hmi1
         0Pd0m4zMBzvzGomRuwdm4x8EtTBJ217AhJ7MHaForkNM3yGuFtlC/Av61OFIhGpNpt
         9nQoaJt5JXRfS3tRqe3q4QXEYnPN0lByjdL4aDXhUhXk2l3zFiI31b+qtJX63UVMwv
         ccaOnO3vgwGpfx/i6HNcxL84ki9IGEmSuF7B9RNTcs5jdeYbxzYuqb2JxCzwHJFL0m
         hx2bRbcsIMTOg==
From:   Mark Brown <broonie@kernel.org>
To:     linma@zju.edu.cn, tiwai@suse.com, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220516092035.28283-1-linma@zju.edu.cn>
References: <20220516092035.28283-1-linma@zju.edu.cn>
Subject: Re: [PATCH v0] ASoC: rt5645: Fix errorenous cleanup order
Message-Id: <165280316877.1635268.8412157029649432133.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 17:20:35 +0800, Lin Ma wrote:
> There is a logic error when removing rt5645 device as the function
> rt5645_i2c_remove() first cancel the &rt5645->jack_detect_work and
> delete the &rt5645->btn_check_timer latter. However, since the timer
> handler rt5645_btn_check_callback() will re-queue the jack_detect_work,
> this cleanup order is buggy.
> 
> That is, once the del_timer_sync in rt5645_i2c_remove is concurrently
> run with the rt5645_btn_check_callback, the canceled jack_detect_work
> will be rescheduled again, leading to possible use-after-free.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5645: Fix errorenous cleanup order
      commit: 2def44d3aec59e38d2701c568d65540783f90f2f

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
