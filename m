Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE754562F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbiFIVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiFIVI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:08:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94426CE50;
        Thu,  9 Jun 2022 14:08:26 -0700 (PDT)
Received: from notapiano (unknown [169.150.201.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B67F56601691;
        Thu,  9 Jun 2022 22:08:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654808905;
        bh=wYeX97LtF96VJpDARGz/GPWf65EoYfMupPmpSXKKEU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIFn3AiPH2Rh1sHlyWAlRt1D2a524FB0g3k34Q1THAnAUOVUsU0SumpfnlhzQrUGX
         qmutXUZoMMPUWJB1JUF+CWs4a1c0cOq+p4E3TsGTrK5+NmjQ9aN8eRE8RLuQwb9mjO
         KmeIja69jkQ8XQpi3mViWvsQ3J3JO+Qs3UR4C/al2e+TRonk9RjJf33IzKL53E1VYF
         XNZjX8omDzuZtuKsQ+qgYSQN+JcGUFMQq9z0yUNj26va4kHOJEUjYOoOvUxlhP/bCU
         WothVV7XPZdfXxeit5NZwbtKH630XEJd533V3s9nWxjEKNhU98NUefAyvzkTmDJh98
         aDiubNDDc5hPA==
Date:   Thu, 9 Jun 2022 17:08:18 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] spi: Fix per-cpu stats access on 32 bit systems
Message-ID: <20220609210818.eysyw4rjy7gd3lq2@notapiano>
References: <20220609121334.2984808-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609121334.2984808-1-david@protonic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:13:34PM +0200, David Jander wrote:
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
> per-cpu access needs to be guarded against preemption.
> 
> Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: David Jander <david@protonic.nl>

Hi, the issue isn't 32-bit specific. I'm seeing it on an aarch64 machine
(mt8192-asurada-spherion) running next-20220609.

The fix did work for me, so

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks!
Nícolas
