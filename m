Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321484F8AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiDGXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiDGXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16E236A003
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649372645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIQi3qGVfQZT8qJz4yv5EPG7fg0JFIcEyArufaTfdyo=;
        b=bpN+i2IH/utSX7hMCCEE4xB2MgwZz8BR2Z9Rd3JpQY5SXbEeuqlKjUt26kM5oq/lVLgSdJ
        kSjUNLzvZysnY2mHRAFU1Umjh5TD1Vlj2Cx/DPT7fbH0m751GNbHC05d3k0lIXfv3sTelb
        NbqLybXhrS98xzNFpF4xwBP8/DRrsWo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-4esry8yZPfWGz2mRLTXNJw-1; Thu, 07 Apr 2022 19:04:04 -0400
X-MC-Unique: 4esry8yZPfWGz2mRLTXNJw-1
Received: by mail-ed1-f71.google.com with SMTP id d19-20020aa7d5d3000000b0041cd772fb03so3648539eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jIQi3qGVfQZT8qJz4yv5EPG7fg0JFIcEyArufaTfdyo=;
        b=rWSyDtL5Ay5F/vUu459jV6GEM6HzsfbUUeVSxVccgl6KELTQPJgi3oDdh+SrQYly/x
         eyapDZ/dfeFBRMs7o0md72uoPCi360TPXQtMTmGmnwVcO56nn9y9SQLsaGiTPkai+DYS
         aiOqqkpCnHVVFRU7hQrHrOIeZFFgMgYqonMN3RYRu84ROsaSxnmwQpPhEaib02/BetpB
         rxf+8gftDMVcAnXnG/k10pknW34m2ukC5RTLOFw3XGiOTLw8Ew/u6xEuXyrbLDLeTBzg
         HGyzl7Qc6V4Yhd+AsvAdYUyeDN+LNEr3xgfldDaUSKqeaEp+bqsRlyef6Ku9Kwl907de
         AIuQ==
X-Gm-Message-State: AOAM533iFOX8ywfg8HmVTSV4e0V3fVH60nn6PwD1HdSYM7t6RUixa62J
        QZCLOMsZpHsKGGnLhNhWc8Hc0os5/rxgLa+bBqKfUCuKDUXcdgemYsK5IUJ8okUmZY5tVJ78Z+a
        AHk/GhXvvFFZxhB9aBucZ1a8j
X-Received: by 2002:a17:907:6d1f:b0:6e8:318d:1df0 with SMTP id sa31-20020a1709076d1f00b006e8318d1df0mr5920268ejc.192.1649372642813;
        Thu, 07 Apr 2022 16:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynH3xr2my/HvzM33HT8/Ct2tHFRQYa9aOTLzc/bGsvVYht/6hLmeB6I2/KNGe6lZX4BClLpQ==
X-Received: by 2002:a17:907:6d1f:b0:6e8:318d:1df0 with SMTP id sa31-20020a1709076d1f00b006e8318d1df0mr5920246ejc.192.1649372642581;
        Thu, 07 Apr 2022 16:04:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm8147133ejb.179.2022.04.07.16.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 16:04:01 -0700 (PDT)
Message-ID: <7dabd2a6-bc48-6ada-f2f1-f9e30370be2f@redhat.com>
Date:   Fri, 8 Apr 2022 01:03:57 +0200
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
 <ec5ffd8b-acc6-a529-6241-ad96a6cf2f88@redhat.com>
 <05b1d51b69f14bb794024f13ef4703ad1c888717.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <05b1d51b69f14bb794024f13ef4703ad1c888717.camel@intel.com>
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

On 4/8/22 00:53, Kai Huang wrote:
>>
> Do you mean below reply?
> 
> "I think use of kvm_gfn_stolen_mask() should be minimized anyway.  I
> would rename it to to kvm_{gfn,gpa}_private_mask and not return bool."
> 
> I also mean we should not use kvm_gfn_stolen_mask().  I don't have opinion on
> the new name.  Perhaps kvm_is_protected_vm() is my preference though.

But this is one of the case where it would survive, even with the 
changed name.

Paolo

