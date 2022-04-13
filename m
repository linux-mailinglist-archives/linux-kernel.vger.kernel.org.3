Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1A4FF4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiDMKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiDMKjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2155AED4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649846184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gww3nqiIUaE/hiebhaeJWaOYoxyisvc31A4eZ4yYvpw=;
        b=D/o6iWCCiHFf36TMJwtVhccAYOv7/j7sLqzw/l2StI6Aj3SIHsVfN+b2qh+z/7ak1sImlK
        FD5RYSsoHFsL9ZeBRvRUwSQdODyhhXMAnDmj1Eat0gvFLLxC6TsDc2IcTilWQrpHzfrkmw
        UN8yWA+jyI8E39fvA57e/3XjZSeRdEY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Mb6edyh7NmCGrclbQbZv7A-1; Wed, 13 Apr 2022 06:36:15 -0400
X-MC-Unique: Mb6edyh7NmCGrclbQbZv7A-1
Received: by mail-wr1-f70.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so249468wri.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Gww3nqiIUaE/hiebhaeJWaOYoxyisvc31A4eZ4yYvpw=;
        b=QH7mHLK5H8F2NiarMqroowFxHGfUtMsZBFi5c4FUnEMsvAEbIuM+VdZo5ectqnKM5w
         HxN2e8E11X7fdkhGRf4O6dyfqCDRMxYc0/3a+kfp+oBaweVYVPPLIHSQPMAcQPP1OogV
         flok9FeXM94VPbINtdj7yH6uaUQ0Oz8YehciAXV9aoX8+NR7rbAMJydwKSDFWHIR22Na
         bMN+P50fBcCBn3Ru66mqCfJH0qiGUCWjFLhYl7w42/x5M911Fxh9UtvF06ghimmEx2hJ
         0A/AAzHbyhWVYQXYKwh1HR7GIaSCm+AQvONKGPTVCuS2FEAdP2tspEs8zbsVv24xFanl
         Qvww==
X-Gm-Message-State: AOAM533Ej+lX3NgJkNs0qIo706gcBG0VCOh2ras628RvqLCNznwqbXYZ
        /uH+0nJO9NW0bZNfGChxrqGt0zIVm4jMljLjGciE5MIyXEHa1rDb68YSF4Wb9snZKI+bi1jK04G
        jOV+19nLectzy8Ogczc9Rh/Dz
X-Received: by 2002:a5d:47c3:0:b0:204:5b8:225c with SMTP id o3-20020a5d47c3000000b0020405b8225cmr31433834wrc.474.1649846174386;
        Wed, 13 Apr 2022 03:36:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQSMzkkc8N52AEUPOHLS9vbDtk6f23iQd0OLo4NpbTx/HV7xfp7bReFl1jssMbbsElB6nYvQ==
X-Received: by 2002:a5d:47c3:0:b0:204:5b8:225c with SMTP id o3-20020a5d47c3000000b0020405b8225cmr31433796wrc.474.1649846174092;
        Wed, 13 Apr 2022 03:36:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm2255442wmq.42.2022.04.13.03.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:36:13 -0700 (PDT)
Message-ID: <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
Date:   Wed, 13 Apr 2022 12:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.22 18:08, Dave Hansen wrote:
> On 4/12/22 01:15, David Hildenbrand wrote:
>> Can we simply automate this using a kthread or smth like that, which
>> just traverses the free page lists and accepts pages (similar, but
>> different to free page reporting)?
> 
> That's definitely doable.
> 
> The downside is that this will force premature consumption of physical
> memory resources that the guest may never use.  That's a particular
> problem on TDX systems since there is no way for a VMM to reclaim guest
> memory short of killing the guest.

IIRC, the hypervisor will usually effectively populate all guest RAM
either way right now. So yes, for hypervisors that might optimize for
that, that statement would be true. But I lost track how helpful it
would be in the near future e.g., with the fd-based private guest memory
-- maybe they already optimize for delayed acceptance of memory, turning
it into delayed population.

> 
> In other words, I can see a good argument either way:
> 1. The kernel should accept everything to avoid the perf nastiness
> 2. The kernel should accept only what it needs in order to reduce memory
>    use
> 
> I'm kinda partial to #1 though, if I had to pick only one.
> 
> The other option might be to tie this all to DEFERRED_STRUCT_PAGE_INIT.
>  Have the rule that everything that gets a 'struct page' must be
> accepted.  If you want to do delayed acceptance, you do it via
> DEFERRED_STRUCT_PAGE_INIT.

That could also be an option, yes. At least being able to chose would be
good. But IIRC, DEFERRED_STRUCT_PAGE_INIT will still make the system get
stuck during boot and wait until everything was accepted.

I see the following variants:

1) Slow boot; after boot, all memory is already accepted.
2) Fast boot; after boot, all memory will slowly but steadily get
   accepted in the background. After a while, all memory is accepted and
   can be signaled to user space.
3) Fast boot; after boot, memory gets accepted on demand. This is what
   we have in this series.

I somehow don't quite like 3), but with deferred population in the
hypervisor, it might just make sense.

-- 
Thanks,

David / dhildenb

