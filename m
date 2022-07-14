Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2EE575036
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiGNOAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiGNN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CA1030;
        Thu, 14 Jul 2022 06:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C88620D7;
        Thu, 14 Jul 2022 13:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2ACC34114;
        Thu, 14 Jul 2022 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657807077;
        bh=B3D92egulcgsm7n+0NyPggYVx4mKUFGfzEbgM/Tvgsk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Nt+67W1KduX3BsbSmUru6FCod7KTvA+ioLWnF26sxzcAHfSjz34RJ8PPac7yaAOmZ
         t8MNSLtjQ40sotrT/LNtiYlZX/H92nP0yBGVmRReE1mKvNehxMsY2b0ZZnIS19Pdlg
         zHQ4dwHiOPguyTlmUSDdM5BO5WGjq+m1IGH1C2vqwdrw9zWdi8VzvaHgKMCDfo7TKA
         j6E4O/PR7OCNYtHryj5p0WV+NVXHzjJ1Cli5CQLdEKDhv3j3Q8D8q0Y5uL1JZHBVjZ
         ykJo5pWwmE4x/OpaFWRVHrwhnpYCWsFbmLd5191EuVPHQLAlvuYMLN4GdHU6tG8qm4
         dVsukeS0/C09g==
From:   Mark Brown <broonie@kernel.org>
To:     vaishnav.a@ti.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     p.yadav@ti.com, vigneshr@ti.com
In-Reply-To: <20220601071611.11853-1-vaishnav.a@ti.com>
References: <20220601071611.11853-1-vaishnav.a@ti.com>
Subject: Re: [PATCH -next] spi: cadence-quadspi: Remove spi_master_put() in probe failure path
Message-Id: <165780707568.72312.6357335988927291228.b4-ty@kernel.org>
Date:   Thu, 14 Jul 2022 14:57:55 +0100
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

On Wed, 1 Jun 2022 12:46:11 +0530, Vaishnav Achath wrote:
> Currently the spi_master is allocated by devm_spi_alloc_master()
> and devres core manages the deallocation, but in probe failure
> path spi_master_put() is being handled manually which causes
> "refcount underflow use-after-free" warning when probe failure happens
> after allocating spi_master.
> 
> Trimmed backtrace during failure:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Remove spi_master_put() in probe failure path
      commit: 73d5fe046270281a46344e06bf986c607632f7ea

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
