Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38440570337
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiGKMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiGKMqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:46:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D851F62F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:45:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n185so2966497wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t777n2+TDn0IVOqq3hDcAeLbMM3MoxW5K5Rlccw3Od8=;
        b=CwhBnHwIQx+qc/9lxiXsapAjOzF7ooWQAJ/hwNRTlHBdTs4EGEopz70uNSdV60sMHM
         rd673qW9ta0iNTurwlWteBP3gKBDPrIIAhfnFY7pOzsaObhiGb6Gq/kwmVztWwIGcN8h
         WuWyB07It2+WGyZ64k6diIcOHrQ1o7WSZqEzFmYHOGQDltnD/vaj0COXM1FGs0fUzd4H
         vOAvwTHbSLd1aDiJi+qx3CG1XQyDaJ2ps4f8onCg1kVVPKOhVsvEzA++mHtPKhaFq4oN
         SOiZ1XTAGR9B5D0whn1vf6LHnKFMr6wDVEo0H+qLzRhZUuaP2Nq8yww5HGfgAUxMbpgA
         f1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t777n2+TDn0IVOqq3hDcAeLbMM3MoxW5K5Rlccw3Od8=;
        b=7Uk71AJ68bTErFJe95Bqgt0n2dgJPU5DWCvAoeVq0Q5FgB0r2O1L+s+A6NwjTWEQHz
         pTO8hiBCfUhYVbn2ranJcV9fGpzxh2nUmbHRz1zoBzxyohd12lRUSET3MYMH6ZfENnZ4
         Y42ATbQnHwfLHQvI7xux+0ZMVmZjLupMnaep2j89daF6iEgnFjWID1H0BLW2o2SaUIH+
         1xl+gBN0wcLIT2pG1PR+02g5I2eTx/0+Yb2C5z4ZZ+2LCNKDXdw0mXkiPfcNkcUAeLk0
         m+wv3tX6czZnMygwr6RY5W1fLXnQG8WcS+91mBInuRZu+PWcWgz1IuCb45nKkkpxf95u
         qzmw==
X-Gm-Message-State: AJIora+FjUK244sLWKLESvljSGT/jxoLSWIhDjfboPToSIzcnRuG5m3G
        4mpcxHn6GbgYyOwezom7u2Is+g==
X-Google-Smtp-Source: AGRyM1tz30I9rm8O+KUFpRG0nRJ+cqUu/InH2GzOhqDpt8AIAuAUSg6ATzCTQTbAzLvDu2yXI+R6TA==
X-Received: by 2002:a7b:c381:0:b0:3a2:aef9:8df4 with SMTP id s1-20020a7bc381000000b003a2aef98df4mr16258084wmj.7.1657543546039;
        Mon, 11 Jul 2022 05:45:46 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d50d1000000b0021b956da1dcsm5702313wrt.113.2022.07.11.05.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:45:45 -0700 (PDT)
Message-ID: <7906385d-d3f5-113a-4d31-8e9564c3c6ab@sifive.com>
Date:   Mon, 11 Jul 2022 13:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To:     Conor.Dooley@microchip.com, robin.murphy@arm.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, sudip.mukherjee@sifive.com,
        jude.onyenegecha@sifive.com, m.szyprowski@samsung.com
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
 <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
 <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com>
 <fc216e29-7dfb-5265-33d1-b547b8b7bd52@microchip.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <fc216e29-7dfb-5265-33d1-b547b8b7bd52@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 12:52, Conor.Dooley@microchip.com wrote:
> 
> 
> On 11/07/2022 12:01, Robin Murphy wrote:
>> On 2022-07-11 11:42, Ben Dooks wrote:
>>> On 11/07/2022 11:39, Christoph Hellwig wrote:
>>>> On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
>>>>> On 11/07/2022 11:21, Christoph Hellwig wrote:
>>>>>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>>>>>> If none of your peripherals should need SWIOTLB, then the fact that
>>>>>>> you're ending up in swiotlb_map() at all is a clear sign that
>>>>>>> something's wrong. Most likely someone's forgotten to set their DMA
>>>>>>> masks correctly.
>>>>>>
>>>>>> Yes.
>>>>>
>>>>> Possibly, we had at least one driver which attempted to set a 32 bit
>>>>> DMA mask which had to be removed as the DMA layer accepts this but
>>>>> since there is no DMA32 memory the allocator then just fails.
>>>>>
>>>>> I expect the above may need to be a separate discussion(s) of how to
>>>>> default the DMA mask and how to stop the implicit acceptance of setting
>>>>> a 32-bit DMA mask.
>>>>
>>>> No.  Linux simply assumes you can do 32-bit DMA and this won't
>>>> change.  So we'll need to fix your platform to support swiotlb
>>>> eventually.
>>>
>>> Ok, is there any examples currently in the kernel that have no memory
>>> in the DMA32 zone that do use swiotlb?
>>
>> The arm64 code originally made an assumption that a system with that kind of memory layout would use a DMA offset in the interconnect, and so placed ZONE_DMA32 in the first 4GB of available RAM rather than actual physical address space. The only relatively mainstream platform we subsequently saw with all RAM above 32 bits was AMD Seattle, which also *didn't* use a DMA offset, so it "worked" by virtue of this bodge in the sense that allocations didn't fail, but DMA transactions would then disappear off into nowhere when the device truncated the MSBs of whatever too-big DMA address it was given.
>>
>> I think that stuff's long gone by now, and if any of handful of remaining Seattle users plug in a 32-bit PCIe device and try to use it with the IOMMU disabled, they'll probably see the fireworks as intended.
>>
>> Much as we'd like to make DMA an explicit opt-in for all drivers, that's something which can only really be solved 30 years ago.
> 
> 
> Out of curiosity Ben, can you shed any more light on the platform?

Not at the moment, sorry.

