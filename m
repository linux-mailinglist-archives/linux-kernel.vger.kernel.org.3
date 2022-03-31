Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B84EE21A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiCaTvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiCaTva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:51:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DA31369;
        Thu, 31 Mar 2022 12:49:43 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 43A991F4724B;
        Thu, 31 Mar 2022 20:49:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648756182;
        bh=0Oz4uyGn6BcSHSRmcqDFLjru1xWqtFKeFoT+J5B44JY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mkWL9XCh5w3HkxbcjX3x/hWKrGoLd7b+8U7J3IwwmUtmUdZoN26J47I5+pxtrFgU+
         VO3AOQtBtif+3n1b+H323sB3kT3o03LgKmglY2r+d94IaOV8bGFWULTxlME15C73p4
         cV6aK8ayKbkSvx2z5ClFobxjNuFtiyVqFWkVftH2tLqcXnIep9RnrDbVBokSw3R9Fi
         19Esy3IhNVesNM4y7aeHkg83drrB4QULqDBwHC/TCbsAMaNNHujo4Fx+vAsATFc/B6
         7umlB+Wj9loa7aQDcuijB/y8QM29Emn3nDVT1S23/IAl0SSUUCjtzKU8/qsZzX50xP
         5XLY7ZQ2c/C+w==
Message-ID: <bf8bee92-0d0e-453b-5ff1-1829a4406fd1@collabora.com>
Date:   Thu, 31 Mar 2022 22:49:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <9ab1a77c-82e6-39be-9b90-b394037fb574@gmail.com>
 <a62bb479-fed4-ada0-ac61-fb67a663a998@nvidia.com>
 <4ea801f4-7929-148d-4e69-d4126a9dfbf7@collabora.com>
 <44235c65-160c-04c7-294d-16b13d25605c@nvidia.com>
 <bf851834-7812-13f1-a382-1f64078ff2a5@collabora.com>
 <06174428-edb1-6478-1b2c-ede83c4bfa87@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <06174428-edb1-6478-1b2c-ede83c4bfa87@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 14:22, Ashish Mhetre wrote:
...
>>> If we are to remove this callback then how to handle unknown interrupt
>>> channel error?
>>
>> Create a common helper function that returns ID of the raised channel or
>> errorno if not bits are set.
>>
> So something like this:
> 
> int status_to_channel(const struct tegra_mc *mc, u32 status,
>               unsigned int *mc_channel)
> {
>     if ((status & mc->soc->ch_intmask) == 0)
>         return -EINVAL;
> 
>     *mc_channel = __ffs((status & mc->soc->ch_intmask) >>
>                  mc->soc->status_reg_chan_shift);
> 
>     return 0;
> }
> 
> Correct?

Yes

>>> Also we want to handle interrupts on one channel at a time and then
>>> clear it from status register. There can be interrupts on multiple
>>> channel. So multiple bits from status will be set. Hence it will be
>>> hard to parameterize shift such that it gives appropriate channel.
>>> So I think current approach is fine. Please correct me if I am wrong
>>> somewhere.
>>
>> You may do the following:
>>
>> 1. find the first channel bit set in the status reg
>> 2. handle that channel
>> 3. clear only the handled status bit, don't clear the other bits
>> 4. return from interrupt
>>
>> If there are other bits set, then interrupt handler will fire again and
>> next channel will be handled.
> 
> For clearing status bit after handling, we can retrieve channel bit by
> something like this:
> 
> ch_bit = BIT(*mc_channel) << mc->soc->status_reg_chan_shift;
> 
> Correct?

Yes

Perhaps using FIELD_PREP() and alike helpers could make it look nice in
the code.
