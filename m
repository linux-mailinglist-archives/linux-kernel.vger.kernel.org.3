Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49E051C1B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380303AbiEEN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380280AbiEEN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:56:50 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 024E957B18
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651758751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tg+1N9l4/UGQjj1ui3wLc+7zUF5Zg5FliDgij7q2A5E=;
        b=NUpWL2Zd/ZLsWoIrzidnJV/jQ78+QfAVy9hLlEgEWqBPtltpQpnrIS7ePABJKbpAVhotto
        4wdQdDA0VL3EWd/hsXVu+uxLWHJeV9QZxCixkUQaNA5Pl4YlaNPJQwofHYVLoc5bRsm7qr
        ViKuDRCfuRBLxNPHXHY82CyXm4sHums=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-zp5FCNGgPK-AtHxsyktbOg-1; Thu, 05 May 2022 09:52:27 -0400
X-MC-Unique: zp5FCNGgPK-AtHxsyktbOg-1
Received: by mail-wr1-f69.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso1487878wrd.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 06:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tg+1N9l4/UGQjj1ui3wLc+7zUF5Zg5FliDgij7q2A5E=;
        b=zqq2911aqfu64y6xakEDE351D/g49+1pifGKnzysOLiVLOJ7Si0UQDFx/Ys4NG4Swa
         MwMgs2V7b4JAxdmDzN+XCCOFn0p2/2pBZKzy5e0qf2eVpvJuHWWdCpNkrPhVG0pF9VLN
         wDX6P4U6fMhjo/AVO8I0ubizpNpgIY5hbK5Ce8KJxCe7To7dQuE1MqgAy7l/o9LNbJno
         jWRvmUVE5twwnb+pS5EllIZVRQizA1rWsFM8JiSVyuh98PSM8zvNJn8ABFQqLTJbALEP
         gUbRhxDJkqj3fwuTDQjuPbp25bQpGPw+LOmj9gzOlEJ1bMZvE9JB2gciyvb09s/hdAqG
         gl7w==
X-Gm-Message-State: AOAM531trp2jatdlObsgjlDnn8Eqc40dj4QjBnwTgEtF3lUYrqFy9+7a
        TYtvuVvl1DgFMLoyi9YHN/ZAqKlk2TvYj/15tG7aAYkHAQJTthKP5DZAAa5GyYE4uGHOtuEIIPQ
        T+ijLEg4XueA8ndbtRR+YbC5z
X-Received: by 2002:a05:6000:136b:b0:20a:c416:e914 with SMTP id q11-20020a056000136b00b0020ac416e914mr21083123wrz.167.1651758745994;
        Thu, 05 May 2022 06:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1N1cypAPDCQRCuIrBe7oEloHiYyuU7KVpyywETK6PeLOX9U0Cef0xV1mmkI0idV7FnO+yfQ==
X-Received: by 2002:a05:6000:136b:b0:20a:c416:e914 with SMTP id q11-20020a056000136b00b0020ac416e914mr21083107wrz.167.1651758745771;
        Thu, 05 May 2022 06:52:25 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b003942a244ee9sm1410841wmc.46.2022.05.05.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:52:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Should arm64 have a custom crash shutdown handler?
In-Reply-To: <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
 <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
Date:   Thu, 05 May 2022 15:52:24 +0200
Message-ID: <878rrg13zb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> On 05/05/2022 09:53, Mark Rutland wrote:
>> [...]
>> Looking at those, the cleanup work is all arch-specific. What exactly would we
>> need to do on arm64, and why does it need to happen at that point specifically?
>> On arm64 we don't expect as much paravirtualization as on x86, so it's not
>> clear to me whether we need anything at all.
>> 
>>> Anyway, the idea here was to gather a feedback on how "receptive" arm64
>>> community would be to allow such customization, appreciated your feedback =)
>> 
>> ... and are you trying to do this for Hyper-V or just using that as an example?
>> 
>> I think we're not going to be very receptive without a more concrete example of
>> what you want.
>> 
>> What exactly do *you* need, and *why*? Is that for Hyper-V or another hypervisor?
>> 
>> Thanks
>> Mark.
>
> Hi Mark, my plan would be doing that for Hyper-V - kind of the same
> code, almost. For example, in hv_crash_handler() there is a stimer
> clean-up and the vmbus unload - my understanding is that this same code
> would need to run in arm64. Michael Kelley is CCed, he was discussing
> with me in the panic notifiers thread and may elaborate more on the needs.
>
> But also (not related with my specific plan), I've seen KVM quiesce code
> on x86 as well [see kvm_crash_shutdown() on arch/x86] , I'm not sure if
> this is necessary for arm64 or if this already executing in some
> abstracted form, I didn't dig deep - probably Vitaly is aware of that,
> hence I've CCed him here.

Speaking about the difference between reboot notifiers call chain and
machine_ops.crash_shutdown for KVM/x86, the main difference is that
reboot notifier is called on some CPU while the VM is fully functional,
this way we may e.g. still use IPIs (see kvm_pv_reboot_notify() doing
on_each_cpu()). When we're in a crash situation,
machine_ops.crash_shutdown is called on the CPU which crashed. We can't
count on IPIs still being functional so we do the very basic minimum so
*this* CPU can boot kdump kernel. There's no guarantee other CPUs can
still boot but normally we do kdump with 'nprocs=1'.

For Hyper-V, the situation is similar: hv_crash_handler() intitiates
VMbus unload on the crashing CPU only, there's no mechanism to do
'global' unload so other CPUs will likely not be able to connect Vmbus
devices in kdump kernel but this should not be necessary.

There's a crash_kexec_post_notifiers mechanism which can be used instead
but it's disabled by default so using machine_ops.crash_shutdown is
better.

-- 
Vitaly

