Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE60F514DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377764AbiD2Osd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377755AbiD2Os3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A184635F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651243509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reLN1pG1/CChgH6ozCSwMmfyN+LJMqKj0Ol22hvsDgw=;
        b=Vpp4qT6PMzFJlWeMiynSYd74/XZKoPYXDfSSnQPMVDwK1rSf8IyfXfVmgiTvYzIQJQUiDV
        S19RYua3pYegIPuUO37ivfXYNKJmw0D0mSMP/pyMb4q/QAuz2wgBEiSX28BrmS6IEGnzBK
        ETSXFtX8V6H7DfdT9p/WBOVN8coOqps=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-jmi4oePoOtekRW4ReXOqQA-1; Fri, 29 Apr 2022 10:45:07 -0400
X-MC-Unique: jmi4oePoOtekRW4ReXOqQA-1
Received: by mail-ej1-f71.google.com with SMTP id l20-20020a170906795400b006f3f30daf18so1185071ejo.22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=reLN1pG1/CChgH6ozCSwMmfyN+LJMqKj0Ol22hvsDgw=;
        b=BiDdbfJbf/4XhkCoqWWrgtuUANIxRpP6/BRl1I0htnrNtQ9sDoCSnNpub21U+pahRo
         FupWEMKTMGOIOFrDpdDdje9JAqsO7sBosgcdZOdcWX7qbALBXdVagKCKj8wl48tleupG
         wXGr8MV+DODoZCzdN9ruq+qLpxivmGuUo+H4Ke9mj24QtnVo9UELyBbzflUyi/40pZ1m
         ID7Tu9JU/0vtVc+QlQz3gos5SQZRgjFBgFopvoBRCL//YfMwD+AA2blFw+pMSR13LzKH
         BbdHGxqrVdzsAd1GL3b/GRsPz2BpVfeRrK3LEaTg1L4cPCfPKXUorNfjUN4iPfduTX4Z
         j0Rg==
X-Gm-Message-State: AOAM530YgjrSY4tAQod46MucS078AS02pmBHUQP/mZBlP5aVLJEyFKF4
        C7PjVHBUF9ElwpVwBuNC3v5CSaCQHveLVagV9TJwVvW/w8jFEu+sKzsAgEWhCAli+7b2Sptplko
        9vWQUN/QIItEuDZiZsYjc3PPr
X-Received: by 2002:a17:907:3f91:b0:6d7:16c0:ae1b with SMTP id hr17-20020a1709073f9100b006d716c0ae1bmr36173033ejc.74.1651243506537;
        Fri, 29 Apr 2022 07:45:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrRMmBaW56vukrRtL88Onw+W9T5clAHH2pPU49YFnPmyqnQ5xD7Ht1ZUTszCVALYKc3un4wQ==
X-Received: by 2002:a17:907:3f91:b0:6d7:16c0:ae1b with SMTP id hr17-20020a1709073f9100b006d716c0ae1bmr36173012ejc.74.1651243506264;
        Fri, 29 Apr 2022 07:45:06 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id t19-20020aa7d4d3000000b0042617ba63c2sm3038883edr.76.2022.04.29.07.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:45:05 -0700 (PDT)
Message-ID: <67222fe0-7bf0-ec7a-0791-a4d48391a15e@redhat.com>
Date:   Fri, 29 Apr 2022 16:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429031757.2042406-1-mizhang@google.com>
 <4b0936bf-fd3e-950a-81af-fd393475553f@redhat.com>
 <Ymv3vwBEgCH0CMPH@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: fix potential races when walking host page
 table
In-Reply-To: <Ymv3vwBEgCH0CMPH@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 16:35, Sean Christopherson wrote:
> On Fri, Apr 29, 2022, Paolo Bonzini wrote:
>>> +out:
>>> +	local_irq_restore(flags);
>>> +	return level;
>>> +}
>>> +EXPORT_SYMBOL_GPL(kvm_lookup_address_level_in_mm);
>>
>> Exporting is not needed.
>>
>> Thanks for writing the walk code though.  I'll adapt it and integrate the
>> patch.
> 
> But why are we fixing this only in KVM?  I liked the idea of stealing perf's
> implementation because it was a seemlingly perfect fit and wouldn't introduce
> new code (ignoring wrappers, etc...).
> 
> We _know_ that at least one subsystem is misusing lookup_address_in_pgd() and
> given that its wrappers are exported, I highly doubt KVM is the only offender.
> It really feels like we're passing the buck here by burying the fix in KVM.

There are two ways to do it:

* having a generic function in mm/.  The main issue there is the lack of 
a PG_LEVEL_{P4D,PUD,PMD,PTE} enum at the mm/ level.  We could use 
(ctz(x) - 12) / 9 to go from size to level, but it's ugly and there 
could be architectures with heterogeneous page table sizes.

* having a generic function in arch/x86/.  In this case KVM seems to be 
the odd one that doesn't need the PTE.  For example vc_slow_virt_to_phys 
needs the PTE, and needs the size rather than the "level" per se.

So for now I punted, while keeping open the door for moving code from 
arch/x86/kvm/ to mm/ if anyone else (even other KVM ports) need the same 
logic.

Paolo

