Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A75A003C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbiHXRTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbiHXRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C27C32A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661361552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fR3F9GSGdIyjl4KjQVv2PTUvzcBxFqMQTexQHu1cYQ=;
        b=IXIqFOeGBGrbRH8Vf4lPvfhRcJ0hhIXVZAPMM5H/Hun7OFC3omKXuFGoMQI/YlwF0X2ACU
        j7+OAKZgf6NcDrv1uy3U+Bniq9a/EN/Y65ilCmC5osEB0GibAY0fM1Ki2V0WLkQi5E1M9J
        Z7plCyzfaO3GIai5qDwMdQDW7Nh1Du0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-gXakordyOn-QwZ4ZhLXEHw-1; Wed, 24 Aug 2022 13:19:11 -0400
X-MC-Unique: gXakordyOn-QwZ4ZhLXEHw-1
Received: by mail-wr1-f70.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so2907186wrf.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5fR3F9GSGdIyjl4KjQVv2PTUvzcBxFqMQTexQHu1cYQ=;
        b=4mg3wIcTodJ0jLM16tHV7eCctdQC00wjmaGZ8ju63EUeOq7pdxLMBv909Y9lYIcLaz
         /C5d+EOmJ4d/B+Sl25jD62IVP/hL5wKxMY4kD+3zEWuNagVwtLxRZ3pYKaUA7Yfhbkx9
         H+cJibb2HNKS+JjIzq1npy4xlkt8G3UYr3vPM7gTLr7KFZz4N7OUOontypbZY3sa7UME
         HFJH6kya35WwO1vrOKXXG/d/LrUcXlOp3yeGXKVQOieDsqTpoQck2CPz6+Gui+A5seMt
         gAUNELYf82cMfpVZZhimj+jVy43k4za6bt2sHA00jbaTmlyWblNmw2zxtYFl4uzuCjXL
         2IGg==
X-Gm-Message-State: ACgBeo0O7QeKcm+Qklig1hzNCLluDct0ecCiZCvXAFoJTAtWALxrXUNE
        3EVT3J8fRs+nkyTK8yWk+comPYScZkwLz2foP78gKWWZBnvHhuJV1PFX3+MKDuveYS+10megmSu
        q1nmthSZXVd51vxaFJ18WIhkf
X-Received: by 2002:a5d:64c3:0:b0:225:4f81:d060 with SMTP id f3-20020a5d64c3000000b002254f81d060mr132901wri.536.1661361550181;
        Wed, 24 Aug 2022 10:19:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ttdjMug0iYpQ5JQgsxkf6+CYDrKkbKyoW3tlDFCWtG6u7rvpOI69IoXi/6KTMQNrqkEgTuA==
X-Received: by 2002:a5d:64c3:0:b0:225:4f81:d060 with SMTP id f3-20020a5d64c3000000b002254f81d060mr132886wri.536.1661361549968;
        Wed, 24 Aug 2022 10:19:09 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id o8-20020a05600c4fc800b003a603fbad5bsm2635447wmq.45.2022.08.24.10.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:19:09 -0700 (PDT)
Message-ID: <f1598980-92a8-267c-cade-8f62d7653017@redhat.com>
Date:   Wed, 24 Aug 2022 19:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] KVM: x86: use TPAUSE to replace PAUSE in halt polling
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dapeng Mi <dapeng1.mi@intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, zhenyuw@linux.intel.com
References: <20220824091117.767363-1-dapeng1.mi@intel.com>
 <YwZDL4yv7F2Y4JBP@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YwZDL4yv7F2Y4JBP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 17:26, Sean Christopherson wrote:
> I say "if", because I think this needs to come with performance numbers to show
> the impact on guest latency so that KVM and its users can make an informed decision.
> And if it's unlikely that anyone will ever want to enable TPAUSE for halt polling,
> then it's not worth the extra complexity in KVM.

Yeah, halt polling works around perhaps the biggest performance issue 
with VMs compared to bare metal (so much that it's even possible to move 
halt polling _inside_ the guest for extra performance).

I am ready to be proven wrong but I doubt TPAUSE will have a small 
effect, and if one wants the most power saving they should disable halt 
polling.  Perhaps KVM could do it automatically if the powersaving 
governor is in effect?

Paolo

