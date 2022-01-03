Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DDE483131
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiACM47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbiACM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641214617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+0VcHP1CYruqwB40NeEtKv4yl+LXrHLsOptfsKeiRI=;
        b=TTZO3sz+dhG1W/zQxCGWArN2XnIhnmQqFY1Bkzyfvql5ZK7j6VEJrffIESnbn1FNpdwscA
        D8qFDzFT/HL78RKI12OZDWm+cfklI7sqOrpolPbajvhxS2BBJIsuQ0GzVNVWBdYOTrBZQo
        tX4RlsezetwRAAT+VgzBtEiT4yL8k88=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-f_vcIepbPG6BAux4lAkEKQ-1; Mon, 03 Jan 2022 07:56:56 -0500
X-MC-Unique: f_vcIepbPG6BAux4lAkEKQ-1
Received: by mail-wm1-f70.google.com with SMTP id v23-20020a05600c215700b0034566adb612so8716902wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 04:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q+0VcHP1CYruqwB40NeEtKv4yl+LXrHLsOptfsKeiRI=;
        b=IYwJutgiXKGrbpP6QBFsx/IWm4ypJhoEimrO9bMdMc+Pw3/iLP2XXbnXftCMo8F/zR
         WIUG5FO+TXRmxqp7kYA53HbzO65XXLKeJrCP8oa0eb5F/v+V/9yh5lNEDOIl9eg2Imug
         phNdEyPhvOukDyanQrr41y+AwrzWF1a5Ty3ww9SM+Im0vc/JJWQtjiLjgAiY9G77OsDe
         LT4HpdDXfM6P7fJIihkuZVj4fsyNlBKubScMClSzEnQ7XnsGZ24qvHjPa1ZqR6CaZ16G
         67gYh5H86Emzq02QjqziUq++gqYBfm1FprLFTzdKsQQCUq63FfntpWkfqQPFp91h8HCQ
         jvOg==
X-Gm-Message-State: AOAM531cfIkbR1xXl4J+DajELZU0+7nRGP9NbYpp2EOnZL87kyTDomku
        7Surq4GXFIUGsUvaYUIe8dBLnyuMvSL6ZFd+CHiwgmEtvvIZNxvTft7MV8HwLpYsDwGM6cY2EwI
        tbLbeRLjJgM8BhoSdaUCGcbJgvdWtiMKsosQIQabFehM4P4cYjCCpEpBzahHPd7AFOygG4vbGLx
        Z0
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr8187886wri.135.1641214615811;
        Mon, 03 Jan 2022 04:56:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDpUMIC/WC+h6hUImHvQqEuiygZq8ljLrr9aVNb+INT15FUbHInzoVOpdVgC/6qO+i+/5zHg==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr8187862wri.135.1641214615521;
        Mon, 03 Jan 2022 04:56:55 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l26sm34337226wrz.44.2022.01.03.04.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 04:56:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
In-Reply-To: <20220103104057.4dcf7948@redhat.com>
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
 <87mtkdqm7m.fsf@redhat.com> <20220103104057.4dcf7948@redhat.com>
Date:   Mon, 03 Jan 2022 13:56:53 +0100
Message-ID: <875yr1q8oa.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Mammedov <imammedo@redhat.com> writes:

> On Mon, 03 Jan 2022 09:04:29 +0100
> Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>> > On 12/27/21 18:32, Igor Mammedov wrote:  
>> >>> Tweaked and queued nevertheless, thanks.  
>> >> it seems this patch breaks VCPU hotplug, in scenario:
>> >> 
>> >>    1. hotunplug existing VCPU (QEMU stores VCPU file descriptor in parked cpus list)
>> >>    2. hotplug it again (unsuspecting QEMU reuses stored file descriptor when recreating VCPU)
>> >> 
>> >> RHBZ:https://bugzilla.redhat.com/show_bug.cgi?id=2028337#c11
>> >>   
>> >
>> > The fix here would be (in QEMU) to not call KVM_SET_CPUID2 again. 
>> > However, we need to work around it in KVM, and allow KVM_SET_CPUID2 if 
>> > the data passed to the ioctl is the same that was set before.  
>> 
>> Are we sure the data is going to be *exactly* the same? In particular,
>> when using vCPU fds from the parked list, do we keep the same
>> APIC/x2APIC id when hotplugging? Or can we actually hotplug with a
>> different id?
>
> If I recall it right, it can be a different ID easily.
>

It's broken then. I'd suggest we revert the patch from KVM and think
about the strategy how to proceed. Going forward, we really want to ban
KVM_SET_CPUID{,2} after KVM_RUN (see the comment which my patch moves).
E.g. we can have an 'allowlist' of things which can change (and put
*APICids there) and only fail KVM_SET_CPUID{,2} when we see something
else changing. In QEMU, we can search the parked CPUs list for an entry
with the right *APICid and reuse it only if we manage to find one.

-- 
Vitaly

