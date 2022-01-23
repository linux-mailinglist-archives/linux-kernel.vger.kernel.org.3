Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7889449729D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiAWPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:39:40 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54361 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiAWPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:39:38 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8BC0B60004;
        Sun, 23 Jan 2022 15:39:36 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Han Xu <han.xu@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 4/4] mtd: rawnand: gpmi: support fast edo timings for mx28
Date:   Sun, 23 Jan 2022 16:39:36 +0100
Message-Id: <20220123153936.673237-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118095434.35081-5-dario.binacchi@amarulasolutions.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ac178a21754cf720b27e82965c2f11e71e9e5968'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 09:54:34 UTC, Dario Binacchi wrote:
> In the i.MX28 manual (MCIMX28RM, Rev. 1, 2010) you can find an example
> (15.2.4 High-Speed NAND Timing) of how to configure the GPMI controller
> to manage High-Speed ​​NAND devices, so it was wrong to assume that only
> i.MX6 can achieve EDO timings.
> 
> This patch has been tested on a 2048/64 byte NAND (Micron MT29F2G08ABAEAH4).
> Kernel mtd tests:
>  - mtd_nandbiterrs
>  - mtd_nandecctest
>  - mtd_oobtest
>  - mtd_pagetest
>  - mtd_readtest
>  - mtd_speedtest
>  - mtd_stresstest
>  - mtd_subpagetest
>  - mtd_torturetest [cycles_count = 10000000]
> run without errors.
> 
> Before this patch (mode 0):
> ---------------------------
> eraseblock write speed is 2098 KiB/s
> eraseblock read speed is 2680 KiB/s
> page write speed is 1689 KiB/s
> page read speed is 2522 KiB/s
> 2 page write speed is 1899 KiB/s
> 2 page read speed is 2579 KiB/s
> erase speed is 128000 KiB/s
> 2x multi-block erase speed is 73142 KiB/s
> 4x multi-block erase speed is 204800 KiB/s
> 8x multi-block erase speed is 256000 KiB/s
> 16x multi-block erase speed is 256000 KiB/s
> 32x multi-block erase speed is 256000 KiB/s
> 64x multi-block erase speed is 256000 KiB/s
> 
> After this patch (mode 5):
> -------------------------
> eraseblock write speed is 3390 KiB/s
> eraseblock read speed is 5688 KiB/s
> page write speed is 2680 KiB/s
> page read speed is 4876 KiB/s
> 2 page write speed is 2909 KiB/s
> 2 page read speed is 5224 KiB/s
> erase speed is 170666 KiB/s
> 2x multi-block erase speed is 204800 KiB/s
> 4x multi-block erase speed is 256000 KiB/s
> 8x multi-block erase speed is 256000 KiB/s
> 16x multi-block erase speed is 256000 KiB/s
> 32x multi-block erase speed is 256000 KiB/s
> 64x multi-block erase speed is 256000 KiB/s
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
