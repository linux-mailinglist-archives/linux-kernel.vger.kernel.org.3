Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2979593422
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiHORmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHORmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553C167D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD796122A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDBDC433C1;
        Mon, 15 Aug 2022 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660585367;
        bh=ameanm77+x8PYOd9wd5XKq8iQVXBTDasmg5+jd8ewBI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TgYbk/AT7P5eMQkOWlOHoebkIBoqir4mKPd4Bv+8sZSr55LKWWuL8mDwP4IJfewpe
         iKmZHBW0tO54OrEsbEJ2RQBPlbri8CSaGsI1TJKZ9IKwiQKlrFp2Juq3kYAonBdGLU
         8CrDiWShHnP5iFVAKKn1+YdRGf+V3wqTSDb613d9kmcHkjGxdsgpO0eVe6UG3o+lD1
         pY+FHT5/Wg+ytKJAW3iM/pWx7mp840ZTLkMp0UxJJ0wsj/hmc1R6evqDbHTRCvNMlZ
         z5mrTxR/GdBYp0u1H/dDYgPJYhki6KOfi71TchuYg+Fs27T76K69vupszquEgFdQ2o
         WCg5rcM164zlA==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
Message-Id: <166058536606.839346.1513878087140672898.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 18:42:46 +0100
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

On Fri, 5 Aug 2022 23:53:17 +0300, Andy Shevchenko wrote:
> The commit eb4a219d19fd ("regmap: Skip clk_put for attached clocks when
> freeing context") oexcluded clk_put() call on regmap freeing. But the
> same is needed for clk_unprepare() since the regmap MMIO users should
> call regmap_mmio_detach_clk() which does unprepare the clock. Update
> the code accordingly, so neither clk_put() nor clk_unprepare() would
> be called for the attached clock.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[3/5] regmap: mmio: Remove mmio_relaxed member from context
      commit: ada79bca380009a85d1e643e5a4da0c079f28225

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
