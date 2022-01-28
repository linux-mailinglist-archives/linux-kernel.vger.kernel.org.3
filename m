Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF149FB63
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiA1OL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346969AbiA1OL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643379087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YNsFnjWqZ84YWknEFOSBbsUZabWkHFytiQN59OiiIQc=;
        b=MOfVECRuCYFIkkwa7tpoWc6u2qYvtUiM5oQREhPwfQs79E5CR7qCTh3jAoc0RLEyZTO4ap
        /SEcvXHpsSc2b9Vo6FogSkttnc/j6BIT3VvNVjSdy0pMOtJtPmRncF4eaSmLE6y5Cl2sL6
        yYIOxDgXZYjvgh83qxdhl6QW7r32XyY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-r7NpfP3mPTyaxHJE5-o_CQ-1; Fri, 28 Jan 2022 09:11:25 -0500
X-MC-Unique: r7NpfP3mPTyaxHJE5-o_CQ-1
Received: by mail-wm1-f72.google.com with SMTP id j6-20020a05600c1c0600b0034c02775da7so1486084wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YNsFnjWqZ84YWknEFOSBbsUZabWkHFytiQN59OiiIQc=;
        b=02s5KbFM9q+0bMGWIkutC0GZxudeGfIJ7mEOv2Nma6KPS9QlWtmPvsi3zZ8D70iPlt
         GFEFmpGHHyyktxHF2gJmS9tmn981d7WU0Q/PY+gv80ZywGCx4YpgmFH083F3TROF9c2v
         opsiybesBBxXvv5YuqV5AjGSxBun9VvGzpa8UMAS8kgLTlA1R/I1qPh5KU6Y8U1pJqUz
         hAcP3OXXzMl2S8C6ZHPVsNXqF+GdyMgWQ9fx6AOd/iFo+MYFKrB86SmHblFygVXxd+hA
         78/y+DgKAkfvy5hHZJEHQyVsyEoFUjlXN3v1cIJTg2wHt2uLjqTvSRSkUTp/gL1wGTyo
         eGqw==
X-Gm-Message-State: AOAM533UKmKDZJfdq6Uo1+Qxf5qOcWDF1uERdqIZ/ut6+py0J86hy2x9
        I1280zpvX30hKf9QxM7lKAOjbOoRu44fO3jC3b1ejx6OGyEbyJYP7G+FDTFjGob58O303AhW75i
        sjht5nM43vQtyc3WtEiWbYOI7
X-Received: by 2002:a05:6000:2a6:: with SMTP id l6mr7658211wry.601.1643379084425;
        Fri, 28 Jan 2022 06:11:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT46Xw3cllhWkaFOkaVffH2KheeQT8rFwQR/Q/9ZacgTrx7aiJ5+eRVjnv5irQ1QCrakHUdQ==
X-Received: by 2002:a05:6000:2a6:: with SMTP id l6mr7658188wry.601.1643379084194;
        Fri, 28 Jan 2022 06:11:24 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f13sm6058576wry.77.2022.01.28.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:11:23 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/5] KVM: nVMX: Fix Windows 11 + WSL2 + Enlightened VMCS
In-Reply-To: <86b78fe0-7123-4534-6aaf-12bd30463665@redhat.com>
References: <20220112170134.1904308-1-vkuznets@redhat.com>
 <87k0exktsx.fsf@redhat.com>
 <86b78fe0-7123-4534-6aaf-12bd30463665@redhat.com>
Date:   Fri, 28 Jan 2022 15:11:22 +0100
Message-ID: <87wnikeyr9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/18/22 15:22, Vitaly Kuznetsov wrote:
>> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>> 
>>> Changes since v2 [Sean]:
>>> - Tweak a comment in PATCH5.
>>> - Add Reviewed-by: tags to PATCHes 3 and 5.
>>>
>>> Original description:
>>>
>>> Windows 11 with enabled Hyper-V role doesn't boot on KVM when Enlightened
>>> VMCS interface is provided to it. The observed behavior doesn't conform to
>>> Hyper-V TLFS. In particular, I'm observing 'VMREAD' instructions trying to
>>> access field 0x4404 ("VM-exit interruption information"). TLFS, however, is
>>> very clear this should not be happening:
>>>
>>> "Any VMREAD or VMWRITE instructions while an enlightened VMCS is active is
>>> unsupported and can result in unexpected behavior."
>>>
>>> Microsoft confirms this is a bug in Hyper-V which is supposed to get fixed
>>> eventually. For the time being, implement a workaround in KVM allowing
>>> VMREAD instructions to read from the currently loaded Enlightened VMCS.
>>>
>>> Patches 1-2 are unrelated fixes to VMX feature MSR filtering when eVMCS is
>>> enabled. Patches 3 and 4 are preparatory changes, patch 5 implements the
>>> workaround.
>>>
>> 
>> Paolo,
>> 
>> would it be possible to pick this up for 5.17? Technically, this is a
>> "fix", even if the bug itself is not in KVM)
>
> Yes, it is.  I have queued the patch

Thanks!

> and feel free to send a 5.16 backport too.

I see your pull request to Linus, will send the backport when it lands.
In fact, all 5 patches apply to 5.16 without issues but I guess stable@
tooling won't pick them up automatically.

-- 
Vitaly

