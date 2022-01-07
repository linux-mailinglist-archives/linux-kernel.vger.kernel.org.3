Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44D48743D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbiAGIpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345863AbiAGIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641545145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJvdwM0wIIO+MMw5O2YidshZCxNzHMhgMOga0XHPFE4=;
        b=TR6EBdE08qK7X5RNyZmzv4qRfxpelDZtKX2Nrnudb9U65VBTMd9nYkm48ChFsJx7nhnb7m
        qWHwnV/BuLgplaBp0iol2S+D2ORJB32QUIdU5QY4r+QPUN5BXoqVGU9IfwfL7/ULf5FF3g
        +UoXPo5ApfXcggRFmNp0MRMAB94ig+E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-LE2A0o54NtKSUeKDsHyD0g-1; Fri, 07 Jan 2022 03:45:43 -0500
X-MC-Unique: LE2A0o54NtKSUeKDsHyD0g-1
Received: by mail-wr1-f69.google.com with SMTP id t26-20020adfa2da000000b001a585909b5dso833975wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 00:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pJvdwM0wIIO+MMw5O2YidshZCxNzHMhgMOga0XHPFE4=;
        b=G6lVQcmtcyCUxqsrWjt/MmyuneLIKXqNNB27Y4m0Ks+emRjrDBZxO4aPJLybrgZVGa
         Rj+0lWwNsuf+Rp9OzfYGIAtBxH7o577s1xRuUiBGUTp6z4QNWbeMXftWnEKdEVYIBRei
         mi+S/kDLzbOCAdQ+TXvviuu0jX2DUz9ONHTP82FKm54gf5QeS8cXILzN2zcvMhr8B0zx
         +4h8SLJm1fGGtUgyYXjxX1vShvxpjXmbVWrju2Gg3ZavCuiAbPX552kXqSJVwac/d/pP
         O8KDI2FowkLBgWJH7/5MyIvdgzAsC1DO7rolmwa4gPXrkFhn6Xpf25HTMxAdqPPXSrMr
         y7Mg==
X-Gm-Message-State: AOAM531n8N6BU3NFBQf387M9PmYDe/L0ucymHloATkXGP0CoyvFkJBOQ
        USVXeIpSQGDpbImSlDqfzlXx/eqR/BimLUZo8R4nXCzkfL2xTN0xsMYhuEKFuI87Ruui6kXcIAM
        ginHJQKKz7oGOQLu48oUZymCDuacG6WT0vnHRT0Y4LiLu9E03DmhPu7jTG6jMTcEoWUw31sSTJh
        5Q
X-Received: by 2002:a5d:47c7:: with SMTP id o7mr54569372wrc.642.1641545142552;
        Fri, 07 Jan 2022 00:45:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLAm59DpFY5G+3MCnkpoiNNNcWyFetrQkrVEx7412q7wq9YccEuMXwcnXpg+/qgwcRxCGMWw==
X-Received: by 2002:a5d:47c7:: with SMTP id o7mr54569349wrc.642.1641545142353;
        Fri, 07 Jan 2022 00:45:42 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 6sm3297942wmo.42.2022.01.07.00.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:45:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] KVM: nVMX: Rename vmcs_to_field_offset{,_table} to
 vmcs12_field_offset{,_table}
In-Reply-To: <Ydd9C7A56JtpSWnu@google.com>
References: <20211214143859.111602-1-vkuznets@redhat.com>
 <20211214143859.111602-4-vkuznets@redhat.com>
 <Ydd9C7A56JtpSWnu@google.com>
Date:   Fri, 07 Jan 2022 09:45:40 +0100
Message-ID: <87czl4orwr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Dec 14, 2021, Vitaly Kuznetsov wrote:
>> vmcs_to_field_offset{,_table} may sound misleading as VMCS is an opaque
>> blob which is not supposed to be accessed directly. In fact,
>> vmcs_to_field_offset{,_table} are related to KVM defined VMCS12 structure.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
>> index 2a45f026ee11..13e2bd017538 100644
>> --- a/arch/x86/kvm/vmx/vmcs12.h
>> +++ b/arch/x86/kvm/vmx/vmcs12.h
>> @@ -361,10 +361,10 @@ static inline void vmx_check_vmcs12_offsets(void)
>>  	CHECK_OFFSET(guest_pml_index, 996);
>>  }
>>  
>> -extern const unsigned short vmcs_field_to_offset_table[];
>> +extern const unsigned short vmcs12_field_offset_table[];
>
> While we're tweaking names, what about dropping "table" and calling this
> vmcs12_field_offsets?
>

Ok.

>>  extern const unsigned int nr_vmcs12_fields;
>>  
>> -static inline short vmcs_field_to_offset(unsigned long field)
>> +static inline short vmcs12_field_offset(unsigned long field)
>
> And get_vmcs12_field_offset() here to make it more obvious that it's translating
> something to an offset, which is communicated by the "to" in the current name.
>

I think we could've even used just 'vmcs12_field_offset()' as I don't
see any ambiguity in it but 4 additional letters shouldn't hurt.

>>  {
>>  	unsigned short offset;
>>  	unsigned int index;
>> @@ -377,7 +377,7 @@ static inline short vmcs_field_to_offset(unsigned long field)
>>  		return -ENOENT;
>>  
>>  	index = array_index_nospec(index, nr_vmcs12_fields);
>> -	offset = vmcs_field_to_offset_table[index];
>> +	offset = vmcs12_field_offset_table[index];
>>  	if (offset == 0)
>>  		return -ENOENT;
>>  	return offset;
>> -- 
>> 2.33.1
>> 
>

-- 
Vitaly

