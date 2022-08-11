Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988C58F73D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 07:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiHKFV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 01:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKFVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 01:21:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3489925
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:21:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c24so11387324pgg.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 22:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=AQfR77oXK1qGUTAyOmsgC9Pxbg9bnSvs4vH+7LPgnRU=;
        b=hpcD5o2WmgfzMo4Urq3AfFOOpZH4O4BdKJwDvUjT9UrwiGjofs3Z0KTV2/N5mBZ/4z
         RKvSPN2qP9HzuPiDwVRcttDMcD4vAkrYbdEzqOswRrlbYIqyvCOV66AANeLWrdkfnHKT
         MNc+jjcQhv3d102liuvgGFN1d4LnA2AUPszD4wisLS+/IOHBXjOYCjLY9EWwrx/YfDXz
         z1Pjnn4Gs7NCWMnAyuhC966TtRFL/9zIUFgspNWhZKWmarwxoPyBftbLtOPQeMbeqbQN
         6JdNAWfB0tiaC2Y3ofmz99Za/0G8la4piTN3yepQ4+JZCrZHG2t3stA4Mj6Rt3mBKVMh
         MJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AQfR77oXK1qGUTAyOmsgC9Pxbg9bnSvs4vH+7LPgnRU=;
        b=197lqvSN5ZC/VkGn0tqxYSQoW5CuuTFuFVju06g1enzBiMU2EU2rkdzaQdj+9N6Bnf
         aK929VBm/MxyAcJSOLW1lcmYhr4FAmPzGAdgbUejTVwpE9twp2dOWSEVywnSkDojAnCM
         QtuhCpc4OlhkSjcWMI95SxKVQt7LE3mFYO/dvhysoxQ3syO++FSnia2RuiPE+pVahSO+
         0YyJEPYK/YuV8V44kPuPYwiapubCms7rPCvtNDKg5/aj9HksGQymFWLnw/Vhz/8WTJTX
         /jeXE+29Y9cM/hfi7JFs5IDpxoWRb1QJfQHNAhip69mp2GYWirPymw2XRBxjf+VCF0c9
         uwfQ==
X-Gm-Message-State: ACgBeo0KRoMrY7IQ3Pwvr7Nb/3S/9J5ZzJQgmMs22oKMYq2GlWCtSW88
        B2lO0lh30umCZ7ZnCqoDzhk=
X-Google-Smtp-Source: AA6agR4PYe54Fj+2uMYSK5joaFpmJj6/9lDL4mUdtIq6NHgVtheJqPvjNRvuUke7JnbxYc7xM+wbBw==
X-Received: by 2002:a63:8143:0:b0:41c:fc6f:681b with SMTP id t64-20020a638143000000b0041cfc6f681bmr23029138pgd.249.1660195279557;
        Wed, 10 Aug 2022 22:21:19 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-79-20-36.ap-northeast-1.compute.amazonaws.com. [35.79.20.36])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79891000000b0052d7cca96acsm3043172pfl.110.2022.08.10.22.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 22:21:18 -0700 (PDT)
Date:   Thu, 11 Aug 2022 05:21:14 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] x86/mm/cpa: restore global bit when page is
 present
Message-ID: <YvSRyjDsrbB7v2JT@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <20220808145649.2261258-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808145649.2261258-2-aaron.lu@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:56:46PM +0800, Aaron Lu wrote:
> For configs that don't have PTI enabled or cpus that don't need
> meltdown mitigation, current kernel can lose GLOBAL bit after a page
> goes through a cycle of present -> not present -> present.
> 
> It happened like this(__vunmap() does this in vm_remove_mappings()):
> original page protection: 0x8000000000000163 (NX/G/D/A/RW/P)
> set_memory_np(page, 1):   0x8000000000000062 (NX/D/A/RW) lose G and P
> set_memory_p(pagem 1):    0x8000000000000063 (NX/D/A/RW/P) restored P
> 
> In the end, this page's protection no longer has Global bit set and this
> would create problem for this merge small mapping feature.
> 
> For this reason, restore Global bit for systems that do not have PTI
> enabled if page is present.
> 
> (pgprot_clear_protnone_bits() deserves a better name if this patch is
> acceptible but first, I would like to get some feedback if this is the
> right way to solve this so I didn't bother with the name yet)
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 1abd5438f126..33657a54670a 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -758,6 +758,8 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
>  	 */
>  	if (!(pgprot_val(prot) & _PAGE_PRESENT))
>  		pgprot_val(prot) &= ~_PAGE_GLOBAL;
> +	else
> +		pgprot_val(prot) |= _PAGE_GLOBAL & __default_kernel_pte_mask;
>  
>  	return prot;
>  }

IIUC It makes it unable to set _PAGE_GLOBL when PTI is on.

Maybe it would be less intrusive to make
set_direct_map_default_noflush() replace protection bits
with PAGE_KENREL as it's only called for direct map, and the function
is to reset permission to default:

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1abd5438f126..0dd4433c1382 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2250,7 +2250,16 @@ int set_direct_map_invalid_noflush(struct page *page)

 int set_direct_map_default_noflush(struct page *page)
 {
-       return __set_pages_p(page, 1);
+       unsigned long tempaddr = (unsigned long) page_address(page);
+       struct cpa_data cpa = {
+                       .vaddr = &tempaddr,
+                       .pgd = NULL,
+                       .numpages = 1,
+                       .mask_set = PAGE_KERNEL,
+                       .mask_clr = __pgprot(~0),
+                       .flags = 0};
+
+       return __change_page_attr_set_clr(&cpa, 0);
 }

set_direct_map_{invalid,default}_noflush() is the exact reason
why direct map become split after vmalloc/vfree with special
permissions.

> -- 
> 2.37.1
> 
> 
