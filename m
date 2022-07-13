Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BE1573E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiGMVBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGMVBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:01:06 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7A31349
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657746063; x=1689282063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LhXI5ldx+R/isqL5mJTcb3Kqhseql2na+Zu9Y+5xW08=;
  b=QI+7ydfC8JjS5pwjUzfLRLuNgh+gRoNEeBhAfrV2QynETZ9TswMd+3fN
   8PZFvXt0GfCoks+dPwsq1ZQAD+2sfxsFKunNTQA2Pt8A/Sc1ozyclCSax
   iloMpV7ebfc1bwHAaoLtIupmqorxI4eLy8gk63bczygm7swkQovZY14wF
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jul 2022 14:01:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 14:01:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Jul 2022 14:01:02 -0700
Received: from [10.110.120.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 14:01:01 -0700
Message-ID: <2260955b-354d-ceda-cadc-49453bfca3e4@quicinc.com>
Date:   Wed, 13 Jul 2022 14:01:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
CC:     <clg@kaod.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <p.yadav@ti.com>,
        <quic_ggregory@quicinc.com>, <quic_jiles@quicinc.com>,
        <tudor.ambarus@microchip.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
 <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 7/13/2022 7:32 AM, Michael Walle wrote:
> Hi,
> 
> Am 2022-07-13 16:26, schrieb Jae Hyun Yoo:
>>>> +    { "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)
>>>
>>> Please use INFO(0xef6020, 0, 0, 0) and test wether it will still
>>> work correctly. We will then be able to convert it to SNOR_ID3()
>>> later.
>>
>> Tested it but it doesn't work with INFO(0xef6020, 0, 0, 0). I'll keep
>> it as is.
> 
> Can you please look into this? I'd expect this to work if the SFDP
> tables are correct because all this should come from the tables.
> You can look at /sys/kernel/debug/spi-nor/spi0.0/params and see
> what is changing there.

I tested it again but result is still the same. I can check the parsed
info like below if I use INFO(0xef6020, 0, 64 * 1024, 1024) but I can't
even check the debugfs info if I use INFO(0xef6020, 0, 0, 0) since it
doesn't boot at all. I think, this patch should go as is and the size
parsing issue could be fixed using a separate fix.

Thanks,
Jae

$ cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
  1S-1S-1S
   opcode        0x13
   mode cycles   0
   dummy cycles  0
  1S-1S-1S (fast read)
   opcode        0x0c
   mode cycles   0
   dummy cycles  8
  1S-1S-2S
   opcode        0x3c
   mode cycles   0
   dummy cycles  8
  1S-2S-2S
   opcode        0xbc
   mode cycles   2
   dummy cycles  2
  1S-1S-4S
   opcode        0x6c
   mode cycles   0
   dummy cycles  8
  1S-4S-4S
   opcode        0xec
   mode cycles   2
   dummy cycles  4
  4S-4S-4S
   opcode        0xec
   mode cycles   2
   dummy cycles  0

Supported page program modes by the flash
  1S-1S-1S
   opcode        0x12
  1S-1S-4S
   opcode        0x34
$ cat /sys/kernel/debug/spi-nor/spi0.0/params
name            w25q512nwq
id              ef 60 20
size            64.0 MiB
write size      1
page size       256
address width   4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | SOFT_RESET

opcodes
  read           0x6c
   dummy cycles  8
  erase          0xdc
  program        0x12
  8D extension   none

protocols
  read           1S-1S-4S
  write          1S-1S-1S
  register       1S-1S-1S

erase commands
  21 (4.00 KiB) [1]
  dc (64.0 KiB) [3]
  c7 (64.0 MiB)

sector map
  region (in hex)   | erase mask | flags
  ------------------+------------+----------
  00000000-03ffffff |     [ 123] |

> Thanks,
> -michael
