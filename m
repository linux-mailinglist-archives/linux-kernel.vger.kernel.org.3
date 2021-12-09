Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A046EDF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241425AbhLIQ6E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 11:58:04 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34295 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbhLIQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:57:48 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 61B9F20000D;
        Thu,  9 Dec 2021 16:54:10 +0000 (UTC)
Date:   Thu, 9 Dec 2021 17:54:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] mtd: nand: fix boolreturn.cocci warning
Message-ID: <20211209175409.7260f5f9@xps13>
In-Reply-To: <20211206121531.31808-1-hanyihao@vivo.com>
References: <20211206121531.31808-1-hanyihao@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yihao,

hanyihao@vivo.com wrote on Mon,  6 Dec 2021 04:15:30 -0800:

> ./drivers/mtd/nand/core.c:25:9-10: WARNING: return of 0/1 in
> function 'nanddev_isbad' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.

This is -next material, I want to have a clean branch there so I
applied this change inline, I hope you don't mind.

> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/mtd/nand/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
> index 33c7788d76c2..416947f28b67 100644
> --- a/drivers/mtd/nand/core.c
> +++ b/drivers/mtd/nand/core.c
> @@ -22,7 +22,7 @@
>  bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos)
>  {
>  	if (WARN_ONCE(mtd_expert_analysis_mode, mtd_expert_analysis_warning))
> -		return 0;
> +		return false;
>  
>  	if (nanddev_bbt_is_initialized(nand)) {
>  		unsigned int entry;


Thanks,
Miquèl
