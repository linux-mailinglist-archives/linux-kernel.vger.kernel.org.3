Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF71D4F86DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346753AbiDGSFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiDGSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37D82340E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649354622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qblZlwLVOW0eR3D4SlQZSCRb0yYaR0BlU1bRFwj122U=;
        b=EnAKPQjc1g5Gc5REjLqyXCyhTwzD0oeI45KlJifzVApeivgTROiYxAdrrGLlqKSgFzCe4n
        RW9Zhzw2w4yON5ehUyzkEzmNdrdDyvok/JZFOG2Q4ITVek0pHYggcxHXFEeUd/bl613Oxy
        2QlKVgqzdxpZF8PJlietEivL7TVytd4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-mFlqodTFNI2tTNFpe2MYmQ-1; Thu, 07 Apr 2022 14:03:41 -0400
X-MC-Unique: mFlqodTFNI2tTNFpe2MYmQ-1
Received: by mail-ej1-f70.google.com with SMTP id qf10-20020a1709077f0a00b006e83684b9c6so1597161ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qblZlwLVOW0eR3D4SlQZSCRb0yYaR0BlU1bRFwj122U=;
        b=FmRQENx0SgArXL0m+XX3jD+k7iu31SWd/cq75lSDSqZV/qvHOjgxWY3kBUTEsdKn9+
         3rmcN38HQ9ZgI1dxECcVe2bWP8UNsV7JGHGnRvK2TKPeCzqPkvWDMkuZnZzpIddWRyY0
         o+eLGdDKbMYd9RXlslQmvf/PXbNR/5T8e5bzaZsnCBzyVRm240jQr41HC/QD4STqgDxI
         vA3JMcbNDUOJX0ndtoyZctUjK/wb/E7s21VHCG4QoKiTBXRTHeM6He2+ZMmm/jT3aHhZ
         2PyAITQ22B1XJBSOYfx5oNu+ejpY+B1aAqLcK+1vQGV4594DW3KrYVzC/4tRyFV0LNll
         RbGQ==
X-Gm-Message-State: AOAM530o3++Wo3dl3Q2gBLi8OBtZgp8rlsMBF9ZcYeFuTv62rXSuc2HW
        liOHC2BO4Ks4GGB/Gqfbb9hflEyEWSe0v5KYcV2rVdMoUiIg44YaAJJPA67MDlA5bFVwYrLFVGI
        xNaRhczEKXiivO29AqrSmlanZ
X-Received: by 2002:a17:906:9b8f:b0:6db:ab62:4713 with SMTP id dd15-20020a1709069b8f00b006dbab624713mr14731001ejc.738.1649354619855;
        Thu, 07 Apr 2022 11:03:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPxFQXOcLc+wg9Chj6cjk13RLg3UF6jdjTnzG19giIe0d5Y51YOzJ8wIhpn6LkthjVJFINQw==
X-Received: by 2002:a17:906:9b8f:b0:6db:ab62:4713 with SMTP id dd15-20020a1709069b8f00b006dbab624713mr14730971ejc.738.1649354619597;
        Thu, 07 Apr 2022 11:03:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id f5-20020a17090624c500b006cee6661b6esm7892592ejb.10.2022.04.07.11.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:03:38 -0700 (PDT)
Message-ID: <6558fe13-6406-7536-7557-e89a8b10d102@redhat.com>
Date:   Thu, 7 Apr 2022 20:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 091/104] KVM: TDX: Handle TDX PV CPUID hypercall
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <e3621e9893796d2bd8ea8b1f16c1616ae9df3f37.1646422845.git.isaku.yamahata@intel.com>
 <adea5393-cbe9-3344-0ef5-461a72321f72@redhat.com>
 <Yk75xJjUghPTjTjT@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yk75xJjUghPTjTjT@google.com>
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

On 4/7/22 16:48, Sean Christopherson wrote:
>> Reviewed-by: Paolo Bonzini<pbonzini@redhat.com>
>>
>> but I don't think tdvmcall_*_{read,write} add much.
> They provided a lot more value when the ABI was still in flux, but I still like
> having them.  That said, either the comments about R12..R15 need to go, or the
> wrappers need to go.  Having both is confusing.
> 

Fair enough, let's keep them but rename them a0..a3 for consistency with 
kvm_emulate_hypercall.

Paolo

