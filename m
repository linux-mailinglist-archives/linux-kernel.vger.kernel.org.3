Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346C4A582F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiBAICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:02:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45342 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBAICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:02:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 211828La078868;
        Tue, 1 Feb 2022 02:02:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643702528;
        bh=Aee/u77ubOE0vyCuYGfT7vvh+kz0CcyyjunwqH/rJt0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pXwOBe42PkEfc0ds2HXv4oGOc+XGWbu6OqHo0PuCjHuW2Y5opM3ii983StFkDwr7l
         f4BRGeDC44bD7ZiNAvEm3vPD6KJcc++6XfQA0QQl2OGQnqk4rPnpoOEMSmNWmunqCg
         opCqDpeBJ6/P8rs3W48JTdwPYHacMomd8GhD4hAg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 211828cH037703
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Feb 2022 02:02:08 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 1
 Feb 2022 02:02:08 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 1 Feb 2022 02:02:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2118275l116286;
        Tue, 1 Feb 2022 02:02:08 -0600
Date:   Tue, 1 Feb 2022 13:32:07 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <broonie@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: check if data buffers are on stack
Message-ID: <20220201080207.bvqpzemldlvvykga@ti.com>
References: <20220131114508.1028306-1-p.yadav@ti.com>
 <366bad2d-ebb3-a2a5-330d-ff9019d18733@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <366bad2d-ebb3-a2a5-330d-ff9019d18733@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/22 07:44AM, Tudor.Ambarus@microchip.com wrote:
> On 1/31/22 13:45, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The buffers passed in the data phase must be DMA-able. Programmers often
> > don't realise this requirement and pass in buffers that reside on the
> > stack. This can be hard to spot when reviewing code. Reject ops if their
> > data buffer is on the stack to avoid this.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/spi/spi-mem.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index 37f4443ce9a0..b3793a2979ee 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -207,6 +207,15 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
> >             !spi_mem_buswidth_is_valid(op->data.buswidth))
> >                 return -EINVAL;
> > 
> > +       /* Buffers must be DMA-able. */
> > +       if (op->data.dir == SPI_MEM_DATA_IN &&
> > +           object_is_on_stack(op->data.buf.in))
> 
> should we also check if the virt addr is valid?
> if (object_is_on_stack(op->data.buf.in) || !virt_addr_valid(op->data.buf.in))

When would virt addr not be valid? When someone passes a bad pointer? I 
generally have not seen kernel APIs checking for pointer validity (other 
than NULL). If you pass a bad pointer then expect bad things to happen. 
Plus a bad pointer might also point to a valid virtual address, and we 
have no way of catching that. Dunno...

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
