Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7954F51915F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243702AbiECWb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiECWby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A02725C5A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651616900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XuOARFW3gYZOmM4Y4nSXFBD8lHm6BchzW975izB6OwE=;
        b=iuBRe20hnQHQVQ0swIUR96GUeNQGJnMv7wv9r87aIyy08tnwLb0gWhiH6ScRw6cLfGiTlX
        ixMtg4sS1gNcl8V6wmaVoEOP4iJO8bbDfjPo0uzq8Z07JuSMTUwbJQadrNcURt/zwFkhYr
        ugc9Zrea8eiWpeImx666Qk9IyOfa3KQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-jzvhMj81N7y9tKQjdCVuKQ-1; Tue, 03 May 2022 16:21:09 -0400
X-MC-Unique: jzvhMj81N7y9tKQjdCVuKQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-e1fa5c533eso6398262fac.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XuOARFW3gYZOmM4Y4nSXFBD8lHm6BchzW975izB6OwE=;
        b=wtdmET3sB2ox6gIQ/lfvZq/Y5mkOQRZH3N+2zdKkkFrrq6js89hUo6iJ3xlLto5zTY
         17/HgCsAAeCS9YPcwEGue5mv56Q5//M5W4uxRlTVOJBW0FkQpHoHV+etgIrp9qJdgMVk
         V5nRz0rwKToxz6UOK95Awa1GDUc0LpReC6MYLcFXYdSjEQ1w9OF0P15nIAFlA38nTOi9
         HCrdeZwJLjfTqhvOoiLdxkdm3pVNZ8Fgc7kMSaPWTz2uYygAyMpsYnowbbvhV/aSvhvn
         zVw8y7T59dtqZ/l4miLFQl2ukBdn7wCr9sYX4IbSuIjc9+zSt3owvt8jn+AyiEYmAIhS
         EL7g==
X-Gm-Message-State: AOAM532FIK2NE1+gnuuPHx/3jTxo3H2+gCLagQ4T89trf25M6C2D7SBr
        z0chpbcL3UYe2bL9+8WJim224zQYXZCfVqQK4GgztHfczIGyouBXEPGHT8XQJBLYskAfMYVf6jX
        vS4iK80cquCcgLa3CCzIoZgsS
X-Received: by 2002:a05:6808:14d3:b0:325:ed6b:e748 with SMTP id f19-20020a05680814d300b00325ed6be748mr2683340oiw.105.1651609267936;
        Tue, 03 May 2022 13:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKRbb5OLkMV2UmDQ1VLpoVhTPJwDt2cIVnFXrIsYyzxEIudxX/SPJKn8BJ62U+FH4qM5Vz5Q==
X-Received: by 2002:a05:6808:14d3:b0:325:ed6b:e748 with SMTP id f19-20020a05680814d300b00325ed6be748mr2683301oiw.105.1651609267392;
        Tue, 03 May 2022 13:21:07 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id w11-20020a4adecb000000b0035eb4e5a6cesm5328939oou.36.2022.05.03.13.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 13:21:06 -0700 (PDT)
Message-ID: <2bb92a84-18f4-d007-9465-fdc19f6f1c86@redhat.com>
Date:   Tue, 3 May 2022 22:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCHv5 02/12] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220425033934.68551-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> +/*
> + * Page acceptance can be very slow. Do not call under critical locks.
> + */
> +static void accept_page(struct page *page, unsigned int order)
> +{
> +	phys_addr_t start = page_to_phys(page);
> +	int i;
> +
> +	accept_memory(start, start + (PAGE_SIZE << order));
> +
> +	for (i = 0; i < (1 << order); i++) {
> +		if (PageUnaccepted(page + i))
> +			__ClearPageUnaccepted(page + i);
> +	}
> +}

What was the rationale of leaving PageUnaccepted() set on sub-pages when
merging pages?

I'd just clear the flag when merging and avoid the loop here. You could
even assert here that we don't have any PageUnaccepted() on tail pages.

-- 
Thanks,

David / dhildenb

