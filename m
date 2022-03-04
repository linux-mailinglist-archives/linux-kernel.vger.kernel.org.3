Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC94CD173
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiCDJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiCDJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:42:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C4198ED4;
        Fri,  4 Mar 2022 01:41:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B2D61631;
        Fri,  4 Mar 2022 09:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25691C340EF;
        Fri,  4 Mar 2022 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386871;
        bh=GsbjS48QOHFFSAp2SabqgOJmfPKt9I0EStElgK6nMQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fomDQF5A9rnh36RT7aw30jgH/cQBXtUenObuO6wtIVvKx8ipvv/08NfrtlsSQ0WHq
         JdlosL+veMPNu43zybuQhG4jQSR/cJI6G8LRQjGoK1boQHEiuobXqTkD1EqvJkqNRF
         W96V/Hoh1QpctVVNY2JTP7JEEhquzhWCtHM09t5zZq5GsC+/SEBjY3vHn2DRph+iFb
         +L6KmCRdONuvJLNclXNAaxpOnqp4/XaC3wUfJLjmAyiJCf4qYsQLHr56d6z8Po++kD
         yxRftv6h0vHELudet6nPFmB8JkrWXOTLbsCH3PBrS3rG7D4O1TmVaCN6z0C+YqZ8K4
         cluba7ELEMySw==
Date:   Fri, 4 Mar 2022 11:40:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2.1 01/30] x86/sgx: Add short descriptions to ENCLS
 wrappers
Message-ID: <YiHejzFlR+p14KHN@iki.fi>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a bug fixed version of v2, and also the requirement
to do obsolete round trip with EMODPE has been optimized away.
I hope that v3 is rolled out quickly because now there is no
comparison point. We can have speculative discussions whether
ioctl or #PF is better but no means to benchmark. Thus, a quick
patch set revision roll out would be such a great thing.

Based on https://lore.kernel.org/linux-sgx/20220304033918.361495-1-jarkko@kernel.org/T/#u

BR, Jarkko

On Fri, Mar 04, 2022 at 11:34:55AM +0200, Jarkko Sakkinen wrote:
> From: Reinette Chatre <reinette.chatre@intel.com>
> 
> The SGX ENCLS instruction uses EAX to specify an SGX function and
> may require additional registers, depending on the SGX function.
> ENCLS invokes the specified privileged SGX function for managing
> and debugging enclaves. Macros are used to wrap the ENCLS
> functionality and several wrappers are used to wrap the macros to
> make the different SGX functions accessible in the code.
> 
> The wrappers of the supported SGX functions are cryptic. Add short
> descriptions of each as a comment.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encls.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index fa04a73daf9c..0e22fa8f77c5 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -136,57 +136,71 @@ static inline bool encls_failed(int ret)
>  	ret;						\
>  	})
>  
> +/* Initialize an EPC page into an SGX Enclave Control Structure (SECS) page. */
>  static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
>  {
>  	return __encls_2(ECREATE, pginfo, secs);
>  }
>  
> +/* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */
>  static inline int __eextend(void *secs, void *addr)
>  {
>  	return __encls_2(EEXTEND, secs, addr);
>  }
>  
> +/*
> + * Associate an EPC page to an enclave either as a REG or TCS page
> + * populated with the provided data.
> + */
>  static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
>  {
>  	return __encls_2(EADD, pginfo, addr);
>  }
>  
> +/* Finalize enclave build, initialize enclave for user code execution. */
>  static inline int __einit(void *sigstruct, void *token, void *secs)
>  {
>  	return __encls_ret_3(EINIT, sigstruct, secs, token);
>  }
>  
> +/* Disassociate EPC page from its enclave and mark it as unused. */
>  static inline int __eremove(void *addr)
>  {
>  	return __encls_ret_1(EREMOVE, addr);
>  }
>  
> +/* Copy data to an EPC page belonging to a debug enclave. */
>  static inline int __edbgwr(void *addr, unsigned long *data)
>  {
>  	return __encls_2(EDGBWR, *data, addr);
>  }
>  
> +/* Copy data from an EPC page belonging to a debug enclave. */
>  static inline int __edbgrd(void *addr, unsigned long *data)
>  {
>  	return __encls_1_1(EDGBRD, *data, addr);
>  }
>  
> +/* Track that software has completed the required TLB address clears. */
>  static inline int __etrack(void *addr)
>  {
>  	return __encls_ret_1(ETRACK, addr);
>  }
>  
> +/* Load, verify, and unblock an EPC page. */
>  static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
>  			 void *va)
>  {
>  	return __encls_ret_3(ELDU, pginfo, addr, va);
>  }
>  
> +/* Make EPC page inaccessible to enclave, ready to be written to memory. */
>  static inline int __eblock(void *addr)
>  {
>  	return __encls_ret_1(EBLOCK, addr);
>  }
>  
> +/* Initialize an EPC page into a Version Array (VA) page. */
>  static inline int __epa(void *addr)
>  {
>  	unsigned long rbx = SGX_PAGE_TYPE_VA;
> @@ -194,6 +208,7 @@ static inline int __epa(void *addr)
>  	return __encls_2(EPA, rbx, addr);
>  }
>  
> +/* Invalidate an EPC page and write it out to main memory. */
>  static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
>  			void *va)
>  {
> -- 
> 2.35.1
> 
