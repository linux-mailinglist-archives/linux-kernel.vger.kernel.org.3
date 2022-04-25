Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8650DA47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiDYHlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiDYHlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85DF212ACE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650872295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D4+EWp9YScvG0/opJ/baqbMoZiCpKGj3I6/h6CC0ZAI=;
        b=QwKT+GN3wCRoZHpAz4fJNodwCQig0Qb2WES9Q4dCrL925MYg2vp/N/8OV0ZRa9Ag1caUX2
        jSTRS8pQ70o+n69OVK8mDNQRWFbo/dQXatqcbgGOeGnKcVD7qzpcAlNjzTSXB3I4bRVtU3
        6QzGHKzAto2+NpNUfEgMqIHvCVi8P18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-sWGJKalkPl6wkzxmadEVYg-1; Mon, 25 Apr 2022 03:38:14 -0400
X-MC-Unique: sWGJKalkPl6wkzxmadEVYg-1
Received: by mail-wm1-f70.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso6406788wma.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=D4+EWp9YScvG0/opJ/baqbMoZiCpKGj3I6/h6CC0ZAI=;
        b=Qm6d1+rt3hqBMXKbfI4X28kqlg0mP6/9+7APWoIcMKYXqQ/lyiMT/CLq6jJPS8dJ9M
         zIMSOorxwCwSgYLw0uCk8DuUYBYQk0XODGXy9GQEUGcJ/o0Kpg4uWzhoKFkqgyVkTMct
         hdDhTi04jnwMPMaSn0x99f6FPvO3UksK57FkvNtb3WRBUyIODC6MsjXq9aMY1RbYTwdC
         f6XLW1yUYUPBgor8sICCjUCZlqTZv3+NMPdrYCTPREd9yPrjUVFZXa48zpcK5mJ+/Tme
         MLC2D79JzVsGOUC6WfygfBU26anUaS/3FMvUrLPY14DFkTr9WPY4r3TA20F8rq0w2Vcu
         Tj9g==
X-Gm-Message-State: AOAM531/ZtdWOXkftLjD6m4OauAkuhtgHm5dB7HWV1ea9ct5PMxnlSOd
        EzfktyxJltyGwfqdz07PmTmNH0pr9vCieRVMS0/21NyLm2TMCHxiNgvjWPYpcNfYl0zyoJXlgtc
        iEp3ln5M6HJ8tGNSUuU5E1hOS
X-Received: by 2002:a05:600c:1c90:b0:393:e5b9:b567 with SMTP id k16-20020a05600c1c9000b00393e5b9b567mr8792579wms.27.1650872292386;
        Mon, 25 Apr 2022 00:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGrMqdIG1qplpHlWo0bNbUMWHaIb+N0Tidl5Idj4Oc/xX/CaDQW7fkXG1PkG7Hd/M5o1cGWw==
X-Received: by 2002:a05:600c:1c90:b0:393:e5b9:b567 with SMTP id k16-20020a05600c1c9000b00393e5b9b567mr8792555wms.27.1650872292152;
        Mon, 25 Apr 2022 00:38:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id y6-20020a056000168600b0020a96d2cf8fsm9498136wrd.60.2022.04.25.00.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:38:09 -0700 (PDT)
Message-ID: <f8ee624f-d1f0-342e-227b-8ffa9d133ba1@redhat.com>
Date:   Mon, 25 Apr 2022 09:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCHv5 01/12] x86/boot/: Centralize __pa()/__va() definitions
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-2-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220425033934.68551-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 05:39, Kirill A. Shutemov wrote:
> Replace multiple __pa()/__va() definitions with a single one in misc.h.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

