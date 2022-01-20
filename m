Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB29494CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiATL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbiATL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642678094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6qeG5JMe+t7+z8JXLCS4Q97k5j0AmGEKqfbALm6D9s=;
        b=OhZkRmCRU14b8vIVxcS3grH8EQEElaz2/flddq8+qdgXPl3a+Dn2leTrAfi8TSCfMUIGYg
        0BhpNtdh5QDKLgUbgzEoSfGGcczZF07RUqnYx2SrUErX6lJqwz9ZgNRiF4fYU3S8Zz0HDw
        WGX6XK9bQHL1GY9ieffrHHBt9wOxHFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-fo0FIRhyM32kLz2NJiQO9w-1; Thu, 20 Jan 2022 06:28:13 -0500
X-MC-Unique: fo0FIRhyM32kLz2NJiQO9w-1
Received: by mail-wm1-f72.google.com with SMTP id s17-20020a7bc0d1000000b00348737ba2a2so3878272wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q6qeG5JMe+t7+z8JXLCS4Q97k5j0AmGEKqfbALm6D9s=;
        b=5/NeGMuBlF1ldn3sO1FAjMygGgG7NPZwH1IdVB8QN0dsakdQ6YXoNed6yTlc6PXsLW
         nqmzOSccUyDyPd3bCEuzqcjalBaXyyptPUn0zP/xRUpjcKtrpgB3y+hpr/4yTuinozCB
         P97f/5WvcSO8INSJkfHlgeH0iyvojAja806Q6/9i5NhaLUFzxxZt2kxsVGyEvkGVHp8b
         XK4bm3Ll49hGrwvjUBOr5v1TgCDSA/AWUOiAGbSM+d6td2sRqeqccVF5xhYOUIhrO7cN
         4mMWzs//XV1pk687BuLv9XcPQ793JkQz7GnEM6ftplCVYmZACSpcUpKY0EOk80BHtC6U
         VjOg==
X-Gm-Message-State: AOAM531tcB/aTKIawYom/uYHnj+WW7Ve2rzs2I7cN8W23S2gDe0x+Cmn
        lSG8aLFhHopXiYKPEUpmCcSYvuYsam+jLu01jh4zo63ttbs0K0xInQ+02+ehp1nd/InN0ZGvoVb
        o6Lk/K72Mx8N5uK5JkGcSaJW4
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr8294084wms.45.1642678092369;
        Thu, 20 Jan 2022 03:28:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZghi1ffmPgh1ii0PBQ0LoK1VH/aBjfHfCpuRYc76BJGR2/yUaAyzSlMsK9JJQb6/eogoqPA==
X-Received: by 2002:a05:600c:3ac5:: with SMTP id d5mr8294041wms.45.1642678092145;
        Thu, 20 Jan 2022 03:28:12 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id 8sm3095771wrz.57.2022.01.20.03.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:28:11 -0800 (PST)
Message-ID: <2688b779-9cb8-b6ea-f8cc-93bc8ddf72f3@redhat.com>
Date:   Thu, 20 Jan 2022 12:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frankja@linux.ibm.com,
        frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220119192217.GD43919@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 20:22, Mark Rutland wrote:
> I wonder, is the s390 guest entry/exit*preemptible*  ?
> 
> If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
> things before a ctx-switch to the idle thread, which would then be able
> to hit this.
> 
> I'll need to go audit the other architectures for similar.

They don't enable interrupts in the entry/exit path so they should be 
okay.  RISC-V and x86 have an explicit preempt_disable/enable, while 
MIPS only has local_irq_disable/enable.

(MIPS is a mess of dead code, I have patches to clean it up).

Paolo

