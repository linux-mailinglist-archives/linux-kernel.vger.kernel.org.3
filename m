Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C268E4846B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiADRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbiADRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641316217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLTIaY5gg/CGkjyFI0nVD1Ynp1qrSv98dwVoxTGL/gk=;
        b=Cw7HN3Rir7v0VIG3xMuVwuOsWwK5O2hiBFpQJIAJhwKOVZ1QqClc8V7UzC8kf7ZgFxJ+su
        jQSS/g9nBD9UtQEijAunsYiAscU74ZwdTABSh8dM1TDTDq3hY58vwwtNqenayvNpT8wvZr
        1z4q2ilXd/HMtEPeeCib8B5lMvrMwhk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-ZasE3F_7PBe7FswaXiWtDA-1; Tue, 04 Jan 2022 12:10:16 -0500
X-MC-Unique: ZasE3F_7PBe7FswaXiWtDA-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a05600c511200b00345c1603997so8199951wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 09:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PLTIaY5gg/CGkjyFI0nVD1Ynp1qrSv98dwVoxTGL/gk=;
        b=i/RLbrM7jlrpfnhnKiaS6ZAxczz3ZZr7xaVSK4feOhouA0pcyYviMZnVsPI+e2442x
         fKtuP/UFLrvnfu1/6glX5ZXu12sxt0HYu1zpL1TLuDg8ibnn05HtCRFhkkO+7sXcylFE
         rZ1xgX311KbNrbA2PiVq6cZWvDLY7SN/HqWtHfrWBHNIq7hvGgh+zf2cqk4mUnV2X7Ee
         9gnmSUUz8E+z2yH4DsPmXv4AM26zJdT+HTHXGuwE0EL1+s5OsVvn5P39NI0fotw3xkYz
         7+jtwMYbzTaS8Fg9j08VmyHLar80Usu6j7ACrYLCPG/u1Ja3Aq2tMbMX46QjBPDDJmR5
         6xmA==
X-Gm-Message-State: AOAM530irluBofGy+a2pJakjMDPZLeoCvDZLUhVQWRz6CI7nQCUrwISk
        KM89qqfVHUh0WHheIWVD5yiKDnEbuqlSpcAtO/b17fJMid+mekTcjXe8Jqn3t5nJp22WzTD+EV0
        EsLnCcsih6urQEC1ROsBJWEev
X-Received: by 2002:a17:906:9f01:: with SMTP id fy1mr6911392ejc.475.1641316202908;
        Tue, 04 Jan 2022 09:10:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg4c8oC/snOnarWsLYe2OuhHx3dyq7Vui9X2KCh4F+Gwu3wSidctLFczPe7rbJzItTjhvIEQ==
X-Received: by 2002:a17:906:9f01:: with SMTP id fy1mr6911372ejc.475.1641316202670;
        Tue, 04 Jan 2022 09:10:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id w17sm14932963edu.48.2022.01.04.09.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 09:10:02 -0800 (PST)
Message-ID: <b8e273bf-ae2c-cc5c-0d20-33f3dd12053c@redhat.com>
Date:   Tue, 4 Jan 2022 18:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        paulmck <paulmck@kernel.org>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
 <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
 <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
 <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
 <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
 <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YdR4N9QVYOzjowAb@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 17:39, Mark Rutland wrote:
> My main issue here was just that it's really difficult to see how the
> entry/exit logic is balanced, and I reckon we can solve that by splitting
> guest_{enter,exit}_irqoff() into helper functions to handle the vtime
> accounting separately from the context tracking, so that arch code can do
> something like:
> 
>    guest_timing_enter_irqoff();
>    
>    guest_eqs_enter_irqoff();
>    < actually run vCPU here >
>    guest_eqs_exit_irqoff();
>    
>    < handle pending IRQs here >
>    
>    guest_timing_exit_irqoff();
> 
> ... which I hope should work for RISC-V too.
> 
> I've had a go, and I've pushed out a WIP to:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/kvm/rcu

Yes, you have a point and it makes sense for x86 too.  You can send me a 
topic branch once you get all the acks.  Thanks!

Paolo

