Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E3F513E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiD1WY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350589AbiD1WY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:24:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C07091F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:21:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a11so5407073pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cc9TTPCgAe2q5px/N1vrmnQy5NmXb5L4YvUPqGlCPDA=;
        b=Q2iJ9J2XrEU8LhLWwdSa4jTWkfrg0XE/oMOAIEHU1HI2GWCuh6e8L5Msc9ZTNlX+gI
         c6U255yflc915BYD9if2UHu/0IkWOl/bXHeBYBhf+cLoNiq2kdHLeIaHBWKQQEdDzvwW
         MrFuxuqCgqTyxAORKBShCvNqEVF6550g04s24jQh6vpi7A0CQcOt1PuCXJJrMU9Pjihu
         2CQYCfNBCp6jSU4mW4dn69EN/UG6gclsLid4APYBZoLZIkOEY2hOSmmb0gwwaeLK7BzH
         EYMd0HWqyZbC/xGDHvgE6nomPw113wv0PRA4azRt8H2++uGUi5wdXR6ieMnua6oX9HQL
         dPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cc9TTPCgAe2q5px/N1vrmnQy5NmXb5L4YvUPqGlCPDA=;
        b=nXzP+3xOGMjynoA2gHrqOWYoaK9RU/O4QrdBEtcLlBJ6qxLOKPATNfl7B5EkHVkG5/
         CRCkdDKwmVJ1C2Sdj3YqDVST6syA1fSKC7Tz9PoqH99QN48qkiGSwdDbLXK2rB5aesSc
         aPFYD7OLRqmOPWSZZKHuglnUTjlRh4dMC7iAeG7m8mRbodqPyTr50mooirlXTqO9GKjP
         5DInK1ZotT2W0BIFUi0nI/50MowOimhrr99UY0EswaRZHmlU3sdLUC/lM8q1hSY4rSSz
         7ojstBlklRReDMAg8PWbWVciDrjpIYJ8jcRNrvNC9sroDKm7LI2LZJNtsz/AVd7voWTW
         opBQ==
X-Gm-Message-State: AOAM531ITUNe8bN6nTfrpKEv0At2si6ZO5FA8FkidqHWpX4dvMuuKrvg
        ACa6SQIJOTV5Jd8JU/N6VSoqMQ==
X-Google-Smtp-Source: ABdhPJzLsrBix3NHPIGwu7aUty0/RvbJ9I2JhDSInfB0jz/EvnTjjSE6Vwzttof/6p/KWP2FSJwn6A==
X-Received: by 2002:a63:f156:0:b0:3ab:ada6:b463 with SMTP id o22-20020a63f156000000b003abada6b463mr10549328pgk.462.1651184469317;
        Thu, 28 Apr 2022 15:21:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b4-20020a63d804000000b003c14af50604sm3880023pgh.28.2022.04.28.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 15:21:08 -0700 (PDT)
Date:   Thu, 28 Apr 2022 22:21:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH] KVM: x86: add HC_VMM_CUSTOM hypercall
Message-ID: <YmsTUGJfVzU3XTkl@google.com>
References: <20220421165137.306101-1-posk@google.com>
 <b1b04160-1604-8281-4c82-09b1f84ba86c@redhat.com>
 <CAPNVh5eTzpK6QpJumegoN4_7r56ZHsi6hFCG-Mqt+R8ngrCitw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5eTzpK6QpJumegoN4_7r56ZHsi6hFCG-Mqt+R8ngrCitw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022, Peter Oskolkov wrote:
> On Thu, Apr 21, 2022 at 10:14 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 4/21/22 18:51, Peter Oskolkov wrote:
> > > Allow kvm-based VMMs to request KVM to pass a custom vmcall
> > > from the guest to the VMM in the host.
> > >
> > > Quite often, operating systems research projects and/or specialized
> > > paravirtualized workloads would benefit from a extra-low-overhead,
> > > extra-low-latency guest-host communication channel.
> >
> > You can use a memory page and an I/O port.  It should be as fast as a
> > hypercall.  You can even change it to use ioeventfd if an asynchronous
> > channel is enough, and then it's going to be less than 1 us latency.
> 
> So this function:
> 
> uint8_t hyperchannel_ping(uint8_t arg)
> {
>         uint8_t inb;
>         uint16_t port = PORT;
> 
>         asm(
>                 "outb %[arg] , %[port]  \n\t"  // write arg
>                 "inb  %[port], %[inb]   \n\t"  // read  res
>                 : [inb] "=r"(inb)
>                 : [arg] "r"(arg), [port] "r"(port)
>         );
>         return inb;
> }
> 
> takes about 5.5usec vs 2.5usec for a vmcall on the same
> hardware/kernel/etc. I've also tried AF_VSOCK, and a roundtrip there
> is 30-50usec.
> 
> The main problem of port I/O vs a vmcall is that with port I/O a
> second VM exit is needed to return any result to the guest. Am I
> missing something?

The intent of the port I/O approach is that it's just a kick, the actual data
payload is delivered via a different memory channel. 

  0. guest/host establish a memory channel, e.g. guest annouces address to host at boot
  1. guest writes parameters to the memory channel
  2. guest does port I/O to let the host know there's work to be done
  3. KVM exits to the host
  4. host does the work, fills memory with the response
  5. host does KVM_RUN to re-enter the guest
  6. KVM runs the guest
  7. guest reads the response from memory

This is what Paolo meant by "memory page".

Using an ioeventfd avoids the overhead of #3 and #5.  Instead of exiting to
userspace, KVM signals the ioeventfd to wake the userspace I/O thread and immediately
resumes the guest.  The catch is that if you want a synchronous response, the guest
will have to wait for the host I/O thread to service the request, at which point the
benefits of avoiding the exit to userspace are largely lost.

Things like virtio-net (and presumably other virtio devices?) take advantage of
ioeventfd by using a ring buffer, e.g. put a Tx payload in the buffer, kick the
host and move on.
