Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D64F04BB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357745AbiDBQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357741AbiDBQKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:10:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF0388E;
        Sat,  2 Apr 2022 09:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C93EFB80A25;
        Sat,  2 Apr 2022 16:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ED7C340EE;
        Sat,  2 Apr 2022 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648915725;
        bh=y7ESlPWtxRlIdhSZGGzoj11NW8q7/9qcgGEefxK5zJw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ua6L3GXkmuQ6CJbvQ5F7qY2YUTD9Bm6adyIsvhGeNXsNC6XRQIDKubNcYcYmQrvco
         +xNuRPps41q7NWA61K7FbzYDDgXDaZEOyXf+p7VeRmvUBltK3U2nX0I/AVa2t7E3SL
         cLQNzb8kmFQWQBE8pfS7TarHYEEMdK41tv2k/1+R1QOp2UVifNHDF4A5l3hILUFi+c
         ZsmRQ5qhDFtCxYqYGKvFdtRFMFgnBWKfgEF4pemgf+qI//J3aAGlJc+qPCfwNGKV0u
         dzHpss38jhP2I9JXo/Hbe2cIJB288yvvfURXVXUtb4Ma/LTQYbTCK2ByCjkOCFZM+j
         SdJo2JLAF6dZg==
Message-ID: <bc91bff4-0ba6-8f9d-e3b2-5e8caf16bd98@kernel.org>
Date:   Sat, 2 Apr 2022 18:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
 <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 15:51, Sven Peter wrote:
> On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
>> On 21/03/2022 17:50, Sven Peter wrote:
>>> Apple SoCs such as the M1 come with multiple embedded co-processors
>>> running proprietary firmware. Communication with those is established
>>> over a simple mailbox using the RTKit IPC protocol.
>>>
>>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>>> ---
>>>  drivers/soc/apple/Kconfig          |  13 +
>>>  drivers/soc/apple/Makefile         |   3 +
>>>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>>>  drivers/soc/apple/rtkit-internal.h |  76 +++
>>>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>>>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>>>  6 files changed, 1284 insertions(+)
>>
>> Isn't this some implementation of a mailbox? If so, it should be in
>> drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
>> Linux is organized. To drivers/soc usually we put drivers which do not
>> fit regular subsystems.
>>
> 
> I put this into soc/apple because I don't think it fits within the mailbox
> framework very well.
> (It actually uses the mailbox framework for the actual communication
> with the hardware with a driver that's already upstream.)
> 
> Essentially, the mailbox subsystem provides a common API to send and
> receive messages over indepedent hardware channels and devicetree bindings
> to describe the relationship between those channels and other drivers.
> 
> One of the features that doesn't really fit is that we need to be able
> to start, shutdown and re-start these co-processors. The NVMe driver
> actually doesn't need to send/receive any messages except those required
> to setup the common syslog/crashlog/etc. interfaces.
> The mailbox framework would have to be extended to support these specific
> use cases.
> 
> Another thing that doesn't fit is the memory management: These co-processors
> sometimes need shared memory buffers to e.g. send syslog messages.
> They always request these buffers with an IPC message but then there are
> different possibilities:
> 
> 	- For some processor the DMA API can just be used and an IOVA must be
> 	  sent back. For NVMe these buffers must additionally be allowed in this
> 	  SART address filter.
> 	- At least one other processor (SMC) does not request such buffers but
> 	  instead just sends a pointer into MMIO space and the buffer must be
> 	  accessed using readl/writel. This MMIO memory region is used for
> 	  both the common buffers (syslog etc.) and for the actual shared buffers
> 	  used for communication, such that the resource would have to be shared
> 	  across drivers.
> 	- And yet another coprocessor (for the display controller) requests some
> 	  buffers with an already existing IOVA that than need to be mapped
> 	  specifically inside the IOMMU.
> 
> Each of these co-processors also provides a single function and most
> of them don't even have different endpoints. And even those that do (DCP) will
> just become a single driver since all those endpoints are very much related.
> 
> While it's not impossible to do all that by extending and forcing this into the
> mailbox framework at lest I think that it doesn't fit very well and would just
> create unneccesarry impedance.

Thanks for explanation. I don't know the mailbox framework well enough
to advise you, so I don't mind keeping it in current location (drivers/soc).

Best regards,
Krzysztof
