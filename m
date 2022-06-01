Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD0539FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351009AbiFAJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351151AbiFAJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97F175FF2F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654074028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47e42rnIYaU6sJqvrI7HnnRd2dfzcghd2QGgfknq5Gw=;
        b=B4GOV2DVy+ciGbiEMpmzQvXARh+SkwiEXKF6Ydh8qPq0k0f7/ecGcFzI7uzS4fEItMxP++
        nF59PnZ2sJsXxDaeUzde4iHE0df2W1Zt9gLMsC9bCdJ3oQ35UkrTZ7ANRx/SQCSML2jtRG
        rkMXdhlcF0zVYqx/1TXhmDljKdxrDH8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-_UUTAGXbNdOvBnu29rQLKA-1; Wed, 01 Jun 2022 05:00:26 -0400
X-MC-Unique: _UUTAGXbNdOvBnu29rQLKA-1
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso616185wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=47e42rnIYaU6sJqvrI7HnnRd2dfzcghd2QGgfknq5Gw=;
        b=me4ojuXstbE6TsAC8eHGstpN7K2aar3IbJRk7n8YkS2mMFTGwBMEvhgGEjfNC70qGY
         L/LkHaiC9rI8whvwy9OiwtDZTbdsgr+9/lxkkJXhmqSgemYyyU8JvMjTSgAnBlZLOG4R
         3oAWCJRuDVWlSZlbW2Jx0cd2YB7aife73djALOIpWPcCM/mY0SaIV61bQKeilqHawO9Z
         vLfrWe1O2yR2HxHJj8OIeIuhAQ/Ky1ilAUfIRuFiWQfDsv+qHDPtzULbPmiiI2ccHdmT
         ahWnCjeOEwGVYPDJjoUJT0cIPKpiyJE7ZJa1z4WhaH1WVaAFPwdaoO7t5HW8cUlyi7eT
         IpIg==
X-Gm-Message-State: AOAM532DUQmgj5W+J1w1sAyU8ukbIVBe0a99Z62CcJy37/+TvGbJfk4i
        +Mk8lS1ucvLxVM6J3kFNziPaJu2z2MeMDF6bts1wCRwjY96f0q9s582nfneomVSZIIeaF/EapSx
        RkQoQrQODuD+pHQsgPygguYUk
X-Received: by 2002:a5d:6d0a:0:b0:20f:ecc9:2819 with SMTP id e10-20020a5d6d0a000000b0020fecc92819mr34366327wrq.666.1654074025593;
        Wed, 01 Jun 2022 02:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJFJMguj1HytJIpfb+YPwV4xImpt7pcmIEp7Y330tAofv7dZyg6rYBGjWbJBVTyfbKbEYsog==
X-Received: by 2002:a5d:6d0a:0:b0:20f:ecc9:2819 with SMTP id e10-20020a5d6d0a000000b0020fecc92819mr34366292wrq.666.1654074025277;
        Wed, 01 Jun 2022 02:00:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id h1-20020a056000000100b0020c5253d8casm992951wrx.22.2022.06.01.02.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:00:24 -0700 (PDT)
Message-ID: <b9a0eb0a-ce27-5306-a12f-79d196445254@redhat.com>
Date:   Wed, 1 Jun 2022 11:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv6 03/15] efi/x86: Get full memory map in allocate_e820()
In-Reply-To: <20220517153444.11195-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.22 17:34, Kirill A. Shutemov wrote:
> Currently allocate_e820() only interested in the size of map and size of
> memory descriptor to determine how many e820 entries the kernel needs.
> 
> UEFI Specification version 2.9 introduces a new memory type --
> unaccepted memory. To track unaccepted memory kernel needs to allocate
> a bitmap. The size of the bitmap is dependent on the maximum physical
> address present in the system. A full memory map is required to find
> the maximum address.
> 
> Modify allocate_e820() to get a full memory map.

Usually we use max_pfn, if we want to know the maximum pfn that's
present in the system (well, IIRC, excluding hotunplug).

How exactly will this (different?) maximum from UEFI for the bitmap
interact with

max_pfn = e820__end_of_ram_pfn();

from e820 in existing code

?

-- 
Thanks,

David / dhildenb

