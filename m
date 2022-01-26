Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8949C7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiAZKd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:33:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43336 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiAZKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:33:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B4A7617FB;
        Wed, 26 Jan 2022 10:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4450C340E3;
        Wed, 26 Jan 2022 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643193203;
        bh=GW9FAjNDweW7gvrSISPpSMwP4D6Zp0v9U2IcNkF/a98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSGWZwN3RgRguwe1RsQAA+ygJ9W8xUAECNarOlDFAkDIdTLn6Zyy+NdPo+v8oLCDL
         ldJSusLrsnKmtCRHli2QeGVdkgELF79xXeKO3g7wC+UPD8qvsHyYNI+8oUrtL0UYKj
         /lEMaOW8GZ5Nk8XP4zYcmThDONWmJne26YnZmu+t5ETC5wp8JIe2KoLEZGY0ft3bJ2
         rClIV9RqdI6UeL3E41BB99vdlxd4/gxKKSTHC/pEr+Qz/X8GM5DRS9BbhCDj725UB5
         FrL/TyBkGw5lExUkXBiUp6y+R+acg9N3GIULoSLfacsFklkrTSxZVQJUW8oHe+yOJf
         Rs+MuluXEcVZg==
Date:   Wed, 26 Jan 2022 16:03:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Message-ID: <20220126103316.GA212068@thinkpad>
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
 <20220114082718.32a2fc83@xps13>
 <20220126111613.3ab0021e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126111613.3ab0021e@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote:
> Hello,
> 
> miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:
> 
> > Hi Konrad,
> > 
> > konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 +0100:
> > 
> > > While I have absolutely 0 idea why and how, running clear_bam_transaction
> > > when READID is issued makes the DMA totally clog up and refuse to function
> > > at all on mdm9607. In fact, it is so bad that all the data gets garbled
> > > and after a short while in the nand probe flow, the CPU decides that
> > > sepuku is the only option.
> > > 
> > > Removing _READID from the if condition makes it work like a charm, I can
> > > read data and mount partitions without a problem.
> > > 
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > ---
> > > This is totally just an observation which took me an inhumane amount of
> > > debug prints to find.. perhaps there's a better reason behind this, but
> > > I can't seem to find any answers.. Therefore, this is a BIG RFC!  
> > 
> > I'm adding two people from codeaurora who worked a lot on this driver.
> > Hopefully they will have an idea :)
> 
> Sadre, I've spent a significant amount of time reviewing your patches,
> now it's your turn to not take a month to answer to your peers
> proposals.
> 
> Please help reviewing this patch.
> 

Sorry. I was hoping that Qcom folks would chime in as I don't have any idea
about the mdm9607 platform. It could be that the mail server migration from
codeaurora to quicinc put a barrier here.

Let me ping them internally.

> BTW why is this driver still using cmdfund? It should have been
> migrated to ->exec_op() a long time ago.

I'll look into it.

Thanks,
Mani
> 
> Thanks,
> Miquèl
