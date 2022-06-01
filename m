Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C3539FED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350973AbiFAI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348187AbiFAI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2668F4D62D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654073848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTXq3UeABBYSaGV3RAS/AH+/JRNDT9mOMSr/5zH7Hs0=;
        b=dN+9CaF18XuOODFJ9YcglnyJb4hLd+dS5AmKPJL5xsK4vxfZZdIuZGqRWBWj5AakJUPxtG
        XqdVECxAS+n8IqscmZZvoOxfaQimc7SheUFK5GklWOkpDOY/TVm9Y5MByFyuIyKhTif77w
        RQEA3bgIdpO9LqObqW8Mu0li16Ia6Ys=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-wKxDxyIxNFChNbUwV2yqlw-1; Wed, 01 Jun 2022 04:57:25 -0400
X-MC-Unique: wKxDxyIxNFChNbUwV2yqlw-1
Received: by mail-ej1-f69.google.com with SMTP id ks1-20020a170906f84100b006fee53b22c2so604095ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oTXq3UeABBYSaGV3RAS/AH+/JRNDT9mOMSr/5zH7Hs0=;
        b=HS10ET9LN1pBisqn7BvD1QV7rYSTGwy8hIpL8QjLgNvMixa6OkK0QqRoeZsDdlNfr9
         oBOAcwvS+Lc2FFONEA5/IqgUMmQub3PLkrdOxLvlHhPRL22xN9CrDOc0DxRc0k3UroCe
         i7GEHN3+OCs9c4GhmJxfGb5Mxngma/BP7+yAW5iL0hMG8roZ1tIbI7NOfzrrAvsE50Ve
         wKizPPBZ49P1XKCBYujq+aTmNjoef30pV4Frky2PzYD4C1QQpeGpd4TgVN29RaMFPaN1
         fwc0Ul/01z1dIHprrDgbBcuvFmLRhiqBnN6q1Q4ymPDAIt0e+PSoo22q3Kd70s4txreV
         zkGg==
X-Gm-Message-State: AOAM531esXs3yTwNAyk+DoU/1Kebt6TRaIopvjap+TLvWbeu1xYm4FJR
        r/SQ2YU1c9TSG7dyN2KH0utKv0n1neoM0z2PakpvM8pHaUb6vT6MB43PZdow1Vy6zyQFnleGNJJ
        FlgxX0afOP+du2XZdjoNINF0O
X-Received: by 2002:a17:907:7f88:b0:6fe:c708:198f with SMTP id qk8-20020a1709077f8800b006fec708198fmr43587490ejc.342.1654073843808;
        Wed, 01 Jun 2022 01:57:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzspdGAJ1tvlmp1pj2tAMQKYUyYFKr+aKmQzllLi1ycv3BYCEiI5u5Vw68OUVvqmMxRgWCtNA==
X-Received: by 2002:a17:907:7f88:b0:6fe:c708:198f with SMTP id qk8-20020a1709077f8800b006fec708198fmr43587459ejc.342.1654073843578;
        Wed, 01 Jun 2022 01:57:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id t6-20020a170906948600b006fed062c68esm448279ejx.182.2022.06.01.01.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:57:22 -0700 (PDT)
Message-ID: <2bdfde74-da27-667d-d1c4-3b17147cecce@redhat.com>
Date:   Wed, 1 Jun 2022 10:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: ...\n
Content-Language: en-US
To:     "Durrant, Paul" <pdurrant@amazon.co.uk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Allister, Jack" <jalliste@amazon.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "diapop@amazon.co.uk" <diapop@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "metikaya@amazon.co.uk" <metikaya@amazon.co.uk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <YpYaYK7a28DFT5Ne@hirez.programming.kicks-ass.net>
 <20220531140236.1435-1-jalliste@amazon.com>
 <YpYpxzt4rmG+LFy9@hirez.programming.kicks-ass.net>
 <059ab3327ac440479ecfdf49fa054347@EX13D32EUC003.ant.amazon.com>
 <YpcMw2TgNWzrcoRm@worktop.programming.kicks-ass.net>
 <87r148olol.fsf@redhat.com>
 <48edf12807254a2b86e339b26873bf00@EX13D32EUC003.ant.amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <48edf12807254a2b86e339b26873bf00@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 10:54, Durrant, Paul wrote:
> That is exactly the case. This is not 'some hare-brained money
> scheme'; there is genuine concern that moving a VM from old h/w to
> new h/w may cause it to run 'too fast', breaking any such calibration
> done by the guest OS/application. I also don't have any real-world
> examples, but bugs may well be reported and having a lever to address
> them is IMO a good idea. However, I also agree with Paolo that KVM
> doesn't really need to be doing this when the VMM could do the job
> using cpufreq, so we'll pursue that option instead. (FWIW the reason
> for involving KVM was to do the freq adjustment right before entering
> the guest and then remove the cap right after VMEXIT).

But if so, you still would submit the full feature, wouldn't you?

Paul, thanks for chiming in, and sorry for leaving you out of the list 
of people that can help Jack with his upstreaming efforts.  :)

Paolo

