Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8545346E664
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhLIKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhLIKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:14:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6F7C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:11:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 16E56CE2529
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656E9C004DD;
        Thu,  9 Dec 2021 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639044660;
        bh=RYhR2iP19QRA3Oma18FQhK2Re2fOq8fTvX1MIpeSMg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q0Lej2zGbp/4EwFGqRP+78kf2BC/Sm+ciMQgKeWUbFMnDtjpHrwIYQbZzzAqslzHY
         YJnSAYBaOAs5nj87BVV0sfc54c3u4kIJ8qV/LDS9x05irsm+RAie8Y2fPftfqXNMzt
         fdBHFxIzTm8A0gk7sjYOP0O0lTF5nf/yIfM/L8UrL5eEHdpUaKrqFKjA3cmM/gCzMJ
         TJ44niU8x6MyUA25i2UOy19P1uVMR2rVCOW/cAnvns6VmDQoqJ6HGLKDcjzUj/R38V
         MeBz0JaUo1U0DmuIKX+T7pK/DSBpgfJ32VZqohyGu56ZqsAa4foZZfm9+KslY71IuR
         rnOmwwuCvhKDg==
Date:   Thu, 9 Dec 2021 10:10:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 01/15] KVM: arm64: Check if running in VHE from
 kvm_host_owns_hyp_mappings()
Message-ID: <20211209101053.GA1833@willie-the-truck>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201170411.1561936-2-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:03:55PM +0000, Quentin Perret wrote:
> The kvm_host_owns_hyp_mappings() function should return true if and only
> if the host kernel is responsible for creating the hypervisor stage-1
> mappings. That is only possible in standard non-VHE mode, or during boot
> in protected nVHE mode. But either way, non of this makes sense in VHE,
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
> index 326cdfec74a1..f8f1096a297f 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -239,6 +239,9 @@ void free_hyp_pgds(void)
>  
>  static bool kvm_host_owns_hyp_mappings(void)
>  {
> +	if (is_kernel_in_hyp_mode())
> +		return false;

This looks identical to:

https://lore.kernel.org/r/20211208152300.2478542-7-qperret@google.com

Will
