Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A5F541CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383556AbiFGWFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379210AbiFGVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B759F106A5D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0170C61724
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86F0C3411F;
        Tue,  7 Jun 2022 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654627756;
        bh=RYYhrO8fEP8cSRkLcxoofnSD4Lmtn28uxTvW4Mk4fDo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=EIVC50APv1WnV/YPh/hwX/QQRcPyt9wz6IQTW8RaidD0DhRZti7uhkD13w1xoFLm7
         7NnJi9qEHEW2WNAJkorw5WgXxXNp4dlh/CckY1VN+gzJoklz9FVH5u8iC/G9v9GAOB
         6iebOKO5VQC4SMZ4bwthTKgpbvcvqh1cvaXKX3d61do3lZZgEDzLznBiL5wSBQI0Rp
         WfSzSlq0k5o+kHf7crSQa2HPA45WBBWgjE3v9F0GVwkPQUkexF42kSAwViqqEf5FPd
         pWrmymQ/WT9uafxR5w0c6fWl8uijM6+bQZNvDmr/dnjtNBsvIorgSItBZW+hRZ9/6D
         oh8AwLoKIrWtw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linmq006@gmail.com,
        s.nawrocki@samsung.com, perex@perex.cz,
        krzysztof.kozlowski@linaro.org, tiwai@suse.com
In-Reply-To: <20220602130218.14901-1-linmq006@gmail.com>
References: <20220602130218.14901-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Fix error handling in aries_audio_probe
Message-Id: <165462775454.3480784.5012321883700193915.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 19:49:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 17:02:17 +0400, Miaoqian Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> This function is missing of_node_put(cpu) in the error path.
> Fix this by goto out label. of_node_put() will check NULL pointer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Fix error handling in aries_audio_probe
      commit: 3e2649c5e8643bea0867bb1dd970fedadb0eb7f3

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
