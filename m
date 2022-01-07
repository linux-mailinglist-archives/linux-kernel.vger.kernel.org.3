Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED16487376
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiAGHWu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jan 2022 02:22:50 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37479 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiAGHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:22:48 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AD1991BF204;
        Fri,  7 Jan 2022 07:22:42 +0000 (UTC)
Date:   Fri, 7 Jan 2022 08:22:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v2 2/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O
 operations
Message-ID: <20220107082241.318132a9@xps13>
In-Reply-To: <703aeebe-3413-0e5e-80ca-4c0bcd36e3f5@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
        <20220107001328.2233896-3-f.fainelli@gmail.com>
        <703aeebe-3413-0e5e-80ca-4c0bcd36e3f5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Thu, 6 Jan 2022 19:10:12 -0800:

> On 1/6/2022 4:13 PM, Florian Fainelli wrote:
> > Allow a brcmnand_soc instance to provide a custom set of I/O operations
> > which we will require when using this driver on a BCMA bus which is not
> > directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
> > to use the SoC operations if provided.
> > 
> > To minimize the penalty on other SoCs which do support standard MMIO
> > accesses, we use a static key which is disabled by default and gets
> > enabled if a soc implementation does provide I/O operations.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---  
> 
> [snip]
> 
> >   	init_completion(&ctrl->done);
> >   	init_completion(&ctrl->dma_done);
> >   	init_completion(&ctrl->edu_done);
> > @@ -3145,6 +3169,8 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
> >   		/* Enable interrupt */
> >   		ctrl->soc->ctlrdy_ack(ctrl->soc);
> >   		ctrl->soc->ctlrdy_set_enabled(ctrl->soc, true);
> > +		if (brcmnand_soc_has_ops(soc))
> > +			static_branch_enable(&brcmnand_soc_has_ops_key);  
> 
> This hunk got mistakenly added with a rebase, I will wait for additional comments before spinning a new version.

FYI the series LGTM otherwise.

Thanks,
Miquèl
