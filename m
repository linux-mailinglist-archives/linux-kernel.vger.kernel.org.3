Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA584F9D70
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiDHTG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiDHTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7544FF8EC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649444661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sI+CKaqjeLSRPAY+LGQfv54eFjnOUGa/yEw/6x76vKY=;
        b=b0U6WOeo0aU0PDAPIuGmyGLW7kFX6CvC4Rc5Bgv+0xBs9UFa9z/G3if/0FNGTOV/JzR53K
        Ngo1oDpwOuQLrMp4np+bJu28LkNtKSrltYDCRE9LG7wQjp+8FEEYHjU+SQarn9Vq0c9kk5
        IeDascBapYORfN3SwIRx56PFy4owsT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-hO6NJAVCNauBALBdnmK_uQ-1; Fri, 08 Apr 2022 15:04:20 -0400
X-MC-Unique: hO6NJAVCNauBALBdnmK_uQ-1
Received: by mail-wm1-f71.google.com with SMTP id h18-20020a05600c351200b0038e82e6321bso2594991wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 12:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=sI+CKaqjeLSRPAY+LGQfv54eFjnOUGa/yEw/6x76vKY=;
        b=iODYTu0Lo+EsAWs2x3DMpmX5Ct6nBBA+2l24xNoPTjOsnH3EfGzDJ40bveeEuFRyXf
         d4vXcVz4YbgCOsnDTsSoIcaUIVfoSL6JT5eqDdZCZzX8NJlAjpaNPMmSLB4oiZaTXa7L
         wGJZCwcGIAM7XDzQnQa1esKhtC2FunE1dUA8tsAVUHNqxHKc8bf3bh+W6a9dSEo6O08v
         7eNYlbGtBkwtClde8bZMd41FO6jMCIkT+JPLcK0l4Ys0V8vN8okfy+P7t9D+QvWdpXEo
         lSM14d4k9dCJO+OHWTxNNqLWTou2UfQj08Z3QqjTaHvHdEH8S1m5qP93OlaxtYH6OlCO
         9Cpw==
X-Gm-Message-State: AOAM532vDoxEj1H+zk6hEQtt6O3zoBfwjv8p1IJdhffBC3dDjNrY/K9h
        CeVLr/Kyx5aY+pHV6lPgKrqSzAQJqWniZOAuaQwc+ilQB6QDwynktYiL1YuJKXgSwZrxwB9EEdb
        C/I5OV/+F5kHoz/5NdXvP6tag
X-Received: by 2002:adf:9f03:0:b0:207:9071:1766 with SMTP id l3-20020adf9f03000000b0020790711766mr4743653wrf.331.1649444659313;
        Fri, 08 Apr 2022 12:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwyaFoxo2wRi67tJhuDxDonRbQNSmnOVJ6SXAc1V3MXq6++aK0JF36Ux0bYx5kIK0LPTcQEw==
X-Received: by 2002:adf:9f03:0:b0:207:9071:1766 with SMTP id l3-20020adf9f03000000b0020790711766mr4743612wrf.331.1649444658934;
        Fri, 08 Apr 2022 12:04:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:fd00:612:f12b:a4a2:26b0? (p200300cbc704fd000612f12ba4a226b0.dip0.t-ipconnect.de. [2003:cb:c704:fd00:612:f12b:a4a2:26b0])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm14481015wmj.18.2022.04.08.12.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 12:04:18 -0700 (PDT)
Message-ID: <0cbee9cc-f89a-81f2-f24a-784b0fd33bab@redhat.com>
Date:   Fri, 8 Apr 2022 21:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
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
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.22 01:43, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific for the Virtual Machine
> platform.
> 
> Accepting memory is costly and it makes VMM allocate memory for the
> accepted guest physical address range. It's better to postpone memory
> acceptance until memory is needed. It lowers boot time and reduces
> memory overhead.
> 
> Support of such memory requires a few changes in core-mm code:
> 
>   - memblock has to accept memory on allocation;
> 
>   - page allocator has to accept memory on the first allocation of the
>     page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages on the first allocation.
> PageUnaccepted() is used to indicate that the page requires acceptance.
> 
> Kernel only needs to accept memory once after boot, so during the boot
> and warm up phase there will be a lot of memory acceptance. After things
> are settled down the only price of the feature if couple of checks for
> PageUnaccepted() in allocate and free paths. The check refers a hot
> variable (that also encodes PageBuddy()), so it is cheap and not visible
> on profiles.
> 
> Architecture has to provide two helpers if it wants to support
> unaccepted memory:
> 
>  - accept_memory() makes a range of physical addresses accepted.
> 
>  - memory_is_unaccepted() checks anything within the range of physical
>    addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock

Thanks, I skimmed over most parts and nothing obvious jumped at me. Dave
has some good suggestions; I'll try giving it a thorough in the near future.


-- 
Thanks,

David / dhildenb

