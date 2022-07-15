Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675DB576A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiGOXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiGOXDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:03:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF9B65D1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:03:40 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B69A822175;
        Sat, 16 Jul 2022 01:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657926219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHA9hmkXfJHcRowuiSm/1pwyuW6mHTYJZjrpyrCLpu4=;
        b=Y2NdEdDdvZsctAvY+X828e/O65uDqcdY5FDfSCbW40ShXS2PmzN7kqRJmcQ4NTVne1vJel
        ONhC/unBbytMNSC+3yEDOKA0OL9V2ZxFY4oDLUDNry4mTwxa/OGK5l1dxhy1xt2w8XGhIe
        7tX91q/YF2F2Ir2J9QUwwlNhytBw5o4=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 16 Jul 2022 01:03:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        quic_ggregory@quicinc.com, quic_jiles@quicinc.com,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
In-Reply-To: <c628e868-5c73-ca4b-1f99-60cc149806bf@quicinc.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
 <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
 <00f0c9d480ef5a414f1c34492661bd9e@walle.cc>
 <63cedfce-34bb-ed63-3871-75a6c3dd5d73@quicinc.com>
 <6be710bb5c1bf0449e54a54b78f6f7a0@walle.cc>
 <47c01d768ea56edc9a2f9d317af7b495@walle.cc>
 <114fcde6-bdf7-68ee-d031-35a916027aee@quicinc.com>
 <b42cb229-f241-6e29-a138-29023ce316d9@quicinc.com>
 <c628e868-5c73-ca4b-1f99-60cc149806bf@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b00410c825486ec406ed1ae773b11792@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-07-16 00:35, schrieb Jae Hyun Yoo:
> On 7/15/2022 1:15 PM, Jae Hyun Yoo wrote:
>> On 7/14/2022 7:30 AM, Jae Hyun Yoo wrote:
>>> On 7/14/2022 7:21 AM, Michael Walle wrote:
>>>> Am 2022-07-14 16:16, schrieb Michael Walle:
>>>>> Am 2022-07-14 15:47, schrieb Jae Hyun Yoo:
>>>>>> On 7/14/2022 12:41 AM, Michael Walle wrote:
>>>>>>> What does "doesn't boot at all" mean? Are there any kernel 
>>>>>>> startup
>>>>>>> messages?
>>>>>> 
>>>>>> I'm sharing the error messages below.
>>>>> 
>>>>> Thanks.
>>>>> 
>>>>>> [    0.748594] spi-nor spi0.0: w25q512nwq (65536 Kbytes)
>>>>>> [    0.865216] spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 
>>>>>> [0x406c0741]
>>>>>> [    0.872833] ------------[ cut here ]------------
>>>>>> [    0.877984] WARNING: CPU: 1 PID: 1 at drivers/mtd/mtdcore.c:583
>>>>>> add_mtd_device+0x28c/0x53c
>>>>>> [    0.887237] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
>>>>>> 5.15.43-AUTOINC-dirty-23801a6 #1
>>>>> 
>>>>> Could you please try it on the latest (vanilla) linux-next?
>>>> 
>>>> or spi-nor/next [1] as there are quite a lot of changes. The
>>>> patches shall be based on that.
>>> 
>>> Okay. Let me try that. I tested it using 5.15.43 with back-ported
>>> spi-nor patches from the latest. I'll back-port more changes from
>>> the spi-nor/next and will test the INFO(0xef6020, 0, 0, 0) setting
>>> again.
>> 
>> I tested the setting again after cherry picking all SPI relating 
>> changes
>> from the 'for-next' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi repository.
>> 
>> No luck! It's still making the same warning dump at 'add_mtd_device'
>> since 'mtd->erasesize' is checked as 0.
>> 
>> I traced it further to check if the erasesize is properly parsed from
>> the sfdp and checked that erase map seems parsed and initialized
>> correctly in 'spi_nor_parse_bfpt' but problem is, a target
>> mtd->erasesize is not properly selected in 'spi_nor_select_erase' 
>> since
>> the 'wanted_size' variable is initialized as sector size of info table
>> so a selected target mtd->erasesize is also 0 so looks like it's the
>> reason why it can't initialize mtd device if we use
>> INFO(0xef6020, 0, 0, 0).
>> 
>> Also, checked that the mtd->erasesize is set to 4096 if I enable
>> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS so the SPI flash can be initialized 
>> with the INFO(0xef6020, 0, 0, 0) setting but, it should cover even 
>> when
>> the configuration is not enabled. I think, this patch should go as it
>> is. The erasesize selecting issue could be fixed using a separate
>> patch.
>> 
>> Are you still sure that the INFO(0xef6020, 0, 0, 0) works in the
>> latest spi-next?
> 
> I also tried to fix the issue and made a fix like below.
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 502967c76c5f..f8a020f80a56 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2117,7 +2117,7 @@ spi_nor_select_uniform_erase(struct
> spi_nor_erase_map *map,
>                  * If the current erase size is the one, stop here:
>                  * we have found the right uniform Sector Erase 
> command.
>                  */
> -               if (tested_erase->size == wanted_size) {
> +               if (wanted_size && tested_erase->size == wanted_size) {
>                         erase = tested_erase;
>                         break;
>                 }
> 
> Tested that it makes the INFO(0xef6020, 0, 0, 0) setting work and a
> selected mtd->erasesize is 65536 which is what I expected for this
> device.
> 
> Not sure if it's a right fix or not. Please review and let me know if
> it's good to submit or not.

Ahh, I think I know whats going wrong here. Thanks!

4bait will set the erase size to 0 if there is no corresponding
opcode for the 4byte erase. So you'll end up with
et[0]: 4096 - 21h
et[1]: 0 - FFh
et[2]: 65536 - DCh
et[3]: --

And spi_nor_select_uniform_erase() will select et[1].

Could you try the following:

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ce5d69317d46..a2c8de250e01 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2113,6 +2113,10 @@ spi_nor_select_uniform_erase(struct 
spi_nor_erase_map *map,

                 tested_erase = &map->erase_type[i];

+               /* Skip masked erase types. */
+               if (!tested_erase->size)
+                       continue;
+
                 /*
                  * If the current erase size is the one, stop here:
                  * we have found the right uniform Sector Erase command.


-michael
