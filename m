Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86E4FF5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiDMLfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiDMLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 754374FC4E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649849546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cw+3SgfZDxAhFDomQUYr7roHFhrC3wRHLqsz1pX4r4U=;
        b=IPlPJjYB6XU6FXCZeDcghWMQu5DbqPJNaF6Rj/UgPFzEHcEUWbiiODxJEv4g7qYMlUzbvs
        jqi+wtolUBErKHVHKF2XwsxAC+ozfGpxBOfqCl7Qdo//NW3ltfwb3Y7l3D3XWot7yKCYzN
        xPwWtvn0pm4P0HWS86PPMZxMgi4z8TQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-k192w3ENM2mBwpcUzoVCWg-1; Wed, 13 Apr 2022 07:32:24 -0400
X-MC-Unique: k192w3ENM2mBwpcUzoVCWg-1
Received: by mail-wm1-f69.google.com with SMTP id az27-20020a05600c601b00b0038ff021c8a4so78582wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cw+3SgfZDxAhFDomQUYr7roHFhrC3wRHLqsz1pX4r4U=;
        b=VScoQrvyCKBiTp192X+Jh2czVs1Qt0XLiVCqaWjZHuPKP/3Uu3k3S9fIbB9gg0HwY/
         iu4j1MRf6qBlfo8DPjUYiNvJ2gcxsW7CnRU5QNaqo6NMP47HCZXv0c5TPTXejPtIFHt3
         Wg7UhixmUHinTVnywBIrVlJE93o0SwvbGvdypMK/eP2kbZIyTxmKFjm2trXYJuZRf0hB
         eMzVN6/n/oBHJ+VjVbMfp7jzf4EfS6hyA5nIT7C8Ft7HhlHCvDPeCd31WwJbLLgWnT1X
         197KiWCsH4gR8HUuQKJzEilrJAQUoGXbwszGlF3jzWfZaDYN0e0KDbzyi/OoRBMOYgd+
         nT5Q==
X-Gm-Message-State: AOAM531/0V3rmnNQUzBg46DgLeo9W3oLImZibvfTvSjHJGYjV4AphQ/i
        63IK8qe+WX3WAyq4D2057sz8X2i/1p+bnMuRigqiq3yd+ViNsyYDsJyXhDdz2s1U3csn/9efHBv
        284DWvUqG7wyfzntrRx8qlEP3
X-Received: by 2002:adf:dd10:0:b0:207:a8ce:c152 with SMTP id a16-20020adfdd10000000b00207a8cec152mr9888740wrm.714.1649849543412;
        Wed, 13 Apr 2022 04:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpw+J1XKXzR0hCFUlh7TDtDEB5sanD73+NCToQFB1rqBDGGXxpw/7OeMjq4vgU34cwcTjz7Q==
X-Received: by 2002:adf:dd10:0:b0:207:a8ce:c152 with SMTP id a16-20020adfdd10000000b00207a8cec152mr9888690wrm.714.1649849543000;
        Wed, 13 Apr 2022 04:32:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm2554558wmp.14.2022.04.13.04.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:32:22 -0700 (PDT)
Message-ID: <f79814f4-1597-41b0-27e7-af4a6459c179@redhat.com>
Date:   Wed, 13 Apr 2022 13:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
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
 <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
 <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 13:30, Kirill A. Shutemov wrote:
> On Wed, Apr 13, 2022 at 12:36:11PM +0200, David Hildenbrand wrote:
>> On 12.04.22 18:08, Dave Hansen wrote:
>>> On 4/12/22 01:15, David Hildenbrand wrote:
>>>> Can we simply automate this using a kthread or smth like that, which
>>>> just traverses the free page lists and accepts pages (similar, but
>>>> different to free page reporting)?
>>>
>>> That's definitely doable.
>>>
>>> The downside is that this will force premature consumption of physical
>>> memory resources that the guest may never use.  That's a particular
>>> problem on TDX systems since there is no way for a VMM to reclaim guest
>>> memory short of killing the guest.
>>
>> IIRC, the hypervisor will usually effectively populate all guest RAM
>> either way right now.
> 
> No, it is not usual. By default QEMU/KVM uses anonymous mapping and
> fault-in memory on demand.
> 
> Yes, there's an option to pre-populate guest memory, but it is not the
> default.

Let me be clearer: I'm talking about the TDX/SEV world, not ordinary
unencrypted VMs. For ordinary encrypted VMs we do have populate on
demand frequently.

For SEV we currently pin all guest memory and consequently don't have
populate on demand. For TDX, again, I did not follow how fd-based
private guest memory will behave. I thought I remembered that we will
similarly not have populate-on-demand.

Preallocation is usually used with huge pages, but I guess that's out of
scope right now for encrypted VMs.


-- 
Thanks,

David / dhildenb

