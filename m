Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72BE59C2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiHVPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiHVPbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:31:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56EA1572C;
        Mon, 22 Aug 2022 08:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 401C961143;
        Mon, 22 Aug 2022 15:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE8BC433D6;
        Mon, 22 Aug 2022 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661182302;
        bh=gsEqIb6Pxtq0JpCj/B3Gh7Z7N4KJZxCB1RnKmicB4J0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PJ7KOq9Wne/JqmHebqtz7Y8zX4jhVxSCR3NJOfI+Am1kPI0wM1pTrYJkpozJbldMg
         EOLlGx+mNAfaIczeMlOvoj/jwyv57IZsXwn34Eg2mz9C8P1FV7dYw6EtFk9kAeD7U/
         SRGoeD4btRfiV45mdxG4TU1XKNKBlOR/SWA5UCc7ScCDRri6Wp4oZMB0pCkBQ72wqq
         ukhvymcdWVqiPvhBSMEj9akH1qu2GPH1MXTzcAXfqMdHEzn0eogH/OHttiknR0j3HI
         mGcMMhYwMGk9kBVXHH1K30yceWcV2MbQ8nUBX0OT1zjcEOPG2MyWDr/K3D7qA7UK54
         zLR3Dxg4YoHRA==
From:   Mark Brown <broonie@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        niravkumar.l.rabara@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220813042616.1372110-1-niravkumar.l.rabara@intel.com>
References: <20220813042616.1372110-1-niravkumar.l.rabara@intel.com>
Subject: Re: [PATCH v2] spi: cadence-quadspi: Disable irqs during indirect reads
Message-Id: <166118230149.175565.15964533101791462074.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 16:31:41 +0100
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

On Sat, 13 Aug 2022 12:26:16 +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> On architecture where reading the SRAM is slower than the pace at
> controller fills it, with interrupt enabled while reading from
> SRAM FIFO causes unwanted interrupt storm to CPU.
> 
> The inner "bytes to read" loop never exits and waits for the completion
> so it is enough to only enable the watermark interrupt when we
> are out of bytes to read, which only happens when we start the
> transfer (waiting for the FIFO to fill up initially) if the SRAM
> is slow.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Disable irqs during indirect reads
      commit: 9ee5b6d53b8c99d13a47227e3b7052a1365556c9

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
