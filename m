Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7D46DA5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbhLHRyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:54:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58688 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhLHRyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:54:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 428CDB82212
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BB0C00446;
        Wed,  8 Dec 2021 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638985857;
        bh=xb90MP/qB6HOV2i1jXMu36XCMenmbWiRSkd39nIEmlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ud+CpWXkWyC0eQlPUzIkm8PiPlvtU5DesoGGVTezeiqznlT7eoggyRWIMxEuzAU+Q
         WZg2msTa2KghO/JnLvHJgxWeVkg4ao5NE4J8uBcJFuFFc0SySIaiCiKlfWGY0BJ5GI
         EqxD2xsgkVornOHroFGXZ/eiVoDoSM24hdYnWgB4cBSEJBFSTL2lblJEsMKXsWqTUl
         PBmHBMLWJe9AjEyrSiebEHAWncWHVFnT1HjDN1th/moeOf3OLITKzjyo9iLgkKUWTd
         lHo4pxlbXW1li6ogPTjyK/QIyO4rrQo62fC0nx81kh6WHqnWQkOnx/0LFcz2lg6Thm
         SwG7IKVUEjghA==
Date:   Wed, 8 Dec 2021 17:50:51 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 6/6] KVM: arm64: pkvm: Make kvm_host_owns_hyp_mappings()
 robust to VHE
Message-ID: <20211208175050.GF820@willie-the-truck>
References: <20211208152300.2478542-1-qperret@google.com>
 <20211208152300.2478542-7-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208152300.2478542-7-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:22:59PM +0000, Quentin Perret wrote:
> The kvm_host_owns_hyp_mappings() function should return true if and only
> if the host kernel is responsible for creating the hypervisor stage-1
> mappings. That is only possible in standard non-VHE mode, or during boot
> in protected nVHE mode. But either way, non of this makes sense in VHE,

Typo: non => none

> so make sure to catch this case as well, hence making the function
> return sensible values in any context (VHE or not).
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 605c104eb030..ea840fa223b5 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -239,6 +239,9 @@ void free_hyp_pgds(void)
>  
>  static bool kvm_host_owns_hyp_mappings(void)
>  {
> +	if (is_kernel_in_hyp_mode())
> +		return false;

Acked-by: Will Deacon <will@kernel.org>

Will
