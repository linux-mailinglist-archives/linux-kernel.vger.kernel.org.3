Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296B4FFCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiDMRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiDMRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E66C977;
        Wed, 13 Apr 2022 10:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22C861EE3;
        Wed, 13 Apr 2022 17:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F147C385A3;
        Wed, 13 Apr 2022 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871380;
        bh=2vNABeBZQ+H0ZHBmPE9Li3qkyTfEc1acEFbKIGMvhic=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cBFQDx0apSqSgapak4T6kjgMK5eLVa1o1UFFHyVGNeld3JMKnzi4Vb4DrmFtRJUR1
         wtfl62qJAuXpp6GM4NjkCM30XbTma2nhOwnaoCtnvdI5jmFwNRfcbirSaqA+Gr6RJM
         EKCSutm57rcPdAO16zaP6n9UDeNNz/S4aOFwYCtca5G0Zu3+3mSz468Dntyy71aA6P
         kSKdlYbkMA4QJex0pzAolJSu0ithWdxVAylEwe+ENTtZ9CMPufp1lg4cVmjaquyIkr
         zkOFXaqV7shwmLNvq0jm+Y9uf8iO23aACqRMLqpzP0v0VdWx1vrzj/NEHJWHy3RUO6
         xnT1qgXp8w4Eg==
From:   Mark Brown <broonie@kernel.org>
To:     p.yadav@ti.com, matthias.schiffer@ew.tq-group.com
Cc:     tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20220406132832.199777-1-matthias.schiffer@ew.tq-group.com>
References: <20220406132832.199777-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v2] spi: cadence-quadspi: fix incorrect supports_op() return value
Message-Id: <164987137835.70105.4695547877202856949.b4-ty@kernel.org>
Date:   Wed, 13 Apr 2022 18:36:18 +0100
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

On Wed, 6 Apr 2022 15:28:32 +0200, Matthias Schiffer wrote:
> Since the conversion to spi-mem, the driver advertised support for
> various operations that cqspi_set_protocol() was never expected to handle
> correctly - in particuar all non-DTR operations with command or address
> buswidth > 1. For DTR, all operations except for 8-8-8 would fail, as
> cqspi_set_protocol() returns -EINVAL.
> 
> In non-DTR mode, this resulted in data corruption for SPI-NOR flashes that
> support such operations. As a minimal fix that can be backported to stable
> kernels, simply disallow the unsupported operations again to avoid this
> issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: fix incorrect supports_op() return value
      commit: f1d388f216aeb41a5df518815ae559d14a6d438e

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
