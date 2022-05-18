Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7618452BE22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiEROnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiEROnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22CDA1D4A35
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652885023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhIAzrZlP5b0i3o1JZmMpkBOPZBq8P077L23uqMpDbI=;
        b=a8u06DJvFOB9zR5/sCkQrIZ1649OVWbRgtNgiMk3q75jFKvCopEqznWUNp0+NaUUd7Lqpb
        CAABPnie3f3MdaTSPEBdaSIikM3mvMyLB47J9yjyQOs7l7BlbwGiYth1xvZ5ycUkFpQpQP
        jw+smOWTwz0R7BQ3nW3+WfJf+Wt9g0o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-VS5megc2Pn-OnpRpYsF3zg-1; Wed, 18 May 2022 10:43:41 -0400
X-MC-Unique: VS5megc2Pn-OnpRpYsF3zg-1
Received: by mail-wm1-f70.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso856153wmm.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UhIAzrZlP5b0i3o1JZmMpkBOPZBq8P077L23uqMpDbI=;
        b=d/J2G5zaeE8PYLLUMfETUqnGZYphDcyposObnRly1CMt8is6HvI0+0M3WMvVxScqFg
         8yPMsXVWDWcv09neYfod40UYZOOH7NB1U9Ox+qxE2Xthmo7XcECNecVw2+Rlpe9+Oeb9
         FLDZUGEVhdIcV65CVqRLsH2UqF3fP/3sRQf3FeqPWKwD5GjCPiroQJzUWxK/SXjvqkAt
         Vb+Uh6KKmV/eMT/JYIWU5kr3yzJm2qqtmqNPkdS4c2hEJ7/cPwHcorghxStSMTOer5S0
         IqhmB/TjXNCCBJGeTb0FBfz1vj0TPSYZouYXuGRiWZ5cGuUHY0Ri4QOBwjI10HNOgX4i
         8+3A==
X-Gm-Message-State: AOAM531Wsu4bWhxc1j8oIpH466JKvgTfyWhygE3Uv2f1v4i5Ptk8KnjK
        jMJVApOlOeGPARs3Iz6M8rfAEeejYTAOmhv2TRM78ZC7Fop0CS4G3804VatsDd1pOHJZYSbW0xJ
        BBM91g2jSQR4qNEkPnr824S+g
X-Received: by 2002:a05:6000:154a:b0:20c:7e65:c79e with SMTP id 10-20020a056000154a00b0020c7e65c79emr42571wry.582.1652885020774;
        Wed, 18 May 2022 07:43:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1tUZPrs0aGeRCeoRMTq7S873vylB577Hd5LWEh1T4z3FePha2SLMPoPBbOBefUrEfYhTqTQ==
X-Received: by 2002:a05:6000:154a:b0:20c:7e65:c79e with SMTP id 10-20020a056000154a00b0020c7e65c79emr42555wry.582.1652885020577;
        Wed, 18 May 2022 07:43:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003942a244edfsm1947203wmb.36.2022.05.18.07.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 07:43:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 04/34] KVM: x86: hyper-v: Handle
 HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently
In-Reply-To: <YoUAM9UtfQlGOZxl@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-5-vkuznets@redhat.com>
 <165aea185dfef1eba9ba0f4fd1c3a95361c41396.camel@redhat.com>
 <877d6juqkw.fsf@redhat.com> <YoUAM9UtfQlGOZxl@google.com>
Date:   Wed, 18 May 2022 16:43:39 +0200
Message-ID: <87y1yyucis.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, May 18, 2022, Vitaly Kuznetsov wrote:
>> Maxim Levitsky <mlevitsk@redhat.com> writes:
>> > Or if using kfifo, then it can contain plain u64 items, which is even more natural.
>> >
>> 
>> In the next version I switch to fifo and get rid of 'flush_all' entries
>> but instead of a boolean I use a 'magic' value of '-1' in GVA. This way
>> we don't need to synchronize with the reader and add any special
>> handling for the flag.
>
> Isn't -1 theoretically possible?  Or is wrapping not allowed?  E.g. requesting a
> flush for address=0xfffffffffffff000, count = 0xfff will yield -1 and doesn't
> create any illegal addresses in the process.
>

Such an error would just lead to KVM flushing the whole guest address
space instead of flushing 4096 pages starting with 0xfffffffffffff000
but over-flushing is always architecturally correct, isn't it?

Personally, I'm not opposed to dropping the magic and enhancing flush
entries with 'flags' again but I'd like to avoid keeping this info
somewhere aside. Also, after we switch to kfifo, we can't play with
ring indexes to somehow indicate this special case. We probably can use
'fifo is full' as such indication but this is very, very un-obvious.

-- 
Vitaly

