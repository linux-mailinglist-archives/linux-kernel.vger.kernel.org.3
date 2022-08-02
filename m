Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE54F58813B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiHBRnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiHBRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E05C4D17B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659462174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SK7bFw/0R7/hTM55OR2c83JALu5NeuiKS9q8ZWkjFk=;
        b=W+39XnN8KdD5LpmWa9r2t4tdEwyYsq9SNOxF7/wyhTRuck22bzd1vgSEoDO2JzYgaFVzbx
        z6ZMGuHalIhTf9C4eTS2GtVsJ0AqfPm6OaYuMQG8+H38Fn9k2Eq9kxa5dt6+c1Z7LO4/ER
        Ta4IqfKhNYSKl9srDsG5fTAe3e8hLOc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-d1N3iltMN1iGaekgqWq16A-1; Tue, 02 Aug 2022 13:42:53 -0400
X-MC-Unique: d1N3iltMN1iGaekgqWq16A-1
Received: by mail-wr1-f72.google.com with SMTP id w17-20020adfbad1000000b0021f0acd5398so3583055wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9SK7bFw/0R7/hTM55OR2c83JALu5NeuiKS9q8ZWkjFk=;
        b=pntrjVYj1U8jXRYn7to59h6RHt6jojRfqxAs1EbfKjtp+ldmP+8QBh7j+IPHmiK9cz
         i+MAcoY9+aUEeyJesmT2Vf5ccZn4DNSRF5daWDBxV4k1u+aDCssasSUiW6k1tKjTVC2m
         25Ngi4yUzWOQE/77XlsvFyTCxWXQ1NHsEjyMZbB7T/ndNBn7kvwjsPHB/G+DvRcxpalh
         dSSugCULs8O62SYme0cLr0di2K86vRUM+drO6n8vcPm6BWWK9DtVFpO2GgEPIBs+cl32
         5XgaIFIF/IUutNbEnpZtu5z3397w4Ku+jGoFt7sqMsjrTaonoCDvP+0b5b1TTNEysn0c
         GfAg==
X-Gm-Message-State: ACgBeo1cZ3wGIFWrLE84GFFq9FG7W/Q2F4jehcH10Il2XxS1t5CGWwcR
        eRrNIh/fd00OPZUeRU6ht4IxII3ORNhzAw9aq/XaV2su7Hz3SQuZNWtKkJ8OCpI8fkZ4LKv3bEz
        VozT8IuOGNGRlKNrAX2qF4d13
X-Received: by 2002:a1c:f718:0:b0:3a3:2416:634d with SMTP id v24-20020a1cf718000000b003a32416634dmr352843wmh.83.1659462172005;
        Tue, 02 Aug 2022 10:42:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+GmtZBuIt1gi72koKOE5H8qmVdhDI9l+aloFYOwLKRdQlZ9zYY5O7hosx3FfQSnhMnFMn+A==
X-Received: by 2002:a1c:f718:0:b0:3a3:2416:634d with SMTP id v24-20020a1cf718000000b003a32416634dmr352835wmh.83.1659462171743;
        Tue, 02 Aug 2022 10:42:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id a1-20020adfe5c1000000b0021e491fd250sm9673171wrn.89.2022.08.02.10.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 10:42:51 -0700 (PDT)
Message-ID: <4ccbafb5-9157-ec73-c751-ec71164f8688@redhat.com>
Date:   Tue, 2 Aug 2022 19:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801151928.270380-1-vipinsh@google.com>
 <YuhPT2drgqL+osLl@google.com> <YuhoJUoPBOu5eMz8@google.com>
 <YulRZ+uXFOE1y2dj@google.com> <YuldSf4T2j4rIrIo@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: Make page tables for eager page splitting
 NUMA aware
In-Reply-To: <YuldSf4T2j4rIrIo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 19:22, Sean Christopherson wrote:
> Userspace can already force the ideal setup for eager page splitting by configuring
> vNUMA-aware memslots and using a task with appropriate policy to toggle dirty
> logging.  And userspace really should be encouraged to do that, because otherwise
> walking the page tables in software to do the split is going to be constantly
> accessing remote memory.

Yes, it's possible to locate the page tables on the node that holds the 
memory they're mapping by enable dirty logging from different tasks for 
different memslots, but that seems a bit weird.

Walking the page tables in software is going to do several remote memory 
accesses, but it will do that in a thread that probably is devoted to 
background tasks anyway.  The relative impact of remote memory accesses 
in the thread that enables dirty logging vs. in the vCPU thread should 
also be visible in the overall performance of dirty_log_perf_test.

So I agree with Vipin's patch and would even extend it to all page table 
allocations, however dirty_log_perf_test should be run with fixed CPU 
mappings to measure accurately the impact of the remote memory accesses.

Paolo

