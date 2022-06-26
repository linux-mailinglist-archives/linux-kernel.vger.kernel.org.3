Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9F55B1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiFZMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFZMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:39:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A41183D;
        Sun, 26 Jun 2022 05:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656247187;
        bh=+Qb3TrnQnb7Tf8bDXxqHXI/Y+7qHL+BXsSHZvSy/8Q8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ekBEZ8twOLhALi0YfO/G9Ad1X0oiIuXja39gmcVL8fhgOjSPaEW813p+SEHsNpycA
         IPLIF2vQ9s/0WIkw/ExcRwIkJlFp0ns0vORXTKvBGPmZFlcQi3RThDUeqCJyTq/pAU
         7atjjAWY+tFbTDZK/FGGCkQiD6fbaWp50FfuB87g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1njUod2MdM-00vMyd; Sun, 26
 Jun 2022 14:39:47 +0200
Subject: Re: [PATCH 22/36] serial: Sanitize rs485_struct
To:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
 <20220606100433.13793-23-ilpo.jarvinen@linux.intel.com>
 <20220625201232.GA17597@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <d6f6cbb9-e8d9-d69c-d722-231096464484@gmx.de>
Date:   Sun, 26 Jun 2022 14:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220625201232.GA17597@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LZnFndGw1j1W6nKEdHMzsiyzI0NP4/oEfoDJKmLVL+Iy8roH/o
 Sr6tyUcw4xyWOovp51TJvkKC8bsOilazvO3PmbBdtGqycz3dgx73zE6VOOc/MLmqDsa9Xvp
 tMgZIDCvNdbivcTaK3PjV67xziE4w9y4NgjFIn1MjsrFwb4wKK1x0/mDVBpepGrknjYkQfQ
 Q6y8H1ncieyt97r4Hxc1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8l6Y89vTbr0=:zFM7zvVDoWn4x+ERbd3vjD
 CHI5erw4V3JdFCx9zKIOOvD5RzBem7tWo2ewfOSLxEOu9c8OSMtT0pSZSF5LZbEI+8ByOcpSG
 v8XW9TPe+UBEqUsaipNlhwp8aVuuxxxFHrN7z0urZLGGL3CtfqAYwzdWrEEtVo28Iju36fl6j
 mMmbAA69yC75hFdKTFH0SFN+sYYfQ/vWG3gbEJ92Oe10H3tTCao/7kis4oOZFtt+B9GFKzvQp
 ndcEAvFYsOUAom/2n8R8lURXectkgZNSsVklhJ4/UR8P2O0v+HgAh+c1xg/nI9d4l5ioJ84/j
 Nn2bW4IWnZnE38NPF8aAqXJXSpCZHFSNM1PDXUe3uZLFMtbIginJHozuq8evM49bhG36mzG/W
 entSUmDG92uJeJSou3x52siqh9OkLM9WaMdmtbJzvdHml97nSXl/XWu/8piDay2AMzkqjTk44
 qAd6PC8OnQhDk77MTcQf5tz1tFcBtcgs3Tihr5IvtrP8h9yFoLaTBhr7qpg80agcaMJ/fnrXV
 BBfWtgCzVeXZ0+tsX7cexpDbRaprxtnlzFSudFeYbuCvmi2nUTiggU2RQsQ8sVCm/L1HHRDsp
 ckCjF7iegrgOxITql2FSNPdsAVtYGJB0ymkeUdrlMLum+8a8Kv9EfLs/mrnXIKh3EAairTf4m
 cKq0nfQ5LU06x36AQKKdf/f72bTFUzCR74cAaWa7UAJjgK8KvBt2ry5UgmUTy8W7xmNH3a0br
 S/0lepmym6jDUVWQZWFX4H5UyQBdtjO3C60VvW1WnGPth6qOLPuMibIlmFLDGfOICgqbEI0g3
 JqZGgEejWa3ZVvbKzQQ3bTgukm+Clc+0kyDqgG5hAJy/eFJ6G69i4lo4GPRC6jCncWPwLI0WL
 oQHFLrjYOSocbSO8vuo7t293L589i4Hoo4kHmq8wQ3pXdAIZrEMlth3SgSbw2Yx92cM2RahBv
 55k6JUBaFepHg3ECduE+aGmNQV4xy8r28bdlrdTyGftlNsnoKD9ElmqEMVtAO3wIHiNMunVG2
 u0vkfaauXMuI2o1N3jUhxRfd/RT5fF7vRz33pUQBCg/6CXJW089wyaHbtNU5s/rzMNEKFXpWd
 nzxFRw+lIHxb0qWcqMwPfjs5Z+PNRkWP6iQQDIsZ1IakMgzhcn0p1yxTQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.22 at 22:12, Lukas Wunner wrote:
> On Mon, Jun 06, 2022 at 01:04:19PM +0300, Ilpo J=C3=A4rvinen wrote:
>> -	if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
>> +	if (!port->rs485_supported->delay_rts_before_send) {
>> +		if (rs485->delay_rts_before_send) {
>> +			dev_warn_ratelimited(port->dev,
>> +				"%s (%d): RTS delay before sending not supported\n",
>> +				port->name, port->line);
>> +		}
>> +		rs485->delay_rts_before_send =3D 0;
>> +	} else if (rs485->delay_rts_before_send > RS485_MAX_RTS_DELAY) {
>>  		rs485->delay_rts_before_send =3D RS485_MAX_RTS_DELAY;
>>  		dev_warn_ratelimited(port->dev,
>>  			"%s (%d): RTS delay before sending clamped to %u ms\n",
>>  			port->name, port->line, rs485->delay_rts_before_send);
>>  	}
>
> This series seems to set rs485_supported->delay_rts_before_send to 1
> in all drivers to indicate that a delay is supported.
>
> It would probably be smarter to define it as a maximum, i.e. drivers
> declare the supported maximum delay in their rs485_supported struct
> and the core can use that to clamp the value.  Initially, all drivers
> may use RS485_MAX_RTS_DELAY.  Some chips only support specific delays
> (multiples of the UART clock or baud clock).  We can amend their
> drivers later according to their capabilities.

Agreed.

Regards,
Lino

