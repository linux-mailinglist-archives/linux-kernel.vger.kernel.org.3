Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BAC52D23E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiESMPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiESMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A169BA568
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652962488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aRBcedztDVErkTvap/GROtONAbxkQWp2teij5HtPU3s=;
        b=d2WNs2Y6Hpfhe6/IyjEmNTE6SQsK9wlnw4qDH0WaOYR+i4sOoksTjBv0Z6YySWKg2tdJPb
        2e3xm7/C4LLobMsZnsnr3iIo60MXisxQa0BaAczmhAwq2pty6bTKiV34FU8GpeMOOzhi7G
        DPAZPbrldmXtVPDBzei8maW5vZtpzoc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-qkAW427eN_Cr5RF6lbapKQ-1; Thu, 19 May 2022 08:14:47 -0400
X-MC-Unique: qkAW427eN_Cr5RF6lbapKQ-1
Received: by mail-wr1-f72.google.com with SMTP id e6-20020adfef06000000b0020d08e465e2so1496611wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aRBcedztDVErkTvap/GROtONAbxkQWp2teij5HtPU3s=;
        b=MMboKKZrzI3Mt9gQSRBaZa93CEiOQZg5waksPABdoBQdUnIFNdOzTeDi2BLME0Ruiy
         fkLyR9oXcZiRjCpLbpM4ITUZ/TVBxZ99TfvEF9QDU3aS+bg2tFCYUJW7FtkzviiQd0Qa
         j70iUyAX3njoeInp0wkMO5hdofawzdqfjRGLEpg9aXskFRsedyG5DuIxCFGnulUHM1en
         1brejAWtQQi316WKy6D9F/zuXqO++TU1Gt91pSK4H0g15uVKQWgmRnsp/nloqfBcsahr
         w166htO1/KYGNJU9fl/cAjB1INgNUF7QiGAYLl5UD1j0vgZA5sB6K2qFR7bpqrabwP87
         GebA==
X-Gm-Message-State: AOAM533xFmEjbQ32N5ITq0x9Lj53FQ/V3X0q165OFfjGSrmh/oLuKiWS
        kewOr6jgfhYQS2ibpk7N9ITGJMEXAwRHXv2wqbTmNBeeh47RS5uNYHz+q4zuQ4iIb7v8uLq0zR/
        pkYPYRlt2ZURj/Q7ofsWZHSDm
X-Received: by 2002:a5d:644e:0:b0:20e:7267:9ef7 with SMTP id d14-20020a5d644e000000b0020e72679ef7mr753020wrw.520.1652962485994;
        Thu, 19 May 2022 05:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc+tWUUsH9tzuVJImbGkhJ0Ej3I7mAxCSsBZ31dKE1NnaH+Ud9Wbb8jH/BhjS13pLD1tIPoQ==
X-Received: by 2002:a5d:644e:0:b0:20e:7267:9ef7 with SMTP id d14-20020a5d644e000000b0020e72679ef7mr753012wrw.520.1652962485831;
        Thu, 19 May 2022 05:14:45 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c255100b0039734037303sm483830wma.38.2022.05.19.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 05:14:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RESEND v12 00/17] KVM: x86/pmu: Add basic support to
 enable guest PEBS via DS
In-Reply-To: <20220411101946.20262-1-likexu@tencent.com>
References: <20220411101946.20262-1-likexu@tencent.com>
Date:   Thu, 19 May 2022 14:14:43 +0200
Message-ID: <87fsl5u3bg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like Xu <like.xu.linux@gmail.com> writes:

...

Hi, the following commit

>   KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS

(currently in kvm/queue) breaks a number of selftests, e.g.:

# ./tools/testing/selftests/kvm/x86_64/state_test 
==== Test Assertion Failure ====
  lib/x86_64/processor.c:1207: r == nmsrs
  pid=6702 tid=6702 errno=7 - Argument list too long
     1	0x000000000040da11: vcpu_save_state at processor.c:1207 (discriminator 4)
     2	0x00000000004024e5: main at state_test.c:209 (discriminator 6)
     3	0x00007f9f48c2d55f: ?? ??:0
     4	0x00007f9f48c2d60b: ?? ??:0
     5	0x00000000004026d4: _start at ??:?
  Unexpected result from KVM_GET_MSRS, r: 29 (failed MSR was 0x3f1)

I don't think any of these failing tests care about MSR_IA32_PEBS_ENABLE
in particular, they're just trying to do KVM_GET_MSRS/KVM_SET_MSRS.

-- 
Vitaly

