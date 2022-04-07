Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A34F85AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbiDGRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345995AbiDGRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:15:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7CD194FD0;
        Thu,  7 Apr 2022 10:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43AF5B8254E;
        Thu,  7 Apr 2022 17:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD50C385A4;
        Thu,  7 Apr 2022 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649351577;
        bh=xoNNkCB4KczoI5BLU4qiA3mDQpdHlNlRPZpZI5L4AsI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YycBXWVYYJmqhOL6ZSUZNReU6W2XswiR8+yjRYGc3HC08TwOBg4uyWBRr5TNZyoLQ
         N6Swe3Mq9vyKHJuhbaIQwcOAgSEPKqCtJgo3fI56GHC+VSpiVBiOv2g0BDCDMroseu
         X8/oBvRxOUj8qavbJVzCQDMRicT/gVwI47YbmUVAM8pCVm6MjzPuyIARvZKDqlK0U/
         MFtxfypz4YVhjA36o8YkJFtL5qM9bOxdoChG+HrqdPBRr9SXuNIqzVnDi7nlIYyWiZ
         96Q8KvDjtsumPsKbLxwviSXJHmjam7BU7EkuPw2ZY3kOV7ufUJUgtQeVvgzX46OMwA
         OuI2haGRk6eXA==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.schiffer@ew.tq-group.com
Cc:     tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        vadivel.muruganx.ramuthevar@linux.intel.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220331110819.133392-1-matthias.schiffer@ew.tq-group.com>
References: <20220331110819.133392-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH] spi: cadence-quadspi: fix protocol setup for non-1-1-X operations
Message-Id: <164935157541.1057547.6578731972016383100.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 18:12:55 +0100
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

On Thu, 31 Mar 2022 13:08:19 +0200, Matthias Schiffer wrote:
> cqspi_set_protocol() only set the data width, but ignored the command
> and address width (except for 8-8-8 DTR ops), leading to corruption of
> all transfers using 1-X-X or X-X-X ops. Fix by setting the other two
> widths as well.
> 
> While we're at it, simplify the code a bit by replacing the
> CQSPI_INST_TYPE_* constants with ilog2().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: fix protocol setup for non-1-1-X operations
      commit: 97e4827d775faa9a32b5e1a97959c69dd77d17a3

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
