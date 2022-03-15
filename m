Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4514DA467
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351892AbiCOVOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351896AbiCOVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 679D6140BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647378779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/Oxo2Zf/jCAmwn2Cz21fK7yT+TLG75ZLqETpuHgIms=;
        b=BvK14RQ/2l7S0xMuuzI5ox50lG84ZiNeurwHCsw9vw1F+Z6yGNwqpnYqusoT4prWiwy2Io
        LZsw0OvAzVXPRnf2C5bemkm+Q8bzvZA+nKQYXLYZnxwqUyKsmlv0YCPgufvWuaUs5diJpo
        zU6f9q2Mfsh+t4VAiKY0EXJjpfMawyw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-bdde6Y_jOjaqzviGGfdnYw-1; Tue, 15 Mar 2022 17:12:57 -0400
X-MC-Unique: bdde6Y_jOjaqzviGGfdnYw-1
Received: by mail-wm1-f70.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so1063004wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S/Oxo2Zf/jCAmwn2Cz21fK7yT+TLG75ZLqETpuHgIms=;
        b=TfhDAFN//TmrCwrpjziUH919QGWecV20jM7TlthDK2i7TdFF861UHFT55uEl9wn9r+
         O/ioJR/dssZgxkSm9wQ9omg1erOVAWQ8GVDNDim9E3oVuSqk6QWei8wHBuk9V66sz4xq
         i0XnJBs7uqwQQCop3dMGpSbhE5kzSO8636Bj6TiKGDbWl3C6AgvyGUBQ+C5m+qPiV7YV
         PJN/nqwCxvlhv9xPUKVVrIEI9tv6xDQRzUasInjPa2bjoOoIBPQwQ166dvyw176pu48C
         1gChdTmu8vXe2sPYDhv2i7UGPs44OOb5pRgWtnQ0erq7N/o5m1205A2D/a6BeD4cGYTy
         s7NA==
X-Gm-Message-State: AOAM531hXGt6oaxAyUsEFv2vKWToGmMoviCegxmwKnThKeiUTbW+jEvo
        5R6Fd3YrWcrCSE7+JNtGff/5NBl2/U1O1/YYXGi5+rKRNCBjlz7Z/bh0N5zKG+lBDxQKdczIzkf
        aUfMaEwflroy/HxPpTuNqkg7V
X-Received: by 2002:a05:600c:42c1:b0:389:8310:1128 with SMTP id j1-20020a05600c42c100b0038983101128mr4868248wme.3.1647378776703;
        Tue, 15 Mar 2022 14:12:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3Rs6Zc4YkLmBuIxVEDciW9Wq9T9wjxv8N/ar8OuoX76JXewHflmabVT9DwIW65yRsimPGKQ==
X-Received: by 2002:a05:600c:42c1:b0:389:8310:1128 with SMTP id j1-20020a05600c42c100b0038983101128mr4868241wme.3.1647378776522;
        Tue, 15 Mar 2022 14:12:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id j42-20020a05600c1c2a00b00389d2ca24c9sm9638wms.30.2022.03.15.14.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 14:12:55 -0700 (PDT)
Message-ID: <61684923-30eb-96eb-7c76-bab9119667bd@redhat.com>
Date:   Tue, 15 Mar 2022 22:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] KVM: x86: Trace all APICv inhibit changes and capture
 overall status
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Chao Gao <chao.gao@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220311043517.17027-1-seanjc@google.com>
 <20220311043517.17027-4-seanjc@google.com> <20220315144249.GA5496@gao-cwp>
 <57c2d5d64f9d65e442744fa8b7f188ed3fd37c1c.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <57c2d5d64f9d65e442744fa8b7f188ed3fd37c1c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 15:48, Maxim Levitsky wrote:
>> Note that some calls may not toggle any bit. Do you want to log them?
>> I am afraid that a VM with many vCPUs may get a lot of traces that actually
>> doesn't change inhibits.
> I also think so.

Let's keep Sean's version for now, it may also be useful to see the 
state changes for all vCPU threads (based on the pid field in the 
trace).  We can always change it later if it's too noisy.

Paolo

