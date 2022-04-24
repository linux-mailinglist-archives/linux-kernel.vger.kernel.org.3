Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F850D321
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiDXQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiDXQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:10:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A2D5579
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:07:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n14so1583739lfu.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P0QTcW9KC8jtIUCRBrIIRQHtbmv2CJL2pbvGJ+qNveo=;
        b=RiDL8hh90QWpKHeZOtsPDicsUv8uA01P9JI5zDhJzv9S+hSKAbApcqzHs0T8Ldp9TH
         fAKRmSgdTSQEE98j8anHPESWwfAC2Wr6fwaU0UzzpCRUSoyOzbyPMzyk4xG8MnEvB3iV
         vXzmNcMzP3+/OStgwtLtURtgOrLqR3sG0n+QrmZd6F+knSa4ckhblkdvzPf132oMlyW7
         8t9564ctxOVGtPTZPcgIhaetMmVgXzuHspqXhW5Z1CHzDb7rM2I+v0s8lEPpdwVc60cp
         RKkWFcAQAI+3ep3nitOiLgSd5r38470CHVIt8zrx9Sfl0OWd+5F9Bp8RCTq2DFJy08Ox
         nIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P0QTcW9KC8jtIUCRBrIIRQHtbmv2CJL2pbvGJ+qNveo=;
        b=nJ875wItR/CFkMQXxdlWMDPRVfsRJxRuJMnfKb5g245Ff5WensxcoHM/+OFxG6+pR1
         BK2RodiBkMm70Fz5dHx6cjd28abMhoo0IjohWCqUpEQRklQ+ogzl/tYF+84gGNZeWozi
         NdAOMxLHpI+kVBPVKvIlu9qa8HmUCoJc1aDRBHL/SmXOVOU9veUbfaWSkeG5grrRJx1C
         CRId1UxLC9VZ8lZbCh4St653f3s5r4Mj1XGfksqdXwHB6TnEqXRzXpsUROD0wI+KXO6H
         GTDXTIdpGcxefiYsy5UUXva1g31ZXMFPLmctVeXOPU89CvcLIRbPvmia/xZMqJirxwPw
         yzJQ==
X-Gm-Message-State: AOAM531sr8/YBbZ8sXi3eT08JS9vGXetakN5bPydaiMWWWOk0E3qcA+Z
        GLVfxGgLHFwXKKJcIhmpZPE=
X-Google-Smtp-Source: ABdhPJwXDQKL0ddwC14m+1rm/W4CunYi8dET47R83s7iLr9ZMexO+AO6MY6p46hpbAM/pGFodjYHLQ==
X-Received: by 2002:a05:6512:685:b0:471:d466:9750 with SMTP id t5-20020a056512068500b00471d4669750mr9842846lfe.623.1650816445822;
        Sun, 24 Apr 2022 09:07:25 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id x5-20020a2e9dc5000000b0024dbe5356bcsm925671ljj.91.2022.04.24.09.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 09:07:25 -0700 (PDT)
Subject: Re: [PATCH V1 6/6] arm/xen: Assign xen-grant DMA ops for xen-grant
 DMA devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-7-git-send-email-olekstysh@gmail.com>
 <YmQsagqMn56jidFZ@infradead.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <d102516a-af42-7637-2b5c-f7da33d5036e@gmail.com>
Date:   Sun, 24 Apr 2022 19:07:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmQsagqMn56jidFZ@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.04.22 19:42, Christoph Hellwig wrote:

Hello Christoph

> On Fri, Apr 22, 2022 at 07:51:03PM +0300, Oleksandr Tyshchenko wrote:
>>   static inline void xen_setup_dma_ops(struct device *dev)
>>   {
>>   #ifdef CONFIG_XEN
>> -	if (xen_swiotlb_detect())
>> +	if (arch_has_restricted_virtio_memory_access() &&
>> +			xen_is_grant_dma_device(dev))
>> +		xen_grant_setup_dma_ops(dev);
>> +	else if (xen_swiotlb_detect())
> I don't think that arch_has_restricted_virtio_memory_access
> check should be there as it still is a bit of a layering violation.

Well, I will remove it then (and update commit description).

For virtualized but non-virtio devices, it is not needed at all. For the 
virtio devices, this check is already present at 
virtio.c:virtio_features_ok()



>
-- 
Regards,

Oleksandr Tyshchenko

