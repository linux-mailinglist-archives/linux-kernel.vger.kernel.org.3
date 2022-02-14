Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870254B5863
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357009AbiBNRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:22:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiBNRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:22:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF581652DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644859369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heen2BB+onxLcxe/2Jf8awF4VD6iWVMhKf1QFzuQRwA=;
        b=IDRl7eXSblyI4XGz4JuGqoQeu8B/9SGXeQkx9sBxUcVmH/ToWzQovog7GmaYNtlz9salBX
        FhyWE3SeAbRgm6B9MJ0ilJotTN3AfrPfAoIGPa9cGVbmaFZuZvskRjsctO7zBUS3TkW3ik
        nt63W5D9sUlFQFaHYTzIxzNkIKRaCkk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-7mGJAX0DOnqkvklYO0l94g-1; Mon, 14 Feb 2022 12:22:47 -0500
X-MC-Unique: 7mGJAX0DOnqkvklYO0l94g-1
Received: by mail-ej1-f71.google.com with SMTP id gn20-20020a1709070d1400b006cf1fcb4c8dso972484ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=heen2BB+onxLcxe/2Jf8awF4VD6iWVMhKf1QFzuQRwA=;
        b=YGiXUA4flqFHyx9SojCJIMjqxuNBB3Nl1xJLhGwXiXbK6kEQNOZjLn9XHxFIcivOth
         8EzL0gEKrQVbIoU8yUV0drr3Lg87A86YUIkjqMkYlp5xlVjtu8rVsfTnvkhQo5+/PJNz
         6fK6w1/5Wn+dJizOoRGBpnIvCuT8/3HK9+Xe9rti6OInNhkZMjae1nRirXgxuEAnPU0O
         H12LABmC529HhrnjehjxbONK/Odeq3LpokbKDW91fUojSs66chT03dtiqLhJJ26FgPxF
         blCWJNELJUDk7DRXrKLCOJIntN6aITMXxXzXtqIs7PQ+Xmb2uextlL+PHnzIeO9xjO+p
         6B/A==
X-Gm-Message-State: AOAM533Hv1NJzRF97Gg+n/4ruRfILNF20UUOMnzzPYIGWKT2lhPWs7eH
        ac6eT+QuYZzz8naQCCGO07UxNkA+XbXU6LVEeeGkcltESziGZalUi7eM+u/uZOkfZ0zMCcIX5PR
        3yEaW4cuxIRlkF2HsTu0nt+fj
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr543356eji.174.1644859366224;
        Mon, 14 Feb 2022 09:22:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxx74GvXC0GfGqL2mBl7P8WYj1j9LH2x5O80iJkp6aztCILB1JQgG3KIu9CpvJEA22swB0kyg==
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr543350eji.174.1644859366041;
        Mon, 14 Feb 2022 09:22:46 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id q19sm9367532ejm.74.2022.02.14.09.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:22:45 -0800 (PST)
Message-ID: <3caa56dc-ec80-a172-a632-42689aaf6f0b@redhat.com>
Date:   Mon, 14 Feb 2022 18:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] KVM: SEV: Allow SEV intra-host migration of VM with
 mirrors
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220211193634.3183388-1-pgonda@google.com>
 <a3008754-86a8-88d6-df7f-a2770b0a2c93@redhat.com>
 <CAMkAt6rLafSikpQEKkbbT8DW4OG_pDL63jPLtCFiO1NNtTRe+A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAMkAt6rLafSikpQEKkbbT8DW4OG_pDL63jPLtCFiO1NNtTRe+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 16:52, Peter Gonda wrote:
> On Mon, Feb 14, 2022 at 5:57 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 2/11/22 20:36, Peter Gonda wrote:
>>> +     list_cut_before(&dst->mirror_vms, &src->mirror_vms, &src->mirror_vms);
>>> +     list_for_each_entry_safe(mirror, tmp, &dst->mirror_vms,
>>> +                              mirror_entry) {
>>
>> Is list_for_each_entry_safe actually necessary here?  (It would be if
>> you used list_add/list_del instead of list_cut_before).
> 
>   I don't think so, I think we could use list_for_each_entry here. Do
> you want me to send another revision?

No, I can do that myself, thanks!

Paolo

