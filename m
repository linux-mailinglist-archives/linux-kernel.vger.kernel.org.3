Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D4539FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiFAI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiFAI71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71BA26BFE7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654073965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzxCOihBBp2MvYCnWOOgAbyz9Dw1/OZ2iZqah66p3+o=;
        b=EXOjlnKQirydQ4DGET0xbN2cNa7Z4L70epX6LmNKhu9loYdD15pyTETP25xHGuxCuJVG7A
        4XIiqBTwMdBcx6IAxe/0BSkmgiMyA/pS5eAPF2CpRmbuhi14SWtJYPqCZ4ZByJjpE7lVF2
        nQE8rwCdnsiYKtQWG2S6MN5nYYfmGvw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-CLrASgcsNEyjDov6QsFk5Q-1; Wed, 01 Jun 2022 04:59:24 -0400
X-MC-Unique: CLrASgcsNEyjDov6QsFk5Q-1
Received: by mail-ed1-f71.google.com with SMTP id g7-20020a056402424700b0042dee9d11d0so812658edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uzxCOihBBp2MvYCnWOOgAbyz9Dw1/OZ2iZqah66p3+o=;
        b=WpqtDLPDNZjrOX03/ygc8KxZQa1TnKDlqG++0Ko9AzAweHhdcnFI5YkAAdoIt7Q1Mf
         Oy24OOSfBKYmfXoO0S20WqfOQv+H3ZJ0v6MkAYyj6woB9E7cjPPlGA/n6kQeDwvsXRFh
         WYDHapcDWQWFrDoz9OvWTFwOQ41XgWJGeK+3td2luG7SwNCrTNi0354Ch5ZeeubdSMdA
         PhqqlrtkxLIF5EKgrBSDSl+/z414ZASiZQqR42ODsOItBY4CS2S5cIp2M1uRmuMllqw1
         vMQoMhTpAU8gA3/TaXFBcA3qwW97mHNcaojm5ZqBr+qhJ7kDIw0SaxvJ4b8GOYztVc3g
         51nQ==
X-Gm-Message-State: AOAM531U6LfvQAC+iXVTT17BLufWdDrJQ2s/8PNrVXpsF6ze6w4TPa04
        EPeWLuCwFOE5dQuHADKiE0pGu1m6zQXM22AdveMrNviNjoRL5UUkt+N5Hf1CPs0SrhtqxJKa7OU
        R1oU5ZQtDAwP6I7q5o9EdzPud
X-Received: by 2002:a50:ea8b:0:b0:428:7d05:eb7e with SMTP id d11-20020a50ea8b000000b004287d05eb7emr66994806edo.185.1654073963162;
        Wed, 01 Jun 2022 01:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcZzdAmqTqAOV48EeckvF3+BiTMXPZ6japnr184Gq8Eqzb54YOTFyRdX28qRg+QRUvnZvVOA==
X-Received: by 2002:a50:ea8b:0:b0:428:7d05:eb7e with SMTP id d11-20020a50ea8b000000b004287d05eb7emr66994790edo.185.1654073962970;
        Wed, 01 Jun 2022 01:59:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id cx12-20020a05640222ac00b0042bd6630a14sm644395edb.87.2022.06.01.01.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:59:22 -0700 (PDT)
Message-ID: <b9238c07-68a7-31fa-c654-d8111a1e2d4b@redhat.com>
Date:   Wed, 1 Jun 2022 10:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: ...\n
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Durrant, Paul" <pdurrant@amazon.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Allister, Jack" <jalliste@amazon.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
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
 <307f19cc-322e-c900-2894-22bdee1e248a@redhat.com> <87tu94olyd.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87tu94olyd.fsf@redhat.com>
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

On 6/1/22 09:57, Vitaly Kuznetsov wrote:
>>> I'll bite... What's ludicrous about wanting to run a guest at a lower CPU freq to minimize observable change in whatever workload it is running?
>> Well, the right API is cpufreq, there's no need to make it a KVM
>> functionality.
> KVM may probably use the cpufreq API to run each vCPU at the desired
> frequency: I don't quite see how this can be done with a VMM today when
> it's not a 1-vCPU-per-1-pCPU setup.

True, but then there's also a policy issue, in that KVM shouldn't be 
allowed to *bump* the frequency if userspace would ordinarily not have 
access to the cpufreq files in sysfs.

All in all, I think it's simpler to let privileged userspace (which 
knows when it has a 1:1 mapping of vCPU to pCPU) handle it with cpufreq.

Paolo

