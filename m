Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C064AE1B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385697AbiBHTA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385658AbiBHTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2449C0612B9;
        Tue,  8 Feb 2022 11:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AD9ACE1C13;
        Tue,  8 Feb 2022 19:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0EDC340ED;
        Tue,  8 Feb 2022 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346819;
        bh=t1N5NOrKXupMG7CxwAfFHbkmU74LUC9sqkk1KguldL0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=NZ5MrNgVbkaZxOHV5KtSraJqt4YatK7/nGZycnr5BDNMvbPo8rndllxxuNk5E1Bae
         yY2vt1khOsDI+VK0ZNurf2pvzdMSZQD8WhSpk8OJh4eW4V/3Je0rMniuB8aWA1bH35
         K5qOGWzpHtoIbFYh27bNKHq+VWTlYpG6ZHKW+d441D/pEeCHtoFMTmSHuVFv4VKGCV
         58L6rR2eXsBVUAFiS9SCsMO8r/KWvqBEPlDnqjRdDpc27Mx2KOFLZE/urOz0D2JVE3
         BdRPETbJtJ6v+YmbfdMEtZczNz1tVCcGKW+89T7C3dS32zYRPYDKe2tAex8ypmzdd9
         XnzwCEJNDTgVg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Miaoqian Lin <linmq006@gmail.com>, linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220128165956.27821-1-linmq006@gmail.com>
References: <20220128165956.27821-1-linmq006@gmail.com>
Subject: Re: [PATCH] spi: tegra210-quad: Fix missin IRQ check in tegra_qspi_probe
Message-Id: <164434681736.1135514.10319336540193161625.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:17 +0000
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

On Fri, 28 Jan 2022 16:59:56 +0000, Miaoqian Lin wrote:
> This func misses checking for platform_get_irq()'s call and may passes the
> negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> Stop calling request_threaded_irq() with invalid IRQ #s.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Fix missin IRQ check in tegra_qspi_probe
      commit: 47c3e06ed95aa9b74932dbc6b23b544f644faf84

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
