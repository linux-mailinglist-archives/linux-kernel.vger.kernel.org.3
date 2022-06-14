Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5354B789
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiFNRUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbiFNRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAF9B2F670
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655227245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqYew11KNAfaBqOsl+Q8igMswKugDrXrgAM/kefOpxk=;
        b=CjOHLg3KHZFjdmb5M8OlmIIe3GBWgLxINnzJqJTUAiqthOJyd9AeMsjA12HafcXtyEeFs8
        2X79RtHVqq2bnlMNkzr1mu+tKwMQa7tOkgQ9nkGKKD+NHLrsg+obeE8esjHo757aQA096h
        xzzx6j3cZofVVDCCPzzu3gYhR1XvVzw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-p30b8t1gNjCb1gCcd3SvUQ-1; Tue, 14 Jun 2022 13:20:43 -0400
X-MC-Unique: p30b8t1gNjCb1gCcd3SvUQ-1
Received: by mail-wm1-f72.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so4061946wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kqYew11KNAfaBqOsl+Q8igMswKugDrXrgAM/kefOpxk=;
        b=R0wpfVvnqJOZa1P9et1Xlr1kU00S9gINCt9j27PgRCplfHdcp6XJy7ckxzNbMO3RT4
         k599mbH/SgmpfqLkLSJO0aYLGfJN/rHuCkKi3UBsYc1W1L+lHp0oGleDH79CgEEtGwWz
         zMouzGPQ5B5oJTAu36o6D76g/aYtEfC5CWmWqBB3N54e4DvNRa9HZw5y3++M7XdlDOks
         4axOL4EIp3denNr36/9oHZ77th+4usXCv9kVGENItsVevmh7pIMKVCY06J4a/1hrTBkW
         eBqZyDLdtgu5Sg6NBAnEmX5cmMzmdg+PFfUxG7jiYZMWSlrFAVkKEZriTHLMDAyQADyu
         yP8g==
X-Gm-Message-State: AJIora/0p67ESVetmftH4pLYa/+U4IzCutR4lj1WRTOJe/lzamPy1iMd
        7/YBcY8EBkbDwy2RBqBlIrnMV0cutWQrNR7RJTiFjWNBPj1xFY9FrZhbswjz3drnj3W6dtqUXpw
        AJQW7D2wefU7rML+QpT733bVK
X-Received: by 2002:a05:6000:2aa:b0:218:3d95:7278 with SMTP id l10-20020a05600002aa00b002183d957278mr5867297wry.503.1655227242593;
        Tue, 14 Jun 2022 10:20:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tgE1OjlkuMBWX+961bgF+gnwmBpiZWtVIeSX94D2taqwQxRimWteEaLxJjNwlPIyUuVPBx0A==
X-Received: by 2002:a05:6000:2aa:b0:218:3d95:7278 with SMTP id l10-20020a05600002aa00b002183d957278mr5867281wry.503.1655227242330;
        Tue, 14 Jun 2022 10:20:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v13-20020a5d610d000000b0020c5253d914sm12639877wrt.96.2022.06.14.10.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:20:41 -0700 (PDT)
Message-ID: <eaefdea0-0ca3-93f1-a815-03900055fdcd@redhat.com>
Date:   Tue, 14 Jun 2022 19:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     mail@anirudhrb.com, kumarpraveen@linux.microsoft.com,
        wei.liu@kernel.org, robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <87sfo7igis.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87sfo7igis.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 14:19, Vitaly Kuznetsov wrote:
> The latest version:
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vmx_enlightened_vmcs
> 
> has it, actually. It was missing before (compare with e.g. 6.0b version
> here:
> https://github.com/MicrosoftDocs/Virtualization-Documentation/raw/live/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf)
> 
> but AFAIR TSC scaling wasn't advertised by genuine Hyper-V either.
> Interestingly enough, eVMCS version didn't change when these fields were
> added, it is still '1'.
> 
> I even have a patch in my stash (attached). I didn't send it out because
> it wasn't properly tested with different Hyper-V versions.
> 
> -- Vitaly

Anirudh, can you check if Vitaly's patches work for you?

Paolo

