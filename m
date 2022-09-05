Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782045AD020
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbiIEK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiIEK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:29:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD90023BE1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1379FB8102E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD6C433D6;
        Mon,  5 Sep 2022 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662373756;
        bh=WlJQ2stKL5wf+I/xSf6BcWn5KmuI9TkM3tH0O9cnh3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZpIQhpmFit4FkPay59RFIocVuFZ4MW1FVM5Vjy4riQQTd1torqq3lf1ps2t2H15zy
         12P12r1QtqRDQGSojls6fVzEhQdjVb1JGl8b3ERFSl4FJR+54jo2gu2cqrcd5Du1rH
         2ZAr6fq3Nmw9mC706pAvdJoljWjvo+16vEw6PvewRgARpH6SNS0U/h36iNbL2K1svJ
         Qyq3ugBNsht1uf8/AIbjEzg8ay3S+T8ilc+8pbeA0Fil04a2+0vJJOt5uwOvRW6tng
         WDBmBUq0f4RIeTmd5B62vjMvS7i/LpvyrYp4LBOi4rAfI46jRGKsxgKp6V02xcDrl5
         9j/soiF9+NlAg==
Date:   Mon, 5 Sep 2022 13:28:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ardb@kernel.org,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxXPannyTqBZInAt@kernel.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
 <YxBeS0G+F+fsBgod@kernel.org>
 <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxCk0mX5IzhvK9Pv@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 08:25:54PM +0800, Baoquan He wrote:
> On 09/01/22 at 10:24am, Mike Rapoport wrote:
> 
> max_zone_phys() only handles cases when CONFIG_ZONE_DMA/DMA32 enabled,
> the disabledCONFIG_ZONE_DMA/DMA32 case is not included. I can change
> it like:
> 
> static phys_addr_t __init crash_addr_low_max(void)
> {
>         phys_addr_t low_mem_mask = U32_MAX;
>         phys_addr_t phys_start = memblock_start_of_DRAM();
> 
>         if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
>              (phys_start > U32_MAX))
>                 low_mem_mask = PHYS_ADDR_MAX;
> 
>         return low_mem_mast + 1;
> }
> 
> or add the disabled CONFIG_ZONE_DMA/DMA32 case into crash_addr_low_max()
> as you suggested. Which one do you like better?
> 
> static phys_addr_t __init crash_addr_low_max(void)
> {
>         if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> 		return PHYS_ADDR_MAX + 1;
> 
>         return max_zone_phys(32);
> }
 
I like the second variant better.

-- 
Sincerely yours,
Mike.
