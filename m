Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B24EC5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiC3NqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbiC3Np2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:45:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C53DDD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=li398NQ0ro5FSjBdELH8D/v/bm7lQVHIEtETV3UhhK8=; b=nbeEYO7dZlLM/ihABCDLnUxqH/
        DmE9Y2n/JpC0+a/XJ2F3hU54zvyitDAkqJJvyJnKDJnF2PJt1vM1XkfOHyTRN9uqUqLsNdjsF+MWf
        +a91ceGDitfnkYPa4Q0/PIX80xhzWcB3/amfFn+pV0ZPCBVaH+irFPPkDm3uoSe5u3mfChOaovJch
        17IMy9Smnp/aJECKokmnvUtFreVPe/zCCfvcWOfDke5pcX5p5MNYafJgvBARoTXeEMxQwk8Dtfmyr
        eG50t/U51Z7k9QWUxyLNzPrmveLbg02yZV7nnOFICj+LvzvWZssbJ9AmveFBNuWo06Afp2m5Vpf6o
        IudlrhrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZYbf-006Dpl-Dn; Wed, 30 Mar 2022 13:43:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A75F9866E9; Wed, 30 Mar 2022 15:43:25 +0200 (CEST)
Date:   Wed, 30 Mar 2022 15:43:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Add a third Alderlake CPU model number
Message-ID: <20220330134325.GM8939@worktop.programming.kicks-ass.net>
References: <20220310215652.32025-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310215652.32025-1-tony.luck@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:56:52PM -0800, Tony Luck wrote:
> Existing suffix conventions only cover mobile/desktop/server options.
> But this isn't any of those. Use "_N" as it matches the Intel naming
> convention for this part.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Peter: What do you think about suffix proliferation? I tried to
> get an answer about the target market segment for this CPU, but
> didn't get an answer that is at all useful.

I'm not loving it, but seeing how they keep making these things into
model numbers (instead of using a different differentiator), there's
little we can do about it :-(

>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 048b6d5aff50..2f7b608f3e55 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -107,6 +107,7 @@
>  
>  #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
>  #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
> +#define INTEL_FAM6_ALDERLAKE_N		0xBE

This is missing the /* Gracemont */ comment. That is, according to
Google, Alder Lake N is an E core only SKU. So alternatively, we can
call it: INTEL_FAM6_ATOM_GRACEMONT ....

/me runs like heck :-)

>  #define INTEL_FAM6_RAPTORLAKE		0xB7

That too is missing the comment, but I can't actually find what it
should be on wikichip so I suppose that's still sekrit or something.
