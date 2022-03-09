Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA44D31F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiCIPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiCIPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88923107095
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646840439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpTV0suVR5QE7kK/w7jo7ZMF5WkTt6GdUr/IKjM2dG0=;
        b=deH1xj8k/1Gm3v8HcekyoH5zGVWvJiY6EoUZSlmDJeILu6jW/+GFkvRMzrRu0hKoqVOsVJ
        jhxmOe5tuH3lfX9tr1JwhSDNuAMJo6jugBABFUz894FLEHMPHFBeYxEgb+Wl4fjWc39ZGa
        IUySaEPO9lxg1yShStTLzYHP8AVP2Mc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-xzPPMAQEPdypLOBT26B5qA-1; Wed, 09 Mar 2022 10:40:38 -0500
X-MC-Unique: xzPPMAQEPdypLOBT26B5qA-1
Received: by mail-ej1-f71.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso1508866ejj.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 07:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bpTV0suVR5QE7kK/w7jo7ZMF5WkTt6GdUr/IKjM2dG0=;
        b=FtPNoCDY5zbkUrMBLz8gd2YIVfrMJ0edaK4qTzYlRl2bBeR3+SgChQNi/71/ocXuyj
         xV0HeRyhurGa+vS3IGy17GeAM+tJ+HNQXphyWg0f2KQXyTpAAjbNjs8YRLaidExlegCo
         KcF8tmRHhbOG99tjH4wO0WFwi+0bhd+umTWEy4t2gA7kszgTu6e280K4NDs2xhkzjkJL
         B5wmxmx8Heg5cPMZWg8woDMBFi6loQStteApCtCoCFrJUYYgjbF/7MpThjaiJlRGhwxn
         M2PxzOFLZuNNBBbcyV4a45X/We5qVZnFDYZkW30nn8iWLzUlsMvoup6rMxFIRCJJOK/N
         oZtw==
X-Gm-Message-State: AOAM533YOBtNon9enWv/tIDM7U2hVuEa/jFihAOmGa1G8r+lcYTUWPx5
        Up7eGshY16H59kOE2UbjokirDA4/56+V7DTyPIL4SOn0i5PIfKril2bU9bwmgHHiz17pLjmObRU
        XfmnrSZsm4LVUvxc8qX6dAfcM
X-Received: by 2002:a17:906:3283:b0:6ce:78f9:fafd with SMTP id 3-20020a170906328300b006ce78f9fafdmr319002ejw.534.1646840437307;
        Wed, 09 Mar 2022 07:40:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsvi69xGcmVAH2G4r9q7CbVDDDecTBatSShtA1zS0xb4AM7c6XC/M/UuI1zB3KNCKERAEjLw==
X-Received: by 2002:a17:906:3283:b0:6ce:78f9:fafd with SMTP id 3-20020a170906328300b006ce78f9fafdmr318981ejw.534.1646840437056;
        Wed, 09 Mar 2022 07:40:37 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id i5-20020a05640242c500b00416701e9466sm978505edc.26.2022.03.09.07.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 07:40:36 -0800 (PST)
Message-ID: <130fe0c3-bd86-18b6-056a-94bdd7072837@redhat.com>
Date:   Wed, 9 Mar 2022 16:40:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 08/25] KVM: x86/mmu: split cpu_mode from mmu_role
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-9-pbonzini@redhat.com> <YiemuYKEFjqFvDlL@google.com>
 <175b89f0-14a6-2309-041f-69314d9f191a@redhat.com>
 <YijJ/3frxdLAsuKV@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YijJ/3frxdLAsuKV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 16:38, Sean Christopherson wrote:
> Can we instead tweak that patch to make it and kvm_calc_shadow_npt_root_page_role() be
> 
> 	static union kvm_mmu_role
> 	kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu,
> 					union kvm_mmu_role cpu_role)
> 	{
> 		union kvm_mmu_role root_role = cpu_role;
> 
> 		if (!cpu_role.ext.efer_lma)
> 			root_role.base.level = PT32E_ROOT_LEVEL;
> 		else if (cpu_role.ext.cr4_la57)
> 			root_role.base.level = PT64_ROOT_5LEVEL;
> 		else
> 			root_role.base.level = PT64_ROOT_4LEVEL;
> 
> 		return root_role;
> 	}

Yep, figured the same in the meanwhile.

Paolo

