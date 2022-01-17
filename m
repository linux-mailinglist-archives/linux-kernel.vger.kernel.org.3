Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9272490921
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiAQNCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234253AbiAQNCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642424555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmxLgMKtM2xp64rnq5p7GdtgJriOCMkjmIrcQ5U3IJY=;
        b=aVynspfbNhQ+xho5wYQtWHvuIN1vtHHV/vYs+84GM/JFAueca8AIDjEU822B3psrk40amp
        kspEFTOmuC47l3vpCIo+24pvcu/mcwN5FjqKgOzViaJft+hlKWjmAfx5/fUKnFqRj9YEth
        kpYcO5HADS/je73rDnhqvDgJqOkjgK0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-6d7_BgZiM9KPizW97X4TAw-1; Mon, 17 Jan 2022 08:02:34 -0500
X-MC-Unique: 6d7_BgZiM9KPizW97X4TAw-1
Received: by mail-wm1-f69.google.com with SMTP id n13-20020a05600c3b8d00b0034979b7e200so5262687wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AmxLgMKtM2xp64rnq5p7GdtgJriOCMkjmIrcQ5U3IJY=;
        b=0XfMGgyG4hyI7mLE1jg0VJ5z0umpi7XFSgh8kFYCKNWmCzDcGluJHi4nBOxdn8qLS2
         /UT0nv36JSVU1WwIU3S/DZyOufEZL1KH6UGylpA04K4DM9RLrmF7PwmES2UcyjsHQRe5
         L5cNzLERbfFHwZe1zC02IZlWNh9e6HUj59mcYgQlT5gLi/z8Bhfq2qsw0qNv8pKaO4ch
         Zbr0rCQV3qDzoLp4uoqaGgqpvDTrU7LO7X8WoYI4mn+7SyEAYVKPGSyqLRb8E4XHIdWS
         H03RxydHGG0ONuyWZs7dhOtbB+gV5Pn/C3egjl9kWcX8kMwyioo6jA8XiH+V7aDzED5C
         YHWw==
X-Gm-Message-State: AOAM532jWEuFJJuLfIVaF8CtQ7PZqoRc4TgUBLseeh+T2VaQMLSRs066
        HosijxnnSOMWLmNNBydiGxAT75DtikoBxk/xDcVvkkOIcneEXEIdlIxrzQtGvawPJjjHzWT7htf
        t0LdRKUTB8gNc064goPClUVsMX2nRCjd5tUg1sWqN18dOr4V4W5C7qp02sg8bVfsiBFF5gGmYy/
        ED
X-Received: by 2002:a5d:5147:: with SMTP id u7mr13731050wrt.687.1642424553461;
        Mon, 17 Jan 2022 05:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5gUyIT+6hmx9at0BIXTQZgqi8LBV9qiFylH3MqPMb8FTU5HuKtAntofElkn6GwInqCUKmTw==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr13730964wrt.687.1642424552481;
        Mon, 17 Jan 2022 05:02:32 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id az29sm9867067wmb.31.2022.01.17.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 05:02:31 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
In-Reply-To: <517e8b95-e336-8796-6657-c0f8d554143a@redhat.com>
References: <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
 <87mtkdqm7m.fsf@redhat.com> <20220103104057.4dcf7948@redhat.com>
 <YeCowpPBEHC6GJ59@google.com> <20220114095535.0f498707@redhat.com>
 <87ilummznd.fsf@redhat.com> <20220114122237.54fa8c91@redhat.com>
 <87ee5amrmh.fsf@redhat.com> <YeGsKslt7hbhQZPk@google.com>
 <8735lmn0t1.fsf@redhat.com>
 <517e8b95-e336-8796-6657-c0f8d554143a@redhat.com>
Date:   Mon, 17 Jan 2022 14:02:31 +0100
Message-ID: <87zgnuldlk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/17/22 10:55, Vitaly Kuznetsov wrote:
>> No, honestly I was thinking about something much simpler: instead of
>> forbidding KVM_SET_CPUID{,2} after KVM_RUN completely (what we have now
>> in 5.16), we only forbid to change certain data which we know breaks
>> some assumptions in MMU, from the comment:
>> "
>>           * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
>>           * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
>>           * tracked in kvm_mmu_page_role.  As a result, KVM may miss guest page
>>           * faults due to reusing SPs/SPTEs.
>> "
>> It seems that CPU hotplug path doesn't need to change these so we don't
>> need an opt-in/opt-out, we can just forbid changing certain things for
>> the time being. Alternatively, we can silently ignore such changes but I
>> don't quite like it because it would mask bugs in VMMs.
>
> I think the version that only allows exactly the same CPUID is the best, 
> as it leaves less room for future bugs.
>

Ok, I hear your vote) Will prepare v2.

-- 
Vitaly

