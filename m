Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BBF53441C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbiEYTQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344770AbiEYTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:15:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EEE4252A4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:14:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FDE81424;
        Wed, 25 May 2022 12:14:24 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6258A3F73D;
        Wed, 25 May 2022 12:14:23 -0700 (PDT)
Message-ID: <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
Date:   Wed, 25 May 2022 20:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Question about SPIs' interrupt trigger type restrictions
Content-Language: en-GB
To:     richard clark <richard.xnu.clark@gmail.com>, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25 11:01, richard clark wrote:
> Hi Marc,
> 
> For below code snippet about SPI interrupt trigger type:
> 
> static int gic_set_type(struct irq_data *d, unsigned int type)
> {
>          ...
>          /* SPIs have restrictions on the supported types */
>          if ((range == SPI_RANGE || range == ESPI_RANGE) &&
>              type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
>                  return -EINVAL;
>          ...
> }
> 
> We have a device at hand whose interrupt type is SPI, Falling edge
> will trigger the interrupt. But the request_irq(50, handler,
> IRQ_TYPE_EDGE_FALLING, ...) will return -EINVAL.
> 
> The question is, why must the SPI interrupt use IRQ_TYPE_EDGE_RISING
> instead of IRQ_TYPE_EDGE_FALLING?

Because that's what the GIC architecture[1] says. From section 1.2.1 
"Interrupt Types":

"An interrupt that is edge-triggered has the following property:
	• It is asserted on detection of a rising edge of an interrupt signal 
and then, regardless of the state of the signal, remains asserted until 
the interrupt is acknowledged by software."

External signals with the wrong polarity may need external logic to 
invert them (which might even be offered by the GIC implementation 
itself, e.g. [2]), but the programmer's model neither knows nor cares 
about such details, it only knows notions of "edge-triggered" and 
"level-sensitive", where from its point of view the asserted states are 
rising and high respectively.

Robin.

[1] https://developer.arm.com/documentation/ihi0069/latest
[2] 
https://developer.arm.com/documentation/100336/0106/components-and-configuration/spi-collator/spi-collator-wires?lang=en
