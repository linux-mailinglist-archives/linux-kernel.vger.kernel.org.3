Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4D4F8102
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiDGNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiDGNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 165F9DB2F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649339553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL9bXerqanJqYa09D53b5usSPv9ZPbbi9nBHaabOGf0=;
        b=UlIhu6iD8aGr583Gjge0Inpusz6pfDpZFM59Nlz79KJxEf3s/6glQtcfIRdtB/dTdvq9yg
        2zRL2eu+RMEVwJ5109eOYlOs/T0PTGhQYl5ytX2GVFNgi9DwCwrVvI/3wR70WeCkrOIt+Q
        L3dETbrMkXLpzUN1fhkbBt/F5zztAxg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-_7xcDWNvMiaBTBvZv_zIAw-1; Thu, 07 Apr 2022 09:52:32 -0400
X-MC-Unique: _7xcDWNvMiaBTBvZv_zIAw-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso2970916edt.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 06:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jL9bXerqanJqYa09D53b5usSPv9ZPbbi9nBHaabOGf0=;
        b=4ETq0/kp7qPF7LVtYui84LrxCTll5XtjtI5pWCGif+YAmLy1qmkpaD7YlGPDt72aWX
         Rss/Yv8lmm2k0lp11HPowfaEv6KIVHGrVx7Zz+4ZNJPO4VaQY5v04d4kJ4NlGTHZvCo/
         9s4Y53FheZ4Y/2aZOUiM7XpWF3o/DYLNtIAH9TUT9XuTa/vqzNpt6JqgPiEEAQk8FUuE
         l5E/QHAQI6tRsfL7PXVOXWpX98OpwyQ0p4W8C56WNyoQaNExXDkTp9vbUw+Shzc9skaa
         rVisPT7/w756ebO72q6O+D0gii6hKTyRv5ROOL8RbxFawVpY+enxtVEoO9gC35XCmE/f
         l/jg==
X-Gm-Message-State: AOAM532cfisJSX3N7G0xd4sVfxn5lpHUwEKkQC+w1vPWRK1xzrRmEX4M
        OIxVwfcvy5uTorK9xWVE31hSxrp+OaZXTICPajo+dzzZOA/oKd5POrjQShpZ4vsUeJYCzkmFhKQ
        6rbYibv8CcAS125p7UzIrRIQa
X-Received: by 2002:a17:906:9c8e:b0:6df:f6bf:7902 with SMTP id fj14-20020a1709069c8e00b006dff6bf7902mr13355732ejc.191.1649339551260;
        Thu, 07 Apr 2022 06:52:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNoQ4CSwzbLRsARzz7uQFWOARItD+XZF5VJ8pDvdIiL2uFf06aBp56DUc8uT+bnytuRG5OkQ==
X-Received: by 2002:a17:906:9c8e:b0:6df:f6bf:7902 with SMTP id fj14-20020a1709069c8e00b006dff6bf7902mr13355709ejc.191.1649339550964;
        Thu, 07 Apr 2022 06:52:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm7697618ejc.99.2022.04.07.06.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 06:52:30 -0700 (PDT)
Message-ID: <ec5ffd8b-acc6-a529-6241-ad96a6cf2f88@redhat.com>
Date:   Thu, 7 Apr 2022 15:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 047/104] KVM: x86/mmu: add a private pointer to
 struct kvm_mmu_page
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <499d1fd01b0d1d9a8b46a55bb863afd0c76f1111.1646422845.git.isaku.yamahata@intel.com>
 <a439dc1542539340e845d177be911c065a4e8d97.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <a439dc1542539340e845d177be911c065a4e8d97.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 01:43, Kai Huang wrote:
>> +	if (kvm_gfn_stolen_mask(vcpu->kvm)) {
> Please get rid of kvm_gfn_stolen_mask().
> 

Kai, please follow the other reviews that I have posted in the last few 
days.

Paolo

