Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6A4A9970
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiBDMgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:36:52 -0500
Received: from foss.arm.com ([217.140.110.172]:41436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352663AbiBDMgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:36:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40A311D4;
        Fri,  4 Feb 2022 04:35:59 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621133F40C;
        Fri,  4 Feb 2022 04:35:58 -0800 (PST)
Message-ID: <903818af-5cec-bfdd-6c03-69e6c4f29604@arm.com>
Date:   Fri, 4 Feb 2022 12:35:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: iommu non-strict mode for arm64
Content-Language: en-GB
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220204054616.cfqhygo3v7amrzvp@treble>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220204054616.cfqhygo3v7amrzvp@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 05:46, Josh Poimboeuf wrote:
> Hi all,
> 
> We've gotten significant slowdowns on arm64 with 4k pages compared to
> 64k.  The slowdowns can be alleviated by setting iommu.strict=0 or
> iommu.passthrough=1.
> 
> Is there a reason x86 defaults to lazy iommu, while arm64 does not?  Are
> there security implications which are specific to arm64?

The x86 behaviour is basically 2 decades of legacy where nobody now 
feels brave enough to flip the default. At the time the arm64 IOMMU DMA 
ops were first added, strict mode was the only thing feasible to 
implement, but there was also a conscious consideration that having a 
default assumption of "IOMMU == more protection" wasn't a bad thing 
anyway. Given what played out a couple of years later, and everyone now 
being that much more security-aware, I think that decision has only been 
reinforced.

Passthrough and non-strict mode in iommu-dma only came along later, and 
most IOMMU drivers for arm64 still don't support them, which is another 
reason I'm still against changing the default today. However, if you're 
confident that your arm64 users care more about high-bandwidth I/O 
throughput than memory protection then feel free to set 
IOMMU_DEFAULT_DMA_LAZY or IOMMU_DEFAULT_PASSTHROUGH in your config.

Cheers,
Robin.
