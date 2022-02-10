Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB154B0D08
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbiBJL7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:59:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbiBJL66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:58:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517FAB9D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644494339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/yiXC42RApJ9PXUMkcbUc4Ysh889sJZTdjISpYC8eM=;
        b=MjArIH5q3ZuTaUYz01y2f0QnxBDCLz0bNV8Sz7Ivz1iFPcQqZw2ezYStA/ABnmnzaVu/yN
        XEju2gwrXMKGyA8VrIP1gzlO53IG44i0/hm9wNglvXyVcrRhgxo5pNLvL1ADsAnif5NiJw
        rSKz3UEl3OK+M4Mkxo7b8lFNmbtr1BQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-EKDTewIjN5SvRD_RIPYw3g-1; Thu, 10 Feb 2022 06:58:56 -0500
X-MC-Unique: EKDTewIjN5SvRD_RIPYw3g-1
Received: by mail-ej1-f72.google.com with SMTP id aj9-20020a1709069a4900b006cd205be806so2602038ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i/yiXC42RApJ9PXUMkcbUc4Ysh889sJZTdjISpYC8eM=;
        b=bugKvW91jj3iN5TOj1N0hrUPbvsGJhrW+7+yVV3UXVxI62Av0vtUg5BJUAl/pD+YkU
         OkEuPQI2uulD9KXBbFwYoO/olmoqV4343etG/ocZz4KgzvtXKnuuuOAcNXQvGlM0gRSF
         J/Xb7q5b1ChP0YjV0HC6a1yse11MlP3gW9+0hlQPbGI64+gq6ABQLnudhZXlIdtDyXRm
         6dkWXaqeL5UsrbQBXP3zTNWf7fBkSABm2q+ViWXogC7+WYAvd9dyRhAv1g26/1j1FEJU
         IeDuveT2zxkK0h7DUUZPu/DKnE2Vkhf4Z+90ClS5kTUrfOICf+QhBeihCvK9lREG3vit
         qUYQ==
X-Gm-Message-State: AOAM533zvCQbE1RACOXja+hqpUi1uzgdR8FGe7asSsSbxYcDiWwVFhxs
        F7PsOc2VUcA1CmxyEFAWIXJbCvOsDlWAbGYU3pAbb0ypXiLFPetS2paG727M9X1zjcWh5QkO4dm
        oa/UoCDkpcmsAzWxxTWOHJN5f
X-Received: by 2002:a17:906:7306:: with SMTP id di6mr6060039ejc.521.1644494334937;
        Thu, 10 Feb 2022 03:58:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX6Jij1AIQnLPu771ecj6g/uugHnqAyd8Uzh9Slumm8IcBh/Bd5oGSt0nl0iQus6cFqRyPxA==
X-Received: by 2002:a17:906:7306:: with SMTP id di6mr6060011ejc.521.1644494334635;
        Thu, 10 Feb 2022 03:58:54 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id j20sm1489328ejo.27.2022.02.10.03.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 03:58:53 -0800 (PST)
Message-ID: <40930834-8f54-4701-d3ec-f8287bc1333f@redhat.com>
Date:   Thu, 10 Feb 2022 12:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/23] KVM: MMU: MMU role refactoring
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <YgGmgMMR0dBmjW86@google.com> <YgGq31edopd6RMts@google.com>
 <CALzav=d05sMd=ARkV+GMf9SkxKcg9c9n5ttb274M2fZrP27PDA@mail.gmail.com>
 <YgRmXDn7b8GQ+VzX@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YgRmXDn7b8GQ+VzX@google.com>
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

On 2/10/22 02:11, Sean Christopherson wrote:
> In a vacuum, I 100% agree that guest_role is better than cpu_role or vcpu_role,
> but the term "guest" has already been claimed for "L2" in far too many places.
> 
> While we're behind the bikeshed... the resulting:
> 
> 	union kvm_mmu_role cpu_role;
> 	union kvm_mmu_page_role mmu_role;
> 
> is a mess.  Again, I really like "mmu_role" in a vacuum, but juxtaposed with
> 	
> 	union kvm_mmu_role cpu_role;
> 
> it's super confusing, e.g. I expected
> 
> 	union kvm_mmu_role mmu_role;

What about

	union kvm_mmu_page_role root_role;
	union kvm_mmu_paging_mode cpu_mode;

?  I already have to remove ".base" from all accesses to mmu_role, so 
it's not much extra churn.

Paolo

