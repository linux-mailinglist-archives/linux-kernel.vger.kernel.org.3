Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB254763D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiFKPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiFKPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 618691A82A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654962689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhRp/pGhgveCjZGUs+5rCBmMFDNeRBkg8UfANY7q/7Q=;
        b=WCA8x0pQiCiNe9Wo/4SSa2IutroB+6RAT2vfpjUBjSXOZXD/llXwS/OpsBDtEp0uHnUrnr
        DnfXA6f+3q+O0joEjJjPS+2tFulIn86fCQ/XA3pURxQZ20Duh7KuIZVoRCEOVdzSyRDe9h
        tbuv4dQoOUtgPe4QmERwhKSK6yU4100=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-uaSfLbnUOGO3s6DKS_bN5A-1; Sat, 11 Jun 2022 11:51:28 -0400
X-MC-Unique: uaSfLbnUOGO3s6DKS_bN5A-1
Received: by mail-ed1-f71.google.com with SMTP id k7-20020aa7d8c7000000b0042dd4a5a393so1478310eds.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nhRp/pGhgveCjZGUs+5rCBmMFDNeRBkg8UfANY7q/7Q=;
        b=r6AxPlsDsF0TAEqMHIZFhfrkqwmQ3poXqfPF6uahUSdi7SzroNQBJfhKBdefuVN35A
         R8DJxB3c9yRzeiBhe+wU0bNi8InjGhevkMU4NAYIqo7MShI4v/hzoouYTfomORlT21oz
         2ccw6zOusEVbU/qqItk60k1YFxEAisGQvb5TkOGwhuU8liZGnRTr0UzTVFnhWwwrWjqD
         eYqvMKo5rKfuUFnxvyWBUjWHJEIxaQfm9CY4x2RXAtlZ4kxpImAiM6HF34fpe5ntqRkI
         o/P9miyPbxTVdCLEOX2kKHyLyH7yFfvdoHu5Yecv3J6F5N7RNcTfu9BY3bLzoPi8fbM7
         ta8A==
X-Gm-Message-State: AOAM5301VVe/wlWL58Cf51mRApJHSZp0tNSrwUcBt+qCEbzBCrLEFaUx
        srp0ghj/FeFzuPE1VZKX/dngIUjO/HvYGPZFwZ4lVzyrvLV3eGNDhusvM7nNqicUMu+QihKXl/0
        wObjzWMyXrUpaP2mUeTLuCpDk
X-Received: by 2002:a05:6402:23a2:b0:42d:d5f1:d470 with SMTP id j34-20020a05640223a200b0042dd5f1d470mr43214823eda.365.1654962687347;
        Sat, 11 Jun 2022 08:51:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7i/21cJ65P0sfonbSV4Xxlqt9fZPtGU+UdW0ennP9y/mw+amxh0Oy8KPFgQJlhQH/Z3jRXQ==
X-Received: by 2002:a05:6402:23a2:b0:42d:d5f1:d470 with SMTP id j34-20020a05640223a200b0042dd5f1d470mr43214806eda.365.1654962687159;
        Sat, 11 Jun 2022 08:51:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id lu33-20020a170906fae100b007041e969a8asm1189152ejb.97.2022.06.11.08.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 08:51:24 -0700 (PDT)
Message-ID: <a1e80ec8-67dc-bde4-8f17-5aa2b3b1a32a@redhat.com>
Date:   Sat, 11 Jun 2022 17:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Anup Patel <anup@brainfault.org>
Cc:     KVM General <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Marc Zyngier <maz@kernel.org>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <CAAhSdy0_50KshS1rAcOjtFBUu=R7a0uXYa76vNibD_n7s=q6XA@mail.gmail.com>
 <CAAhSdy1N9vwX1aXkdVEvO=MLV7TEWKMB2jxpNNfzT2LUQ-Q01A@mail.gmail.com>
 <YqIKYOtQTvrGpmPV@google.com> <YqKRrK7SwO0lz/6e@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YqKRrK7SwO0lz/6e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 02:34, Sean Christopherson wrote:
> I pushed a new version that's based on the current kvm/queue, commit 5e9402ac128b.
> arm and x86 look good (though I've yet to test on AMD).
> 
> Thomas,
> If you get a chance, could you rerun the s390 tests?  The recent refactorings to
> use TAP generated some fun conflicts.

I did so, rebased over David's nested dirty_log_perf_test patches and 
pushed to kvm/queue.

Paolo

