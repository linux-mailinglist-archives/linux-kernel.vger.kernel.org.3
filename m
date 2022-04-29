Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CA65144D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356130AbiD2Ivx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiD2Ivw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17492C4010
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651222112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j44ABfQoLltxcMt0c2HfidhVNagQghr3QdYc0SH5ZHg=;
        b=aaU2yu1y2wAOknin+zcreQdH4ZbJX3FaLm1LjuS+1eYmelMnKQbY7q1ZJ4z9gQtZXxvpxl
        CFspRdqrf5GEQ8N3zQ4AlYKW8SOfNKEgB06Nl2Gk3yGk3EN0fbMxnmO0PwH9CD3/SRaGvo
        sa/GnivYup51zhdQpl7yFXJzIRVjXek=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-2rGHZFm4NjWyuoppjk-Wnw-1; Fri, 29 Apr 2022 04:48:30 -0400
X-MC-Unique: 2rGHZFm4NjWyuoppjk-Wnw-1
Received: by mail-ej1-f70.google.com with SMTP id o8-20020a170906974800b006f3a8be7502so4212847ejy.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j44ABfQoLltxcMt0c2HfidhVNagQghr3QdYc0SH5ZHg=;
        b=Iq9/NcZDQgv0ZyU1TjpC2SWSR70SNxHz1POQkQN/imgCv6BOaTLxBs5PWhM+tTZ699
         l5nYVaP8iZMbDA2ugooOAMkR0oyVBXuVk67w35CA9i/vW6KCzhrsIlPCgeOA816m0CJx
         DqoHn36eWnZvpzZ4B3xNFYiYcYPotqqrBOI+tbabclU0fRqI2ipl1IoUnthMA9HZwf5/
         zxNxWyDT0+OBung1fm0i0UvTrPqTSph8aJ38PQS7qXNpXfW5rfH153nx6hg9KCUQwiUm
         7HqCZRydlPqTfUuK/6NjpcLhuk4ARRIYQqObvv9k94hK3pnenm/n3HirZsfyncdx1oDk
         I/Pg==
X-Gm-Message-State: AOAM53261gYLPjNKJiLrpcLgs9D2+7Ve0YDp271ex3Yua6RW7RcSfZ1o
        Ceq8vYvzeaSbOwjWqd7VD458+spT/vSrs17+tMgTa7eQvXDD9JYPdG69BF3iaokwe66swmqZTOn
        OsdV6DexFLrN/DqGxUVv8LX6i
X-Received: by 2002:a17:907:868c:b0:6f2:d939:630c with SMTP id qa12-20020a170907868c00b006f2d939630cmr32630761ejc.211.1651222109337;
        Fri, 29 Apr 2022 01:48:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzDSm/Wy3LhlYxAfl4v2YEjSte/OeUbnyjP+Ps5nFd2tf+MquRI+eye5FQEOO4r4SeTrFP7A==
X-Received: by 2002:a17:907:868c:b0:6f2:d939:630c with SMTP id qa12-20020a170907868c00b006f2d939630cmr32630744ejc.211.1651222109148;
        Fri, 29 Apr 2022 01:48:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id e13-20020a170906844d00b006f3ef214dc3sm434320ejy.41.2022.04.29.01.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:48:28 -0700 (PDT)
Message-ID: <0cfb1f41-381f-6621-0fe7-14a54059a90d@redhat.com>
Date:   Fri, 29 Apr 2022 10:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] KVM: SEV: Mark nested locking of vcpu->lock
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220407195908.633003-1-pgonda@google.com>
 <CAFNjLiXC0AdOw5f8Ovu47D==ex7F0=WN_Ocirymz4xL=mWvC5A@mail.gmail.com>
 <CAMkAt6r-Mc_YN-gVHuCpTj4E1EmcvyYpP9jhtHo5HRHnoNJAdA@mail.gmail.com>
 <CAMkAt6r+OMPWCbV_svUyGWa0qMzjj2UEG29G6P7jb6uH6yko2w@mail.gmail.com>
 <62e9ece1-5d71-f803-3f65-2755160cf1d1@redhat.com>
 <CAMkAt6q6YLBfo2RceduSXTafckEehawhD4K4hUEuB4ZNqe2kKg@mail.gmail.com>
 <4c0edc90-36a1-4f4c-1923-4b20e7bdbb4c@redhat.com>
 <CAMkAt6oL5qi7z-eh4z7z8WBhpc=Ow6WtcJA5bDi6-aGMnz135A@mail.gmail.com>
 <CAMkAt6rmDrZfN5DbNOTsKFV57PwEnK2zxgBTCbEPeE206+5v5w@mail.gmail.com>
 <20220429010312.4013-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220429010312.4013-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 03:03, Hillf Danton wrote:
> Wonder if local lock classes [1] help.
> 
> [1]https://lore.kernel.org/lkml/165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com/

No, they wouldn't.  Local lock classes are more of a per-subsystem lock, 
while here the issue is that we are taking an arbitrary amount of locks 
at the same time.

Technically it would be possible to put a struct lock_class_key in 
struct kvm_vcpu, but that wouldn't scale and would actually _reduce_ the 
likelihood of lockdep reporting bad things.

The effectiveness of lockdep comes exactly from using the same map for 
all locks in the class, so that AB/BA scenarios are caught throughout 
the whole life of the system.  If each lock has a separate they would be 
caught only if the "B" is exactly the same mutex in both AB and BA cases.

Paolo

