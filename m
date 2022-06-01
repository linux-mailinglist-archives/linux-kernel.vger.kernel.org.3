Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C45539F64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350707AbiFAIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350773AbiFAIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68A995F58
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654071907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PuqWSM1RqEiAAMMqRkf0RREiczy16fCzdCz4SZ9Yh8=;
        b=a3X3DM8Q450FYyesFUrHPF2J/QSKCH5+ZUisxb+Kbv+QX7wyMo398Ra6iaImtmW0AacKrV
        XM+xLz9Ds80MpETIpazRnyC8VSLUxSizGfbQMVStbTVa0VvutwAV2mqZyC6YxRV24huX4s
        yhrHFJnR8/d5YiAgA1IUVZvwC+Umh6I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-gQ_nIOOEPZ6Yd-dx0n06rA-1; Wed, 01 Jun 2022 04:25:06 -0400
X-MC-Unique: gQ_nIOOEPZ6Yd-dx0n06rA-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a05600c1c8500b003974c5d636dso783845wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9PuqWSM1RqEiAAMMqRkf0RREiczy16fCzdCz4SZ9Yh8=;
        b=RCmPJIoUd4MpgKUqVvrsWapVe3VQF6AQ/Jj/nMQH/eeER1JNp35S9dHJTM3/cW0fQx
         8aWOkJw2JVC82KMI+Vo9ktXpebaf1PUOLbtrD1S5VXQgNaapBoPnsv2+zwsn8cfBqc1g
         WBhYK+89ZchmT51Lsc6qsudpSo2YIKMm2U/cqLGb1oO37eLgwnCtZM6ND2Hx0OjSBqf3
         eBUfCccRES99SZqT7shksxz3ZGAyOoZvLOx378MIGtIIqfnlmjE7jQk1YjtYcp30sxah
         zsAryBrrM/hjt5LjD80LJ7DS6vP5cx7U/lTZH3MTOAxQFhAUMIwpt8s3Yxa74dV4BYem
         sqqQ==
X-Gm-Message-State: AOAM531VOAaUO2SZYbdq1PYzvlmND2l2dGeiF3V4OVV5ceOECoZ/5UuH
        IBE/fP0xjbaFYpiVof2a81eo9obAKqJOp/WzV63G2dAcKcK3kYM2cc9R32jPAxtrQFxcMxDQayV
        wpH4AWa12Oodchgdf2T0bZRVg
X-Received: by 2002:adf:fb46:0:b0:210:2316:dd02 with SMTP id c6-20020adffb46000000b002102316dd02mr17673880wrs.557.1654071905005;
        Wed, 01 Jun 2022 01:25:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRD/IRDpVLqPBmdGC0pIb4xFXUChVcdXWE70cLKfJv6Nh+TFUtXKaRUjy4B0vznzkaEH6ugw==
X-Received: by 2002:adf:fb46:0:b0:210:2316:dd02 with SMTP id c6-20020adffb46000000b002102316dd02mr17673852wrs.557.1654071904613;
        Wed, 01 Jun 2022 01:25:04 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:2c2a:4832:6517:63a])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b003973ea7e725sm6337978wmq.0.2022.06.01.01.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:25:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: ...\n
From:   Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <87r148olol.fsf@redhat.com>
Date:   Wed, 1 Jun 2022 10:25:01 +0200
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Durrant, Paul" <pdurrant@amazon.co.uk>,
        "Allister, Jack" <jalliste@amazon.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "diapop@amazon.co.uk" <diapop@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "metikaya@amazon.co.uk" <metikaya@amazon.co.uk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F662DF4F-930A-486E-86FB-97D54E535114@redhat.com>
References: <YpYaYK7a28DFT5Ne@hirez.programming.kicks-ass.net>
 <20220531140236.1435-1-jalliste@amazon.com>
 <YpYpxzt4rmG+LFy9@hirez.programming.kicks-ass.net>
 <059ab3327ac440479ecfdf49fa054347@EX13D32EUC003.ant.amazon.com>
 <YpcMw2TgNWzrcoRm@worktop.programming.kicks-ass.net>
 <87r148olol.fsf@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1 Jun 2022, at 10:03, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> Peter Zijlstra <peterz@infradead.org> writes:
>=20
>> On Tue, May 31, 2022 at 02:52:04PM +0000, Durrant, Paul wrote:
>=20
> ...
>=20
>>>=20
>>> I'll bite... What's ludicrous about wanting to run a guest at a =
lower
>>> CPU freq to minimize observable change in whatever workload it is
>>> running?
>>=20
>> *why* would you want to do that? Everybody wants their stuff done
>> faster.
>>=20
>=20
> FWIW, I can see a valid use-case: imagine you're running some software
> which calibrates itself in the beginning to run at some desired real
> time speed but then the VM running it has to be migrated to a host =
with
> faster (newer) CPUs. I don't have a real world examples out of top of =
my
> head but I remember some old DOS era games were impossible to play on
> newer CPUs because everything was happenning too fast. Maybe that's =
the
> case :-)

The PC version of Alpha Waves was such an example, but Frederick Raynal,
who did the port, said it was the last time he made the mistake. That =
was 1990 :-)

More seriously, what about mitigating timing-based remote attacks by
arbitrarily changing the CPU frequency and injecting noise in the =
timing?
That could be a valid use case, no? Although I can think of about a
million other ways of doing this more efficiently=E2=80=A6


>=20
> --=20
> Vitaly
>=20

