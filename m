Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEF450E746
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiDYR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244099AbiDYR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:28:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE0A4130D;
        Mon, 25 Apr 2022 10:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 982CECE18E6;
        Mon, 25 Apr 2022 17:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A42EC385A9;
        Mon, 25 Apr 2022 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907493;
        bh=mvFjQvGDLrQO3UKthtsQolM5bkR9ybZ3sqbDhcll+MQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X0ZAS4g1JdQ/DXyYYIoAgCbcfFX785SKb0rjMWSvEyrXyRxYMZqdrFdA9FT/OVrn9
         f2iPkph0DJym6mdTSfnwod/Usn0LDH81dB/mktNAQHBuySR9sJ+TrWVKY0xlI8tVnW
         oGsny/gj7F7ome6N1LDD3fm8qp4TUxc3SKitDO0dIaYbJnrGFRbPEMmm+G0lxaL+Mz
         ZWeQM7a6Gc2YblMutHULc59e2Hq2jxa1h+3N+P3+WyrjDP2keYhYsoP3bZpVMLKbS9
         ob49Y5WzZOZYf4o3lObhMwNrKA3GhCZj03EaAvvHR2qVEEgkb5/qtsu42vaZOfvRMV
         Yacia59+nleDA==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, tudor.ambarus@microchip.com,
        p.yadav@ti.com, vadivel.muruganx.ramuthevar@linux.intel.com
In-Reply-To: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
References: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] spi: cadence-quadspi: drop cqspi_set_protocol()
Message-Id: <165090749221.584172.15272036659287081946.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:52 +0100
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

On Wed, 20 Apr 2022 17:56:15 +0200, Matthias Schiffer wrote:
> As suggested, this removes the whole cqspi_set_protocol() function, as it
> is not actually needed:
> 
> - Checks for unsupported operations are already handled by supports_op(),
>   removing the need to distinguish DTR and non-DTR modes in the buswidth
>   setup
> - supports_op() ensures that the DTR flags match for all relevant parts of
>   an operation, so op->cmd.dtr can be used instead of copying the flag to
>   the cqspi_flash_pdata
> - The logic in cqspi_set_protocol() is moved to cqspi_calc_rdreg() and
>   cqspi_write_setup() (with a helper macro CQSPI_OP_WIDTH())
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-quadspi: drop cqspi_set_protocol()
      commit: 28ac902aedd18abf4faf8816b1bea6623d0e9509
[2/2] spi: cadence-quadspi: allow operations with cmd/addr buswidth >1
      commit: 1aeda0966693574c07c5fa72adf41be43d491f96

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
