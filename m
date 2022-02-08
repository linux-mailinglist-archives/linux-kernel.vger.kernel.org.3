Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8984ADC03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379472AbiBHPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351474AbiBHPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:08:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C8C061578;
        Tue,  8 Feb 2022 07:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 593FDB81B82;
        Tue,  8 Feb 2022 15:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3D0C004E1;
        Tue,  8 Feb 2022 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644332884;
        bh=m+XAn2rGWJrSsSfX1FShC6Eo8n+JIqs8s5P/WsHDYu4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H9NTGjomupshEEFChzZO90ds52KO/6EFz6MAOstGYx9Q89l95PKattlrwWpNVnU+A
         FD/83VYz9TWZloye0lhXlWHla4fIr4Uks8Te1yINurUUNhFJGtAbuFCon/ZGvk6sJf
         JGpbXr7Hn5FcDtivxPfpXGWeXK7iu994/aDLqscm4IfQighmhUIW84N1LBFjbpgF5c
         QGG25m0ywpRPJ/wAvyX8+3cb+AjP1xm1hDocu3YNYgLVVtiLIpy+KqFugyoY7lliGj
         IABRY3/Z/ni3t8h16zO1sGWnbGFh7w9Ovd1XeMa5h0enpaHmSUS9NJ1CitT58CeYwE
         Q9SjfY1GD4jKA==
From:   Mark Brown <broonie@kernel.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-spi@vger.kernel.org, kjlu@umn.edu,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211130172253.203700-1-zhou1615@umn.edu>
References: <20211130172253.203700-1-zhou1615@umn.edu>
Subject: Re: [PATCH] spi: spi-zynq-qspi: Fix a NULL pointer dereference in zynq_qspi_exec_mem_op()
Message-Id: <164433288249.2965024.5625458005559637267.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 15:08:02 +0000
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

On Wed, 1 Dec 2021 01:22:53 +0800, Zhou Qingyang wrote:
> In zynq_qspi_exec_mem_op(), kzalloc() is directly used in memset(),
> which could lead to a NULL pointer dereference on failure of
> kzalloc().
> 
> Fix this bug by adding a check of tmpbuf.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: spi-zynq-qspi: Fix a NULL pointer dereference in zynq_qspi_exec_mem_op()
      commit: ab3824427b848da10e9fe2727f035bbeecae6ff4

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
