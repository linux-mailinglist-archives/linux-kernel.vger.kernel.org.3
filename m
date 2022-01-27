Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34DA49DE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiA0Jgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbiA0Jgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643276197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PV01ELli/hyFaStUxqX6n9QaOQmZ2C+YT0HIqDtWr78=;
        b=OuDuvzSJQ1MuMn6312uwjJqGhlGKipensborb/8LpxDz1TMhmAHy6GeI9vPnhm6Kpl0P+v
        ISoiwMTkxm3WtIM5ZWJlsO1iHc6KpdCUQi7QTPPVGD0dDcaNKkrpF92Dg8YgVipjEeyG4s
        FYE5BIEiZbslJI4IheQxadrbkHE22Oc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-uznb40cZN1GVY_TGUcC56g-1; Thu, 27 Jan 2022 04:36:24 -0500
X-MC-Unique: uznb40cZN1GVY_TGUcC56g-1
Received: by mail-ed1-f69.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso1108042edr.21
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PV01ELli/hyFaStUxqX6n9QaOQmZ2C+YT0HIqDtWr78=;
        b=1R0Ft/Bl37mQBjx/xHqPa0geOdIelfUuLI98g6HmIgXNgoTlr6n7Rp0exe+ysDzgxP
         9RhmLmjxpyU/2ahlJRzoQVbsKDqkFLTKE3V4Q6QWvrVDbR3Q1/6ifnyP0TjjzeMsuUHs
         dqqvQXyuKLWvzNy8t8ssnZgqEP2BrFVtJ6YYlbERk5x+TcYmUIOToOP5BCbgkXsnJNuK
         aB7FyIsz26LrVss5k8i/8BvHnYUvYw1a7S3a6YiX4Rg5f3UOlgdxI2JqGE/Rx/40KVua
         xCbvUCIOaT1xX+47qP5MW6swAIzf6Ta9VpDPXp7XSFRgJXSLnF6DHb61wejVwwNFhMiH
         nF7w==
X-Gm-Message-State: AOAM531DzUkyjFeVrrDHBJYZiDYy+YVewJeqx5n38O4Zbr/el3/B8YFV
        Vuq85XsXnO1I4+kFU4lQWcJK6/A1mpDO+F+f0tMXKaV1Zkpwc3/XWS99WejLcGJFoEKKi8kFfjE
        01qjtMxW2XxgZGdgq8VyQIGhc
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr2815816edq.232.1643276183794;
        Thu, 27 Jan 2022 01:36:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSDbYtEKfjFx4mZY8KRDFwpmKOB6JY/3sQYjWOBAHu7dHGUuXD0KB1JiyVurp5evEm9AatQw==
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr2815802edq.232.1643276183640;
        Thu, 27 Jan 2022 01:36:23 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i16sm8495187eja.8.2022.01.27.01.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 01:36:23 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/5] KVM: nVMX: Fix Windows 11 + WSL2 + Enlightened VMCS
In-Reply-To: <87k0exktsx.fsf@redhat.com>
References: <20220112170134.1904308-1-vkuznets@redhat.com>
 <87k0exktsx.fsf@redhat.com>
Date:   Thu, 27 Jan 2022 10:36:22 +0100
Message-ID: <87ee4th65l.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> Changes since v2 [Sean]:
>> - Tweak a comment in PATCH5.
>> - Add Reviewed-by: tags to PATCHes 3 and 5.
>>
>> Original description:
>>
>> Windows 11 with enabled Hyper-V role doesn't boot on KVM when Enlightened
>> VMCS interface is provided to it. The observed behavior doesn't conform to
>> Hyper-V TLFS. In particular, I'm observing 'VMREAD' instructions trying to
>> access field 0x4404 ("VM-exit interruption information"). TLFS, however, is
>> very clear this should not be happening:
>>
>> "Any VMREAD or VMWRITE instructions while an enlightened VMCS is active is
>> unsupported and can result in unexpected behavior."
>>
>> Microsoft confirms this is a bug in Hyper-V which is supposed to get fixed
>> eventually. For the time being, implement a workaround in KVM allowing 
>> VMREAD instructions to read from the currently loaded Enlightened VMCS.
>>
>> Patches 1-2 are unrelated fixes to VMX feature MSR filtering when eVMCS is
>> enabled. Patches 3 and 4 are preparatory changes, patch 5 implements the
>> workaround.
>>
>
> Paolo,
>
> would it be possible to pick this up for 5.17? Technically, this is a
> "fix", even if the bug itself is not in KVM)

Ping)

-- 
Vitaly

