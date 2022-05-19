Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFAE52D782
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbiESP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbiESP1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:27:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F86EC3D4;
        Thu, 19 May 2022 08:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 817F5CE2508;
        Thu, 19 May 2022 15:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DC7C385AA;
        Thu, 19 May 2022 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652974048;
        bh=fWzT1RDzL+g/G2pbgJJD/u9obC3MZhKB4yK9conyL8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KhPlyqr5DQ+2cxzW0xu4vYkoXbmxOHVwbib+1FOdSi4DyM1fdNRJKpkCXmhKC8/sw
         jNg5Ewr2ACxNFq6z9vUY4tGKAxaJ6wujFNx5o7sLHygM2LxCMvsb+AXZ+kJbtwHbrm
         TcVxENBVaAuttLzbvtbAahxCC7LXKKuezdvoJFBMa9CL6AZPR13x9yJAJs3w9JdE2M
         gILeHgLB+1/mYxOpjc9gAt4SIVhmBzql+/b7dKEEToGvpMwDfrRpEtcjpy6FnzQ5iP
         1yGgwc3aZNTv1BV6VUHo14UYj1DGJ41lfxRRnI3gGhcTloxiboRbNY0M0VvQwEOy+f
         tiNlDxh+Nzn/g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nri3i-00CSzu-B2; Thu, 19 May 2022 16:27:26 +0100
MIME-Version: 1.0
Date:   Thu, 19 May 2022 16:27:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, axboe@kernel.dk, rafael@kernel.org,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org, len.brown@intel.com, pavel@ucw.cz,
        paulmck@kernel.org, bp@suse.de, keescook@chromium.org,
        songmuchun@bytedance.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, pasha.tatashin@soleen.com,
        tabba@google.com, ardb@kernel.org, tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 1/6] arm64: hibernate: Introduce new entry point to kernel
In-Reply-To: <1652860121-24092-2-git-send-email-quic_vivekuma@quicinc.com>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-2-git-send-email-quic_vivekuma@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1d517a7598f7833196ec0c8258816aba@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_vivekuma@quicinc.com, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, axboe@kernel.dk, rafael@kernel.org, akpm@linux-foundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com, pavel@ucw.cz, paulmck@kernel.org, bp@suse.de, keescook@chromium.org, songmuchun@bytedance.com, rdunlap@infradead.org, damien.lemoal@opensource.wdc.com, pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org, tsoni@quicinc.com, quic_psodagud@quicinc.com, quic_svaddagi@quicinc.com, quic_kprasan@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-18 08:48, Vivek Kumar wrote:
> Introduce a new entry point to hibernated kernel image.
> This is generally needed when bootloader restores the
> hibernated image from disc to ddr and passes control
> to it by turning off the mmu, also initialize this new
> entry point with cpu_resume which turns on the mmu and
> then proceeds with restore routines.
> 
> Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
> Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
> ---
>  arch/arm64/kernel/hibernate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hibernate.c 
> b/arch/arm64/kernel/hibernate.c
> index 6328308..4e294b3 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -74,6 +74,14 @@ static struct arch_hibernate_hdr {
>  	void		(*reenter_kernel)(void);
> 
>  	/*
> +	 * Another entry point if jump to kernel happens with mmu disabled,
> +	 * generally done when restoring hibernation image from bootloader
> +	 * context
> +	 */
> +
> +	phys_addr_t	phys_reenter_kernel;
> +
> +	/*
>  	 * We need to know where the __hyp_stub_vectors are after restore to
>  	 * re-configure el2.
>  	 */
> @@ -116,6 +124,7 @@ int arch_hibernation_header_save(void *addr,
> unsigned int max_size)
>  	arch_hdr_invariants(&hdr->invariants);
>  	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
>  	hdr->reenter_kernel	= _cpu_resume;
> +	hdr->phys_reenter_kernel  = __pa(cpu_resume);
> 
>  	/* We can't use __hyp_get_vectors() because kvm may still be loaded 
> */
>  	if (el2_reset_needed())

So here, you are creating a new ABI with the bootloader, based on
a data structure that isn't mean't to be ABI. It means that we
wouldn't be allowed to ever change this data structure, as this
would mean having to update the bootloader in sync.

Clearly, this isn't acceptable.

         M.
-- 
Jazz is not dead. It just smells funny...
