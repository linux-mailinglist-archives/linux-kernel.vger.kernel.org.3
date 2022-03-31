Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00104ED537
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiCaIKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCaIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:10:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BC5AA40
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vgFxkctDb1FZErJ2oJenfEMHhTzev2yqQ09Rt4ERQxU=; b=aA4LJOR8MTxejC1TyR1HcWxmCa
        LrhuCQFnUh3CRSyXPPFc9f6ZtThp5vHGoFFQGp/sx7CyB+dumpA5dxIw+B3PiKIMaatgk5cCuwvQ6
        mUC5KWnfjW8aur8tMRherLxfeLbJtWKewxILva23uF2c+k1pj2LmUm5uiAAJdD3ZTddjxsAuKftLV
        TgKSUw2+FUZDQzxhKvYfa7ACP1wiLggzmgkZ3eKjsTPVsI92uuLH5r6RyHx3Q7dByp1jmRzlmAXOd
        +IN04P6J3op3CoQs06cFKJq96zv5ZBr2GAC8guy03Msr3brJA4tbZvpHskAQR4nMPZkZDYCWoPQ1I
        1bYJ3H8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZpqp-0022BW-Rs; Thu, 31 Mar 2022 08:08:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7200098695C; Thu, 31 Mar 2022 10:08:14 +0200 (CEST)
Date:   Thu, 31 Mar 2022 10:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1] objtool: Use target file endianness instead of a
 compiled constant
Message-ID: <20220331080814.GQ8939@worktop.programming.kicks-ass.net>
References: <7c503552c4bc1f0e1aa4775765f8f24e9d1b0a04.1648713067.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c503552c4bc1f0e1aa4775765f8f24e9d1b0a04.1648713067.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:52:07AM +0200, Christophe Leroy wrote:
> Some architectures like powerpc support both endianness, it's
> therefore not possible to fix the endianness via arch/endianness.h
> because there is no easy way to get the target endianness at
> build time.
> 
> Use the endianness recorded in the file objtool is working on.
> 

> +#include <objtool/elf.h>
>  
>  /*
> - * Does a byte swap if target endianness doesn't match the host, i.e. cross
> + * Does a byte swap if target file endianness doesn't match the host, i.e. cross
>   * compilation for little endian on big endian and vice versa.
>   * To be used for multi-byte values conversion, which are read from / about
>   * to be written to a target native endianness ELF file.
>   */
> -#define bswap_if_needed(val)						\
> +static inline bool need_bswap(GElf_Ehdr *ehdr)
> +{
> +	return (__BYTE_ORDER == __LITTLE_ENDIAN) ^
> +	       (ehdr->e_ident[EI_DATA] == ELFDATA2LSB);
> +}
> +
> +#define bswap_if_needed(ehdr, val)					\
>  ({									\
>  	__typeof__(val) __ret;						\
> +	bool __need_bswap = need_bswap(ehdr);				\
>  	switch (sizeof(val)) {						\
> -	case 8: __ret = __NEED_BSWAP ? bswap_64(val) : (val); break;	\
> -	case 4: __ret = __NEED_BSWAP ? bswap_32(val) : (val); break;	\
> -	case 2: __ret = __NEED_BSWAP ? bswap_16(val) : (val); break;	\
> +	case 8: __ret = __need_bswap ? bswap_64(val) : (val); break;	\
> +	case 4: __ret = __need_bswap ? bswap_32(val) : (val); break;	\
> +	case 2: __ret = __need_bswap ? bswap_16(val) : (val); break;	\
>  	default:							\
>  		BUILD_BUG(); break;					\
>  	}								\

Far less painfull that I imagined it would be,.. but I think I prefer
passing in elf, as opposed to elf->ehdr, would that work?
