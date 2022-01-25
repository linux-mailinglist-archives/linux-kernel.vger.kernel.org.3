Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900D49B715
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377658AbiAYPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1580091AbiAYO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643122586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lGL2/NjefHhyINykRNyB07vGQwioJ1sjJSOwSvg1S6Y=;
        b=dwuVxIxb6rnEKWi01oFa0jw2gYOamVyObqTIUH+Q7iQKqDh/XkBYd5yTrkbQdaccsCDcSo
        Ez+FDTFk8/7TJnhmcxyiCvM6OcnUAruB6OxTYCaxAZl7nqo/4hyKpdZ7mSPOy8X0l2fygG
        LSpUerVemYZ7ssspXeGQucfogcmPB4E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-NojHH0vSNN63YWpeOhuljA-1; Tue, 25 Jan 2022 09:56:25 -0500
X-MC-Unique: NojHH0vSNN63YWpeOhuljA-1
Received: by mail-ed1-f70.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso15187187edi.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lGL2/NjefHhyINykRNyB07vGQwioJ1sjJSOwSvg1S6Y=;
        b=JWu5lsnfu3cu1A8Rh9ZpCsEoUMsvb0FIoc/3LktC1uGFNf2JVHQHdjoypKdtgmB8Sx
         b5pr3YkFciEKzQqJhx0OlWzcYxG8KrDCPWSlLI7xy6nk9Bj1QYteKgyouEayVFQB0Y6Y
         CkhhO6Mct4M1KyrGEw3HurVfMQRO1ERIUMFGBSjlgDkEaf1nNumKu+f556p/KqI9zbBp
         X7IlZcxbpYLOzT+b9G2WCoQDHt/+4H5U+e2AdTMhvH0tFgLwxWQQB2m6gCvLAzjjXCp8
         5GqpI7isLHyRlxwzEgIwkknMg/Ldon0mamOgCKLTH8LVF5HNRXkjHvphIPrCiWG6/NQc
         xmtg==
X-Gm-Message-State: AOAM532hYkINATHhhjy3ABrtIlXCZnLMPlpClvXZGUj02rm7OWqB4Jrf
        0nDUm/C+TFRsvOiPHunGGofiCrug1HBEthqnpGbwzzbo2HRAs0/beNfbg0hm2DAhCWF8fEiTVrs
        5q+6S34oZ2LixR7zzTqHONdSV
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr20572181edv.174.1643122584286;
        Tue, 25 Jan 2022 06:56:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVGauajL/pyWmlWy8fSIPc8ZX2dsHxs6NAmP9jhUXsGReDypI2HiaL16DWhDfC4d1IpPkbIw==
X-Received: by 2002:a05:6402:195:: with SMTP id r21mr20572161edv.174.1643122584118;
        Tue, 25 Jan 2022 06:56:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id g4sm8419999edl.50.2022.01.25.06.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 06:56:23 -0800 (PST)
Message-ID: <23c80e45-856c-b188-44a4-08a97d5e5ba3@redhat.com>
Date:   Tue, 25 Jan 2022 15:56:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 6/9] KVM: SVM: WARN if KVM attempts emulation on #UD or
 #GP for SEV guests
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Liam Merwick <liam.merwick@oracle.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <20220120010719.711476-1-seanjc@google.com>
 <20220120010719.711476-7-seanjc@google.com>
 <483ed34e-3125-7efb-1178-22f02173667a@oracle.com>
 <YemWCwhQ8aYcqUw9@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YemWCwhQ8aYcqUw9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 18:04, Sean Christopherson wrote:
>>> +	WARN_ON_ONCE(emul_type & (EMULTYPE_TRAP_UD | EMULTYPE_VMWARE_GP));
>> What about EMULTYPE_TRAP_UD_FORCED?
> Hmm, yeah, it's worth adding, there's no additional cost.  I was thinking it was
> a modifier to EMULTYPE_TRAP_UD, but it's a replacement specifically to bypass
> the EmulateOnUD check (which I should have remembered since I added the type...).
> 

Added on top:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d5fe71862bcb..85bbfba1fa07 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4269,7 +4269,9 @@ static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
  		return true;
  
  	/* #UD and #GP should never be intercepted for SEV guests. */
-	WARN_ON_ONCE(emul_type & (EMULTYPE_TRAP_UD | EMULTYPE_VMWARE_GP));
+	WARN_ON_ONCE(emul_type & (EMULTYPE_TRAP_UD |
+				  EMULTYPE_TRAP_UD_FORCED |
+				  EMULTYPE_VMWARE_GP));
  
  	/*
  	 * Emulation is impossible for SEV-ES guests as KVM doesn't have access


Paolo

