Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4CF46DA58
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhLHRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhLHRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:52:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5DFC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4B61B82211
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF2EC00446;
        Wed,  8 Dec 2021 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638985752;
        bh=eSGWmUYDabFMwKqG3Chvgj52S+6K8S0+wchgsln66Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVmbuBVeHGA+t64aKKCQOwctestVgv+cfhL7/r35fiX8zZB3uJURgeSJ7dHVxN2Gk
         aDzKJ/pmK12DTEPigcRtOzASHbVbl/6ENj+4/EPq+4KZ0oz4DgNiEYHAxAxUpsJhD7
         o51f+yGvq8oPCbCgtfwoS0tMm2EFXSOT59VWXNT/Egzvtor5jg89SNSgMNezUUWxKg
         H6Dgf/MNSrEXbo7szXz7gyIW8OkSLT7P2NXyMCOwc0gypZDsAdkRrheMVScy3G/nGO
         2O9YmzKL+wHhQSTU3Whi2kgOlzMR3hiawKJbt+Tn6VZHy3X43CIsmlT+xICA2uU0WS
         nohonXYIn9Pjw==
Date:   Wed, 8 Dec 2021 17:49:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5/6] KVM: arm64: pkvm: Stub io map functions
Message-ID: <20211208174906.GE820@willie-the-truck>
References: <20211208152300.2478542-1-qperret@google.com>
 <20211208152300.2478542-6-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208152300.2478542-6-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:22:58PM +0000, Quentin Perret wrote:
> Now that GICv2 is disabled in nVHE protected mode there should be no
> other reason for the host to use create_hyp_io_mappings() or
> kvm_phys_addr_ioremap(). Add sanity checks to make sure that assumption
> remains true looking forward.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/mmu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 326cdfec74a1..605c104eb030 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -407,6 +407,9 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
>  	unsigned long addr;
>  	int ret;
>  
> +	if (is_protected_kvm_enabled())
> +		return -EPERM;

Looks like the vGIC is the only caller, so no need to worry about anybody
relying on *kaddr being zeroed on failure.

Acked-by: Will Deacon <will@kernel.org>

Will
