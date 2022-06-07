Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8553F7E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbiFGIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiFGIIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B21925A5BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654589284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZTgjDf+UWl4UtFCiXYtarwLaB8M/ZFWa3rfAZbcUBI=;
        b=Qq7ORn2465iBM0oV3by4mSlr8WQQvUNOHcxCTuPTJ1qcQyW4pTIAbns29rAjUFFV+yyOhS
        aIKSr8riboqY73+DCuJHvOpBgVPctbDDwMm63NUovrhAz3ermozPF7vNXV8yR4YrrhnN+S
        omAZIq/jC05qwBKrNFVKId9oku3dVoA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-HJWxz1ApOi-39tXJdDBKUQ-1; Tue, 07 Jun 2022 04:08:03 -0400
X-MC-Unique: HJWxz1ApOi-39tXJdDBKUQ-1
Received: by mail-qk1-f199.google.com with SMTP id v14-20020a05620a0f0e00b00699f4ea852cso13552381qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IZTgjDf+UWl4UtFCiXYtarwLaB8M/ZFWa3rfAZbcUBI=;
        b=fmW9QJ6EAJ9YGqcR9JKekdsZ3KlR8kIQQd+aAFnNy0XeQ3P2hkVCb6doktROG6J0hM
         D3ro65lsJrjVltS74QZ8QCX59uLU8lDIN4Qiy51kGamqYU36kN6SRZBuXA7r8kMM1+5z
         /88o6YdJleyI8bANczdqSTvDzsSxfYWBzHFOvLV93xzlOef84NwOFUx40c2R5RRd/OjD
         XrjsW2szHFkwl1XT6HAtUlqQYjDGScEBzpvvlJxBAurB+iw5rajMX47JYZKlUH4sXJlV
         sCCz8dBQrWyNMeQZosz4HArcNByoF0+WfdW1lEHNJH/gYJmeALQGx5BLyhK/fzW/Kxwo
         Vwyw==
X-Gm-Message-State: AOAM531Mn/LnUxGJsRQsooyUy6l9tIZRV0VHCHX/k0prqv//cNVxy7Lp
        VyywsCWwiRZyycapYmMkevXjZTPplDXi9m+CHvCfTktpMb321qDg3VF8fFPbK4GPNfeN7MwbILr
        H+t+2m+qml+xd23yBc+onkz4a
X-Received: by 2002:ac8:590a:0:b0:304:b5f4:941e with SMTP id 10-20020ac8590a000000b00304b5f4941emr22023366qty.46.1654589282368;
        Tue, 07 Jun 2022 01:08:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycQP/GTtOsz6+QIATq+TualN4Uxn7cN48AFOCttf+Fq0iyROoF2An3yCeUmiaLnBG0VYMgCQ==
X-Received: by 2002:ac8:590a:0:b0:304:b5f4:941e with SMTP id 10-20020ac8590a000000b00304b5f4941emr22023357qty.46.1654589282107;
        Tue, 07 Jun 2022 01:08:02 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id ay16-20020a05620a179000b006a6991233a3sm9539677qkb.126.2022.06.07.01.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:08:01 -0700 (PDT)
Message-ID: <2a20d49f5a18ecd3a76a96dec01ad592a59bdc3f.camel@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Make hyperv_clock selftest more stable
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 11:07:58 +0300
In-Reply-To: <YpeOkx0gkINeKFuz@google.com>
References: <20220601144322.1968742-1-vkuznets@redhat.com>
         <YpeOkx0gkINeKFuz@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-01 at 16:06 +0000, Sean Christopherson wrote:
> On Wed, Jun 01, 2022, Vitaly Kuznetsov wrote:
> > hyperv_clock doesn't always give a stable test result, especially
> > with
> > AMD CPUs. The test compares Hyper-V MSR clocksource (acquired
> > either
> > with rdmsr() from within the guest or KVM_GET_MSRS from the host)
> > against rdtsc(). To increase the accuracy, increase the measured
> > delay
> > (done with nop loop) by two orders of magnitude and take the mean
> > rdtsc()
> > value before and after rdmsr()/KVM_GET_MSRS.
> 
> Rather than "fixing" the test by reducing the impact of noise, can we
> first try
> to reduce the noise itself?  E.g. pin the test to a single CPU, redo
> the measurement

Pinning is a good idea overall, however IMHO should not be done in 
all KVM selftests, as vCPU migration itself can be source of bugs.


> if the test is interrupted (/proc/interrupts?), etc...  Bonus points
This is not feasable IMHO - timer interrupt alone can fire at rate of
1000 interrupts/s. Just while reading /proc/interurpts you probably get
few of interrupts.


> if that can
> be implemented as a helper or pair of helpers so that other tests
> that want to
> measure latency/time don't need to reinvent the wheel.
> 

Best regards,
	Maxim Levitsky

