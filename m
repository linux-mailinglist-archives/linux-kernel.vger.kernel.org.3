Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927A4FF5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiDMLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDMLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:35:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CDE35A9C;
        Wed, 13 Apr 2022 04:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5492B82265;
        Wed, 13 Apr 2022 11:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADCAC385A3;
        Wed, 13 Apr 2022 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649849608;
        bh=4a5JEYuva23R1RGYMHAMOqQi9kkUsmhoMwzj/Rnvwxw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H2UW35uuk/ToXg//R0VZwYI+/Ppb7JXB0UTBU7Dq3m4rNWh7pFeqsAtDzFVLVjy7x
         e8uHxKESm8yfKY2USzzxPS27Iioaiq+PB6Crnkns0gv3qv8U3A1EwE3gyVr7cmy8ru
         XJHNOKs1BPtIxngIXPCrMCynzm/Z5f2vxFwOwcIYQt+js2GrUnFp9G32b6h9LmNoBw
         iDcfrwYlutYWTiqGGTHfK7bp0dIuZMIMPcOdijixn5RQv6Gcy+FWHR0dnhQ1dxyRkk
         6ai9OypW5XbJxUJI53ycr0ouPYgbhkMyEHuOHasyFGrw+/t27FRDc6wM6TN+G5avvz
         fdaieufFY6uHw==
Message-ID: <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
Date:   Wed, 13 Apr 2022 14:33:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzk@kernel.org
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 14:05, Krzysztof Kozlowski wrote:
> On 13/04/2022 13:01, Roger Quadros wrote:
>>> https://krzk.eu/#/builders/63/builds/162
>>>
>>>
>>>>  config OMAP_GPMC
>>>> -	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>>>> -	depends on OF_ADDRESS
>>>> +	bool "Texas Instruments OMAP SoC GPMC driver"
>>>> +	depends on OF_ADDRESS || COMPILE_TEST
>>
>>
>> Looks like include/linux/irqdomain.h does not have fallbacks if
>> CONFIG_IRQ_DOMAIN is not enabled.
>>
>> I'll have to drop COMPILE_TEST and add depends on IRQ_DOMAIN.
>> Is that OK?
> 
> Previously it was building with COMPILE_TEST on sparc, so what else changed?
> 
Previously it was like so

	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
	depends on OF_ADDRESS

Means it won't build if OF_ADDRESS is not set even if COMPILE_TEST is set.

And OF_ADDRESS is not set for sparc

config OF_ADDRESS
        def_bool y
        depends on !SPARC && (HAS_IOMEM || UML)

cheers,
-roger
