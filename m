Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A379B4FF244
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiDMIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiDMIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 893B94EA2E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649839111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoMMC2LMJaH+wT3SQsP3VkYrWPiF7nKkDApGo/gOh/Y=;
        b=APiRH5OgfhMB+ZAGufL02NrhBgbbS2Q3pBioJha639sp8IAvdiMA9/FNnRH3BzYPR5/UMi
        giApsmmCOC8UgcwF8pG1NS2aKYc7PQSzL0fF487vyTmcYYkk+EYTa6kcJ7E1sI47A2IIn5
        9WoUtZA/xnKEmsnemDBjspViwdscibI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-WflL0aeTOcuPN0ksAeNbQg-1; Wed, 13 Apr 2022 04:38:30 -0400
X-MC-Unique: WflL0aeTOcuPN0ksAeNbQg-1
Received: by mail-wm1-f70.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so545587wmi.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FoMMC2LMJaH+wT3SQsP3VkYrWPiF7nKkDApGo/gOh/Y=;
        b=OeFQrDsJS8fV8zWY5jeQXSq2c/srddxlIdb0LjMfDlhXUznNe6o6wQOLBaIn+mHEMo
         293xWmz+/cZDKAs7PV+e1fu2BorxDWSmveHgvHAfHjxH+fZX/3Hbi7tBc+8lnvobswSM
         dwHPWDnMcZIiQMwSC19mUrsG+8zvypGBDjb+bAE6TDIpEC3AuQhAaGx7BR342VgMlamB
         rNaCyirM9WFVnsvCE3WsgpobHCg0uQhGMkS81uDavXpmywjxst3td9nNvf0DbIF3DIN1
         1mHYcgGTjisxOj4oNQGxmwP3/FwgT2Ox0wFJIubQmFPEwyFJaASCHrvu/1RP96rtfM+E
         kC0Q==
X-Gm-Message-State: AOAM532PJELkXeAexD+bSxSolQE4Re2r7CB2hEyGp5gsNJDgMJmBeSQo
        vhOXxztAOpcGXdV9oG6fXJmwLO8IKSEGdHVImBVoTm50wniTJuODM6YsGIwKVoNGcBqP3DJhqfe
        JXfFF/qGupH5myiY9XZpE4kW1
X-Received: by 2002:a05:6000:1549:b0:207:aadd:87ae with SMTP id 9-20020a056000154900b00207aadd87aemr8781988wry.282.1649839109211;
        Wed, 13 Apr 2022 01:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVgucUFVic2dUsqqIHD+2DGQQJnfgxTbKjYB7CmhPL/uRKi1K0epJjliff4gFJ1qw5xdURjA==
X-Received: by 2002:a05:6000:1549:b0:207:aadd:87ae with SMTP id 9-20020a056000154900b00207aadd87aemr8781969wry.282.1649839108965;
        Wed, 13 Apr 2022 01:38:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id x4-20020adfdd84000000b00207b60ed68esm1474940wrl.100.2022.04.13.01.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:38:28 -0700 (PDT)
Message-ID: <caffa434-5644-ee73-1636-45a87517bae2@redhat.com>
Date:   Wed, 13 Apr 2022 10:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH V3 2/4] KVM: X86: Introduce role.glevel for level
 expanded pagetable
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-3-jiangshanlai@gmail.com> <YlXvtMqWpyM9Bjox@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YlXvtMqWpyM9Bjox@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 23:31, Sean Christopherson wrote:
>> +		unsigned glevel:4;
> We don't need 4 bits for this.  Crossing our fingers that we never had to shadow
> a 2-level guest with a 6-level host, we can do:
> 
> 		unsigned passthrough_delta:2;
> 
> Where the field is ignored if direct=1, '0' for non-passthrough, and 1-3 to handle
> shadow_root_level - guest_root_level.  Basically the same idea as Paolo's smushing
> of direct+passthrough into mapping_level, just dressed up differently.

Basically, your passthrough_delta is level - glevel in Jiangshan's 
patches.  You'll need 3 bits anyway when we remove direct later (that 
would be passthrough_delta == level).

Regarding the naming:

* If we keep Jiangshan's logic, I don't like the glevel name very much, 
any of mapping_level, target_level or direct_level would be clearer?

* If we go with yours, I would call the field "passthrough_levels".

Paolo

