Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A14F50A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842845AbiDFBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443911AbiDEPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 344C414DFDA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649167333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJYEigw7gcZXWEyFZUr/9QDtSTka9JkbzhfWwkRGDd4=;
        b=icU7AB6YYKUnvftN2X8qG4stY5ePjwlHLdPkODSV/UPwWm0DOkeaPxIUp1HmTmylXjt3rX
        81tY0owgw4gM/oVB/C9N6Ym0krpDvyyDi2tr0h2SODjGZcFiDMmVSEZQ6wCs1sSRK6Ct+g
        2+RJsYGWuuGlIjhp/6IxsTR/Rgs9Cgs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-XspWuqyBNMSuMfuyvcVjLg-1; Tue, 05 Apr 2022 10:02:12 -0400
X-MC-Unique: XspWuqyBNMSuMfuyvcVjLg-1
Received: by mail-wr1-f69.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so2494439wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nJYEigw7gcZXWEyFZUr/9QDtSTka9JkbzhfWwkRGDd4=;
        b=3feWaPW86kUCi7p0B7iKhQs19aJg+asqCntOO/NehW+vlptH9EBZbsLlkWB1cZUY3a
         uVcyMnoSUTeH0j28jw+csLdyGjX61Lr2JSpz9Eg3lt+5XsOmWQ7LGCS0hd6PvJ43gM4Q
         Wv9mnjH9CYxdQYQhxg2bOG4ro4EcgP2WAsmFlntCTRCSXisIaxFK+ttFY2OUr4wv8Ak9
         bTzPNMlMwCDCmW4jMRCxW68Wc2ZBWfdLkTCxOT9+hlcELlGqEhBrex8eFjozAnICo0He
         /p8MGt1KT2iGvPV0e/7P8PDgLmw6Q/5ZUULaGW3YBtUAiUbNIVKV5U4cRFasEZPYmkHQ
         J3zQ==
X-Gm-Message-State: AOAM533W1zl0VoUe5LzlHrt/6hQi3dmvML2b9yzOLdGCKx+nFSxtDcZl
        R9Cg0ldK5wcmdEG6otIPjzMy7/7z7J4fZjUWbnh9IxhawPoBPYipLAz4DfN33/ZofhB1kbWGIrS
        LMeBUOm+ATvmcfPtpX5R1QsFn
X-Received: by 2002:a05:600c:4e8a:b0:380:e340:bfba with SMTP id f10-20020a05600c4e8a00b00380e340bfbamr3263452wmq.80.1649167330585;
        Tue, 05 Apr 2022 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrHlRseRHCErT1uO73tFAno9TovB88a0z4HJ3eP+jBDO4+00dj5Ln+r/duaMsX+o8AkGwlEg==
X-Received: by 2002:a05:600c:4e8a:b0:380:e340:bfba with SMTP id f10-20020a05600c4e8a00b00380e340bfbamr3263429wmq.80.1649167330381;
        Tue, 05 Apr 2022 07:02:10 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm5011314wra.96.2022.04.05.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 07:02:09 -0700 (PDT)
Message-ID: <0d18e8aa-93ac-ea3e-37ee-d104d681459d@redhat.com>
Date:   Tue, 5 Apr 2022 16:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 033/104] KVM: x86: Add infrastructure for stolen
 GPA bits
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Kai Huang <kai.huang@intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <a21c1f9065cf27db54820b2b504db4e507835584.1646422845.git.isaku.yamahata@intel.com>
 <2b8038c17b85658a054191b362840240bd66e46b.camel@intel.com>
 <20220401023426.GF2084469@ls.amr.corp.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220401023426.GF2084469@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 04:34, Isaku Yamahata wrote:
> Sure, this patch heavily changed from the original patch Now.  One suggestion
> is that private/shared is characteristic to kvm page fault, not gpa/gfn.
> It's TDX specific.
> 
> - Add a helper function to check if KVM MMU is TD or VM. Right now
>    kvm_gfn_stolen_mask() is used.  Probably kvm_mmu_has_private_bit().
>    (any better name?)

I think use of kvm_gfn_stolen_mask() should be minimized anyway.  I 
would rename it to to kvm_{gfn,gpa}_private_mask and not return bool.

> - Let's keep address conversion functions: address => unalias/shared/private

unalias is the same as private.  It doesn't seem to have a lot of uses. 
  I would just inline "x & ~gfn_private_mask", or "x & 
~kvm_gfn_private_mask(kvm)"; or the same with gpa of course.

The shared and private conversion functions should remain.

> - Add struct kvm_page_fault.is_private
>    see how kvm_is_private_{gpa, gfn}() can be removed (or reduced).

Agreed.

Paolo

