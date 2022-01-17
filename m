Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4B490FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiAQRpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235374AbiAQRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642441542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4GDA0IUvWhhcky7T0HTZUXu5KWeN95yhvrj+pk935s=;
        b=SQpRF2pYlK4kQ4w9Gkg7l2e7f2tPVfY4MPMFc4m4W8TgidhehfwhzUZ6w8hhMwWeFOI5yZ
        D6TPPy4uU+QDynWYxQm3s93n3Vo2kNscg1qCA/jEOXhpn0KRMltS+yof86coLiEJVRxefa
        2Wnii5T4ZT0rGcbB6wSNOgECde/Iot4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-9SV0cg8SNOC7Xam8F3SPyA-1; Mon, 17 Jan 2022 12:45:40 -0500
X-MC-Unique: 9SV0cg8SNOC7Xam8F3SPyA-1
Received: by mail-wm1-f71.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso293846wmb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g4GDA0IUvWhhcky7T0HTZUXu5KWeN95yhvrj+pk935s=;
        b=CvQWL7JQKTNaiKr/OaG/E/kEAzBQeZcogcBvhrcx9Oza3mVn0kglw1CclCUGvPjOEq
         RPOTQyNmeymMwoiiJ/kiwYH8u3nuB7WvYDhJhohVlQpezqMPfIfOZdO2n2gwasJ3fsF+
         bh1+WGl3eD9DKLJSRrQVII0YA/7N6KD2K/QRvctOV1sM7K71bkAbg9V4Phk+v20I8HWD
         k81u+i7+aYWTA6+HWAX/72Igdm1VAQ5/NxnCipqFD3c0VSImDmjI/dZEj69otKiKJalC
         n6KZDuCE8MlYToA6EoqwaEEZ7fFebfx3usx04jMksiqCI5O0ajLhEcGnji9WrNYS0aQ+
         b56Q==
X-Gm-Message-State: AOAM530799NbbV7E/5MfdIv5Bzo2Q3tMLUvDf8eDzSdyeqHeMPhSbjEO
        ZXH7RwOcsxuMBG+Hq4somunTFSEyqbJ9HsLJZQNdMOLA3HwcSxNSd+78AGtleD5AHwuS9bmwI1F
        oEdm4+V+gHj26kaQjXavBBnlL
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr19867266wrh.48.1642441539524;
        Mon, 17 Jan 2022 09:45:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgkvq3SKcG5Ln75eIGYRH0iLxGvcr0OxQQNkLYP5yKBD5lv8kPaNE8lD0JUnmC89kdC/2UXQ==
X-Received: by 2002:adf:d0ce:: with SMTP id z14mr19867254wrh.48.1642441539309;
        Mon, 17 Jan 2022 09:45:39 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r15sm40119wmq.3.2022.01.17.09.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:45:38 -0800 (PST)
Message-ID: <8aa0cada-7f00-47b3-41e4-8a9e7beaae47@redhat.com>
Date:   Mon, 17 Jan 2022 18:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/5] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        david@redhat.com, frankja@linux.ibm.com, frederic@kernel.org,
        gor@linux.ibm.com, hca@linux.ibm.com, imbrenda@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paulus@samba.org, paul.walmsley@sifive.com,
        seanjc@google.com, suzuki.poulose@arm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220111153539.2532246-1-mark.rutland@arm.com>
 <127a6117-85fb-7477-983c-daf09e91349d@linux.ibm.com>
 <YeFqUlhqY+7uzUT1@FVFF77S0Q05N>
 <ae1a42ab-f719-4a4e-8d2a-e2b4fa6e9580@linux.ibm.com>
 <YeF7Wvz05JhyCx0l@FVFF77S0Q05N>
 <b66c4856-7826-9cff-83f3-007d7ed5635c@linux.ibm.com>
 <YeGUnwhbSvwJz5pD@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YeGUnwhbSvwJz5pD@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22 16:19, Mark Rutland wrote:
> I also think there is another issue here. When an IRQ is taken from SIE, will
> user_mode(regs) always be false, or could it be true if the guest userspace is
> running? If it can be true I think tha context tracking checks can complain,
> and it*might*  be possible to trigger a panic().

I think that it would be false, because the guest PSW is in the SIE 
block and switched on SIE entry and exit, but I might be incorrect.

Paolo

> In irqentry_enter(), if user_mode(regs) == true, we call
> irqentry_enter_from_user_mode -> __enter_from_user_mode(). There we check that
> the context is CONTEXT_USER, but IIUC that will be CONTEXT_GUEST at this point.
> We also call arch_check_user_regs(), and IIUC this might permit a malicious
> guest to trigger a host panic by way of debug_user_asce(), but I may have
> misunderstood and that might not be possible.

