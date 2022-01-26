Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7F49CFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbiAZQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236907AbiAZQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643214364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZP7rMmgyeJ3Qoh7yXeapZfkZgz+JP+eRsAiK+6Ga24=;
        b=aQhuB6gtuwOItH3q5oOWBeFXFT9LBHh60k7I/9Gw11d178HSQHxjZP4+eM5tp1j25vtlKk
        f/ydZqbUJRPkyVLK87VuIZs+trsOLU096r35PvBwlInAWR4MB/NSY+bm5BUgh+5eLzI0lY
        DncQ+HNPVslIefpXDEoZX0gWtrSEz0k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-W2R8kv7jOlqjOYYfiqMgSg-1; Wed, 26 Jan 2022 11:26:02 -0500
X-MC-Unique: W2R8kv7jOlqjOYYfiqMgSg-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so3460wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JZP7rMmgyeJ3Qoh7yXeapZfkZgz+JP+eRsAiK+6Ga24=;
        b=j/o+CTH3vO4nit8ecOOVHxn7uK0Ln5iSE8KXo8WEQ7zdZCNVKeCOJUoTEZD25yjxn8
         sJYRXOqBc9fAsOrkJQiU8Ijv1O2j3C+q2CecH2MZ9nyh9BlAYiYwsuYU6jjFe67wW+8g
         iShsVKvB/Cb5WiM58SR834K14yOmCQ/F9JjTSJ99OxyoJbESnAgpdqOobvbZH6Edlab1
         Fw+LHexIJN33lMfsN/bENglxr9M68np0K2WU4aqDbMMqQZQjNsQHPgYzIT/5VabWYyoM
         Poin5azQrzpn5lK378rvQeIUnNFb8GsyFq7dxISxZfXbpNZRw1GzDoyHTzNmyByB2pq0
         4QqQ==
X-Gm-Message-State: AOAM5300yDXS7QriQ4nZQ8g0cVc515R6w6b/ulLM4WTFhIkXNAXu9rW7
        DBiLrc+OYXt+ey4k3gaFqQHReKPc9fnlNrt09RefjSgibXSYGAUwqme/+xqx4ioKQquEII0IzRe
        0Y4rphbPCvXD0y5G7a0KsSRn+
X-Received: by 2002:a5d:5044:: with SMTP id h4mr20824817wrt.681.1643214361467;
        Wed, 26 Jan 2022 08:26:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAPjkU/T3WFos1KJxEHSc/1+U+j1V1UGcEseQncQ0Py8Ob2nIbLAswePEr99lXr5H7pkZjbA==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr20824803wrt.681.1643214361290;
        Wed, 26 Jan 2022 08:26:01 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p17sm19478544wrf.112.2022.01.26.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:26:00 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Joe Perches <joe@perches.com>, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: x86: Use memcmp in kvm_cpuid_check_equal()
In-Reply-To: <YfFwnm3Vp0eOPElp@google.com>
References: <20220124103606.2630588-1-vkuznets@redhat.com>
 <20220124103606.2630588-3-vkuznets@redhat.com>
 <864dfbfdc44e288e99cf7baa3aa8f7c8568db507.camel@perches.com>
 <878rv2izjp.fsf@redhat.com> <YfFwnm3Vp0eOPElp@google.com>
Date:   Wed, 26 Jan 2022 17:25:59 +0100
Message-ID: <87mtjih3ag.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jan 26, 2022, Vitaly Kuznetsov wrote:
>> Joe Perches <joe@perches.com> writes:
>> 
>> > On Mon, 2022-01-24 at 11:36 +0100, Vitaly Kuznetsov wrote:
>> >> kvm_cpuid_check_equal() should also check .flags equality but instead
>> >> of adding it to the existing check, just switch to using memcmp() for
>> >> the whole 'struct kvm_cpuid_entry2'.
>> >
>> > Is the struct padding guaranteed to be identical ?
>> >
>> 
>> Well, yes (or we're all doomeed):
>> - 'struct kvm_cpuid_entry2' is part of KVM userspace ABI, it is supposed
>> to be stable.
>> - Here we compare structs which come from the same userspace during one
>> session (vCPU fd stays open), I can't imagine how structure layout can
>> change on-the-fly.
>
> I'm pretty sure Joe was asking if the contents of the padding field would be
> identical, i.e. if KVM can guarnatee there won't be false positives on
> mismatches,

Ah, sorry, I thought about structure layout. Generally, there's no
guarantee the content of the padding will be the same in the
KVM_SET_CPUID2 case as we vmemdup_user() what userspace VMM gives us.

> which is the same reason Paolo passed on this patch.  Though I still think we
> should roll the dice :-)

Well, so far we've only identified CPU (re-)hotplug by reusing an
existing vCPU fd as a broken use-case and it may happen that QEMU is the
only VMM which does that (and memcmp() approach works for it) ... but
who know what's out there)

-- 
Vitaly

