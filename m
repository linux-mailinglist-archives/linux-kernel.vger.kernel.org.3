Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED5520F44
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiEJICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiEJIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FB601E251D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652169445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GogPWfkvrNoObtQPGw+NoKWIrWBSSJnqUGbnCQ7gy8=;
        b=Y7rJYOxTYwIL44kNmTc9RnCV6C84Kyd2xFlt7B3/Elaae2t0Nz3hlhMsKQQU2gEOlFgURq
        DrxDmOvIbdIVkhgQiQnZjYsygw7A2MyUPBOxFF8512CiBoV7UD5Vcm+1/UOM+sWj3zvWLV
        QCDj0FThK8k76HiiV8wdUoR1DYj91nQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-mc1In2aYMyq6jeONhZ2QMw-1; Tue, 10 May 2022 03:57:22 -0400
X-MC-Unique: mc1In2aYMyq6jeONhZ2QMw-1
Received: by mail-ed1-f72.google.com with SMTP id a19-20020aa7d913000000b004284eecb34aso7046698edr.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+GogPWfkvrNoObtQPGw+NoKWIrWBSSJnqUGbnCQ7gy8=;
        b=AbiGLNYk9Uva1Q6wYOK9PJ0B9AVx8V6wA394dJ64EMGjmypvEvZNW9gx7jLNoHuNrH
         wMHgpoWmReijiba+Jd6aHKxtYP+D2QhGgmQscs5alnQzxspvBFp2TAN3pvVqrs3jmi8v
         oJD4JmUGNnqecdAnLqPCX65OmTC+J0bc2HD2pKuRDp32auAHdco8JHxExpK17X3hGQGZ
         c1AdP/8fHegKHHKM4aRj2CgGuxxJYds951io+jNK7WtI/k+5HXieYuwJZ6BlJylz8xyr
         UDcFrJOv4SsFTuLJ7jycJp/ZT9BqwWm2fjNMaK0M0MuA4f8iaAdNoqYEQbJx+KWcn7Yy
         QUww==
X-Gm-Message-State: AOAM532CGLAXlitLmh7WrBiezYgMdohSyR45EGiRPGyDPug177pXIuJH
        8RHPKjpKh96DrKOqKZvhWJ/x7l00TdhQU2FOvoGeU8U5lmtDWbsEnyc5nHRhISAAKxguIqp4JVs
        g2W/b01UIoe4rAeGZdXQVY8MZ
X-Received: by 2002:a17:907:2cc7:b0:6fa:7356:f411 with SMTP id hg7-20020a1709072cc700b006fa7356f411mr8350478ejc.369.1652169441767;
        Tue, 10 May 2022 00:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0z9Bybx4Np2JFUQ4kYBlYYkYDzd5vyFPqkU2JXcuwv3AnrvJ4kxcu0CAARzbIYsdPk1ng6g==
X-Received: by 2002:a17:907:2cc7:b0:6fa:7356:f411 with SMTP id hg7-20020a1709072cc700b006fa7356f411mr8350462ejc.369.1652169441548;
        Tue, 10 May 2022 00:57:21 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906244500b006f3ef214dd2sm5853119ejb.56.2022.05.10.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 00:57:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: X86: correct trace_kvm_pv_tlb_flush stats
In-Reply-To: <C8885C42-26FE-4BD3-80B1-2B8C7C413A21@nutanix.com>
References: <20220504182707.680-1-jon@nutanix.com>
 <YnL0gUcUq5MbWvdH@google.com>
 <8E192C0D-512C-4030-9EBE-C0D6029111FE@nutanix.com>
 <87h7641ju3.fsf@redhat.com>
 <C8885C42-26FE-4BD3-80B1-2B8C7C413A21@nutanix.com>
Date:   Tue, 10 May 2022 09:57:20 +0200
Message-ID: <874k1xzuov.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Kohler <jon@nutanix.com> writes:

>> On May 5, 2022, at 4:09 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>=20
>> Jon Kohler <jon@nutanix.com> writes:
>>=20
>>>> On May 4, 2022, at 5:47 PM, Sean Christopherson <seanjc@google.com> wr=
ote:
>>>>=20
>>=20
>> ...
>>=20
>>>=20
>>> The net problem here is really that the stat is likely incorrect; howev=
er,
>>> one other oddity I didn=E2=80=99t quite understand after looking into t=
his is that
>>> the call site for all of this is in record_steal_time(), which is only =
called
>>> from vcpu_enter_guest(), and that is called *after*
>>> kvm_service_local_tlb_flush_requests(), which also calls
>>> kvm_vcpu_flush_tlb_guest() if request =3D=3D KVM_REQ_TLB_FLUSH_GUEST
>>>=20
>>> That request may be there set from a few different places.=20
>>>=20
>>> I don=E2=80=99t have any proof of this, but it seems to me like we migh=
t have a
>>> situation where we double flush?
>>>=20
>>> Put another way, I wonder if there is any sense behind maybe hoisting
>>> if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu)) up before
>>> Other tlb flushes, and have it clear the FLUSH_GUEST if it was set?
>>=20
>> Indeed, if we move KVM_REQ_STEAL_UPDATE check/record_steal_time() call
>> in vcpu_enter_guest() before kvm_service_local_tlb_flush_requests(), we
>> can probably get aways with kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST,
>> vcpu) in record_steal_time() which would help to avoid double flushing.
>
> Thanks, Vitaly, I=E2=80=99ll rework this one and incorporate that. In the=
 mean time, do you
> have any suggestions on Sean's concern about losing the trace in situatio=
ns
> where pv tlb flushing isn=E2=80=99t happening?
>

No strong preference from my side but there are multiple places which
conditionally cause TLB flush but we don't have tracepoints saying
"flush could've been done but wasn't" there, right? Also,
kvm_vcpu_flush_tlb_all()/kvm_vcpu_flush_tlb_guest()/kvm_vcpu_flush_tlb_curr=
ent()
don't seem to have tracepoints so we don't actually record when we
flush. Hyper-V TLB flush has its own tracepoints
(trace_kvm_hv_flush_tlb()/trace_kvm_hv_flush_tlb_ex()) though.
This probably deserves a cleanup if we want TLB flush to be debuggable
without code instrumentation.

--=20
Vitaly

