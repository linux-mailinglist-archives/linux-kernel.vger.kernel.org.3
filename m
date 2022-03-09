Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD54D2EFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiCIMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiCIMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:21:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1D317584B;
        Wed,  9 Mar 2022 04:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFC03B8213D;
        Wed,  9 Mar 2022 12:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBD6C340E8;
        Wed,  9 Mar 2022 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646828424;
        bh=RaV6K88b3L+HXsuscECSUuHuH+07EtXgyzZft0gRdcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoREBFOUl14/i+Qq2IVSd9fjFkfETF6Sg34FaN5hBlxaLwgP2vPL6yKjLMEj8m5fI
         tpfuEu0LfOhinnCcz1cwVyiCjB+EAS74dTpu9zvm1dIaEsonqHzUaTswDLdoA8s+vP
         l2y1Nh+N9j5GySqkWrWPJCOSewK9s0gRKmHsmRJpu6Uo0fC78vNxdpiZPO3U9o6yEN
         Z2xvzdY61aF9egf64Ve0ObbjG/k8a8E4CAAnV5eWXbG7mvQQIqYJUvzjRhXGQoPV+q
         S4IBqoxKjyCcgfVVPmCam9iaO7PmYPTcU/7r5PuIziHDce7fViqdecfV0tg24IVhTd
         d9crahvyQ3dng==
Date:   Wed, 9 Mar 2022 12:20:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20220309122019.GD397@willie-the-truck>
References: <20220309094235.146df5bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309094235.146df5bd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:42:35AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm64 tree got a conflict in:
> 
>   arch/arm64/kernel/cpufeature.c
> 
> between commit:
> 
>   228a26b91228 ("arm64: Use the clearbhb instruction in mitigations")
> 
> from Linus' tree and commit:
> 
>   def8c222f054 ("arm64: Add support of PAuth QARMA3 architected algorithm")
> 
> from the arm64 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm64/kernel/cpufeature.c
> index d33687673f6b,32aa0eb3ed68..000000000000
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@@ -231,7 -226,10 +231,11 @@@ static const struct arm64_ftr_bits ftr_
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
>  +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_CLEARBHB_SHIFT, 4, 0),
> + 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
> + 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_APA3_SHIFT, 4, 0),
> + 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
> + 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_GPA3_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_RPRES_SHIFT, 4, 0),
>   	ARM64_FTR_END,
>   };

This (and https://lore.kernel.org/r/20220309093832.01585172@canb.auug.org.au)
are due to the surprise spectre mitigations which landed yesterday. Now
that's all public, I'll merge those changes into our for-next/core branch
and these conflicts should all disappear.

Thanks,

Will
