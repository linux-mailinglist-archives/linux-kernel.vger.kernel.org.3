Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219C654F32D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380059AbiFQIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380387AbiFQIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:38:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750F69295
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E657B827CC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D8C3411B;
        Fri, 17 Jun 2022 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655455104;
        bh=/+PA0s6iDokI32NSUKyXUB8BkzRNE2/BPEMG8iwbzJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzhXz8zt15gWuroBUz4xp7oQIAyE2Zg7k0+EuLpVXGyzcayS5RLRo4utGjS2qT7Dy
         vZVNLx9AI4uoL3jm1N+xkt6pzKuDQ4n37PcWbOpIMDgcjt8g9IGect8wXJ2r1uk6gN
         ZcMijsDAlGeFKXDRQwAyc+uQj2mQk+qOKHFWpzHdERbvHu55fL2JxvFQQCcjB6ZsgN
         r42QoQ2bPbWgQlVapm7YHnn7gc79lQ/r1sr8/D2jAHFJXCHAdazY+kHfzMqXRxGqKb
         z6zabU/HjuYTH08Un3rRyqRTKm5VzO57zZpaxBeDlUbKH6UQE6z6FD2evVHpL1DdOB
         EHylArov6qpuA==
Date:   Fri, 17 Jun 2022 11:38:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Quentin Perret <qperret@google.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
Message-ID: <Yqw9dou3qgpAKQkZ@kernel.org>
References: <20220616161135.3997786-1-qperret@google.com>
 <165545408679.771055.5076080259874437048.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165545408679.771055.5076080259874437048.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:21:31AM +0100, Marc Zyngier wrote:
> On Thu, 16 Jun 2022 16:11:34 +0000, Quentin Perret wrote:
> > Commit a7259df76702 ("memblock: make memblock_find_in_range method
> > private") changed the API using which memory is reserved for the pKVM
> > hypervisor. However, it seems that memblock_phys_alloc() differs
> > from the original API in terms of kmemleak semantics -- the old one
> > excluded the reserved regions from kmemleak scans when the new one
> > doesn't seem to. Unfortunately, when protected KVM is enabled, all
> > kernel accesses to pKVM-private memory result in a fatal exception,
> > which can now happen because of kmemleak scans:
> > 
> > [...]
> 
> Applied to fixes, thanks!
> 
> [1/1] KVM: arm64: Prevent kmemleak from accessing pKVM memory
>       commit: 9e5afa8a537f742bccc2cd91bc0bef4b6483ee98

I'd really like to update the changelog to this:

Commit a7259df76702 ("memblock: make memblock_find_in_range method
private") changed the API using which memory is reserved for the pKVM
hypervisor. However, memblock_phys_alloc() differs from the original API in
terms of kmemleak semantics -- the old one didn't report the reserved
regions to kmemleak while the new one does. Unfortunately, when protected
KVM is enabled, all kernel accesses to pKVM-private memory result in a
fatal exception, which can now happen because of kmemleak scans:

$ echo scan > /sys/kernel/debug/kmemleak
[   34.991354] kvm [304]: nVHE hyp BUG at: [<ffff800008fa3750>] __kvm_nvhe_handle_host_mem_abort+0x270/0x290!
...

Fix this by explicitly excluding the hypervisor's memory pool from
kmemleak like we already do for the hyp BSS.


> Cheers,
> 
> 	M.
> -- 
> Marc Zyngier <maz@kernel.org>
> 

-- 
Sincerely yours,
Mike.
