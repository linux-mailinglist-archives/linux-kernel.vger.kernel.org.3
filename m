Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3357C49C745
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiAZKQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jan 2022 05:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiAZKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:16:24 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4425DC06161C;
        Wed, 26 Jan 2022 02:16:21 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B4238100009;
        Wed, 26 Jan 2022 10:16:15 +0000 (UTC)
Date:   Wed, 26 Jan 2022 11:16:13 +0100
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
Message-ID: <20220126111613.3ab0021e@xps13>
In-Reply-To: <20220114082718.32a2fc83@xps13>
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
        <20220114082718.32a2fc83@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:

> Hi Konrad,
> 
> konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 +0100:
> 
> > While I have absolutely 0 idea why and how, running clear_bam_transaction
> > when READID is issued makes the DMA totally clog up and refuse to function
> > at all on mdm9607. In fact, it is so bad that all the data gets garbled
> > and after a short while in the nand probe flow, the CPU decides that
> > sepuku is the only option.
> > 
> > Removing _READID from the if condition makes it work like a charm, I can
> > read data and mount partitions without a problem.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> > This is totally just an observation which took me an inhumane amount of
> > debug prints to find.. perhaps there's a better reason behind this, but
> > I can't seem to find any answers.. Therefore, this is a BIG RFC!  
> 
> I'm adding two people from codeaurora who worked a lot on this driver.
> Hopefully they will have an idea :)

Sadre, I've spent a significant amount of time reviewing your patches,
now it's your turn to not take a month to answer to your peers
proposals.

Please help reviewing this patch.

BTW why is this driver still using cmdfund? It should have been
migrated to ->exec_op() a long time ago.

Thanks,
Miquèl
