Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4DC525C67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377826AbiEMHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377824AbiEMHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:37:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3649F11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:37:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE2E11F45F;
        Fri, 13 May 2022 07:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652427419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKInJY+z1MdEACvSvKMPA2hgKgaGT9z3htD+GfUf0Oo=;
        b=fPI77AxPsrNnCVDAkkAKVd0QiBEuNhi+b0iOmR7+64VvJV6mNMPbVb7kjPCPo0UkXi1yxT
        IFw0EFCJveuVn1LczcX9U9uupEZ86vONwi6gKZLVzFpE3Aw2XpIdeGkJ2gRtu8uU1npf8Y
        +KD/VA/p3U+hf/VXgBF1225jtI+KLII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652427419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKInJY+z1MdEACvSvKMPA2hgKgaGT9z3htD+GfUf0Oo=;
        b=vTi2324TaszPtIm1ajwe6hJq0Ri9Z3B4faCIjj9vF63MrPTmRxtZr0/38/SL4hsUeWjxst
        1x/6sF9nohTbfMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C019D13A84;
        Fri, 13 May 2022 07:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KtujLpsKfmIsRwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 13 May 2022 07:36:59 +0000
MIME-Version: 1.0
Date:   Fri, 13 May 2022 09:36:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Adrian-Ken Rueegsegger <ken@codelabs.ch>
Cc:     dave.hansen@linux.intel.com, david@redhat.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix marking of unused sub-pmd ranges
In-Reply-To: <20220509090637.24152-2-ken@codelabs.ch>
References: <20220509090637.24152-1-ken@codelabs.ch>
 <20220509090637.24152-2-ken@codelabs.ch>
User-Agent: Roundcube Webmail
Message-ID: <396545e80737225ca37c85224d578c1f@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-09 11:06, Adrian-Ken Rueegsegger wrote:
> The unused part precedes the new range spanned by the start, end
> parameters of vmemmap_use_new_sub_pmd. This means it actually goes from
> ALIGN_DOWN(start, PMD_SIZE) up to start. Use the correct address when
> applying the mark using memset.
> 
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>

Yes, this was clearly an oversight from my side.
Thanks for fixing it!

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/x86/mm/init_64.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 96d34ebb20a9..e2942335d143 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -902,6 +902,8 @@ static void __meminit vmemmap_use_sub_pmd(unsigned
> long start, unsigned long end
> 
>  static void __meminit vmemmap_use_new_sub_pmd(unsigned long start,
> unsigned long end)
>  {
> +	const unsigned long page = ALIGN_DOWN(start, PMD_SIZE);
> +
>  	vmemmap_flush_unused_pmd();
> 
>  	/*
> @@ -914,8 +916,7 @@ static void __meminit
> vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
>  	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
>  	 */
>  	if (!IS_ALIGNED(start, PMD_SIZE))
> -		memset((void *)start, PAGE_UNUSED,
> -			start - ALIGN_DOWN(start, PMD_SIZE));
> +		memset((void *)page, PAGE_UNUSED, start - page);
> 
>  	/*
>  	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap 
> of

-- 
Oscar Salvador
SUSE Labs
