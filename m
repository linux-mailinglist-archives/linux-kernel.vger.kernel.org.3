Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C474E4E2ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351663AbiCURKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351690AbiCURKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0C382BF5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647882523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJfkHmVteh3T64TEzHnOxY0U7R9RqYwPmRB3l1CleQU=;
        b=DsjwguDXoeUrla7MDJh5Ni/NSgrao3jraCGbuaj2SLc4Jw2rCyb4A+9xTtSbfQValZ3dBT
        FpMooLsUnV3mSqprTJ0IaeIGDAG7ToX4dVkXfIJ1UvFDFqPReEmeFLRpzuaZcWYUXRrL7m
        T5z7YzoNjKtVLhx/5QGOOQoGqYkcNug=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-oBUT0MDQMX6Qu4SZSKQxgw-1; Mon, 21 Mar 2022 13:08:42 -0400
X-MC-Unique: oBUT0MDQMX6Qu4SZSKQxgw-1
Received: by mail-ed1-f69.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so9007646edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dJfkHmVteh3T64TEzHnOxY0U7R9RqYwPmRB3l1CleQU=;
        b=cGJxvc3D3nCSJXojkVcRKbS5D78w73NXmfAL4lln8oWL4A1sNyeTkT9N0G5iGVZPwd
         Wes4h54l5t1zLcuyROER89V2t1uoQlEYnnoQOGwdAWF92eMkatxaAo1Nr46PjKWy5e2J
         WZ5iRKiof4vaY2Rt/LrR0BUQCC80cW1uAvJjqteH8NckHIUMeka92iREFaYD3wlLlOPz
         gJ2W3m/IFnMzyemWZECARif4LAaiAvJX4LcJf3mQTRNs8EGQ9G33owqr10aSXopqciVl
         cDFTDB/PExDb3tBzu3yr6bXX4EJAUWYty65m2wEx/O1Z6qWovCg30Odh45uuZ0n3hdfL
         3LSQ==
X-Gm-Message-State: AOAM530/nPvUJrNQLR4c21Q/b67JalVxLHpeMuXhmJdNHpfhufzZWtOY
        F6ohgqbUStmXfIkqPkkh954cFgzFoXjnbGdWlmphaIHuiXGqGgjTm37Fm8b+QoMCVYPCnowmmYK
        y9HjpLCApIoYDGZ8+gVpHmIyK
X-Received: by 2002:a17:906:ae0c:b0:6a6:a09f:f8d5 with SMTP id le12-20020a170906ae0c00b006a6a09ff8d5mr21214467ejb.627.1647882521149;
        Mon, 21 Mar 2022 10:08:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9vOllZzruoK6Px19KOGf8G+AZzG2Lh5NsWDQstKlL8pkmJxJy/bkjawSFGfb/CaNq0Q1wkQ==
X-Received: by 2002:a17:906:ae0c:b0:6a6:a09f:f8d5 with SMTP id le12-20020a170906ae0c00b006a6a09ff8d5mr21214429ejb.627.1647882520644;
        Mon, 21 Mar 2022 10:08:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id bd12-20020a056402206c00b00418c9bf71cbsm8003710edb.68.2022.03.21.10.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 10:08:39 -0700 (PDT)
Message-ID: <d94532b7-67bc-295b-fe40-73c519b6f916@redhat.com>
Date:   Mon, 21 Mar 2022 18:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Marc Orr <marcorr@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220321150214.1895231-1-pgonda@google.com>
 <f8500809-610e-ce44-9906-785b7ddc0911@redhat.com>
 <CAMkAt6pNE9MC7U_qQDwTrFG5e8qaiWZ6f0HzR+mk4dCNC2Ue8A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAMkAt6pNE9MC7U_qQDwTrFG5e8qaiWZ6f0HzR+mk4dCNC2Ue8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 16:42, Peter Gonda wrote:
> On Mon, Mar 21, 2022 at 9:27 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 3/21/22 16:02, Peter Gonda wrote:
>>> SEV-ES guests can request termination using the GHCB's MSR protocol. See
>>> AMD's GHCB spec section '4.1.13 Termination Request'. Currently when a
>>> guest does this the userspace VMM sees an KVM_EXIT_UNKNOWN (-EVINAL)
>>> return code from KVM_RUN. By adding a KVM_EXIT_SHUTDOWN_ENTRY to kvm_run
>>> struct the userspace VMM can clearly see the guest has requested a SEV-ES
>>> termination including the termination reason code set and reason code.
>>>
>>> Signed-off-by: Peter Gonda <pgonda@google.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Brijesh Singh <brijesh.singh@amd.com>
>>> Cc: Joerg Roedel <jroedel@suse.de>
>>> Cc: Marc Orr <marcorr@google.com>
>>> Cc: Sean Christopherson <seanjc@google.com>
>>> Cc: kvm@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>
>> Looks good, but it has to also add a capability.
> 
> Thanks for the quick review! Just so I understand. I should add
> KVM_CAP_SEV_TERM or something, then if that has been enabled do the
> new functionality, else keep the old functionality?

No, much simpler; just something for which KVM_CHECK_EXTENSION returns 
1, so that userspace knows that there is a "shutdown" member to be 
filled by KVM_EXIT_SHUTDOWN.  e.g. KVM_CAP_EXIT_SHUTDOWN_REASON.

Paolo

