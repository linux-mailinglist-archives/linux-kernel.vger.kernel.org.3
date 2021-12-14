Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D903474D40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhLNVft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhLNVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639517747;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=o2cT5ggkWIKGyDNwgNiQey+aVDolDjsoQ/s1dXv95NY=;
        b=R8QE8Vtah54+4pz/U0KCc2SsEOjGXy40ExWU370l8uKqeP2iaROMP+xE+ZFUfTSfTgZ7H7
        w1r1E8HmjEbuZVbnzZNA2wyZwd7N5Ha4ENkq3uopBqdve4BfpZUEP9g/w77mLFXdCxesDk
        RgKHzpRXNIqXAOTw9MpvaD76qN1SnEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-gjwMNxZpMyOlBZidV1KnVw-1; Tue, 14 Dec 2021 16:35:46 -0500
X-MC-Unique: gjwMNxZpMyOlBZidV1KnVw-1
Received: by mail-wm1-f69.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso13711788wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:reply-to:date:message-id:mime-version;
        bh=o2cT5ggkWIKGyDNwgNiQey+aVDolDjsoQ/s1dXv95NY=;
        b=jwhH1mIlyJ2V5lQrqlXa/5iMPn8nNTE6loQw52XPww/xLgHAirHVZ0j8VuXH59phSt
         AmItA2QHERVhVrfoCLnndl7IXMclnDlyfHSGM3UyQXZca04RjfOw7gpv0fyR+Znhucaw
         JVvJPpJX8IpcmRQnL2ihJFFx81huD3H+LY9dEOxm7+kYGVAOBMURHIFxldZEWPf19q9j
         Zn2tfvnTwiR5/8gb4HjmbMtk9x2RkgyMCwud2JXXtE3kX6r4bEiFIDTgYbNvN/yOq7I6
         kXFccVuZ//RFG26QjZK8AJIS4DgWHB6A7Ms9whVVxxT4p86CD9iibDIdjjUrByLP0ovQ
         OUpQ==
X-Gm-Message-State: AOAM531E70YXS2h1aDJHNTbpvuukjCs8esDXONtZKK8FUfX4Cy0+WeGx
        zerOgAWPwDjRa6Y29Lp7W4jXcdaWtBd9x4PjZC5e4Lcfv+bwdFQvT1MMihsVdBx5KxWGuToxqbk
        spuZ+wpPTXv6yBwqCwhSEXoPD
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr1597637wrr.365.1639517744770;
        Tue, 14 Dec 2021 13:35:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyecBHUIn82YQbtrUymxLlWCWfzV9H2x2nD6Qsq8dnjH7ObgGDJUMLpQ9PukDq7CFi71rPsvg==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr1597622wrr.365.1639517744597;
        Tue, 14 Dec 2021 13:35:44 -0800 (PST)
Received: from localhost (static-174-144-85-188.ipcom.comunitel.net. [188.85.144.174])
        by smtp.gmail.com with ESMTPSA id j11sm85226wrt.3.2021.12.14.13.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 13:35:44 -0800 (PST)
From:   Juan Quintela <quintela@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Jing Liu <jing2.liu@linux.intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Sean Christoperson <seanjc@google.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [patch 5/6] x86/fpu: Provide fpu_update_guest_xcr0/xfd()
In-Reply-To: <87k0g7rkwj.ffs@tglx> (Thomas Gleixner's message of "Tue, 14 Dec
        2021 21:28:28 +0100")
References: <20211214022825.563892248@linutronix.de>
        <20211214024948.048572883@linutronix.de>
        <854480525e7f4f3baeba09ec6a864b80@intel.com> <87zgp3ry8i.ffs@tglx>
        <b3ac7ba45c984cf39783e33e0c25274d@intel.com> <87r1afrrjx.ffs@tglx>
        <87k0g7qa3t.fsf@secure.mitica> <87k0g7rkwj.ffs@tglx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Reply-To: quintela@redhat.com
Date:   Tue, 14 Dec 2021 22:35:43 +0100
Message-ID: <878rwm7tu8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:

Hi Thomas

> On Tue, Dec 14 2021 at 20:07, Juan Quintela wrote:
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>> On Tue, Dec 14 2021 at 16:11, Wei W. Wang wrote:
>>>> We need to check with the QEMU migration maintainer (Dave and Juan CC-ed)
>>>> if changing that ordering would be OK.
>>>> (In general, I think there are no hard rules documented for this ordering)
>>>
>>> There haven't been ordering requirements so far, but with dynamic
>>> feature enablement there are.
>>>
>>> I really want to avoid going to the point to deduce it from the
>>> xstate:xfeatures bitmap, which is just backwards and Qemu has all the
>>> required information already.
>>
>> First of all, I claim ZERO knowledge about low level x86_64.
>
> Lucky you.

Well, that is true until I have to debug some bug, at that time I miss
the knowledge O:-)

>> Once told that, this don't matter for qemu migration, code is at
>
> Once, that was at the time where rubber boots were still made of wood,
> right? :)

I forgot to add: "famous last words".

>> target/i386/kvm/kvm.c:kvm_arch_put_registers()
>>
>>
>>     ret = kvm_put_xsave(x86_cpu);
>>     if (ret < 0) {
>>         return ret;
>>     }
>>     ret = kvm_put_xcrs(x86_cpu);
>>     if (ret < 0) {
>>         return ret;
>>     }
>>     /* must be before kvm_put_msrs */
>>     ret = kvm_inject_mce_oldstyle(x86_cpu);
>
> So this has already ordering requirements.
>
>>     if (ret < 0) {
>>         return ret;
>>     }
>>     ret = kvm_put_msrs(x86_cpu, level);
>>     if (ret < 0) {
>>         return ret;
>>     }
>>
>> If it needs to be done in any other order, it is completely independent
>> of whatever is inside the migration stream.
>
> From the migration data perspective that's correct, but I have the
> nagging feeling that this in not that simple.

Oh, I was not meaning that it was simple at all.

We have backward compatibility baggage on x86_64 that is grotesque at
this point.  We don't send a single msr (by that name) on the main
migration stream.  And then we send them based on "conditions".  So the
trick as somithing like:

- qemu reads the msrs from kvm at some order
- it stores them in a list of MSR's
- On migration pre_save we "mangle" that msr's and other cpu state to
  on the main (decades old) state
- then we send the main state
- then we send conditionally the variable state

on reception side:

- we receive everything that the sending side have sent
- we "demangle" it on pre_load
- then we create the list of MSR's that need to be transferred
- at that point we send them to kvm in another random order

So yes, I fully agree that it is not _that_ simple O:-)


>> I guess that Paolo will put some light here.
>
> I fear shining light on that will unearth quite a few skeletons :)

It is quite probable.

When a bugzilla start with: We found a bug while we were trying to
migrate during (BIOS) boot, I just ran for the hills O:-)

Later, Juan.

