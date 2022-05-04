Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF651B3CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382549AbiEDXs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380850AbiEDXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:32:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6841B4EA0A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651706919; x=1683242919;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZqynadAVI1dGSdWdqZWxVEgZ7tBU2Zi6LJqgmjvgqE=;
  b=d2lZxym9Rq/7DKC+R2+9RKdBVAkH20aluqupsh8nu7tf527UM2wihvrP
   P65c11vRE5p4ONOWPYmlNQfsq5v53mqWDK4HcZuIKaDdqmI+cPs2RH4Rn
   4pW5TTOcZdId5QhuEfZSTCj0v2FjJTgXj3WCWN0x41FYvj4FkNQg6IxVq
   H/0KiTX67cDs7GAG1dpuEoYatyDV3mxYbZILC6fsrd+G8lmCjTz2p8CKa
   JsT0OSwlYyO7qJ/lmBfpTI5HMT6nFEt02IcHt2famfQ2kuxC0YOU4N2kt
   h/e3/FWXEJiE7yrks30b6FfVwqtm80XzVnIQYuPXdilZ0Y7OB6Q5LIz4D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265523372"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="265523372"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:28:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="599758006"
Received: from karendt-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.3.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 16:28:34 -0700
Message-ID: <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 May 2022 11:28:32 +1200
In-Reply-To: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 15:49 -0700, Sathyanarayanan Kuppuswamy wrote:
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -15,6 +15,7 @@
>   #include <asm/idtentry.h>
>   #include <asm/irq_regs.h>
>   #include <asm/desc.h>
> +#include <asm/io.h>
> 
>   /* TDX module Call Leaf IDs */
>   #define TDX_GET_INFO                   1
> @@ -680,8 +681,15 @@ static bool try_accept_one(phys_addr_t *start, 
> unsigned long len,
>    */
>   static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, 
> bool enc)
>   {
> -       phys_addr_t start = __pa(vaddr);
> -       phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +       phys_addr_t start;
> +       phys_addr_t end;
> +
> +       if (is_vmalloc_addr((void *)vaddr))
> +               start =  page_to_phys(vmalloc_to_page((void*)vaddr));
> +       else
> +               start = __pa(vaddr);
> +
> +       end = start + numpages * PAGE_SIZE;
> 
>          if (!enc) {
>                  /* Set the shared (decrypted) bits: */

Looks set_memory_decrypted() only works for direct-mapping, so you should not
use this.  Instead, you can pass shared bit in 'prot' argument (using
pgprot_decrypted()) when you call vmap(), and explicitly call MapGPA().

-- 
Thanks,
-Kai


