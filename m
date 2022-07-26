Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533C58154B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiGZObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiGZObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E58F02
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658845862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gr7dw0e3vkHCOc9kW8UEU5CieYdDfZtmZu7Qeg3pxlU=;
        b=BBk8rmoJn5aEZXHyBZfx5S5d6hocf2+rg0Hg2wUwF/XLZv46NiOjkPW1Xo6nCMEPhhdw3E
        6aAkvtz4Bmrb2q4lux2dMJiqP8Aal6TFxJ7hXZRl5DJxPKYB2ayBZrJlvrPwCrgP7RXwUH
        oHfKn6GkKB5KbBe0uYeoSuH6f4lEsa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-Ha49n7cHNvCfpecrolDu8Q-1; Tue, 26 Jul 2022 10:30:59 -0400
X-MC-Unique: Ha49n7cHNvCfpecrolDu8Q-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adfa34d000000b0021e3c8834a3so2182124wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gr7dw0e3vkHCOc9kW8UEU5CieYdDfZtmZu7Qeg3pxlU=;
        b=uLjuSk6NYQ7IqszjNiWeWh6nDGOwJgAzHA+I+OSsQ/izlR9+N4nMiF8acG9NCYA6ZG
         Ad1wnnu564aq5MWmFAEdK3f6NvV9UkJyMMSKH2eBy5u/GpuoAMgg1vbn5Sym8G5Xql+9
         OXKF7q8XAhgCqrhM/bESXTi+RKOxEX9M2YHCQ98pWfIPIfzc/4FrcQw1SFNXEQzMSmXE
         CJvFlOC4R6sV7cxMVSNoXh3PvmcK2zIW4exkMjtcYYq4G+8bZE8TyFDKEF9MYL6pY4oN
         y9jrUujdQRYPBLhMr3B3ASrTVcUWiNBBV+sjKwtwNpim4banEQ9k6Oc4jINOnYFkrTVw
         UMDQ==
X-Gm-Message-State: AJIora9j25tPOoJfx/9lC1oPLd2rVbBp9WoqN/pd1KUMUzHzs8S9NzTw
        eF8xtGyhi4c32lRkYOGNF+rMMkmbywEBjKYVVGPMk/pmWa35lRS7IAemowG8MNbjYyjBnbbaRhm
        Ej37ms497jLb3eiUfxmWxbblu
X-Received: by 2002:a7b:c3cc:0:b0:3a3:8ec:d69 with SMTP id t12-20020a7bc3cc000000b003a308ec0d69mr25694585wmj.78.1658845857805;
        Tue, 26 Jul 2022 07:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8k0/X43EXk3DBk+CZ8uyrXpNOynm2gCY+Qrl/OkI5JufZYaMneweAdNpBJGa8v5GHTMBxdg==
X-Received: by 2002:a7b:c3cc:0:b0:3a3:8ec:d69 with SMTP id t12-20020a7bc3cc000000b003a308ec0d69mr25694552wmj.78.1658845857423;
        Tue, 26 Jul 2022 07:30:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:fe00:8ba4:5871:abc3:8a75? (p200300cbc708fe008ba45871abc38a75.dip0.t-ipconnect.de. [2003:cb:c708:fe00:8ba4:5871:abc3:8a75])
        by smtp.gmail.com with ESMTPSA id v11-20020adfe4cb000000b0021e6b62fde2sm10429441wrm.59.2022.07.26.07.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 07:30:57 -0700 (PDT)
Message-ID: <fb58de71-a255-364b-5d32-1c839ed4a5c2@redhat.com>
Date:   Tue, 26 Jul 2022 16:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 <Yt6LOD9Ae2NqyG1N@zn.tnic> <7d664831-a78c-4a4f-5bd6-f0e04463ca7c@redhat.com>
 <Yt6SL8+nr1ESSZDh@zn.tnic>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yt6SL8+nr1ESSZDh@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.22 14:53, Borislav Petkov wrote:
> On Mon, Jul 25, 2022 at 02:38:57PM +0200, David Hildenbrand wrote:
>> The less core-MM code to handle unaccepted memory the better. Meaning,
>> that any kind of additional pre-acceptance (in addition to what we have
>> here) needs good justification.
> 
> I actually mean to have a user interface to have the core code
> pre-accept. I.e., interface to what will be already there anyway.
>

Ah, got it. The "issue" with ordinary prefaulting in user space is that
you'll also end up zeroing the memory. But yeah, it should just accept a
bunch of memory.

> Or is that frowned upon too?

I was assuming you'd want some additional interface that only accept
memory without actually temporarily allocating it.

-- 
Thanks,

David / dhildenb

