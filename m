Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACE35531E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349947AbiFUMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349886AbiFUMW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422FA23168;
        Tue, 21 Jun 2022 05:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F7661368;
        Tue, 21 Jun 2022 12:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A6C3411C;
        Tue, 21 Jun 2022 12:22:22 +0000 (UTC)
Message-ID: <c05ac6d9-92cc-8c47-9665-dfc5332b860a@xs4all.nl>
Date:   Tue, 21 Jun 2022 14:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Content-Language: en-US
To:     Eugen.Hristev@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com, Nicolas.Ferre@microchip.com,
        jacopo@jmondi.org
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <1da0d3e3-7c63-eac8-c3ac-9083d5d16c88@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <1da0d3e3-7c63-eac8-c3ac-9083d5d16c88@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On 6/15/22 13:06, Eugen.Hristev@microchip.com wrote:
> On 5/3/22 12:51 PM, Eugen Hristev wrote:
>> This series is a split from the series :
>> [PATCH v9 00/13] media: atmel: atmel-isc: implement media controller
>> and it includes the media controller part.
>> previous fixes were sent on a different patch series.
>>
>> As discussed on the ML, moving forward with having the media link validate at
>> start/stop streaming call.
>> I will test the patch :
>> [RFC PATCHv2] vb2: add support for (un)prepare_streaming queue ops
>> afterwards, but that patch requires moving my logic to the new vb2 callbacks.
>>
>> Full series history:
>>
>> Changes in v10:
>> -> split the series into this first fixes part.
>> -> moved IO_MC addition from first patch to the second patch on the driver changes
>> -> edited commit messages
>> -> DT nodes now disabled by default.
>>
>> Changes in v9:
>> -> kernel robot reported isc_link_validate is not static, changed to static.
>>
>> Changes in v8:
>> -> scaler: modified crop bounds to have the exact source size
>>
>> Changes in v7:
>> -> scaler: modified crop bounds to have maximum isc size
>> -> format propagation: did small changes as per Jacopo review
>>
>>
>> Changes in v6:
>> -> worked a bit on scaler, added try crop and other changes as per Jacopo review
>> -> worked on isc-base enum_fmt , reworked as per Jacopo review
>>
>> Changes in v5:
>> -> removed patch that removed the 'stop' variable as it was still required
>> -> added two new trivial patches
>> -> reworked some parts of the scaler and format propagation after discussions with Jacopo
>>
>>
>> Changes in v4:
>> -> as reviewed by Hans, added new patch to remove the 'stop' variable and reworked
>> one patch that was using it
>> -> as reviewed by Jacopo, reworked some parts of the media controller implementation
>>
>>
>> Changes in v3:
>> - change in bindings, small fixes in csi2dc driver and conversion to mc
>> for the isc-base.
>> - removed some MAINTAINERS patches and used patterns in MAINTAINERS
>>
>> Changes in v2:
>> - integrated many changes suggested by Jacopo in the review of the v1 series.
>> - add a few new patches
>>
>> Eugen Hristev (5):
>>    media: atmel: atmel-isc: prepare for media controller support
>>    media: atmel: atmel-isc: implement media controller
>>    ARM: dts: at91: sama7g5: add nodes for video capture
>>    ARM: configs: at91: sama7: add xisc and csi2dc
>>    ARM: multi_v7_defconfig: add atmel video pipeline modules
>>
>>   arch/arm/boot/dts/sama7g5.dtsi                |  51 ++
>>   arch/arm/configs/multi_v7_defconfig           |   3 +
>>   arch/arm/configs/sama7_defconfig              |   2 +
>>   drivers/media/platform/atmel/Makefile         |   2 +-
>>   drivers/media/platform/atmel/atmel-isc-base.c | 485 +++++++++---------
>>   .../media/platform/atmel/atmel-isc-scaler.c   | 267 ++++++++++
>>   drivers/media/platform/atmel/atmel-isc.h      |  50 +-
>>   .../media/platform/atmel/atmel-sama5d2-isc.c  |  34 +-
>>   .../media/platform/atmel/atmel-sama7g5-isc.c  |  32 +-
>>   9 files changed, 685 insertions(+), 241 deletions(-)
>>   create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c
>>
> 
> 
> Hello Hans,
> 
> What do you think about this series, does it require more work or 
> changes until it could move further ? Anything in particular you would 
> like me to try or test out ?

It's high on my todo list to look at this and see if anything else needs to
be done. I hope to get to this this week.

Regards,

	Hans

> 
> Thanks,
> Eugen
