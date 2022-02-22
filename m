Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED54BFAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiBVO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:28:12 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0ABC248A;
        Tue, 22 Feb 2022 06:27:46 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6FFDE22205;
        Tue, 22 Feb 2022 15:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645540064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dj0piB+942CQbs7XIdKdDi92gQwu/L2SA425BJSZIw=;
        b=ktuPX8BKiZqDpYwucvTcKBislX13mpMQ+qRPl2YCsKBgJ7lC9fxFZtsETlzyl7sNWWtTkP
        VV37FTzWj3GngcMe/KCdXOSn5dkIo/qR5uJBlK81gMsRWZegjuwhPyEkdbCh5Zcjz/pPIM
        AG5HZLtdFM5XS5xImsEXMgP1b3pHdkQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Feb 2022 15:27:44 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, broonie@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Nicolas.Ferre@microchip.com, zhengxunli@mxic.com.tw,
        jaimeliao@mxic.com.tw
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
In-Reply-To: <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-22 15:23, schrieb Tudor.Ambarus@microchip.com:
> On 2/22/22 16:13, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-02-22 14:54, schrieb Tudor.Ambarus@microchip.com:
>>> On 2/21/22 09:44, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Am 2022-02-18 15:58, schrieb Tudor Ambarus:
>>>>> Fortunately there are controllers
>>>>> that can swap back the bytes at runtime, fixing the endiannesses.
>>>>> Provide
>>>>> a way for the upper layers to specify the byte order in DTR mode.
>>>> 
>>>> Are there any patches for the atmel-quadspi yet? What happens if
>>> 
>>> not public, but will publish them these days.
>>> 
>>>> the controller doesn't support it? Will there be a software 
>>>> fallback?
>>> 
>>> no need for a fallback, the controller can ignore 
>>> op->data.dtr_bswap16
>>> if
>>> it can't swap bytes.
>> 
>> I don't understand. If the controller doesn't swap the 16bit values,
>> you will read the wrong content, no?
>> 
> 
> In linux no, because macronix swaps bytes on a 2 byte boundary both on
> reads and on page program. The problem is when you mix 8D-8D-8D mode 
> and
> 1-1-1 mode along the boot stages. Let's assume you write all boot 
> binaries
> in 1-1-1 mode. When reaching u-boot if you enable 8D-8D-8D mode, when 
> u-boot
> will try to get the kernel it will fail, as the flash swaps the bytes 
> compared
> to what was written with 1-1-1 mode. You write D0 D1 D2 D3 in 1-1-1 
> mode and
> when reaching u-boot you will read D1 D0 D3 D2 and it will mess the
> kernel image.

But you have to consider also 3rd parties, like an external programmer 
or
another OS. So, there has to be *one correct* way of writing/reading 
these
bytes.

-michael
