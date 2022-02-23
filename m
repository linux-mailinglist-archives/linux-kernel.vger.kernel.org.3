Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1FE4C0F74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiBWJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiBWJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:44:49 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582A70F4A;
        Wed, 23 Feb 2022 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uD+YdSB7BK2YZwHIlrFrUTb1ozQHZ1Cv2M2UMS1FjFg=; b=ddUFMN63QJ6TBX1ryUpKDsU/sP
        +7bMajKfZDclWj9HZR+nZqarXuhOYEc6+hQbWxMk1nIPbkJT3HthlJ+E3J7gP+aY9mkI12PxJTwVz
        j5o4v0FG6u/gMKV4m/QztKGHnt4kpcUZrULZUio4pv6LvX8W9HuQ+EaSsI9UA1MTfYL2wRR0+siSb
        8+VsToOmQMrcizomZAYvuvXA1fqbsA30K5w1Xbfa/4JFtCLIOP4S5Sxd+MR15CRsWy1QPPk6NaoIz
        OXPOpzYJ93NSv7xV6y6zIGnswVRXmhe45W0UBnXxJV4IBbSb9j4ZVAbXKcNb7/9F5yjdZDB2l8pd9
        Aid3wUXg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nMoBn-0003QL-UA; Wed, 23 Feb 2022 11:44:03 +0200
Message-ID: <d2579e10-e5c2-0d99-4233-19318a1db6c1@kapsi.fi>
Date:   Wed, 23 Feb 2022 11:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-4-mperttunen@nvidia.com>
 <YhUOKaoCA7dyAZAh@infradead.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <YhUOKaoCA7dyAZAh@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/22/22 18:24, Christoph Hellwig wrote:
> On Fri, Feb 18, 2022 at 01:39:46PM +0200, Mikko Perttunen wrote:
>> +
>> +/*
>> + * Due to an issue with T194 NVENC, only 38 bits can be used.
>> + * Anyway, 256GiB of IOVA ought to be enough for anyone.
>> + */
>> +static dma_addr_t context_device_dma_mask = DMA_BIT_MASK(38);
> 
> You need a mask per device.  Please don't share the same variable
> for multiple masks.
> 
>> +EXPORT_SYMBOL(host1x_context_alloc);
> 
> All this low-level code really should be EXPORT_SYMBOL_GPL.

Thanks, will fix (and same for patch 2).

Mikko
