Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30F48E4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiANH2O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 02:28:14 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59993 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiANH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:28:14 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8DE02240010;
        Fri, 14 Jan 2022 07:27:18 +0000 (UTC)
Date:   Fri, 14 Jan 2022 08:27:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Message-ID: <20220114082718.32a2fc83@xps13>
In-Reply-To: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 +0100:

> While I have absolutely 0 idea why and how, running clear_bam_transaction
> when READID is issued makes the DMA totally clog up and refuse to function
> at all on mdm9607. In fact, it is so bad that all the data gets garbled
> and after a short while in the nand probe flow, the CPU decides that
> sepuku is the only option.
> 
> Removing _READID from the if condition makes it work like a charm, I can
> read data and mount partitions without a problem.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> This is totally just an observation which took me an inhumane amount of
> debug prints to find.. perhaps there's a better reason behind this, but
> I can't seem to find any answers.. Therefore, this is a BIG RFC!

I'm adding two people from codeaurora who worked a lot on this driver.
Hopefully they will have an idea :)

Thanks,Miquèl

> 
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 04e6f7b26706..506006ccdf1a 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1459,8 +1459,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
>  
>  	clear_read_regs(nandc);
>  
> -	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
> -	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
> +	if (command == NAND_CMD_RESET || command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
>  		clear_bam_transaction(nandc);
>  }
>  
