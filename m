Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED33570011
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiGKLT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiGKLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:19:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A224BED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:42:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so269192wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4EsrGLApiR7KrR1xe+qurlpT+LNNhJnrtqXG7Ct5qrg=;
        b=mBQ2tztMqWmZzMu8saxlYgxtl18KpAj78UtlG8syY6uZgAhZLM4LaHwE8b+pOSr7hS
         8P2+PoZ0Lgbvc39aLBqyanCJ33Mp30b/GPrixov9DM6+4NMexNzMeadogihoYvXVOqsh
         LUtFG5kzfp5t5bDAcpBb5x/g8d0ffk2k1JbKSCtfaXU5RJ1I5rHnKKlH1sNH7aihTr1L
         D9Q5GtRIy80EhNV1tDvG+OvhExwbnBWEf6eaLNvsLp3YIT/yRpTzE61P9IS7YG87yQ/a
         6uIGoHm4NWMSVhFYu9jHwDVzPfE8d5oiAGkv7mrvy2iFgJotaRla7e3tn8FJXfQcsvxL
         tjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4EsrGLApiR7KrR1xe+qurlpT+LNNhJnrtqXG7Ct5qrg=;
        b=qaqYLcHFf899H1IwM6/SEv81cYfB3upZ8fCPu4gJ5S+YuWoXW48CX3uCAEeVVITGR1
         jjbaNxaGtEgwm8dPXpcXjxIVbMrWKDO8gMvC1kY1y/8L6MYdWF9gK9KxHPaWFHth1sFI
         BY3HhY6D/fnW+7ulL700ftsKS82CddZV84iQe+lN3su4nLB7Yle52TqG1JE307DpA1HS
         gg0lT8ddpxcxrJQl3Td6tC8uZDBeAqCl6gxLoRVws7CrGvfGWnsj3eGqWgJ+HHn1GqCI
         KRseAuHV8ODtdJwsXxy0lTWCXp2jRLUpzfFDA3QeJrdGCR+zW1gay0WThCdS13Bzg8uM
         nsSA==
X-Gm-Message-State: AJIora/ZcYAzugz9IGcpSQ8kqI4vHxeabozMa4xDEfshRXcPW4TwXZd1
        XHdv48VpNv2ZfzEPqTVIb9upGg==
X-Google-Smtp-Source: AGRyM1sEB9+GDlLklpISpqNfzr+fBlk8GhUJnAMJ+JjMDQ1mQwHG2E1B/C0mLWNhigPNUqJnLchWXg==
X-Received: by 2002:a5d:60c1:0:b0:21d:7469:9687 with SMTP id x1-20020a5d60c1000000b0021d74699687mr15945574wrt.361.1657536164868;
        Mon, 11 Jul 2022 03:42:44 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d624e000000b0021b9585276dsm5425864wrv.101.2022.07.11.03.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:42:44 -0700 (PDT)
Message-ID: <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com>
Date:   Mon, 11 Jul 2022 11:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
 <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de>
 <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
 <20220711103921.GA6542@lst.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220711103921.GA6542@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 11:39, Christoph Hellwig wrote:
> On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
>> On 11/07/2022 11:21, Christoph Hellwig wrote:
>>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>>> If none of your peripherals should need SWIOTLB, then the fact that
>>>> you're ending up in swiotlb_map() at all is a clear sign that
>>>> something's wrong. Most likely someone's forgotten to set their DMA
>>>> masks correctly.
>>>
>>> Yes.
>>
>> Possibly, we had at least one driver which attempted to set a 32 bit
>> DMA mask which had to be removed as the DMA layer accepts this but
>> since there is no DMA32 memory the allocator then just fails.
>>
>> I expect the above may need to be a separate discussion(s) of how to
>> default the DMA mask and how to stop the implicit acceptance of setting
>> a 32-bit DMA mask.
> 
> No.  Linux simply assumes you can do 32-bit DMA and this won't
> change.  So we'll need to fix your platform to support swiotlb
> eventually.

Ok, is there any examples currently in the kernel that have no memory
in the DMA32 zone that do use swiotlb?
