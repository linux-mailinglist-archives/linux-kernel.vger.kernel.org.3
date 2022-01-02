Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0E9482C5E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiABRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbiABRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641144718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xx53ITjWAFhyNMijkvxtQDoUWUdkY09dXfOKBGXfymQ=;
        b=Ko7VExloArW8w60lthNj0G3A1U1sENa6GrXOsafDYgofxBqbhKJ3WRDWYMzubg/ASo+tPr
        M4IJjEKYcSoCdmopGl+o4UpnNo3MhZl3bTlt+2RBSmrsAA+X1glA0SxJMVbWNWViSvIaKr
        xrDY1aOqt/sRVvRLj2Lbv0ofH4Z9dcg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-qF_wFr1KOc-bZl2fITAJKA-1; Sun, 02 Jan 2022 12:31:57 -0500
X-MC-Unique: qF_wFr1KOc-bZl2fITAJKA-1
Received: by mail-ed1-f70.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so21576504edd.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 09:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xx53ITjWAFhyNMijkvxtQDoUWUdkY09dXfOKBGXfymQ=;
        b=mziiffgr2zni94pZ57ms429m7KgvcJl7tZz3XxVeo9ztgpvGFc8v6ohFpSAXtsMJVR
         3w0dgH40XyTQ8xpXWv2rfQ2M9RCwlAvaUTjYUj5xf2+q5nFqlUpAfiAgUIDostg/5F+9
         fK30DVhQGNI9BYwFAEG7nGCgdgkmO8eczgRS4i7f24WTPoToTaemTNcJNYxA7AYsMdGl
         Me8DOTRKBScA9uYd70qBOJDmbjGwoDA+08BDNItEcTyAA2GhHIjgnlAO4b2dM+dIorFA
         qrpTtZu0JRkGPFgKtCsmdKHZhKhoCRpcAwmabox5odpxbBWYCMp7RjHvuLrq6bkyyuZL
         M69Q==
X-Gm-Message-State: AOAM532H4rZqqEqZ+zPczw5BBI53aSrUlx3FVgYvEKHATouFDdkJDdYy
        N7oNICQ4ncX6FfjE6SFcSjFzwZYhhl5jmli393oq+zB0DmfppffADUaU7zRajauV9SXxnSnqdc9
        Lcpo4FOGFK1/f0+i86YHhPrHx
X-Received: by 2002:a17:906:3e09:: with SMTP id k9mr35418891eji.104.1641144716130;
        Sun, 02 Jan 2022 09:31:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEQrTX0mLlJOs6HtUvWNyvJ5ZzPfG+dPZnuAx1kq+NyBboQlJA1+kSzghmTAFrtlhkLZLi8w==
X-Received: by 2002:a17:906:3e09:: with SMTP id k9mr35418885eji.104.1641144715920;
        Sun, 02 Jan 2022 09:31:55 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id o10sm5093507ejm.127.2022.01.02.09.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 09:31:55 -0800 (PST)
Message-ID: <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
Date:   Sun, 2 Jan 2022 18:31:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
Content-Language: en-US
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211227183253.45a03ca2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 18:32, Igor Mammedov wrote:
>> Tweaked and queued nevertheless, thanks.
> it seems this patch breaks VCPU hotplug, in scenario:
> 
>    1. hotunplug existing VCPU (QEMU stores VCPU file descriptor in parked cpus list)
>    2. hotplug it again (unsuspecting QEMU reuses stored file descriptor when recreating VCPU)
> 
> RHBZ:https://bugzilla.redhat.com/show_bug.cgi?id=2028337#c11
> 

The fix here would be (in QEMU) to not call KVM_SET_CPUID2 again. 
However, we need to work around it in KVM, and allow KVM_SET_CPUID2 if 
the data passed to the ioctl is the same that was set before.

Paolo

