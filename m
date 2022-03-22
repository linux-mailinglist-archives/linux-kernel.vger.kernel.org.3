Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEB14E3C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiCVKOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiCVKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51BA9119
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647943976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQp1gYLyNcExNlv89/UFFWzjc9zXJmAYUKrBW18aegE=;
        b=UDn0N7n7/lxQIRybk10EsLNFyMFOIEOWOcX4cN0mbpD7TxttEHsBijHpP1xp3/JZn7rdu3
        ixpcxEn5mpDTM1wvos9PrpVdh4fI1UokIF+k/Vmo9GATKs90Ms/IXf1vnbJ6Kmxhok+S5x
        ko1NY7euY9sfGBZZi6L+Jd1aghP7yGE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-9iNIkC2aMhOrBejWVGcsbA-1; Tue, 22 Mar 2022 06:12:55 -0400
X-MC-Unique: 9iNIkC2aMhOrBejWVGcsbA-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a509549000000b00418d7c2f62aso10247175eda.15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YQp1gYLyNcExNlv89/UFFWzjc9zXJmAYUKrBW18aegE=;
        b=BsUBEA9HgmKcNzRhCGr24sxZ4WYDLGPMGkZ2gvIdMx5v5NKAvD8ZJ2qQychdIG/QO8
         VmS8q5mEKPIuyLC+4TGS4EhioHJIdFFP0YyPyQCdbJEhgYF+IP/8Ej3UeNegxZZ/YP5e
         b7LTeSsgoQRGZtBOgm7FdQkbK4KlM6TE7g1oXczaAgS3C/gnhT+PksuRaTx0kTkT60vc
         iHhI+Xz+6tSO6shLTwzulkPYRuzZs1TeQWW46U7yZ6+YWTQSlVDFp8AXPzut4JtCH/RL
         iSFUKdqFm4xGkWgGQUdJNJevZCuKjy0AY5ATSBYTr4Yyt9klKbD842LxTWRZfrWDjqjf
         PwIA==
X-Gm-Message-State: AOAM530PNWrZ8vz+q9VLW7fGNi4XvyjSH7yrgXiXXbKsuQ9THLi5cKdB
        vsjJASqDqeRDUqjHCWCIshwFGGQW9L6VQ10wtRyy3gEOJP5/eFFFpA68nj+h8vSdAdOq4wTABy4
        noeBZXd2I39mo6Pzg0Uz1pm5Z
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr25061538ejc.217.1647943974083;
        Tue, 22 Mar 2022 03:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDBB9tGmtD3a23htpdMy5Uitfw5FvxbGEfQJ0gNsoD+jzGxh0echsqZesil7pTtNq0t5Cnhw==
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr25061522ejc.217.1647943973849;
        Tue, 22 Mar 2022 03:12:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id d2-20020a50cf42000000b004135b6eef60sm9356472edk.94.2022.03.22.03.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:12:53 -0700 (PDT)
Message-ID: <b81c095a-30b2-95c6-1b5f-dfa102f5790a@redhat.com>
Date:   Tue, 22 Mar 2022 11:12:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/7] KVM: x86: nSVM: support PAUSE filter threshold and
 count when cpu_pm=on
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>
References: <20220301143650.143749-1-mlevitsk@redhat.com>
 <20220301143650.143749-5-mlevitsk@redhat.com>
 <CALMp9eRjY6sX0OEBeYw4RsQKSjKvXKWOqRe=GVoQnmjy6D8deg@mail.gmail.com>
 <6a7f13d1-ed00-b4a6-c39b-dd8ba189d639@redhat.com>
 <CALMp9eRRT6pi6tjZvsFbEhrgS+zsNg827iLD4Hvzsa4PeB6W-Q@mail.gmail.com>
 <abe8584fa3691de1d6ae6c6617b8ea750b30fd1c.camel@redhat.com>
 <CALMp9eSUSexhPWMWXE1HpSD+movaYcdge_J95LiLCnJyMEp3WA@mail.gmail.com>
 <8071f0f0a857b0775f1fb2d1ebd86ffc4fd9096b.camel@redhat.com>
 <CALMp9eQgDpL0eD_GZde-s+THPWvQ0v6kmj3z_023f_KPERAyyA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eQgDpL0eD_GZde-s+THPWvQ0v6kmj3z_023f_KPERAyyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 23:41, Jim Mattson wrote:
>> 100%. Do you have a pointer where to document it?
> I think this will be the first KVM virtual CPU erratum documented,
> though there are plenty of others that I'd like to see documented
> (e.g. nVMX processes posted interrupts on emulated VM-entry, AMD's
> merged PMU counters are only 48 bits wide, etc.).
> 
> Maybe Paolo has some ideas?

So let's document them, that's a great idea.  I can help writing them 
down if you have a pointer to prior email discussions.  I'll send a 
skeleton.

Paolo

