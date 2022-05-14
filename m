Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70B52715F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiENNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiENNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9337F1CFC0;
        Sat, 14 May 2022 06:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2DB60EFE;
        Sat, 14 May 2022 13:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F34C340EE;
        Sat, 14 May 2022 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652535670;
        bh=cVPc8IxLVs5l5GfO+OTpaS1oTxpwAgb4hn1moAJyGJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BfwymUFfcpF0xX+ohmRqugaY5uNQQiIsZhcVsOJ7srIDsHdnD/rk8mpyGUW/E1wXi
         3TrLJ/fCFjf3cdl+MbCYrh/f8xzwGDOFtHgJ5l1dOHrFuy9CmLRkBrzDSAj4uW+Xgg
         sjaGfYmQ86vC/gUZNZt9J9cATz9BYHxh+4cBxJDWrPGlpVEs3pH4JUHrTzt1VS2wv2
         kkhdKxb+AGwamgHMI+27pNS6j8h28iF6OVC4FmAsPcqYXBtrfmzxBn/Pns+chQfdZF
         KRz8NbEWGlaDJnTIZRzUpAIdMAEiocfuXRyM6jarMrVd5IUccNmR4acUf34C9GMxxs
         I5BhqFLd8kTXA==
Date:   Sat, 14 May 2022 14:49:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     <cgel.zte@gmail.com>, <lars@metafoo.de>,
        <anand.ashok.dumbre@xilinx.com>, <manish.narani@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] iio: adc: fix return error variable
Message-ID: <20220514144944.21709427@jic23-huawei>
In-Reply-To: <c19cce8d-ca99-4993-435d-1a4e53543713@xilinx.com>
References: <20220509072405.1118019-1-lv.ruyi@zte.com.cn>
        <c19cce8d-ca99-4993-435d-1a4e53543713@xilinx.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 09:34:57 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> On 5/9/22 09:24, cgel.zte@gmail.com wrote:
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>

Applied, with modified patch title.  There are a lot of ADC drivers
so you should include the name of the driver in the patch description.

iio: adc: xilinx-ams: fix return error variable
> > 
> > Return irq instead of ret which always equals to zero here.
> > 
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> > ---
> >   drivers/iio/adc/xilinx-ams.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > index a55396c1f8b2..a7687706012d 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -1409,7 +1409,7 @@ static int ams_probe(struct platform_device *pdev)
> >   
> >   	irq = platform_get_irq(pdev, 0);
> >   	if (irq < 0)
> > -		return ret;
> > +		return irq;
> >   
> >   	ret = devm_request_irq(&pdev->dev, irq, &ams_irq, 0, "ams-irq",
> >   			       indio_dev);  
> 
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> 
> Thanks,
> Michal

