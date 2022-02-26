Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496F4C5273
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiBZARM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiBZAQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:16:52 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0419225591
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:14 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21Q0G8eL060315;
        Fri, 25 Feb 2022 18:16:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645834568;
        bh=pBw395L0AUcASRYS2i9hrKEYCApz4CFHb/+TgP651cs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tEr177f4BrpptmxG8YZOj0yhtBjccpWEyYiO/+USDUeHVXfvyiwmRu1eq02D9jnEo
         kQ5sNQ8SGNrxqVyXFZqeswtOOoLMkbAq5LN845c+CNQt1oaVoFhMzq3um9EHLmSO0K
         C7lxQevcdFNM7MIlCjqmZwiFQEQYnFD79ujEUJt0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21Q0G87f012350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Feb 2022 18:16:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 25
 Feb 2022 18:16:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 25 Feb 2022 18:16:08 -0600
Received: from [10.249.33.2] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21Q0G854109058;
        Fri, 25 Feb 2022 18:16:08 -0600
Message-ID: <073d7213-bd3a-5adb-8187-f0a83478fd76@ti.com>
Date:   Fri, 25 Feb 2022 18:16:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] mailbox: ti-msgmgr: Refactor message read during
 interrupt handler
Content-Language: en-US
To:     Dave Gerlach <d-gerlach@ti.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220210041631.26767-1-d-gerlach@ti.com>
 <20220210041631.26767-2-d-gerlach@ti.com>
From:   Suman Anna <s-anna@ti.com>
In-Reply-To: <20220210041631.26767-2-d-gerlach@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 22:16, Dave Gerlach wrote:
> Refactor the portion of code that actually reads received messages from
> a queue into its own function, ti_msgmgr_queue_rx_data, that is called
> by the interrupt handler instead of reading directly from the handler.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/mailbox/ti-msgmgr.c | 88 +++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
> index efb43b038596..f860cd0c907a 100644
> --- a/drivers/mailbox/ti-msgmgr.c
> +++ b/drivers/mailbox/ti-msgmgr.c
> @@ -190,6 +190,53 @@ static inline bool ti_msgmgr_queue_is_error(const struct ti_msgmgr_desc *d,
>  	return val ? true : false;
>  }
>  
> +static int ti_msgmgr_queue_rx_data(struct mbox_chan *chan, struct ti_queue_inst *qinst,
> +				   const struct ti_msgmgr_desc *desc)
> +{
> +	int num_words;
> +	struct ti_msgmgr_message message;
> +	void __iomem *data_reg;
> +	u32 *word_data;
> +
> +	/*
> +	 * I have no idea about the protocol being used to communicate with the
> +	 * remote producer - 0 could be valid data, so I wont make a judgement
> +	 * of how many bytes I should be reading. Let the client figure this
> +	 * out.. I just read the full message and pass it on..
> +	 */
> +	message.len = desc->max_message_size;
> +	message.buf = (u8 *)qinst->rx_buff;
> +
> +	/*
> +	 * NOTE about register access involved here:
> +	 * the hardware block is implemented with 32bit access operations and no
> +	 * support for data splitting.  We don't want the hardware to misbehave
> +	 * with sub 32bit access - For example: if the last register read is
> +	 * split into byte wise access, it can result in the queue getting
> +	 * stuck or indeterminate behavior. An out of order read operation may
> +	 * result in weird data results as well.
> +	 * Hence, we do not use memcpy_fromio or __ioread32_copy here, instead
> +	 * we depend on readl for the purpose.
> +	 *
> +	 * Also note that the final register read automatically marks the
> +	 * queue message as read.
> +	 */
> +	for (data_reg = qinst->queue_buff_start, word_data = qinst->rx_buff,
> +	     num_words = (desc->max_message_size / sizeof(u32));
> +	     num_words; num_words--, data_reg += sizeof(u32), word_data++)
> +		*word_data = readl(data_reg);
> +
> +	/*
> +	 * Last register read automatically clears the IRQ if only 1 message
> +	 * is pending - so send the data up the stack..
> +	 * NOTE: Client is expected to be as optimal as possible, since
> +	 * we invoke the handler in IRQ context.
> +	 */
> +	mbox_chan_received_data(chan, (void *)&message);
> +
> +	return 0;
> +}
> +
>  /**
>   * ti_msgmgr_queue_rx_interrupt() - Interrupt handler for receive Queue
>   * @irq:	Interrupt number
> @@ -206,10 +253,7 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
>  	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
>  	struct ti_queue_inst *qinst = chan->con_priv;
>  	const struct ti_msgmgr_desc *desc;
> -	int msg_count, num_words;
> -	struct ti_msgmgr_message message;
> -	void __iomem *data_reg;
> -	u32 *word_data;
> +	int msg_count;
>  
>  	if (WARN_ON(!inst)) {
>  		dev_err(dev, "no platform drv data??\n");
> @@ -237,41 +281,7 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
>  		return IRQ_NONE;
>  	}
>  
> -	/*
> -	 * I have no idea about the protocol being used to communicate with the
> -	 * remote producer - 0 could be valid data, so I won't make a judgement
> -	 * of how many bytes I should be reading. Let the client figure this
> -	 * out.. I just read the full message and pass it on..
> -	 */
> -	message.len = desc->max_message_size;
> -	message.buf = (u8 *)qinst->rx_buff;
> -
> -	/*
> -	 * NOTE about register access involved here:
> -	 * the hardware block is implemented with 32bit access operations and no
> -	 * support for data splitting.  We don't want the hardware to misbehave
> -	 * with sub 32bit access - For example: if the last register read is
> -	 * split into byte wise access, it can result in the queue getting
> -	 * stuck or indeterminate behavior. An out of order read operation may
> -	 * result in weird data results as well.
> -	 * Hence, we do not use memcpy_fromio or __ioread32_copy here, instead
> -	 * we depend on readl for the purpose.
> -	 *
> -	 * Also note that the final register read automatically marks the
> -	 * queue message as read.
> -	 */
> -	for (data_reg = qinst->queue_buff_start, word_data = qinst->rx_buff,
> -	     num_words = (desc->max_message_size / sizeof(u32));
> -	     num_words; num_words--, data_reg += sizeof(u32), word_data++)
> -		*word_data = readl(data_reg);
> -
> -	/*
> -	 * Last register read automatically clears the IRQ if only 1 message
> -	 * is pending - so send the data up the stack..
> -	 * NOTE: Client is expected to be as optimal as possible, since
> -	 * we invoke the handler in IRQ context.
> -	 */
> -	mbox_chan_received_data(chan, (void *)&message);
> +	ti_msgmgr_queue_rx_data(chan, qinst, desc);
>  
>  	return IRQ_HANDLED;
>  }

