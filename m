Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD92047F00E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353215AbhLXQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353211AbhLXQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:17:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B57C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 08:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 495B6B82337
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 16:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9657C36AF6;
        Fri, 24 Dec 2021 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640362658;
        bh=F8xnkK+XpNG5NYxvlj4BQZhPsYtY54y6CQF2ovCcV/Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gzWNJU/3nh3+RRe1YRafjKNiCEuPqx3j7N6ua573I6A5go4D/y3I7yEXM7ekKdhK5
         xnCCCNw+OaqbEhM3lYyPInWwnXidOB4Gy0HFr/i6ApgkWkSkzCWg5fFNtmYSR1bWG7
         eoZBwDwgHVyQaJbKYCq/aI9pbSW0REthSsATgqZjPA/9nCMKjvZJpZlWDzvJ07HgJj
         LSnKAFv4yr3/bKRfH2T/vrDfTsoXqSQmSoDWLE5x6X/rKLGEuarqEGfeDIKBXGiXdQ
         5uwOopUUi4rIVREeXjuWIDqUUGFyUen5J8G0h/O+b+WxX35uWX1SCIf37Du6SQbY7L
         gZmQaY3Oi3f6A==
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, lgirdwood@gmail.com,
        matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211222015157.1025853-1-jiasheng@iscas.ac.cn>
References: <20211222015157.1025853-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] isoc: mediatek: Check for error clk pointer
Message-Id: <164036265653.3720027.11806563702893486753.b4-ty@kernel.org>
Date:   Fri, 24 Dec 2021 16:17:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 09:51:57 +0800, Jiasheng Jiang wrote:
> On Wed, Dec 22, 2021 at 01:57:15AM +0800, Mark Brown wrote:
> >> +	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
> >>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> >> +		if (IS_ERR(clk[i]))
> >> +			return PTR_ERR(clk[i]);
> >
> > This now pays attention to the error code here which is good but...
> >
> >> -	init_clks(pdev, clk);
> >> +	ret = init_clks(pdev, clk);
> >> +	if (ret)
> >> +		return ERR_PTR(-ENOMEM);
> >
> > ...then discards it here with a random most likely inappropriate error
> > code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] isoc: mediatek: Check for error clk pointer
      commit: 9de2b9286a6dd16966959b3cb34fc2ddfd39213e

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
