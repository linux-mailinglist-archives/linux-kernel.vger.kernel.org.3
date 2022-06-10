Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D75469FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbiFJP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiFJP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:59:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73451DAE50;
        Fri, 10 Jun 2022 08:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BBB3B83633;
        Fri, 10 Jun 2022 15:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C0AC3411B;
        Fri, 10 Jun 2022 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654876744;
        bh=PEBI4IefY8pKprvXaRActK32wag0WXWO8S1y+vUL8Os=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hJ49vzeTcDLAu/mb3y7ZmY9KCIeF8R/yGUKRqMtdAavyBbkZ2hgKPX1eUiIcqJEpp
         XywDV/ubbKQHoreetGe1lRtfpfk0ahl/S5Pp38RVrjSBE9F7XJwUPU9mopSLxiSItD
         V0oQ4ZTWK7Ojj+iCr6OXnekGzFzlfR6kv7/L+IRcF8z4dHmjTW+To6cP0VrtjT3Gaf
         NmJ0KGj8QCppzY5SEaE9CetnJVY2niDvpFoBH6GaKaYxTXJeTAynWp/c8BiR5nQ8mv
         Dq2bGO8+npyDGmWc3Pfbg+B3umAf3Qk96nCchSZzATs9GZoYQxV7JrQOSYojl8W8HP
         sLhS1g4D4Bk8g==
From:   Mark Brown <broonie@kernel.org>
To:     david@protonic.nl
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, linux-next@vger.kernel.org
In-Reply-To: <20220609121334.2984808-1-david@protonic.nl>
References: <20220609121334.2984808-1-david@protonic.nl>
Subject: Re: [PATCH] spi: Fix per-cpu stats access on 32 bit systems
Message-Id: <165487674305.1756526.15679160461201421253.b4-ty@kernel.org>
Date:   Fri, 10 Jun 2022 16:59:03 +0100
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

On Thu, 9 Jun 2022 14:13:34 +0200, David Jander wrote:
> On 32 bit systems, the following kernel BUG is hit:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is debug_smp_processor_id+0x18/0x24
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc1-00001-g6ae0aec8a366 #181
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Backtrace:
>  dump_backtrace from show_stack+0x20/0x24
>  r7:81024ffd r6:00000000 r5:81024ffd r4:60000013
>  show_stack from dump_stack_lvl+0x60/0x78
>  dump_stack_lvl from dump_stack+0x14/0x1c
>  r7:81024ffd r6:80f652de r5:80bec180 r4:819a2500
>  dump_stack from check_preemption_disabled+0xc8/0xf0
>  check_preemption_disabled from debug_smp_processor_id+0x18/0x24
>  r8:8119b7e0 r7:81205534 r6:819f5c00 r5:819f4c00 r4:c083d724
>  debug_smp_processor_id from __spi_sync+0x78/0x220
>  __spi_sync from spi_sync+0x34/0x4c
>  r10:bb7bf4e0 r9:c083d724 r8:00000007 r7:81a068c0 r6:822a83c0 r5:c083d724
>  r4:819f4c00
>  spi_sync from spi_mem_exec_op+0x338/0x370
>  r5:000000b4 r4:c083d910
>  spi_mem_exec_op from spi_nor_read_id+0x98/0xdc
>  r10:bb7bf4e0 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:82358040
>  r4:819f7c40
>  spi_nor_read_id from spi_nor_detect+0x38/0x114
>  r7:82358040 r6:00000000 r5:819f7c40 r4:819f7c40
>  spi_nor_detect from spi_nor_scan+0x11c/0xbec
>  r10:bb7bf4e0 r9:00000000 r8:00000000 r7:c083da4c r6:00000000 r5:00010101
>  r4:819f7c40
>  spi_nor_scan from spi_nor_probe+0x10c/0x2d0
>  r10:bb7bf4e0 r9:bb7bf4d0 r8:00000000 r7:819f4c00 r6:00000000 r5:00000000
>  r4:819f7c40
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix per-cpu stats access on 32 bit systems
      commit: 67b9d64139e13621d3ab8bb0daad7602e5fe0778

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
