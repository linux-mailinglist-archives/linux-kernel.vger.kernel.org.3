Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740FE49FCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiA1Pek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:34:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231994AbiA1Pej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643384079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FddNkihBKrpyFAjQbGjNX8VSm5TbuzI1tnV/kFzwOrM=;
        b=WV/u/GCxwlzhdWPQptq185cpTgM94LlxmJwMUave3mQMKoKwYnjUMAaprMdsK1NNxJUXNL
        rfpSb9hzYAQvV4APk/nAHl7b8GVsAF3WAIvtDtW2Lf1m3+Bx9FkcXxeHWuGlsQSaTyhe5q
        vUl2yrC6J2Pe/vADph81ZYhQOwwUJcU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-dXkp9pLcOL-q6PyDh54hhQ-1; Fri, 28 Jan 2022 10:34:37 -0500
X-MC-Unique: dXkp9pLcOL-q6PyDh54hhQ-1
Received: by mail-ej1-f70.google.com with SMTP id q21-20020a17090622d500b006bb15a59a68so1101643eja.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FddNkihBKrpyFAjQbGjNX8VSm5TbuzI1tnV/kFzwOrM=;
        b=bx0skE/mLZKFCvPlwzguwYE2ASBGhaQ8rTrRqwkBcM5tuV2ji1Hy1rWA9jWQ3dDB7g
         DB0/J9Gcs/OjcJioI0Wzy0yJyMw5gfWSyaDmvPSQz72UC2QGI37pseFhyLatHAKW92Ut
         sxqWwCpNsVCizSSCu7vYTWwPzMtjsESSTyjB/1/mrWuLXzcdu1l9elGkoc1suVTZMO2N
         8KPwAGbsztRREENL8BFHGPjTYjdnYP9B3zY1EhsQpB+2dji3hHPMjH77guY4duCHTvjd
         kAVOGSsZCMQSjJBOv4LI4vuhnhbV5I5aT/OM8I/7CSmDXQ8m8wexXVf6mmYU+QxXNVVi
         +52Q==
X-Gm-Message-State: AOAM531z7sApcXjuNIGdDCTbZDlnvK32+F0fEvk9UaKvyC+DdKaLJmpM
        eRacrXxo0jBS7w0ovDwpG5CxHp6/1/V4h3850pk7erLOOUhFrw4vwmUkIZD2qlaQjEulf1sF2vF
        jDObHBpS8dQLDGLuMYl7cpw0a
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr7398612ejc.625.1643384076776;
        Fri, 28 Jan 2022 07:34:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwLL+POnsBqFB2XKtrVYeYBbTz8onLQhw2ZyyyQ9/AMR2vPIoGCO/UMj3nGYWHOnUUShojAg==
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr7398598ejc.625.1643384076595;
        Fri, 28 Jan 2022 07:34:36 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g9sm9985829ejf.33.2022.01.28.07.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 07:34:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/5] KVM: nVMX: Fix Windows 11 + WSL2 + Enlightened VMCS
In-Reply-To: <b84dbb2c-0319-e9cc-adbe-bf78be6652d5@redhat.com>
References: <20220112170134.1904308-1-vkuznets@redhat.com>
 <87k0exktsx.fsf@redhat.com>
 <86b78fe0-7123-4534-6aaf-12bd30463665@redhat.com>
 <87wnikeyr9.fsf@redhat.com>
 <b84dbb2c-0319-e9cc-adbe-bf78be6652d5@redhat.com>
Date:   Fri, 28 Jan 2022 16:34:34 +0100
Message-ID: <87pmobg9h1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/28/22 15:11, Vitaly Kuznetsov wrote:
>> I see your pull request to Linus, will send the backport when it lands.
>> In fact, all 5 patches apply to 5.16 without issues but I guess stable@
>> tooling won't pick them up automatically.
>
> I noticed, but I wasn't sure what the dependencies were among them and 
> whether you'd prefer to only have patches 3-5; so I didn't just add "Cc: 
> stable" myself.

Actually yes, patches 1/2 don't fix any "real" issue (afair) so we can
be a bit more conservative with 5.16.

-- 
Vitaly

