Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC283575022
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiGNN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiGNN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:56:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222862A7B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657806768; x=1689342768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q+g6Ua55R21KxZs8gSKLd53pDGdsbCuBh0okh1FzeHs=;
  b=sXuZYUploPnbv1WJa1MfJGwOaCtFmMrL8CCTRpcV71IbBiV3YGo6m8vx
   IkMT1UILvokXf30Mf5J6fCGBVIRTW9ODt3IzG2WoVpKrnwjP0BB6vxC78
   wkDNmpeECzf/wlf1yJS8jmikWL/F2yyv5Q9EE3sBbDtlJlpxUUT5UwZXz
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 14 Jul 2022 06:52:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:52:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 06:52:46 -0700
Received: from [10.110.120.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 06:52:45 -0700
Message-ID: <fa7b4a47-8ba7-a105-d216-1b86e0512751@quicinc.com>
Date:   Thu, 14 Jul 2022 06:52:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: add support for W25Q512NW-IQ
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220713211210.1945044-1-quic_jaehyoo@quicinc.com>
 <4d4a2abab1508fe80e36c2e524f98ed8@walle.cc>
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
In-Reply-To: <4d4a2abab1508fe80e36c2e524f98ed8@walle.cc>
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

On 7/14/2022 12:37 AM, Michael Walle wrote:
> Hi,
> 
> thanks for the update.
> 
> Am 2022-07-13 23:12, schrieb Jae Hyun Yoo:
>> Add support for Winbond W25Q512NW-IQ/IN
>>
>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Link: 
>> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> Changes in v2:
>>  * Refined commit message (Michael)
>>
>> Test result on AST2600 SoC's SPI controller:
>> $ cat
>> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/jedec_id 
>>
>> ef6020
>>
>> $ cat
>> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/manufacturer 
>>
>> winbond
>>
>> $ cat
>> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/partname 
>>
>> w25q512nwq
>>
>> $ hexdump
>> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp 
>>
>> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
>> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
>> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
>> *
>> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
>> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
>> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
>> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
>> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
>> 00000d0 0aff fff0 ff21 ffdc
>> 00000d8
> 
> md5sum of this file is missing.

Sure. I'll add md5sum of sfdp in v3.

Thanks,
Jae

> For the record: there is still an ongoing discussion on the v1 of
> this patch.
> 
> -michael
