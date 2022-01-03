Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8D482EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiACIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230057AbiACIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641197075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdxaGBuR9xauk+WHq8djtOf6D/AnMAtrzYys2hrg50c=;
        b=QtGxKdkJvuoiHKczHSfgr3AYLT9wt15yrq7sI0sEkGidT4RkwSEUmfvKzYGbTJX2EQcb+F
        pzXPjS8jpSz5fQ++GJSnflPObrR0+mPMhLzofmGmj00UhltDz64BJeb8/UZQn/MjOjyPBZ
        f2vrIC31HhsZjD4/qEmmidqQScwVIzI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-7BPCJbh0OQKoK9XPUB9hlg-1; Mon, 03 Jan 2022 03:04:32 -0500
X-MC-Unique: 7BPCJbh0OQKoK9XPUB9hlg-1
Received: by mail-wr1-f72.google.com with SMTP id w25-20020adf8bd9000000b001a255212b7cso9951636wra.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 00:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UdxaGBuR9xauk+WHq8djtOf6D/AnMAtrzYys2hrg50c=;
        b=YQxmMHCoXO2JQ7xqRiObFs4D6rXjx3dDiSB+Huc/ZP9IVg0YOSKDbPvkN69sE4Z/dF
         Vmow9BJN5oSL1sTJcObyn2nY2jmV1brPk1STA16jh2oD2e+1hRVpMhKCnIvA2JvBRk4R
         CtrMzQ4jkQxXDlnputpT6ypnGRBaiZbBjIzo3MY5V1xcrPmLyw+bCCCS5TbbXcDaE4XT
         i9h4i1SUOukK57D4rLK717SjPChPP/9XUFF7hMy6Ags0d8Ulh0RLDiIF+c68xCn9jHtZ
         LF2vjEkO7F7+HO4VDRYMt5sQW25WAMjx14VuIZy4mMes8Nca4VsaEtxjZxmEyChT/huL
         RdPQ==
X-Gm-Message-State: AOAM531d8IrEJIBnycjjjksIbGICSb8UeQ5E55zYK9Cflq/uU7yYcohr
        KMK7x0zEB5xAX1Ml95vXisl/5PGNffhEWqdD+fyEOonr3U+85OptqcpnuS+Zzh7uzL3yVz7XlM4
        4E1rpwlI5/J1s/Dm6VPHGhC85mAwaWmA+WZxeyAFL5JxcdGUu35FiVZmEffMyThwqU+G/vMSZsv
        aB
X-Received: by 2002:a5d:608a:: with SMTP id w10mr36053912wrt.596.1641197071197;
        Mon, 03 Jan 2022 00:04:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVtP/aq31R7doXdWIFuANBoKaaKn+9HxKrxNy2cFus2ZwBwWHx5SjUajR9BsycSue2V/+yEw==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr36053893wrt.596.1641197070956;
        Mon, 03 Jan 2022 00:04:30 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p18sm4961997wmq.23.2022.01.03.00.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 00:04:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
In-Reply-To: <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
Date:   Mon, 03 Jan 2022 09:04:29 +0100
Message-ID: <87mtkdqm7m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/27/21 18:32, Igor Mammedov wrote:
>>> Tweaked and queued nevertheless, thanks.
>> it seems this patch breaks VCPU hotplug, in scenario:
>> 
>>    1. hotunplug existing VCPU (QEMU stores VCPU file descriptor in parked cpus list)
>>    2. hotplug it again (unsuspecting QEMU reuses stored file descriptor when recreating VCPU)
>> 
>> RHBZ:https://bugzilla.redhat.com/show_bug.cgi?id=2028337#c11
>> 
>
> The fix here would be (in QEMU) to not call KVM_SET_CPUID2 again. 
> However, we need to work around it in KVM, and allow KVM_SET_CPUID2 if 
> the data passed to the ioctl is the same that was set before.

Are we sure the data is going to be *exactly* the same? In particular,
when using vCPU fds from the parked list, do we keep the same
APIC/x2APIC id when hotplugging? Or can we actually hotplug with a
different id?

-- 
Vitaly

