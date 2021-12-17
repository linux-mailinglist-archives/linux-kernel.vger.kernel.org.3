Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F7478A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhLQLwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230396AbhLQLwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639741920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VbaoBagpyxB2kBwkaE/GX54RBymyP3RskJ4qz0SPZ7M=;
        b=CBQ7f49XG5jg6NjgGa+UhhPuZP0tZ+Xe2DatfIfvtnloCvZgfMJFU65mIUIm+PZEL7x9GS
        6CS7wr1VcF6T72Al+TjjPqip4+dcYLnUuvvpCWTThSow8dY+9tYb3f/JUdF9G9E5ZDZqFE
        GOF2N9IHubpH4CEW9F7SONX/Nr3Iz70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-1C1lXVCqMQCX2TmQ5KX8kA-1; Fri, 17 Dec 2021 06:51:59 -0500
X-MC-Unique: 1C1lXVCqMQCX2TmQ5KX8kA-1
Received: by mail-wm1-f70.google.com with SMTP id p13-20020a05600c1d8d00b0034565e7e5c6so914989wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 03:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=VbaoBagpyxB2kBwkaE/GX54RBymyP3RskJ4qz0SPZ7M=;
        b=raPKfea4g+w4qbECwR3KGgoTQFQjJISgd041gjIXbXWjUAPN3z5z+dBxADGdgWSET2
         OHAL3CbWfcDJATM9/Jty5BHuozjv+k5aIYadarWO83ibAD85bDGYpTmFoaZlcgqGmT0T
         rZm8QUJJFEpoIg2w+tHxuuW03Hdg3imfuZISDtBpFnk8PKkhCJVPuTAAPCoJhrrRAEDB
         FJndjM1Mq9gCebi/66M8//z9PlvKtxvxZM+7HRHRKajKFwtfOV5scozKqSemEKSJbRwU
         ReZjhljk3Y3Bf9vnWREkQAaNL9YRP+MAlqYHGj0jrSjsHBBsFL+41z4W6ZnF5uWkZT3p
         PStA==
X-Gm-Message-State: AOAM533ZHrgzsytHcBxX+dlyZTov5TJg7sk6OUFBEkhZtOWMr6l1iqBd
        wEmLS6UItgZj8E4xRRf8v+5ZAU/1oCJgubQ6o9ICva0i4ebBQHHx+CY1R/DTK9NNA3JAhMO9dY/
        2uJmZ24zPHWk6X9/4y4AmmR9B
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr2256902wrt.208.1639741918359;
        Fri, 17 Dec 2021 03:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuWJ1oAUOR9ZdBi/KYt7RPzUDX8mfw0bBNc+p+s/E8DzmY72v3omfLECQ4vU+R5FsDQMAaaQ==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr2256884wrt.208.1639741918131;
        Fri, 17 Dec 2021 03:51:58 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3b0e:bd00:1099:cf34:d27f:de8a? ([2a0c:5a80:3b0e:bd00:1099:cf34:d27f:de8a])
        by smtp.gmail.com with ESMTPSA id f3sm7117441wrm.96.2021.12.17.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 03:51:57 -0800 (PST)
Message-ID: <d80e440375896f75d45e227d40af60ca7ba24ceb.camel@redhat.com>
Subject: Possible nohz-full/RCU issue in arm64 KVM
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>, maz <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu <rcu@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        frederic <frederic@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 12:51:57 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
arm64's guest entry code does the following:

int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
{
	[...]

	guest_enter_irqoff();

	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);

	[...]

	local_irq_enable();

	/*
	 * We do local_irq_enable() before calling guest_exit() so
	 * that if a timer interrupt hits while running the guest we
	 * account that tick as being spent in the guest.  We enable
	 * preemption after calling guest_exit() so that if we get
	 * preempted we make sure ticks after that is not counted as
	 * guest time.
	 */
	guest_exit();
	[...]
}


On a nohz-full CPU, guest_{enter,exit}() delimit an RCU extended quiescent
state (EQS). Any interrupt happening between local_irq_enable() and
guest_exit() should disable that EQS. Now, AFAICT all el0 interrupt handlers do
the right thing if trggered in this context, but el1's won't. Is it possible to
hit an el1 handler (for example __el1_irq()) there?

Thanks,

-- 
Nicolás Sáenz

