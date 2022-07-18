Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64134577EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiGRJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiGRJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:50:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B19817E1C;
        Mon, 18 Jul 2022 02:50:42 -0700 (PDT)
Received: from zn.tnic (p200300ea972976d7329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76d7:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA5EE1EC0502;
        Mon, 18 Jul 2022 11:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658137836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6DTNQWLWEiUavjwO5kJULSizhPzyAq+tui1+RbSI3to=;
        b=Qmed7QwQmwlZAx3wTCKTdlbnmYeSkWHZHxr1h6oGAYLv9gtqXlnVtxOSXZyFCX181p8hmd
        Ew+uewl/NT15cquSaq3S9k+run5XXoZzItGd8C/nDFjgnRmDCeg+dAwiWuPPFULPZAWjit
        wqywj86pi9Bfjh2GilMP+bMFyqJhSGM=
Date:   Mon, 18 Jul 2022 11:50:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/urgent] x86/sgx: Set active memcg prior to shmem
 allocation
Message-ID: <YtUs3MKLzFg+rqEV@zn.tnic>
References: <20220520174248.4918-1-kristen@linux.intel.com>
 <165419442842.4207.2566961916839377924.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165419442842.4207.2566961916839377924.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just what I think looks like a discrepancy I noticed while merging
tip/master:

On Thu, Jun 02, 2022 at 06:27:08PM -0000, tip-bot2 for Kristen Carlson Accardi wrote:
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index d44e737..332ef35 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -103,10 +103,13 @@ static inline int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
>  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  		     unsigned long end, unsigned long vm_flags);
>  
> +bool current_is_ksgxd(void);
>  void sgx_encl_release(struct kref *ref);
>  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
> -int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
> -			 struct sgx_backing *backing);
> +int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
> +			    struct sgx_backing *backing);
> +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
> +			   struct sgx_backing *backing);
>  void sgx_encl_put_backing(struct sgx_backing *backing);

So this is making the sgx_encl_get_backing() thing static but its
counterpart sgx_encl_put_backing() is not and is still called by other
places.

Perhaps something wrong with the layering or is this on purpose?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
