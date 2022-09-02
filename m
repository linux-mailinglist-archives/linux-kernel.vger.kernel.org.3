Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB14D5AB523
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiIBP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiIBP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3618D2E69C;
        Fri,  2 Sep 2022 08:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF9861EB2;
        Fri,  2 Sep 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6F3C433B5;
        Fri,  2 Sep 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130972;
        bh=juCmVv9yVRVu6vgAJSepeShnFkMGD40VL3ymb2cpIs8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HKoQkgI7WYHu4jMuGdUDcInPVifE5wUHoBAbBuoGzIZ3f102JB2nF5lBgAl3+xBBZ
         PYcEkQR7mGB/ftpCC9CPk46Z1I4EvjwFvbHVvMAKHtGlUx47D1hKSU2655Oa8zfTi7
         r6Ei+/5/SY6kppspVMP/qGH2P4PALGSp4gvRISLy4NljZpLWlp9ismdp3oyVXNaMb+
         92n4zgLjn8M30LyF/VZNQ/eJJj7mSkd183iRdpw4HRpNV0t8OfJQV4Rfr/E+1DPAzl
         t6vx3pxediMjXTEHEKRNrbc5Qw9CzDCNZibsghE0Jk7cPbZmnChPOiLPdwvEmYjSQ/
         3wWWB/qS80djA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Casper Andersson <casper.casan@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220901123630.1098433-1-david@protonic.nl>
References: <20220901123630.1098433-1-david@protonic.nl>
Subject: Re: [PATCH] spi: spi.c: Fix queue hang if previous transfer failed
Message-Id: <166213097084.48295.10048279518019656460.b4-ty@kernel.org>
Date:   Fri, 02 Sep 2022 16:02:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7d1a0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 14:36:30 +0200, David Jander wrote:
> The queue worker always needs to be kicked one final time after a transfer
> is done in order to transition to idle (ctlr->busy = false).
> 
> Commit 69fa95905d40 ("spi: Ensure the io_mutex is held until
> spi_finalize_current_message()") moved this code into
> __spi_pump_messages(), but it was executed only if the transfer was
> successful. This condition check causes ctlr-busy to stay true in case of
> a failed transfer.
> This in turn causes that no new work is ever scheduled to the work queue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi.c: Fix queue hang if previous transfer failed
      commit: 9c9c9da7aa108e6bf952c18289527a5234e4fc59

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
