Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F94C7C99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiB1WBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiB1WBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:01:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A5434B7;
        Mon, 28 Feb 2022 14:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1536B61283;
        Mon, 28 Feb 2022 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC45BC340F4;
        Mon, 28 Feb 2022 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646085621;
        bh=Wb90RxImS2AgSxc/qOLbamqSz7YM6BOWom2v7EY9JXo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iSJBkk24KAZWr8zbirvAshQHOVJC5ageHX6CoQSzKU317bxDLhZKOKuUx9YnS5Deq
         zauwajKQhvOWDcsICABmTHpfafrP8grVgvbIAgNTS79u4GGYC3Cg4bsPVa9K9D73I1
         QcRjInY67w/ihQlMmt68ZSxGJ3y5VSX7HGcb3IVTCngzOIVif9VG7NiCziWxH3joqs
         BRQpehg6+5aoKa6MwoAxZJemOOLszGoTMhFT8rmJ9kITtwUOKl+rS/4twbOtji8WBS
         NpLJdGNZJtltWuh73ItBdnQkOmhVIQwAJwYUx268j9K/jlQwl92XzDUbTAZqp8Cd1P
         030VmRR5U9opQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     linux-kernel@vger.kernel.org, ying.xue@windriver.com,
        richard.danter@windriver.com, linux-spi@vger.kernel.org
In-Reply-To: <20220217141234.72737-1-yun.zhou@windriver.com>
References: <20220217141234.72737-1-yun.zhou@windriver.com>
Subject: Re: [v2][PATCH] spi: use specific last_cs instead of last_cs_enable
Message-Id: <164608561951.2299679.13478091058345926726.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 22:00:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 22:12:34 +0800, Yun Zhou wrote:
> Commit d40f0b6f2e21 instroduced last_cs_enable to avoid setting
> chipselect if it's not necessary, but it also introduces a bug. The
> chipselect may not be set correctly on multi-device SPI busses. The
> reason is that we can't judge the chipselect by bool last_cs_enable,
> since chipselect may be modified after other devices were accessed.
> 
> So we should record the specific state of chipselect in case of
> confusion.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: use specific last_cs instead of last_cs_enable
      commit: 6bb477df04366e0f69dd2f49e1ae1099069326bc

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
