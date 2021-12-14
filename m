Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A5474A13
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbhLNRuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:50:51 -0500
Received: from foss.arm.com ([217.140.110.172]:33824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhLNRuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:50:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38B1D6E;
        Tue, 14 Dec 2021 09:50:47 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862113F5A1;
        Tue, 14 Dec 2021 09:50:46 -0800 (PST)
Message-ID: <ddbe509c-8e54-e653-040f-e7edc8774060@arm.com>
Date:   Tue, 14 Dec 2021 17:50:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 10/11] iommu/iova: Move flush queue code to iommu-dma
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
References: <cover.1639157090.git.robin.murphy@arm.com>
 <0752bfc207b974e76eab7564058b5a7b9e8d5e6e.1639157090.git.robin.murphy@arm.com>
 <f0ec6978-4571-2d7c-f94c-cd92ba167074@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <f0ec6978-4571-2d7c-f94c-cd92ba167074@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-14 17:18, John Garry via iommu wrote:
> On 10/12/2021 17:54, Robin Murphy wrote:
>> +    iovad->fq_domain = fq_domain;
>> +    iovad->fq = queue;
>> +
>> +    timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
>> +    atomic_set(&iovad->fq_timer_on, 0);
>> +
>> +    return 0;
>> +}
>> +
>> +
> 
> nit: a single blank line is standard, I think

Hmm, you're right - I've grown fond of leaving an extra little bit of 
breathing space between logically-independent sections of code, and for 
some reason I thought this file was already in that style, but indeed it 
isn't.

Joerg - let me know if you feel strongly enough that you'd like me to 
change that. I'm going to have one last go at fixing tegra-drm, so I'm 
happy to send a v3 of the whole series later this week if there are any 
other minor tweaks too.

Thanks for all the reviews!

Robin.

> 
> Cheers
> 
>>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie 
>> *cookie)
>>   {
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
