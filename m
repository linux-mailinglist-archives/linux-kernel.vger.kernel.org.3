Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D753FBFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiFGKsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbiFGKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732AED7B1;
        Tue,  7 Jun 2022 03:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E699B6156A;
        Tue,  7 Jun 2022 10:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B51C3411E;
        Tue,  7 Jun 2022 10:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598815;
        bh=tm1TflPGmEDKpwON1qC2bgKQuglKGcgo+mlL9tjn+28=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LENGS2wVb8Y+9BHDPiC+24SQKag1/003HSb8AxcA53DSzgbcIX1JMId6xZE8Js11n
         7TNK1mmpSlBg3IHILW63qLKh+AZDCQMxi6SQ3jczaTmrXErUbYBN86e4e+j1SEY0kL
         LxuE+8joHznqMzsOtfzPDkyWOtIhexnYg582u8P30K8OAr0jtWpEy4eyfJhMRfoD27
         9OUoWJYAPJAnIGY1TeSL0mj9wcRMujskIJIj4zK8R6JaVAGoelgH+muJrdyL/JomT5
         EumxoomfejAaJODzZXbyha0r9N8jJR0pKluxC7xdE8iekMzwNrXwNvypmDjby11hn+
         iXDbbV2Z/CCeA==
From:   Mark Brown <broonie@kernel.org>
To:     christophe.jaillet@wanadoo.fr, matthew.gerlach@linux.intel.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <0607bb59f4073f86abe5c585d35245aef0b045c6.1653805901.git.christophe.jaillet@wanadoo.fr>
References: <0607bb59f4073f86abe5c585d35245aef0b045c6.1653805901.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: spi-altera-dfl: Fix an error handling path
Message-Id: <165459881400.302078.16808587662616763292.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 08:31:53 +0200, Christophe JAILLET wrote:
> The spi_alloc_master() call is not undone in all error handling paths.
> Moreover, there is no .remove function to release the allocated memory.
> 
> In order to fix both this issues, switch to devm_spi_alloc_master().
> 
> This allows further simplification of the probe.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-altera-dfl: Fix an error handling path
      commit: 8e3ca32f46994e74b7f43c57731150b2aedb2630

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
