Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D538251815F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiECJoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiECJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1DB836E02
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651570749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Vl3zBaptlkLi2pN2YFgVBOvYXnkT8yd21wK9z5rSdc=;
        b=RoD2LUvWVjLcJ+TxPOMiJJusK8sAf3o6xv1wnJ33KxJADIssOKnJjxc3tg+J59Wo4u/Np7
        ilhNOK+r8E0zvbTG+2nYx07QiTmrDA3excn+dNTxtx1de5/XIqAfVohwNCNdP1wZiEQ3/f
        VRi1AAn+aNIoAlK7GcayDbl2JloZem0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-bTHVz4OzOEij_FIPh_Qdbg-1; Tue, 03 May 2022 05:39:08 -0400
X-MC-Unique: bTHVz4OzOEij_FIPh_Qdbg-1
Received: by mail-wm1-f70.google.com with SMTP id 26-20020a05600c021a00b003940660c053so5482896wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Vl3zBaptlkLi2pN2YFgVBOvYXnkT8yd21wK9z5rSdc=;
        b=4IazLuhhCPipEDLRdLhdkCNxbum2sbyS3BVwKp6OPl/eLIu+XYtR1cDjZJBjwJF7Cv
         F+9k75L8cH2zoXzAjZ/syhxOok1o6vtzRoE/+HhzFVMq5HmmfQGLHP63pZgcwJ6mXsBo
         /qRVm3YELggxBG7KwpQrctLZ8dxgqZbytBikzM7s+r0jJZ5Q2Erxfdp+65tUBA+PHld1
         0hwCSCqvtZDTs3so+D2yYaM3ChJQEoIlyVmft2mnsTAA/V/pvi6rHTfOVEWmECblv1gS
         pTlsMb8jMqHL8Z16FS+qGTqq5Z0CUkOipO1YqSUE3jDzWyJ5Ipg27pI9CZps7dMpq+ie
         dQGw==
X-Gm-Message-State: AOAM530vtPfvLl1OMqPU/HmuxG/z35ngxEnKe4sD+RPU9h2wR51cNAyD
        flvdEukphqM2d9wMgOKOxZwG01igUJqdGqHST8b5f5fqrQ2FU4xFlvaTHDeRy4RCh3ILNWkokTo
        DATiBYIcteavuhZjC/GVL8hwC
X-Received: by 2002:a05:6000:2a5:b0:20c:520a:a12e with SMTP id l5-20020a05600002a500b0020c520aa12emr11875129wry.629.1651570747248;
        Tue, 03 May 2022 02:39:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA6L/WATVBozXOB3fYrHpsCfnZqDpiLrJbyUtPkvN0RR1QELlYfoMEoyThVwbkvsuFsTfwJw==
X-Received: by 2002:a05:6000:2a5:b0:20c:520a:a12e with SMTP id l5-20020a05600002a500b0020c520aa12emr11875112wry.629.1651570747058;
        Tue, 03 May 2022 02:39:07 -0700 (PDT)
Received: from [10.32.181.74] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id u2-20020adfa182000000b0020c5253d915sm8918771wru.97.2022.05.03.02.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 02:39:06 -0700 (PDT)
Message-ID: <f0e633b3-38ea-f288-c74d-487387cefddc@redhat.com>
Date:   Tue, 3 May 2022 11:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 0/9] IPI virtualization support for VM
Content-Language: en-US
To:     Zeng Guang <guang.zeng@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hu, Robert" <robert.hu@intel.com>,
        "Gao, Chao" <chao.gao@intel.com>
References: <20220419153155.11504-1-guang.zeng@intel.com>
 <2d33b71a-13e5-d377-abc2-c20958526497@redhat.com>
 <cf178428-8c98-e7b3-4317-8282938976fd@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <cf178428-8c98-e7b3-4317-8282938976fd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 09:32, Zeng Guang wrote:
> 
> I don't see "[PATCH v9 4/9] KVM: VMX: Report tertiary_exec_control field in
> dump_vmcs()" in kvm/queue. Does it not need ?

Added now (somehow the patches were not threaded, so I had to catch them 
one by one from lore).

> Selftests for KVM_CAP_MAX_VCPU_ID is posted in V2 which is revised on top of
> kvm/queue.
> ([PATCH v2] kvm: selftests: Add KVM_CAP_MAX_VCPU_ID cap test - Zeng 
> Guang (kernel.org) 
> <https://lore.kernel.org/lkml/20220503064037.10822-1-guang.zeng@intel.com/>)

Queued, thanks.

Paolo

