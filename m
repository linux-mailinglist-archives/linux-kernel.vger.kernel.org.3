Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADABF4A61F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiBARKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240134AbiBARKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643735440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEVNkKCbHNsoRZio7QbHHHdj6sVhTp1ERvduRi68G80=;
        b=ZqnopwJ8zLyAB/3xdPV93IQD5bMiWDqpCiMiWa8tpQVwO5cFK/QUwn/bJZoYjL2Ll5CCmY
        GRT+Y0/uV0GDt0PRzmJCN4+qYAkxG4tgECJdafCnsE1IVw2eFxL4bOHpGZ0q6put7Qm+ho
        uGdgzcmMXgSzTAUwRErnBPBhR5FjOJ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-fPgP0uWuPkm36HzKHoEYlA-1; Tue, 01 Feb 2022 12:10:39 -0500
X-MC-Unique: fPgP0uWuPkm36HzKHoEYlA-1
Received: by mail-wr1-f70.google.com with SMTP id l22-20020adfa396000000b001d8e6467fe8so619503wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HEVNkKCbHNsoRZio7QbHHHdj6sVhTp1ERvduRi68G80=;
        b=jXepsdVuzEuTbLzZwqT/VAROL6nBVGgnJp+MRQZ23k6fwMitLjmfRZqOrYDAgPknhv
         9kS6svta+ymsUaB/L1CX3IzRveXkMMscRJW5gq90L65GTouzM5XDWVzKQx/h6vhYI/WB
         tfFO+i4jBG1/rYT79TRzG+Zuai5EE6p4lWCfGnmviEJ/PFGaTw98ox9878AvcgwwYBEi
         SrLtiZR5MdFU46qDb6ox0dlbsBdqC6nirB+HMyiODasN3woAZdZfefyRXPXh1RJ/tVHJ
         El7nbHfzqPnPyYTaNRCQQct9b/XMNPj1nMeG9iaLAkJUppchBzAFHEMtISvrDYc8nC0x
         zMjw==
X-Gm-Message-State: AOAM530QLEYaep1TSJK3YFJ4Ybnk2ZY6I9dfk6m6lP5PhpGSvSMC4Yc6
        qCtGT1rZHvTOIH7jD6I+b46x68J6M2Za3F8w2bX25WfFuRWLesbI4tr4/tmmR4TnB1zG2oHYSCz
        N31uaMyBWlE1Cu7lw6zTd9+/G
X-Received: by 2002:a5d:584a:: with SMTP id i10mr22335721wrf.305.1643735438634;
        Tue, 01 Feb 2022 09:10:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgD/z3iBdu65HEErOV/81d5kpd1JUezr2MJZPHfQ+M/3yuV5A/oGB8uKnV0q2JOEgF1YHjUg==
X-Received: by 2002:a5d:584a:: with SMTP id i10mr22335673wrf.305.1643735438392;
        Tue, 01 Feb 2022 09:10:38 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id q13sm15472852wrd.78.2022.02.01.09.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:10:37 -0800 (PST)
Message-ID: <c1371392-70ff-0a14-68cd-aa253998d271@redhat.com>
Date:   Tue, 1 Feb 2022 18:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/5] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@atishpatra.org,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paulus@samba.org, paul.walmsley@sifive.com,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220201132926.3301912-1-mark.rutland@arm.com>
 <87aa8af0-c262-ad04-58f8-da6c7882e23c@redhat.com>
 <YfleTYWIW1sBbMNn@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YfleTYWIW1sBbMNn@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 17:22, Mark Rutland wrote:
> On Tue, Feb 01, 2022 at 04:59:47PM +0100, Paolo Bonzini wrote:
>> On 2/1/22 14:29, Mark Rutland wrote:
>>> I've pushed the series (based on v5.17-rc2) to my kvm/entry-rework branch:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/entry-rework
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework
>>
>> Thanks!  I cherry-picked the basic, x86 and mips patches to kvm.git's master
>> branch (I did not use your branch in order to leave arm64 and riscv to the
>> respective maintainers).
> 
> Since everything's dependent upon that core patch, IIUC that's going to make it
> a pain for them to queue things.
> 
> How are you expecting the arm64 and riscv maintainers to queue things? Queue
> their own copies of that core patch?

The kvm.git master branch has a stable commit id, so the KVM/ARM and 
KVM/RISCV maintainers can just base their pull request to me on it. 
Alternatively, if they prefer it that way, I can get it quickly to Linus.

Paolo

