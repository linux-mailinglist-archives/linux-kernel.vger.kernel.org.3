Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23E554466E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiFIIvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242633AbiFIIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED27F145581;
        Thu,  9 Jun 2022 01:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89659619AF;
        Thu,  9 Jun 2022 08:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50939C34114;
        Thu,  9 Jun 2022 08:47:28 +0000 (UTC)
Message-ID: <afafa5db-cf2c-4e4d-7003-2e7d35658a99@xs4all.nl>
Date:   Thu, 9 Jun 2022 10:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: hantro: fix compatible string deprecation warning
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220517143521.1670663-1-martin.kepplinger@puri.sm>
 <0da188fa-efd8-62d0-2ea6-5a8e0c286cb5@arm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <0da188fa-efd8-62d0-2ea6-5a8e0c286cb5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 5/17/22 18:46, Robin Murphy wrote:
> On 2022-05-17 15:35, Martin Kepplinger wrote:
>> of_device_is_compatible() in the end uses strlen of the string
>> for comparison, so in this case, the condition is true even if
>> the requested string "nxp,imx8mq-vpu-g1" is being used. The first
>> chars containing "nxp,imx8mq-vpu" are the same.
> 
> Have you seen this go wrong in practice? AFAICS, unless you're on SPARC, which seems somewhat unlikely for an i.MX8 peripheral, of_compat_cmp() should map to strcasecmp(), which should do the right thing :/

Robin is correct, the existing code is fine for all but SPARC, which
won't be using this driver.

I'm rejecting this patch.

Regards,

	Hans

> 
> Robin.
> 
>> Fix this by encoding what the comment says.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>> ---
>>
>> This is more of a bugreport as the solution doesn't look very elegant
>> to me. I'm happy for advice.
>>
>> thanks,
>>                             martin
>>
>>
>>   drivers/staging/media/hantro/hantro_drv.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
>> index ac232b5f7825..014fab637df0 100644
>> --- a/drivers/staging/media/hantro/hantro_drv.c
>> +++ b/drivers/staging/media/hantro/hantro_drv.c
>> @@ -923,10 +923,11 @@ static int hantro_probe(struct platform_device *pdev)
>>         /*
>>        * Support for nxp,imx8mq-vpu is kept for backwards compatibility
>> -     * but it's deprecated. Please update your DTS file to use
>> -     * nxp,imx8mq-vpu-g1 or nxp,imx8mq-vpu-g2 instead.
>> +     * but it's deprecated.
>>        */
>> -    if (of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu"))
>> +    if ((of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu")) &&
>> +        (!of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu-g1")) &&
>> +        (!of_device_is_compatible(pdev->dev.of_node, "nxp,imx8mq-vpu-g2")))
>>           dev_warn(&pdev->dev, "%s compatible is deprecated\n",
>>                match->compatible);
>>   
