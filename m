Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568F24AE1BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385665AbiBHTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385631AbiBHTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E9C0612AA;
        Tue,  8 Feb 2022 11:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C107FCE1C1B;
        Tue,  8 Feb 2022 19:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42AFC004E1;
        Tue,  8 Feb 2022 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346817;
        bh=zJd+H+BIPkR2OI3cFt0/lJSBS7oK/94+7PCJWcu8U/M=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hoE1wnoZdIOBNhyQQdvZMVEKbdamCmwiLoxUBpPTTHa8SG7pRO9viyElKLyJwxSL/
         oxeUkZdI1qrMhFXXCDjVTfAWWtkOUb7JwDIhmMuB+rFKuc45V0RDxKr0lJQ1Jg9QbM
         73r/Pj6+oIMEFckMfW+dKnAffRRXz4dBOjdTwiXdF/UlnBCv41e7VTZh1nKkVdispC
         ajwNQpsW66RwZwcNPn8O6/qVNkq4m4SA8gkodbfEXuD+cpefDW98jmDtMRlD5a99QT
         +NHUEAfRGsYnQQkBr2O+pYINiHf5up34Gw5jYh3wraf8E7U2tIj5uZKXaobuX04KpM
         t/dEGQEequoVQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-spi@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220128165238.25615-1-linmq006@gmail.com>
References: <20220128165238.25615-1-linmq006@gmail.com>
Subject: Re: [PATCH] spi: tegra114: Add missing IRQ check in tegra_spi_probe
Message-Id: <164434681322.1135514.2854633035091330179.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:13 +0000
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

On Fri, 28 Jan 2022 16:52:38 +0000, Miaoqian Lin wrote:
> This func misses checking for platform_get_irq()'s call and may passes the
> negative error codes to request_threaded_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> Stop calling request_threaded_irq() with invalid IRQ #s.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Add missing IRQ check in tegra_spi_probe
      commit: 4f92724d4b92c024e721063f520d66e11ca4b54b

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
