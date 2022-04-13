Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A604FF652
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiDMMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiDMMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BC05C845;
        Wed, 13 Apr 2022 04:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02EBEB822A2;
        Wed, 13 Apr 2022 11:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD47BC385A3;
        Wed, 13 Apr 2022 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649851022;
        bh=/28cBlZHS/9AS9L3mR/Qf4hSb2eXatBFtJPO4rc1wnM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oMYdFttn45VkRrPzkoAkcyqwojs9pgADdtRbLPwxR04bSSVCbms1orrzbuvoPj5Wt
         lEsn+thfEmx/Yjn5VsoZCmfnSbZHzY2UAy6ryMd0Z7PBkJdqe/fKIxD7JJz9H8/gHC
         GDQfF3PkmWlF7vB8eawnnIk/8S+d5djg/OroRESeyxSgj+rbcaoqVoL6lW8kaNdQUM
         qqYSZXf2yE4ZBSRNWfM/yiqSsM+gQjJCubxYa75EjvMoT0DZZP1MsmvcBWJ3x2ZSg1
         zoKou0wFi3qdMcKekqA5+XSFr+ASf92v3tZgoaJxMpQFU7PXepkz/KgVqNnSePOE6f
         QNlFvciDzaCIQ==
Message-ID: <605268c7-9d0f-83d5-d7e6-850dabb380f0@kernel.org>
Date:   Wed, 13 Apr 2022 14:56:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
 <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
 <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
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



On 13/04/2022 14:47, Krzysztof Kozlowski wrote:
> On 13/04/2022 13:33, Roger Quadros wrote:
>>> Previously it was building with COMPILE_TEST on sparc, so what else changed?
>>>
>> Previously it was like so
>>
>> 	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>> 	depends on OF_ADDRESS
>>
>> Means it won't build if OF_ADDRESS is not set even if COMPILE_TEST is set.
>>
>> And OF_ADDRESS is not set for sparc
>>
> 
> Ah, yes, so dropping COMPILE_TEST seems the solution. There are no other
> "depends" here.

But the build failed at irq_domain_remove() which is only available if IRQ_DOMAIN
is enabled.

It could be possible that OF_ADDRESS is enabled but IRQ_DOMAIN is not right?

cheers,
-roger
