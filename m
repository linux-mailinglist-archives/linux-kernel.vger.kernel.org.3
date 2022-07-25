Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D200C57FF17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiGYMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiGYMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36AA5BC98
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658752742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WHFuKmZPQedoN55ZoH0FtL+rcxDT0vItFUzM4he2I8=;
        b=XdVuorXcX3UyPmS6Mpnf0VZc2RmgGmB9OIc+vj3gqOyDQJlLHIT1DLzffEtVFoDl3+ekKe
        PPUKhHKPrSxYttXJ2lVB2tBlCENlOjxtf8bG+EnEpINAtqXuZCVJFYi7Bwi8DKHOkbAaav
        aBRaNvU2qjsThva9Zx+16hz2AFPjeYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-NdnxX3kONx6504fm3bNVgw-1; Mon, 25 Jul 2022 08:39:00 -0400
X-MC-Unique: NdnxX3kONx6504fm3bNVgw-1
Received: by mail-wm1-f70.google.com with SMTP id n30-20020a05600c501e00b003a3264465ebso5821606wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3WHFuKmZPQedoN55ZoH0FtL+rcxDT0vItFUzM4he2I8=;
        b=tn7o24noEcpo/dtAP6JE+bpqPGGTu5cmQEDPys0X3jIUpGlSuEyVeDnXF8p8SyIyPD
         zFm0imwTXUc4qa4ChazkbvFJz2rdEZ6CbB4C6qr10rRKSj64Sp8UpckctAzs65BUNLSL
         AAEfCvCy3rjlPeagk2fubnBqxZeoI1dPo8xLgJ5hQLt9YjD7CSZ3YXUlvbUY/bE7iW0o
         4OuN46qmpEBXi3cCrDyS3NE63Nt2/9hCk2hWtefWD+O7mVsbWSOrDWnLtSevzn0pfhJA
         QXK/zF6u2sUrDNp7VXeY96qLZb7OwdQfAPfDkMH/7gZccixoawEkpZ7L9DAVkAREPnMF
         j8vQ==
X-Gm-Message-State: AJIora9hQAqFGM8E13EyderiRJ2IvATaJptwJsWYJEAsN9C8OUbwLEfb
        7xXOXnSuM0nIDAFQsM5c8y4Re0NC/fAKE7VUtAJ/mAikq1G781GDi7kWEJ6eVjk6GpyLVHtdc8Q
        QTHyaIfwtzes3RmSJJSruCWQD
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr7365133wmq.140.1658752739747;
        Mon, 25 Jul 2022 05:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTnXfTssXHtYtWUqP9z+lS8oior8tLmN08lGBELo1Up+/gD5Avnva+lrhKtPOFyww/a8mGKA==
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr7365095wmq.140.1658752739261;
        Mon, 25 Jul 2022 05:38:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:8c00:eee4:63f0:cef2:5ac0? (p200300cbc7048c00eee463f0cef25ac0.dip0.t-ipconnect.de. [2003:cb:c704:8c00:eee4:63f0:cef2:5ac0])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm11691804wrv.94.2022.07.25.05.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 05:38:58 -0700 (PDT)
Message-ID: <7d664831-a78c-4a4f-5bd6-f0e04463ca7c@redhat.com>
Date:   Mon, 25 Jul 2022 14:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <YtltYRuL+2uQkYUK@zn.tnic> <ebcf2979-45fc-8d41-cc28-ac8da0d24245@intel.com>
 <Ytr4FCV2xPGUBLqs@zn.tnic> <707ca113-c2a2-8fe2-a22c-5be13adc7bb4@intel.com>
 <Yt6LOD9Ae2NqyG1N@zn.tnic>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yt6LOD9Ae2NqyG1N@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.22 14:23, Borislav Petkov wrote:
> On Fri, Jul 22, 2022 at 12:30:36PM -0700, Dave Hansen wrote:
>> Sure does...  *Something* has to manage the cache coherency so that old
>> physical aliases of the converted memory don't write back and clobber
>> new data.  But, maybe the hardware is doing that now.
> 
> Let's hope.
> 
>> Yeah, that two-tier system is the way it's happening today from what
>> I understand. This whole conversation is about how to handle the >4GB
>> memory.
> 
> Would it be possible to pre-accept a bunch of mem - think "pre-fault" -
> from userspace?
> 
> I.e., I'm thinking some huge process is going to start in the VM, VM
> userspace goes and causes a chunk of memory to be pre-accepted and then
> the process starts and runs more-or-less smoothly as the majority of its
> memory has already been "prepared".
> 
> Or does that not make any sense from mm perspective?
> 

The less core-MM code to handle unaccepted memory the better. Meaning,
that any kind of additional pre-acceptance (in addition to what we have
here) needs good justification.

-- 
Thanks,

David / dhildenb

