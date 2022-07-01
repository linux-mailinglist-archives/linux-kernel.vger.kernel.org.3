Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822C562D88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiGAIMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiGAIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B6A070AE2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656663151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/AmvOZyV6QrDA7wpE31jhK9NIwk6H7+U8kbekS2CX4=;
        b=iUnRAoNiE1KAFhHRNCnNfvZyABa3m+0Ahijql50R4Z6WNDv1n2BLeMQ+zCfl30BK+My5/s
        LWiBd9Ia7MLktE5wY7ybb+y0+FRgW2Jbk1t/EEDAYLf0toDeNTB4xacDXUkxJ17FeMe1lz
        GtCRPEFY3WTB2UUxb2XBDoOy3NEaOS8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-zmlOjAhUNjq3momEdVCf8g-1; Fri, 01 Jul 2022 04:12:30 -0400
X-MC-Unique: zmlOjAhUNjq3momEdVCf8g-1
Received: by mail-wm1-f72.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so1028940wmp.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z/AmvOZyV6QrDA7wpE31jhK9NIwk6H7+U8kbekS2CX4=;
        b=OcmB32I6+8GxN6XezQUiVP/92GIrVCg8ypTy+v8RSIqx0RgEBn3p52c9YXbiPlo4uw
         6p3UksTEJ0pVHe/PXIG3yI33a6rybes1JEioJTvZFWZVdT5pWc8aoCdnSzALNWOWkex4
         2NP77rfMj5tqqxs6M92bcL4c8A7OASOGEi74jYtO5cnDFV8VPq9EmJmdISYHB895KpXI
         ZzbmzXSILgVE9T7N7M95Ycdxba3P+/lTkGhEthkcVMvoH0zAlTtx+OUuGiegknbz7SLf
         /DKhDakbWcfRvhy7avmk9Y2NmFUJz4c8dQufhViMjbUIAnEol09ff634Ykl8QEFNh+VU
         yL1g==
X-Gm-Message-State: AJIora+DC931WL6+6dA53V1FiY7S6JSqotqhMKAlx5w8/GfXVNJnU/iD
        2EEWPh8Lqdov5mDkIDIz7qXnnawkKTCTaPm2Rh6rRPL4whNqZzB7XbhioXVkWinDyBjmXl6NndV
        lubpYXth6qdxSukpgLaNYuA7kfvHRWr60xIZFn2qugZP5NNBlD4TtoKsPcNN8W8gdZeNrf+UdNI
        ly
X-Received: by 2002:a5d:48ce:0:b0:21b:9f34:f297 with SMTP id p14-20020a5d48ce000000b0021b9f34f297mr12409459wrs.351.1656663149041;
        Fri, 01 Jul 2022 01:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uPWo0xmhO7Sqt29ZDdDqBVBiI91YlLkKsb9zDgKgODfne6Ky2CuYV/YqnDSO9FRwIJuR4dlQ==
X-Received: by 2002:a5d:48ce:0:b0:21b:9f34:f297 with SMTP id p14-20020a5d48ce000000b0021b9f34f297mr12409431wrs.351.1656663148790;
        Fri, 01 Jul 2022 01:12:28 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b003a03e63e428sm7220233wms.36.2022.07.01.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:12:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/28] KVM: VMX: Check
 CPU_BASED_{INTR,NMI}_WINDOW_EXITING in setup_vmcs_config()
In-Reply-To: <CALMp9eSTv8e5=vwXRouhLubx8k6q9sH4X8z0CgFsKTv54VFdSA@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-16-vkuznets@redhat.com>
 <CALMp9eSTv8e5=vwXRouhLubx8k6q9sH4X8z0CgFsKTv54VFdSA@mail.gmail.com>
Date:   Fri, 01 Jul 2022 10:12:27 +0200
Message-ID: <87edz5s13o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> CPU_BASED_{INTR,NMI}_WINDOW_EXITING controls are toggled dynamically by
>> vmx_enable_{irq,nmi}_window, handle_interrupt_window(), handle_nmi_window()
>> but setup_vmcs_config() doesn't check their existence. Add the check and
>> filter the controls out in vmx_exec_control().
>>
>> No (real) functional change intended as all existing CPUs supporting
>> VMX are supposed to have these controls.
>
> I'm pretty sure vIrtual NMIs and NMI-window exiting are not available
> on Prescott or Yonah.
>

I seemed to have questioned their existence :-) But you're right, I
should've said something like "all CPUs supported by KVM" instead (as
pre-patch KVM toggles these controls unconditionally).

>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

