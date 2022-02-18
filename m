Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41DB4BBF3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiBRSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:14:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiBRSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:14:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C27B536300
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645208075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy/IK4V/mhCajFQx2hxF7UpJtAMmgdBhiWBJ5HepLmw=;
        b=H7qYIfmhsTgWiVsO3z7If/LanM/MMs3+BtaTCNAb7V87yePK1JVgkeKWIYWugMyO6ZCNFm
        rRmGBopki6PJ/u4XLWmuv2JL3HvYzgV0oRVlX4mMUd2HT7iE8U77LWINYXWVEPeF/fdGGy
        58qsB2BS21WKARFw6vVU3dszqWJgJBQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-Q1ypdXAHPZetnOlajbkDyg-1; Fri, 18 Feb 2022 13:14:33 -0500
X-MC-Unique: Q1ypdXAHPZetnOlajbkDyg-1
Received: by mail-ed1-f70.google.com with SMTP id b26-20020a056402139a00b004094fddbbdfso5978453edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vy/IK4V/mhCajFQx2hxF7UpJtAMmgdBhiWBJ5HepLmw=;
        b=xcU9SR3WuI++ohKMYq7UTF3vt/cSwr4UoLJZV0Rolm1b4tvo2UKxkPBAI2Kv6fYSSQ
         iqxxD9WMUNWX3xpxG/WaAScIfnGAVlLxvZkIo0UqgbN4LdvX+IDtEkrxdZdpCwx50yLf
         2lN0nwWq8LO+7rGtjdAftSh92vlOrvmWE00BoNgkkWEwyZFx7IxQBMiZOOcrXO8eWLHJ
         p/ewYG8jc/8H3Wo/6RIZBg8wocDy3RCrxkDdRDa/9FHNVM70R6TAYDeUQxNC0XyoNmSb
         dqn85I3xqfo6RhDzzioSSfRYbiUZSeq6qGTKfCpLQyF5cPaAq5bkRcyYYuu7PiMh3QTI
         qCxw==
X-Gm-Message-State: AOAM531npz179mVgePkmxqxFM8ooHumcAYrEbBuX3rqkYFBFNeqB5bw3
        CYkfLtkBsxYUCHwHrbf3rCBnvqIipFAWHX5fHKwPWVo+kS09WvAffrabih+yIferW3xHCxfQ/oj
        W2oB7PI+ilf6Di1MiBP0MO2nn
X-Received: by 2002:a17:907:766e:b0:6cf:d1d1:db1d with SMTP id kk14-20020a170907766e00b006cfd1d1db1dmr7451158ejc.503.1645208072323;
        Fri, 18 Feb 2022 10:14:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfPFU//Xg7klZt6Vb3buhqfNO6wio3MC0ppqJeKT7OkOn6q8yF9jxxvxKpgWHMVWAuWGmmzg==
X-Received: by 2002:a17:907:766e:b0:6cf:d1d1:db1d with SMTP id kk14-20020a170907766e00b006cfd1d1db1dmr7451145ejc.503.1645208072096;
        Fri, 18 Feb 2022 10:14:32 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id w4sm5090427edc.73.2022.02.18.10.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 10:14:31 -0800 (PST)
Message-ID: <6cef7c8a-10d3-9fc6-f68d-220fdfc079c1@redhat.com>
Date:   Fri, 18 Feb 2022 19:14:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] KVM: x86: Forcibly leave nested virt when SMM state is
 toggled
Content-Language: en-US
To:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+8112db3ab20e70d50c31@syzkaller.appspotmail.com
References: <20220125220358.2091737-1-seanjc@google.com>
 <db8a9edd-533e-3502-aed1-e084d6b55e48@linaro.org>
 <Yg/QKgxotNyZbYAI@google.com>
 <3561688b-b52c-8858-3da2-afda7c3e681f@linaro.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <3561688b-b52c-8858-3da2-afda7c3e681f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 18:22, Tadeusz Struk wrote:
> On 2/18/22 08:58, Sean Christopherson wrote:
>> This SMM-specific patch fixes something different, the bug that you 
>> are still
>> hitting is the FNAME(cmpxchg_gpte) mess.  The uaccess CMPXCHG 
>> series[*] that
>> properly fixes that issue hasn't been merged yet.
>>
>>    ==================================================================
>>    BUG: KASAN: use-after-free in ept_cmpxchg_gpte.constprop.0+0x3c3/0x590
>>    Write of size 8 at addr ffff888010000000 by task repro/5633
>>
>> [*]https://lore.kernel.org/all/20220202004945.2540433-1-seanjc@google.com
>>
> 
> Ok, that's good. I will keep an eye on it and give it a try then.

I'll poke PeterZ for a review next week.

Paolo

