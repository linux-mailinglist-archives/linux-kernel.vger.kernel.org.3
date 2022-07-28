Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C3584833
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiG1WZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiG1WZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A8E22E6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659047106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndVyxggE9NRkNXPrTefS8i3sDBY7mXSC7xSnt5hqVcI=;
        b=BhMPx08NbcnmQVd20DJoJ7Y+dmBDIkx2Sjl1IlNf1Wd7RN3XzZKktyH7PzDB6GcJXhYQqU
        YLaF26YEHaAEmOElQBc8g/YzqGEAJ0Lfr5oy5nRI/IjJVficThsvWCoVhmjZXnzBeSaOZA
        oZpTL7ATb+lzmJsTXBMoYMvpcOQVYGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-BmZ2ypaBMZquZ26djS_LZA-1; Thu, 28 Jul 2022 18:25:02 -0400
X-MC-Unique: BmZ2ypaBMZquZ26djS_LZA-1
Received: by mail-wm1-f69.google.com with SMTP id 131-20020a1c0289000000b003a3497306a8so1742196wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ndVyxggE9NRkNXPrTefS8i3sDBY7mXSC7xSnt5hqVcI=;
        b=2beK1srR4Lw3SHcQh8t+Rt5qgU5qfAt7cAyzB0SYm/Rejx5e69C7qn1R7vkdfSwLBy
         w+Xx1A36WCySobHs6YFuxpcv4QgqbgE33Hki06OjJziKP6Kro60WLsjkPCe+fGB6LFA5
         L41ie9g/Ho2+WLJhMqzkEmhaC9yWExLygJII7JNp1Ynml1NMAqcG5jlb0ZPvycnatS24
         RhI86hiQrKElYyB+8+SEWPXhDMIhimRIxsidT5DOyeLQgBlCWho5QyVsA286VOMLnJMU
         sZ32ihihuo3K40Db2F28yLBZbU1BZWwzaJEK3PTkO+og7ygJO/FhNIwJ4nT7MB551Pcp
         Krnw==
X-Gm-Message-State: ACgBeo26BFvESDJuxLXwzRBkmgJcQtdM7MQAYMFIEwkYgYYrHpDsybMg
        feUwyQHyG7vqWgFr/EGYmWTcyMnZ0kPE48pW4FaOVmjPDp31p8xJLidYj1MEg+If1m2k5+HFwK7
        gIQMnm86LG+GrUl+KMeWL6y7v
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr536575wrs.347.1659047101750;
        Thu, 28 Jul 2022 15:25:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Q9rKQXjFh0ctRsdAdZhnqZ3N2P/1jov3HzMQFk5kNK/RNIbPCnkKzM1LTMgw0NuP7UzQJXA==
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr536558wrs.347.1659047101267;
        Thu, 28 Jul 2022 15:25:01 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id a6-20020a5d53c6000000b0021ea5b1c781sm2112257wrw.49.2022.07.28.15.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 15:25:00 -0700 (PDT)
Message-ID: <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
Date:   Fri, 29 Jul 2022 00:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 09/25] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-10-vkuznets@redhat.com> <YtnMIkFI469Ub9vB@google.com>
 <48de7ea7-fc1a-6a83-3d6f-e04d26ea2f05@redhat.com>
 <Yt7ehL0HfR3b97FQ@google.com>
 <870d507d-a516-5601-4d21-2bfd571cf008@redhat.com>
 <YuMKBzeB2cE/NZ2K@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YuMKBzeB2cE/NZ2K@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 00:13, Sean Christopherson wrote:
> The only flaw in this is if KVM gets handed a CPUID model that enumerates support
> for 2025 (or whenever the next update comes) but not 2022.  Hmm, though if Microsoft
> defines each new "version" as a full superset, then even that theoretical bug goes
> away.  I'm happy to be optimistic for once and give this a shot.  I definitely like
> that it makes it easier to see the deltas between versions.

Okay, I have queued the series but I still haven't gone through all the 
comments.  So this will _not_ be in the 5.21 pull request.

The first patch also needs a bit more thought to figure out the impact 
on userspace and whether we can consider syndbg niche enough to not care.

Paolo

