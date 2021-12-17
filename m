Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE7479155
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhLQQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239024AbhLQQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639758024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeSLiX88ywUnJSn3OPy2dA6dAW/L5+XCxa+K1ZsSMkg=;
        b=NOw0MKAnc0pj9/G80WgJMwBpp8NVc+QKkyUM7G66odslwzBeYnP3Q7pUbc/pAUbqnzbtAw
        fJO+d2d2prpFVY4pFUuxR3DLhpSGDYPq2Lqy1Oj2WVDO0+FHLLU62MEEAcO+sP9zVqzve6
        MKyalSIiDubC1LQmQZSNc/tbxIRehTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-JvYMVebiO9ywliTTVI2F0A-1; Fri, 17 Dec 2021 11:20:23 -0500
X-MC-Unique: JvYMVebiO9ywliTTVI2F0A-1
Received: by mail-wr1-f70.google.com with SMTP id r7-20020adfbb07000000b001a254645f13so711265wrg.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yeSLiX88ywUnJSn3OPy2dA6dAW/L5+XCxa+K1ZsSMkg=;
        b=m7vxWc+IzjAE8Asm2BaW43nGHXCCFMyJMGPnD99GTRAlCmXHlLLNe+Azd9FBwYPER3
         3WmS5m12N5PSDk5SF8PCp8wU0F1el7eahzX9RT3HpHetvSKslpNnqlGX18n8n1bZf5IQ
         yNimJYw8hR2m0+7OQE6Umxk1L4FUh0/bxVPBpriwLAi8ujefUor+s8zY9QT95RkhZrSm
         finXTLlq+ty+3AnmnheOl0zjHe/DUpRBhta3OO6+eCdQSLYQjG0CT23pkW+K6bla90cd
         pfMGRvKRVaGMPQa9JeNNqZlmRbbLNGJKPeaDddzhYQS2WeuHzeRP07kuyPeQAYUGUr04
         dzhg==
X-Gm-Message-State: AOAM5310/HVjvzwJDp4qu0Le+GHhLz8F6NZxtrwAJbevMxaSFpGG3Uow
        4n1qGvF6+J4J5pHo13MsLjJPyG6wQNG3DvA4wRxLEL/rFiulRdD+fpvMTCQwovc9LWMEPIi70RT
        tTt8AGBZozBuEd6JS711cngD1
X-Received: by 2002:a5d:6483:: with SMTP id o3mr3128435wri.634.1639758022084;
        Fri, 17 Dec 2021 08:20:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwk2ba7Tbij6WYWb1HqhmTZxhP9T+f29JbPI5KYAluKtYZQtdJHeX0aXwhZAJkm79KXnc0PuQ==
X-Received: by 2002:a5d:6483:: with SMTP id o3mr3128421wri.634.1639758021885;
        Fri, 17 Dec 2021 08:20:21 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3511:9200:f938:102b:34c2:d5db? ([2a0c:5a80:3511:9200:f938:102b:34c2:d5db])
        by smtp.gmail.com with ESMTPSA id b10sm8204839wrg.19.2021.12.17.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:20:21 -0800 (PST)
Message-ID: <27231550b5600072da918aa41c07404dea13590e.camel@redhat.com>
Subject: Re: Possible nohz-full/RCU issue in arm64 KVM
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     paulmck@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, maz <maz@kernel.org>,
        frederic <frederic@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 17 Dec 2021 17:20:21 +0100
In-Reply-To: <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
References: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
         <YbyO40zDW/kvUHEE@FVFF77S0Q05N>
         <70f112072d9496d21901946ea82832d3ed3a8cb2.camel@redhat.com>
         <Ybyg1r/Q6EfeuXGV@FVFF77S0Q05N>
         <9ab8107f-ff41-6a9e-57e1-a261bea93aca@redhat.com>
         <20211217160749.GS641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, 2021-12-17 at 08:07 -0800, Paul E. McKenney wrote:
> On Fri, Dec 17, 2021 at 04:54:22PM +0100, Paolo Bonzini wrote:
> > On 12/17/21 15:38, Mark Rutland wrote:
> > > For example kvm_guest_enter_irqoff() calls guest_enter_irq_off() which calls
> > > vtime_account_guest_enter(), but kvm_guest_exit_irqoff() doesn't call
> > > guest_exit_irq_off() and the call to vtime_account_guest_exit() is open-coded
> > > elsewhere. Also, guest_enter_irq_off() conditionally calls
> > > rcu_virt_note_context_switch(), but I can't immediately spot anything on the
> > > exit side that corresponded with that, which looks suspicious.
> > 
> > rcu_note_context_switch() is a point-in-time notification; it's not strictly
> > necessary, but it may improve performance a bit by avoiding unnecessary IPIs
> > from the RCU subsystem.
> > 
> > There's no benefit from doing it when you're back from the guest, because at
> > that point the CPU is just running normal kernel code.
> 
> Do scheduling-clock interrupts from guest mode have the "user" parameter
> set?  If so, that would keep RCU happy.

Are you referring to the user_mode() check in irqentry_enter()? If so I don't
think it'll help, arm64 doesn't use that function. It directly calls
enter_from_{user,kernel}_mode() through its custom entry/exit routines.

Regards,

-- 
Nicolás Sáenz

