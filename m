Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6276A463263
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhK3LcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232569AbhK3LcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638271725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yZqFBMQmU1IhB8ncRVftJNI3p0Vlo844LTlyhHxLazk=;
        b=a9FOmUg1Ua4kXJbIV/r82QPhfzwW4tnJLsIHyvXHuV7gmL2L0n7AQ26O/UpQualuoybBlk
        ruAh202Q81bKEY67fwrMX/CZ54hyTkY/39VKxX6u1fX2asjWC7VZ4p/XFD4/azKjFAYOsv
        8foMGAPouAat7EJJrGsoalOEPcf6CUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-wvBmXMWyOM6VGRo_8H_KSw-1; Tue, 30 Nov 2021 06:28:43 -0500
X-MC-Unique: wvBmXMWyOM6VGRo_8H_KSw-1
Received: by mail-wm1-f69.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso12692440wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=yZqFBMQmU1IhB8ncRVftJNI3p0Vlo844LTlyhHxLazk=;
        b=X2IkX1e7nxinpkTxIyIXmaRfnfCsTLEKYJs8VeowuhsaebNStNdQMUI1SyyP5j/R0I
         +E+geK7+9vuLGfkFFAi/21vVERkW8g3Pf2tEbe81uA2SwoCHr9K6PVHK58gk2g4dPoMT
         8/VN+HzckeGOteQLPFTKEUj4HVXIKqGNsXZ5ZOYuPIDP86TOZ/lNDz6TmGNV+bd/f6tD
         FqVpYstTpusTOuCNL28uNPKdlwbTGWcCAD+87W6AMuXK9mgCQ+tBlnkLk/7+xPqs2nwj
         TIKey4WkQWlCzHbdKapl+sjYIUqA9HP2wElY0oSzm8o0KVeyt+V8KxsaE2zLZEq52L8u
         btqg==
X-Gm-Message-State: AOAM530eToY/LhojuzQIeYeO1Uh4r1Gsc/UwWdmnVHaeC/zA0lHg046J
        aMTzVkD03xjSB4OPJuZHdyHpCvqu9Yiy+x0yUxK3zlmGXMFJsyjTvQIX8m/RzJhBX3rMgusIoiG
        q9ELa5DH2wzn8wIXMiDPt+/upQfdlAeMUZeQMltDGyqfjHGYfbeKBSAChQmXyuy/Ii4Z0D4F55G
        pf
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr4254410wmp.46.1638271722560;
        Tue, 30 Nov 2021 03:28:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/9GrALUeaBbvZUBckwc79sI7gw19bJw72Npbegb+eXE0pVIKTWiKgjhI8d3++hkKkU2yZJw==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr4254381wmp.46.1638271722371;
        Tue, 30 Nov 2021 03:28:42 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id k37sm2413311wms.21.2021.11.30.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:28:42 -0800 (PST)
Message-ID: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
Subject: Question WRT early IRQ/NMI entry code
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>
Date:   Tue, 30 Nov 2021 12:28:41 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
while going over the IRQ/NMI entry code I've found a small 'inconsistency':
while in the IRQ entry path, we inform RCU of the context change *before*
incrementing the preempt counter, the opposite happens for the NMI entry
path. This applies to both arm64 and x86[1].

Actually, rcu_nmi_enter() — which is also the main RCU context switch function
for the IRQ entry path — uses the preempt counter to verify it's not in NMI
context. So it would make sense to assume all callers have the same updated
view of the preempt count, which isn't true ATM.

I'm sure there an obscure/non-obvious reason for this, right?

Thanks!
Nicolas

[1] 
IRQ path:
  -> x86_64 asm (entry_64.S)
  -> irqentry_enter() -> rcu_irq_enter() -> *rcu_nmi_enter()*
  -> run_irq_on_irqstack_cond() -> irq_exit_rcu() -> *preempt_count_add(HARDIRQ_OFFSET)*
  -> // Run IRQ...

NMI path:
  -> x86_64 asm (entry_64.S)
  -> irqentry_nmi_enter() -> __nmi_enter() -> *__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)*
                          -> *rcu_nmi_enter()*

For arm64, see 'arch/arm64/kernel/entry-common.c'.

