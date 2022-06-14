Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2DB54B75E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbiFNRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiFNRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D33E201A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655226644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdTx0UxZNie9egiNrklzoc2+ItGio2T/VUZ8M/iIzT0=;
        b=T4ggdqZRc+h6MPK9LpxEa1PBObhZjdQQ5IktKoU/aDp8ZgqzLlFUbxO0zoYqHR4e5GQXxq
        ROhnA0gH+YFG0tQGrNWStPg4zoIaUnhk4l7YN8dtd5SROBqg9y5TUiXgsAVNkhCATz6M5f
        QUDI3HKWVTr5xYUTiOBGu0s59+dLyLg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-PY3QEOCLMyimevHu1Sw1pQ-1; Tue, 14 Jun 2022 13:10:42 -0400
X-MC-Unique: PY3QEOCLMyimevHu1Sw1pQ-1
Received: by mail-wm1-f71.google.com with SMTP id j20-20020a05600c1c1400b0039c747a1e5aso5075951wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wdTx0UxZNie9egiNrklzoc2+ItGio2T/VUZ8M/iIzT0=;
        b=GpzTOSb/ImaPphFEW+La7hDFzhzmu18xIq/R5C+uurzdFTmEJ1OV8Tfrr7DSd1bQ6q
         q/rMQIlg/aTP0rUgMTUDeHguHeO6aAP/aMosqLg5gT6msRShdFMrXGw1nDUa4aDAzkpX
         +d3qpvu0b6PLiFlWp2wbZ+jwyo4M80vuIz6yodDyjzOzczMb+EkGlDEgCHnnb6nKHZuP
         jQBnHl1Q9ceIfipAHU1ydnWBBp0erlEFBd/2PsSQzXEBXzIOPCbxVYwFO22oVkTlAgeN
         HDbqjHwci0ZfXJb8Kt/XDMEVsWs/a1zQhiZnNCxbsuZF/j4khWNfAuklKllTmBNw+yUZ
         lj3Q==
X-Gm-Message-State: AJIora9oDwjtGt+QNESueIwYWG53r576v+c3lESOj6sXo7yu1rk+wQlt
        vFZD25d3fXn5zmealLk8LnYCeR4Ur6hxooUqUZX7yT7lxfigbq3kb3csVoEqp18y7k/OAgjrkm7
        Kpq6KOKvcKgo+BR7Iw4CaRjfF
X-Received: by 2002:a5d:5222:0:b0:213:b7f7:58fe with SMTP id i2-20020a5d5222000000b00213b7f758femr5502059wra.620.1655226641542;
        Tue, 14 Jun 2022 10:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t9/AkMew9VeDM8YYt21zvgf/5/6NovrH8S/spj9cUNFHVR2U9Nsa7Do36pfJPc1RFOGvs39g==
X-Received: by 2002:a5d:5222:0:b0:213:b7f7:58fe with SMTP id i2-20020a5d5222000000b00213b7f758femr5502044wra.620.1655226641339;
        Tue, 14 Jun 2022 10:10:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id r20-20020a05600c35d400b0039c1396b495sm14287976wmq.9.2022.06.14.10.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:10:40 -0700 (PDT)
Message-ID: <25edd702-3364-921c-2bcf-015fd86296c4@redhat.com>
Date:   Tue, 14 Jun 2022 19:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/8] KVM: x86/mmu: Drop unused CMPXCHG macro from
 paging_tmpl.h
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)" 
        <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20220613225723.2734132-1-seanjc@google.com>
 <20220613225723.2734132-2-seanjc@google.com>
 <CAJhGHyDjFCJdRjdV-W5+reg-3jiwJAqeCQ7A-vdUqt+dToJBdA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAJhGHyDjFCJdRjdV-W5+reg-3jiwJAqeCQ7A-vdUqt+dToJBdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 04:13, Lai Jiangshan wrote:
> On Tue, Jun 14, 2022 at 6:59 AM Sean Christopherson <seanjc@google.com> wrote:
>>
>> Drop the CMPXCHG macro from paging_tmpl.h, it's no longer used now that
>> KVM uses a common uaccess helper to do 8-byte CMPXCHG.
>>
>> Fixes: f122dfe44768 ("KVM: x86: Use __try_cmpxchg_user() to update guest PTE A/D bits")
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> 
> In https://lore.kernel.org/lkml/20220605063417.308311-2-jiangshanlai@gmail.com/
> two other unused macros are also removed.
> 

Queued that one, thanks!

Paolo

