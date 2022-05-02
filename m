Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA151741A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbiEBQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbiEBQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC681E0E2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651508324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dVu3cda9e/DnYte+PR82A6GQffK3GwvS8zB8AzhqgM=;
        b=XDjtYSAVJx5OvQ1xRhWtTU6DfTZ6QGN6P7pZJbfo2TXSeBnYt+6JVyuQaUyP+pY7Zvks0v
        fBZrmbCfBbaO91EwfFuMY8O2I9TiEAdK0N24xxoAM8Qtq0Wj55JZ3aosDAvB9E0TtR7YBk
        RO4AmJuBX9Jijivp3lkxHIsAGhAycv0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-fLs69EbMOpm2VWTsXsFL0Q-1; Mon, 02 May 2022 12:18:43 -0400
X-MC-Unique: fLs69EbMOpm2VWTsXsFL0Q-1
Received: by mail-ed1-f70.google.com with SMTP id co27-20020a0564020c1b00b00425ab566200so8973172edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3dVu3cda9e/DnYte+PR82A6GQffK3GwvS8zB8AzhqgM=;
        b=Ydea1q+383WKWmLdqaU6J5eH2B6puHD+WIK5la3fNTMzZi1HzAM1zZHmFGNaakGn92
         VdZrcQBY0g9LAs/mCSkCnyPtosNfd7UggDF8/L9cDGMsdu6k5Fwz9jkkwkqEf5myDReG
         rY9F/VSSvTklfEKrm2htbIwNv7GcC1qn3IS6+47lkcPx8ycjRSIwHb4Pn7zo2MVMm+HB
         wtWQ6KfT03AGv23R6G5M8Wp6pgcyK+eZStjBeOqGUwGjlG3uEN6lpFszXdsQx3tRo74d
         p55KdL/ZMSvCOWoB/f8CQ6rxACFn08yo2b7sLRbGks2XGsOAU8tkfmKix5U9OCtVmLHF
         kpjg==
X-Gm-Message-State: AOAM532+V5Yh+a2TiSArF0S/YiStaN44Pv9C+f/5v1tVJD5GFJIc3kYI
        b+DthRugcfsE96qH/cVG6jfnb8WA8Q5v0sQbUHC9gKD56YuG7q54QvvjxVVpTVGK8C9khipkyUN
        KwSHTVpcJdOjaKDthfYNKL9yi
X-Received: by 2002:a05:6402:26d3:b0:427:c590:ae2 with SMTP id x19-20020a05640226d300b00427c5900ae2mr6411903edd.242.1651508322599;
        Mon, 02 May 2022 09:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWgTBRsmtnOix2xpdyet9Fkn61dhyjd3l0nRwiruGKfjGoLdFiy8arkd3UVa1l1da3QF9yVg==
X-Received: by 2002:a05:6402:26d3:b0:427:c590:ae2 with SMTP id x19-20020a05640226d300b00427c5900ae2mr6411867edd.242.1651508322335;
        Mon, 02 May 2022 09:18:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id t26-20020a05640203da00b0042617ba6383sm6791879edw.13.2022.05.02.09.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 09:18:41 -0700 (PDT)
Message-ID: <2d33b71a-13e5-d377-abc2-c20958526497@redhat.com>
Date:   Mon, 2 May 2022 18:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Zeng Guang <guang.zeng@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Robert Hu <robert.hu@intel.com>, Gao Chao <chao.gao@intel.com>
References: <20220419153155.11504-1-guang.zeng@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v9 0/9] IPI virtualization support for VM
In-Reply-To: <20220419153155.11504-1-guang.zeng@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 17:31, Zeng Guang wrote:
> Currently, issuing an IPI except self-ipi in guest on Intel CPU
> always causes a VM-exit. It can lead to non-negligible overhead
> to some workloads involving frequent IPIs when running in VMs.
> 
> IPI virtualization is a new VT-x feature, targeting to eliminate
> VM-exits on source vCPUs when issuing unicast, physical-addressing
> IPIs. Once it is enabled, the processor virtualizes following kinds
> of operations that send IPIs without causing VM-exits:
> - Memory-mapped ICR writes
> - MSR-mapped ICR writes
> - SENDUIPI execution
> 
> This patch series implements IPI virtualization support in KVM.
> 
> Patches 1-4 add tertiary processor-based VM-execution support
> framework, which is used to enumerate IPI virtualization.
> 
> Patch 5 handles APIC-write VM exit due to writes to ICR MSR when
> guest works in x2APIC mode. This is a new case introduced by
> Intel VT-x.
> 
> Patch 6 cleanup code in vmx_refresh_apicv_exec_ctrl(). Prepare for
> IPIv status dynamical update along with APICv status change.
> 
> Patch 7 move kvm_arch_vcpu_precreate() under kvm->lock protection.
> This patch is prepared for IPIv PID-table allocation prior to
> the creation of vCPUs.
> 
> Patch 8 provide userspace capability to set maximum possible VCPU
> ID for current VM. IPIv can refer to this value to allocate memory
> for PID-pointer table.
> 
> Patch 9 implements IPI virtualization related function including
> feature enabling through tertiary processor-based VM-execution in
> various scenarios of VMCS configuration, PID table setup in vCPU
> creation and vCPU block consideration.

I queued it, but I am not going to send it to Linus until I get 
selftests for KVM_CAP_MAX_VCPU_ID.  Selftests are generally _not_ 
optional for new userspace API.

Please send a patch on top of kvm/queue.

Paolo

