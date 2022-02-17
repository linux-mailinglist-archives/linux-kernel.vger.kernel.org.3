Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE604BA0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbiBQNR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:17:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:17:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4827E62C7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:17:43 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21H6Pe7P024602;
        Thu, 17 Feb 2022 07:17:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=2/2QWMVQZuOrEboq7TUrZ8hnD0NRdcbNcRPzzJbzT9E=;
 b=c4GZHKc8TDgn0mkT7E5V7rRePL7qpURwfH/sqxkyZxkbnl0aK3izfSCGCzQb671EhxQ6
 5AzwNT6yzZUVFVErtxNBG0f2B6ur2rda0n6IYCpIDVZdxa/TRLGTQ8UQ/P805bCRu1BS
 W1fMYF7a2v0ANyl8np2XWNBFFYRCVi8hDiOJLrMq5LArQH5yuMqMuYT39lKBuC/DFeOD
 VoNZf4am1+8hKBys5W3JL+YyjnoPvbsGZU3dlB0CjxCYyjfP5HSFYs8HS6M3FbHGSuy7
 Fa3JMAsIQxeK+bx8+ZV9ooG3GJ79AAkJSNRuJ2ZQWvVEbor2U/aHEkZ9qZJBYci4ln+7 kA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3e8nraj7tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 07:17:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 13:17:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 17 Feb 2022 13:17:33 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5961D11DC;
        Thu, 17 Feb 2022 13:17:33 +0000 (UTC)
Date:   Thu, 17 Feb 2022 13:17:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] regmap-irq: Update interrupt clear register for
 proper reset
Message-ID: <20220217131733.GH38351@ediswmail.ad.cirrus.com>
References: <20220217085007.30218-1-quic_pkumpatl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217085007.30218-1-quic_pkumpatl@quicinc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: WGJGyZmZCTyhZc9SHxtslOVB1tpT9C0j
X-Proofpoint-GUID: WGJGyZmZCTyhZc9SHxtslOVB1tpT9C0j
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:20:07PM +0530, Prasad Kumpatla wrote:

+ Marek Szyprowski, as the old version of the patch was causing
problems on his system.

> With the existing logic where clear_ack is true (HW doesn’t support
> auto clear for ICR), interrupt clear register reset is not handled
> properly. Due to this only the first interrupts get processed properly
> and further interrupts are blocked due to not resetting interrupt
> clear register.
> 
> Example for issue case where Invert_ack is false and clear_ack is true:
> 
>     Say Default ISR=0x00 & ICR=0x00 and ISR is triggered with 2
>     interrupts making ISR = 0x11.
> 
>     Step 1: Say ISR is set 0x11 (store status_buff = ISR). ISR needs to
>             be cleared with the help of ICR once the Interrupt is processed.
> 
>     Step 2: Write ICR = 0x11 (status_buff), this will clear the ISR to 0x00.
> 
>     Step 3: Issue - In the existing code, ICR is written with ICR =
>             ~(status_buff) i.e ICR = 0xEE -> This will block all the interrupts
>             from raising except for interrupts 0 and 4. So expectation here is to
>             reset ICR, which will unblock all the interrupts.
> 
>             if (chip->clear_ack) {
>                  if (chip->ack_invert && !ret)
>                   ........
>                  else if (!ret)
>                      ret = regmap_write(map, reg,
>                             ~data->status_buf[i]);
> 
> So writing 0 and 0xff (when ack_invert is true) should have no effect, other
> than clearing the ACKs just set.
> 
> Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> ---

I think this version looks like it should work to me.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

>  drivers/base/regmap/regmap-irq.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index d2656581a608..4a446259a184 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -189,11 +189,9 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
>  				ret = regmap_write(map, reg, d->mask_buf[i]);
>  			if (d->chip->clear_ack) {
>  				if (d->chip->ack_invert && !ret)
> -					ret = regmap_write(map, reg,
> -							   d->mask_buf[i]);
> +					ret = regmap_write(map, reg, UINT_MAX);
>  				else if (!ret)
> -					ret = regmap_write(map, reg,
> -							   ~d->mask_buf[i]);
> +					ret = regmap_write(map, reg, 0);
>  			}
>  			if (ret != 0)
>  				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
> @@ -556,11 +554,9 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>  						data->status_buf[i]);
>  			if (chip->clear_ack) {
>  				if (chip->ack_invert && !ret)
> -					ret = regmap_write(map, reg,
> -							data->status_buf[i]);
> +					ret = regmap_write(map, reg, UINT_MAX);
>  				else if (!ret)
> -					ret = regmap_write(map, reg,
> -							~data->status_buf[i]);
> +					ret = regmap_write(map, reg, 0);
>  			}
>  			if (ret != 0)
>  				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
> @@ -817,13 +813,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
>  					d->status_buf[i] & d->mask_buf[i]);
>  			if (chip->clear_ack) {
>  				if (chip->ack_invert && !ret)
> -					ret = regmap_write(map, reg,
> -						(d->status_buf[i] &
> -						 d->mask_buf[i]));
> +					ret = regmap_write(map, reg, UINT_MAX);
>  				else if (!ret)
> -					ret = regmap_write(map, reg,
> -						~(d->status_buf[i] &
> -						  d->mask_buf[i]));
> +					ret = regmap_write(map, reg, 0);
>  			}
>  			if (ret != 0) {
>  				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
> -- 
> 2.17.1
> 
