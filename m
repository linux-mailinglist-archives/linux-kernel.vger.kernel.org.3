Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE574E501B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbiCWKNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiCWKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:13:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3786476673
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7BBCB81E3C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA28C340E8;
        Wed, 23 Mar 2022 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648030337;
        bh=ZqYelnPHSyiekUSEVdXVFLAEHUGzk7MFiKPIvGvUj2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LKl7N67IgqJflytndpt1oe+XvN66fr/e77YshVtL8MAaBNuHLNShe+LPMtWnfhLXg
         mkZlEoWvDluP4UFnpjWceesFM2O4QSskd9+8hxAzm9xyMB5lbR2ytb1LB0EXhk9Fhc
         n9juoHp0Qvu49IrjbSYLIIDEceNEVFHjlidqH+tKg/LMnKsFECTmYPnbkCWolbeb88
         B387tOwxi3QcAKAz1FRT3HolHAc08DR56OMHnhQ84ijMrnKl2bmT01z1dvpHhh2fcx
         1QmOylv6NAVNhwuS5cWwQZM+M1V1e11owG5wEBA+Uap63Y/rAc3ML3wWPZvevEbXNE
         JEAVzVTNEWYzQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWxyR-00GTAS-7C; Wed, 23 Mar 2022 10:12:15 +0000
MIME-Version: 1.0
Date:   Wed, 23 Mar 2022 10:12:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     xieming <xieming@kylinos.cn>
Cc:     christoffer.dall@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: fix gpu passthrough into vm on arm64
In-Reply-To: <20220323012519.521058-1-xieming@kylinos.cn>
References: <20220323012519.521058-1-xieming@kylinos.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7fbec7b1c2eaa805cb9e846e7e915707@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: xieming@kylinos.cn, christoffer.dall@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use my *working* email address (look in the MAINTAINERS file for 
the up-to-date one).

On 2022-03-23 01:25, xieming wrote:
> 1) when passthrough some pcie device, such as AMD gpus,
>         kvm will report:"Unsupported FSC:" err.

Please detail this. What values of FSC? In what circumstances?

> 
> 2) the main reason is kvm setting memory type to
>    PAGE_S2_DEVICE(DEVICE_nGnRE), but in guestos, all of device io 
> memory
>    type when ioremapping (including gpu driver TTM memory type) is
>    setting to MT_NORMAL_NC.
> 
> 3) according to ARM64 stage1&stage2 conbining rules.
>    memory type attributes combining rules:
>    Normal-WB < Normal-WT <  NormalNC <  Device-GRE <  Device-nGRE <
>    DevicenGnRE < Device-nGnRnE
>    Normal-WB is weakest,Device-nGnRnE is strongest.
> 
>    refferring to 'Arm Architecture Reference Manual Armv8,
>    for Armv8-A architecture profile' pdf, chapter B2.8
>    refferring to 'ARM System Memory Management Unit Architecture
>    Specification SMMU architecture version 3.0 and version 3.1' pdf,
>    chapter 13.1.5
> 
> 4) therefore, the I/O memory attribute of the VM is setting to
>    DevicenGnRE is a big mistake. it causes all device memory accessing 
> in
>    the virtual machine must be aligned.
> 
>    To summarize: stage2 memory type cannot be stronger than stage1 in
>    arm64 archtechture.

How do you suggest KVM finds out about what the guest wants and
what the device supports?

> 
> Signed-off-by: xieming <xieming@kylinos.cn>
> ---
>  virt/kvm/arm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 11103b75c596..9b7fb13f4546 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1209,7 +1209,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm,
> phys_addr_t guest_ipa,
>  	pfn = __phys_to_pfn(pa);
> 
>  	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
> -		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
> +		pte_t pte = pfn_pte(pfn, PAGE_S2);
> 
>  		if (writable)
>  			pte = kvm_s2pte_mkwrite(pte);

No, this cannot be a blanket change. This means that the
guest will be able to obtain a cacheable mapping on devices,
allow reordering, and other things that are likely to *break*
the system. You also have no business calling this function
outside of KVM.

You are asking us to trust the guest. There is no way this
is acceptable. If the device supports NORMAL_NC, this should
be known by the host kernel and exposed to KVM.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
