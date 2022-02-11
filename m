Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035584B2417
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348418AbiBKLQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:16:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiBKLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4D8FE5E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644578193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzdZoc1ECG5crN5WeDHv4EcL6o8IY8l6QLLymfvZCEA=;
        b=iJfEhwC+q3fG5P6bJ6iFMGLCWPIavX/N8kjVQiNpBDhARQPsLUSLqGl1lQlzKyiNluodnK
        SKxjPUI/0A7TOvKBGGyIySPAQABIjKtjEifNXy0fNqGInaMSlZVhRqPkOHWWrBTPGejg1n
        nkGXw+85I+i7sDKjMNiHxQ3RevE7Uv0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-XYuIXm-FPJeStyxUCrSdyg-1; Fri, 11 Feb 2022 06:16:32 -0500
X-MC-Unique: XYuIXm-FPJeStyxUCrSdyg-1
Received: by mail-wm1-f70.google.com with SMTP id j39-20020a05600c1c2700b0037becd18addso2378161wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UzdZoc1ECG5crN5WeDHv4EcL6o8IY8l6QLLymfvZCEA=;
        b=54BSLbG8B+W5hdFCCPrDs11D6LMtlKmg2tqb07zEVpIdLKrKGX8bLC4EeRJz9wst04
         rZvezmOU9KiWPK66q6JjMJcLt+KTF7oLt+DoCFgl6PBuc909y1oscOkk7kkHlhjLt/gL
         5x2f9yipLJuwEGJy0GsPl5z+kkrzRLdxeh0PXgPFoll9jS/CRBsPhLvLveAMm9goFkaJ
         hNws0XMtFosxe4ZEsYRO3tVk/suFi4cq29pkTalG3fXjYDIcvnTCtIebU+oqMqcMRxsb
         lPNR6wlpXfGKTOYRtGTgzUfS3rsbAjnD4skoYZdPDEU6pL4ZYcezaHk6Djufyu9JqZ3A
         bjvg==
X-Gm-Message-State: AOAM531jvPNLQYgcWFwwW1Mgv3bxlbcEuflV1I+gcCWZZidrcHDNtnOA
        /Rkkp90hay9qYE3n93+6j2qwogzUJvYHiWBICWpnLx/653isw7cdOuE0ndr73IWR2+UUebCAHnD
        39LMcWfpmgarIlKTG7unuonBJ
X-Received: by 2002:adf:d841:: with SMTP id k1mr986385wrl.29.1644578191130;
        Fri, 11 Feb 2022 03:16:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP54xcz6c2X8mYBTklUkWw6ZWry2xTHUvff39cx18UUukR/DLcnbFDJ5/w2n/uoH1fKqVgdA==
X-Received: by 2002:adf:d841:: with SMTP id k1mr986377wrl.29.1644578190922;
        Fri, 11 Feb 2022 03:16:30 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id 11sm24868572wrb.30.2022.02.11.03.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:16:30 -0800 (PST)
Message-ID: <9c0125cd-bf69-50f6-7fe8-2b8d860bde04@redhat.com>
Date:   Fri, 11 Feb 2022 12:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 03/12] KVM: x86: do not deliver asynchronous page faults
 if CR0.PG=0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-4-pbonzini@redhat.com> <YgWbgfSrzAhd97LG@google.com>
 <YgWcS/0naKPdAn2E@google.com> <YgWcwQYHIFCb2pvH@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YgWcwQYHIFCb2pvH@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 00:16, Sean Christopherson wrote:
> Third time's a charm...
> 
> 	if (kvm_pv_async_pf_enabled(vcpu))
> 		return false;
> 
> 	if (vcpu->arch.apf.send_user_only &&
> 	    static_call(kvm_x86_get_cpl)(vcpu) == 0)
> 		return false;
> 
> 	/* L1 CR0.PG=1 is guaranteed if the vCPU is in guest mode (L2). */
> 	if (is_guest_mode(vcpu))
> 		return !vcpu->arch.apf.delivery_as_pf_vmexit;
> 
> 	return is_paging(vcpu);
> 
> 

Went for this, but with slightly different final "if":

         if (is_guest_mode(vcpu)) {
                 /*
                  * L1 needs to opt into the special #PF vmexits that are
                  * used to deliver async page faults.
                  */
                 return vcpu->arch.apf.delivery_as_pf_vmexit;
         } else {
                 /*
                  * Play it safe in case the guest does a quick real mode
                  * foray.  The real mode IDT is unlikely to have a #PF
                  * exception setup.
                  */
                 return is_paging(vcpu);
         }

Paolo

