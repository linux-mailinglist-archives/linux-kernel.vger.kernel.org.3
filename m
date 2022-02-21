Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847C4BE93A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356501AbiBULgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:36:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiBULgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:36:08 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384DADF3C;
        Mon, 21 Feb 2022 03:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Sw0I/RylQnKI1uq0FibHj95obK9mnJQpn1pSKABNnu4=; b=gfg8U2QUAXfumrTD8Ej62KBdYt
        iK+1LPPtSoHp2VAEDWfEKsObDjwWMfI+Czo0lPkH4p6lHUhAuxPd9caqhTAAznjJ3A5fOvEvqbiQR
        L0FHlTx6FrJWU6NqoNCo2syRgLj7slWQaQujCc2K9yW/+gC5bzEhMaXq7vIHFTunnnku/WZXmtTuR
        v83CnecZ7mgL7pJaDxOdrS+ByyrKZVMRxQXQ6UvIeBSk7UKhZu7VEV1g7Y8G83O4FfoPYHHi1T94j
        LEIxcin8vZ/W14NsYg4JNUlgPSIiyJF0WjmkPD/k9X0HsElqZ/upiv6Es7KQHF21rinaUXL+byoJe
        m9ommXOQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nM6yb-00021R-0w; Mon, 21 Feb 2022 13:35:33 +0200
Message-ID: <d30291a3-c1d1-5c7d-025f-03cd58eee1ab@kapsi.fi>
Date:   Mon, 21 Feb 2022 13:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-4-mperttunen@nvidia.com>
 <149d4794-90fd-cde3-9d59-39e6488db679@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <149d4794-90fd-cde3-9d59-39e6488db679@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/22 19:48, Dmitry Osipenko wrote:
> 18.02.2022 14:39, Mikko Perttunen пишет:
> ...
>> +/*
>> + * Due to an issue with T194 NVENC, only 38 bits can be used.
>> + * Anyway, 256GiB of IOVA ought to be enough for anyone.
>> + */
>> +static dma_addr_t context_device_dma_mask = DMA_BIT_MASK(38);
> 
> s/dma_addr_t/u64/ ? Apparently you should get compilation warning on ARM32.
> 
> https://elixir.bootlin.com/linux/v5.17-rc4/source/include/linux/device.h#L524 >
>> +int host1x_context_list_init(struct host1x *host1x)
>> +{
>> +	struct host1x_context_list *cdl = &host1x->context_list;
>> +	struct host1x_context *ctx;
>> +	struct device_node *node;
>> +	int index;
> 
> Nitpick: unsigned int
> 
> ...
>> +del_devices:
>> +	while (--index >= 0)
> 
> Nitpick: while (index--)
> 
> ... >> +void host1x_context_list_free(struct host1x_context_list *cdl)
>> +{
>> +	int i;
> 
> Nitpick: unsigned int
> 

Thanks, fixed all.

Mikko
