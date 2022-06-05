Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47953DE22
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347062AbiFET6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344478AbiFET6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 15:58:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C449687;
        Sun,  5 Jun 2022 12:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA1ECB80DAE;
        Sun,  5 Jun 2022 19:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F14C385A5;
        Sun,  5 Jun 2022 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654459105;
        bh=66jU7St7J/rQkWEC+xtYa4b2N3D8EzKe3flOReZVLn8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BC1wbJ2wvSSXy/eC676d4HdHWx8nmKxbPExDrb/vQHSVp5GJTaUAxDCb8lovxEAP4
         vU/JiuaF6m6cBrqgFMdmwR0c7XIjsMrG/xHYLa5GEoZ3FddCusZpuKfv/xPo7aMvc1
         IZ5LmWcU5+dAy+iQFeDzVLP7heYTnBy4vOPNcErbj5X0SVS5lKT4hM3N7PNATvbVDX
         aXUN1q0r7d7wVNgpQ+QtOKCdhKOiDp3MBCWfoByYjQ0RN7LVjgYhyVYLcDUoISgyCi
         Pgf/ikulSSl95wy7PNnvyyvIvA8CStcsjOg2dkgo8gQf8wDA5mcuwcao87jfx/5YxQ
         sJAkZb5FRBJCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3B5FC5C0514; Sun,  5 Jun 2022 12:58:25 -0700 (PDT)
Date:   Sun, 5 Jun 2022 12:58:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH] ia64: fix sparse warnings with cmpxchg() & xchg()
Message-ID: <20220605195825.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87h7547k8c.fsf@toke.dk>
 <20220605160738.79736-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220605160738.79736-1-luc.vanoostenryck@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 06:07:38PM +0200, Luc Van Oostenryck wrote:
> On IA64, new sparse's warnings where issued after fixing
> some __rcu annotations in kernel/bpf/.
> 
> These new warnings are false positives and appear on IA64 because
> on this architecture, the macros for cmpxchg() and xchg() make
> casts that ignore sparse annotations.
> 
> This patch contains the minimal patch to fix this issue:
> adding a missing cast and some missing '__force'.
> 
> Link: https://lore.kernel.org/r/20220601120013.bq5a3ynbkc3hngm5@mail
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Looks good to me!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> Note: This patch is only compile tested on defconfig. The corresponding
>       binary is unchanged (except some .rodata with the kernel version)
>       as it should be.
> 
>  arch/ia64/include/uapi/asm/cmpxchg.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
> index 2c2f3cfeaa77..ca2e02685343 100644
> --- a/arch/ia64/include/uapi/asm/cmpxchg.h
> +++ b/arch/ia64/include/uapi/asm/cmpxchg.h
> @@ -33,24 +33,24 @@ extern void ia64_xchg_called_with_bad_pointer(void);
>  									\
>  	switch (size) {							\
>  	case 1:								\
> -		__xchg_result = ia64_xchg1((__u8 *)ptr, x);		\
> +		__xchg_result = ia64_xchg1((__u8 __force *)ptr, x);	\
>  		break;							\
>  									\
>  	case 2:								\
> -		__xchg_result = ia64_xchg2((__u16 *)ptr, x);		\
> +		__xchg_result = ia64_xchg2((__u16 __force *)ptr, x);	\
>  		break;							\
>  									\
>  	case 4:								\
> -		__xchg_result = ia64_xchg4((__u32 *)ptr, x);		\
> +		__xchg_result = ia64_xchg4((__u32 __force *)ptr, x);	\
>  		break;							\
>  									\
>  	case 8:								\
> -		__xchg_result = ia64_xchg8((__u64 *)ptr, x);		\
> +		__xchg_result = ia64_xchg8((__u64 __force *)ptr, x);	\
>  		break;							\
>  	default:							\
>  		ia64_xchg_called_with_bad_pointer();			\
>  	}								\
> -	__xchg_result;							\
> +	(__typeof__ (*(ptr)) __force) __xchg_result;			\
>  })
>  
>  #ifndef __KERNEL__
> @@ -76,42 +76,42 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
>  									\
>  	switch (size) {							\
>  	case 1:								\
> -		_o_ = (__u8) (long) (old);				\
> +		_o_ = (__u8) (long __force) (old);			\
>  		break;							\
>  	case 2:								\
> -		_o_ = (__u16) (long) (old);				\
> +		_o_ = (__u16) (long __force) (old);			\
>  		break;							\
>  	case 4:								\
> -		_o_ = (__u32) (long) (old);				\
> +		_o_ = (__u32) (long __force) (old);			\
>  		break;							\
>  	case 8:								\
> -		_o_ = (__u64) (long) (old);				\
> +		_o_ = (__u64) (long __force) (old);			\
>  		break;							\
>  	default:							\
>  		break;							\
>  	}								\
>  	switch (size) {							\
>  	case 1:								\
> -		_r_ = ia64_cmpxchg1_##sem((__u8 *) ptr, new, _o_);	\
> +		_r_ = ia64_cmpxchg1_##sem((__u8 __force *) ptr, new, _o_);	\
>  		break;							\
>  									\
>  	case 2:								\
> -		_r_ = ia64_cmpxchg2_##sem((__u16 *) ptr, new, _o_);	\
> +		_r_ = ia64_cmpxchg2_##sem((__u16 __force *) ptr, new, _o_);	\
>  		break;							\
>  									\
>  	case 4:								\
> -		_r_ = ia64_cmpxchg4_##sem((__u32 *) ptr, new, _o_);	\
> +		_r_ = ia64_cmpxchg4_##sem((__u32 __force *) ptr, new, _o_);	\
>  		break;							\
>  									\
>  	case 8:								\
> -		_r_ = ia64_cmpxchg8_##sem((__u64 *) ptr, new, _o_);	\
> +		_r_ = ia64_cmpxchg8_##sem((__u64 __force *) ptr, new, _o_);	\
>  		break;							\
>  									\
>  	default:							\
>  		_r_ = ia64_cmpxchg_called_with_bad_pointer();		\
>  		break;							\
>  	}								\
> -	(__typeof__(old)) _r_;						\
> +	(__typeof__(old) __force) _r_;					\
>  })
>  
>  #define cmpxchg_acq(ptr, o, n)	\
> -- 
> 2.36.1
> 
