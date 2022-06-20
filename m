Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178C255177D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiFTLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiFTLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6457A15FD3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655724811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3PbCQbIK7HmUq+A4wdqW1zRM8TVyI16FcVAtMkTtwns=;
        b=dLgGBXxWqu74ukngw6HQmTnZJd1V3a/ny1dQ8kjEPGOa0igty37kNtk+TOM0LugeBsqRU0
        cXHchhY2CdtvWZ930ph32/tpYvX5lPQu29yIOSR+tqoUmdV5O9JTtjJZSX7QAkhhhdP/TP
        uMWBDDvwKdVnku7ry+mPsTnd4pG1uuk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-urmT8y6tP3akduD2cPofMg-1; Mon, 20 Jun 2022 07:33:30 -0400
X-MC-Unique: urmT8y6tP3akduD2cPofMg-1
Received: by mail-ed1-f72.google.com with SMTP id w14-20020a056402268e00b0043556edda4dso7780138edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3PbCQbIK7HmUq+A4wdqW1zRM8TVyI16FcVAtMkTtwns=;
        b=OK9ya5xlqrjGB5HPgK5KsCI1O5gyUUQBt06VRE0IwmUNFbR3uhK22li0Sn2jXRgqEK
         pPVLYEzQBkbOvWA21Y7bVTSPGvwgcSi6/oDiX11ot2XNfTVs/QpbFxBfcArzFWh1iXSI
         KnBGe8iYFbYFswE2+0pFNcGkiPLryW522JKVVU8HkMYwAwku0jQ3KdbXfEQT+aWyN6LS
         fhu1nItxOjveYyxBESxb3xlYntWkJbq3NMCL7E+dvpUKoKw3UZjE4SzBE6FzA0kGXLDB
         my4piLuMUMbXws2kQOwP+yhvpHD6ZuRseikE3R2JJcef4a+SJxOplw3hWj3Dl+ytaWAi
         gYWA==
X-Gm-Message-State: AJIora8EeYEbynleO6+cvOPbfGfZC5NzNpb7acdFUhGNpaYVZBazY+TC
        mNL3Fe7a/PNSRmwccQ/dYUElxuoJ5MtvEVDjDWYzy0YVfs5Ub+g1UG1n+dPaS5r2i52hxClYJq8
        8/6MKgr7TdsQDj8AwOuJ9g9yU
X-Received: by 2002:aa7:dd85:0:b0:435:64d1:5ba with SMTP id g5-20020aa7dd85000000b0043564d105bamr18660977edv.389.1655724809312;
        Mon, 20 Jun 2022 04:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tHnk2ocuWxsBwnqq7v2gZTo+b+WJkchX/7ahH1U/LmESuHPgZOhPNyLY8WwvbZRn6F8Jbjtg==
X-Received: by 2002:aa7:dd85:0:b0:435:64d1:5ba with SMTP id g5-20020aa7dd85000000b0043564d105bamr18660949edv.389.1655724809062;
        Mon, 20 Jun 2022 04:33:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id z19-20020a056402275300b004319b12371asm10485788edd.47.2022.06.20.04.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 04:33:27 -0700 (PDT)
Message-ID: <a844abdc-97c3-8e5a-94e7-ea967876f226@redhat.com>
Date:   Mon, 20 Jun 2022 13:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: 'WARNING in handle_exception_nmi' bug at
 arch/x86/kvm/vmx/vmx.c:4959
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?5r2Y6auY5a6B?= <pgn@zju.edu.cn>
Cc:     linux-sgx@vger.kernel.org, secalert@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, kangel@zju.edu.cn, 22121145@zju.edu.cn
References: <69ab985c.7d507.18180a4dcd7.Coremail.pgn@zju.edu.cn>
 <CACT4Y+anXSNgCW3jvsm8wPf0LPxW-kCmXTeno4n-BWntpMaZBA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CACT4Y+anXSNgCW3jvsm8wPf0LPxW-kCmXTeno4n-BWntpMaZBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/22 13:24, Dmitry Vyukov wrote:
> On Mon, 20 Jun 2022 at 12:25, 潘高宁 <pgn@zju.edu.cn> wrote:
>>
>> Hello,
>>
>>      This is Xiao Lei, Gaoning Pan and Yongkang Jia from Zhejiang University. We found a 'WARNING in handle_exception_nmi' bug by syzkaller. This flaw allows a malicious user in a local DoS condition. The following program triggers Local DoS at arch/x86/kvm/vmx/vmx.c:4959 in latest release linux-5.18.5, this bug can be reproducible stably by the C reproducer:
> 
> 
> FWIW a similarly-looking issue was reported by syzbot:
> https://syzkaller.appspot.com/bug?id=1b411bfb1739c497a8f0c7f1aa501202726cd01a
> https://lore.kernel.org/all/0000000000000a5eae05d8947adb@google.com/
> 
> Sean said it may be an issue in L0 kernel rather than in the tested kernel:
> https://lore.kernel.org/all/Yqd5upAHNOxD0wrQ@google.com/

Indeed I cannot reproduce these either on bare metal.

Paolo

