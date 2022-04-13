Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127E94FFADC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiDMQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiDMQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B85B366216
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649865836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qaes6GsZIWmYMSJxhYz4nyZc0I8zaCDHxt97W/Tu4Ck=;
        b=A/GacZqnUW3k+f27LJSZjQUNtZx6yGncVwBu97k7Nxie/Eu1AEpFACEpxM5LZBjKM53SUw
        05ZiM5sNC3VDJmrxw+OmLXGe1dWkPpx+bNqVJIfPkYm1DnN53RzE8Im2r6aYt3l1TzIVwh
        9ACeaEKq1Jgn+s0w+/s5OzLs3TlyvPc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-IAaEfzPiMTmFnWYVul6tsw-1; Wed, 13 Apr 2022 12:03:55 -0400
X-MC-Unique: IAaEfzPiMTmFnWYVul6tsw-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso1062952wma.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qaes6GsZIWmYMSJxhYz4nyZc0I8zaCDHxt97W/Tu4Ck=;
        b=mCJeI429W62pa41QhVBM1CnbmeVTWWdI/k6OROXdxHc6+k4eIEQypUhM3R1i7ihQ8d
         WZONrJRvkGnouV8nCRjirWrx9s/6B0KChqgRwwxtnmhHMODSYy+sEVE5nw9mg+1h5Rvv
         HmvD8lFEbz4Ubcbxp+p4rbg5WurYQgMi/uF4MyoQZSoQx9tiLvcZ+Ep1dTvar/Kcll82
         M8WUbHzVrCsErFgpPVFDpaEp7Q/6+IiudS4mUbde6+nkwT9aIG+LXJGpfBWX8S7DK4/N
         xRPaDPIUQs8xCx/2DMmwJoFeZ0GMoSJLeQbLfFiSnoc9PLIvflYGCyTp/nMPrDBkJVhz
         PnAA==
X-Gm-Message-State: AOAM531i6wllaum3nGrslB3nE0BbZZ4inhSN0PPr/uQtxUXPmXguJFg7
        aGFO91QdvtBALYY6jgVBuqf2GNf6zleUIW0vsFAGnU6Hz6B24t9c0jI8OWRqz0zSXaEjwt7jNj+
        yGGQz+YxSQhfULXwpQWrKvpNA
X-Received: by 2002:a5d:684b:0:b0:207:b978:1a51 with SMTP id o11-20020a5d684b000000b00207b9781a51mr2135109wrw.189.1649865833670;
        Wed, 13 Apr 2022 09:03:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr8eDe+uZec98zyFAbHiVBo/INth+bOteQZ2k4WxUL0QZvCYOhQblO8Y9OngstuW8Kb5UMbg==
X-Received: by 2002:a5d:684b:0:b0:207:b978:1a51 with SMTP id o11-20020a5d684b000000b00207b9781a51mr2135076wrw.189.1649865833408;
        Wed, 13 Apr 2022 09:03:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id n1-20020a5d5981000000b00207a0853460sm11755147wri.14.2022.04.13.09.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:03:52 -0700 (PDT)
Message-ID: <e549d4c4-ca56-da1d-cc50-1a73621ba487@redhat.com>
Date:   Wed, 13 Apr 2022 18:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH V3 2/4] KVM: X86: Introduce role.glevel for level
 expanded pagetable
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-3-jiangshanlai@gmail.com> <YlXvtMqWpyM9Bjox@google.com>
 <caffa434-5644-ee73-1636-45a87517bae2@redhat.com>
 <YlbhVov4cvM26FnC@google.com>
 <d2122fb0-7327-0490-9077-c69bbfba4830@redhat.com>
 <YlbtEorfabzkRucF@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YlbtEorfabzkRucF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 17:32, Sean Christopherson wrote:
>>> Are we planning on removing direct?
>>
>> I think so, it's redundant and the code almost always checks
>> direct||passthrough (which would be passthrough_delta > 0 with your scheme).
> 
> I'm ok dropping direct and rolling it into target_level, just so long as we add
> helpers, e.g. IIUC they would be
> 
> static inline bool is_sp_direct(...)
> {
> 	return !sp->role.target_level;
> }
> 
> static inline bool is_sp_direct_or_passthrough(...)
> {
> 	return sp->role.target_level != sp->role.level;
> }

Yes of course.  Or respectively:

	return sp->role.passthrough_levels == s->role.level;

	return sp->role.passthrough_levels > 0;

I'm not sure about a more concise name for the latter.  Maybe 
sp_has_gpt(...) but I haven't thought it through very much.

>>> Hmm, it's not a raw level though.
>>
>> Hence the plural. :)
> 
> LOL, I honestly thought that was a typo.  Making it plural sounds like it's passing
> through to multiple levels.

I meant it as number of levels being passed through.  I'll leave that to 
Jiangshan, either target_level or passthrough_levels will do for me.

Paolo

