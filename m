Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11357B3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiGTJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:36:38 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758762A47
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:36:29 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id E67zo5xjSgtndE67zohBES; Wed, 20 Jul 2022 11:36:27 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 20 Jul 2022 11:36:27 +0200
X-ME-IP: 90.11.190.129
Message-ID: <9cef7bd3-62ed-6438-8508-617ff7872af6@wanadoo.fr>
Date:   Wed, 20 Jul 2022 11:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] crypto: ccree - Remove a useless dma_supported() call
Content-Language: fr
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <ef6f884ef144390f152c34d2f549b1f50303b7b1.1658262447.git.christophe.jaillet@wanadoo.fr>
 <CAOtvUMdvXZ8s43ZetZZ8VwCtpDoJy5Ajk4yA=7xZS4OafmsjAw@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAOtvUMdvXZ8s43ZetZZ8VwCtpDoJy5Ajk4yA=7xZS4OafmsjAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/07/2022 à 11:24, Gilad Ben-Yossef a écrit :
> Hi Christophe,
> 
> Thank you for the patch!
> 
> 
> On Tue, Jul 19, 2022 at 11:27 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> There is no point in calling dma_supported() before calling
>> dma_set_coherent_mask(). This function already calls dma_supported() and
>> returns an error (-EIO) if it fails.
>>
>> So remove the superfluous dma_supported() call.
>>
>> While at it, fix the name of the function reported in a dev_err().
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>
> 
>> ---
>> I guess that the whole while loop could be removed, but I don't remind the
>> thread with the corresponding explanation, so leave it as-is :(
> 
> I would be happy to ack a patch that does this if you care to write it...

I will send a v2.

Don't bother with this patch.

CJ

> 
> Gilad
> 
>> ---
>>   drivers/crypto/ccree/cc_driver.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
>> index 7d1bee86d581..99f8bda718fe 100644
>> --- a/drivers/crypto/ccree/cc_driver.c
>> +++ b/drivers/crypto/ccree/cc_driver.c
>> @@ -373,16 +373,16 @@ static int init_cc_resources(struct platform_device *plat_dev)
>>
>>          dma_mask = DMA_BIT_MASK(DMA_BIT_MASK_LEN);
>>          while (dma_mask > 0x7fffffffUL) {
>> -               if (dma_supported(dev, dma_mask)) {
>> -                       rc = dma_set_coherent_mask(dev, dma_mask);
>> -                       if (!rc)
>> -                               break;
>> -               }
>> +               rc = dma_set_coherent_mask(dev, dma_mask);
>> +               if (!rc)
>> +                       break;
>> +
>>                  dma_mask >>= 1;
>>          }
>>
>>          if (rc) {
>> -               dev_err(dev, "Failed in dma_set_mask, mask=%llx\n", dma_mask);
>> +               dev_err(dev, "Failed in dma_set_coherent_mask, mask=%llx\n",
>> +                       dma_mask);
>>                  return rc;
>>          }
>>
>> --
>> 2.34.1
>>
> 
> 

