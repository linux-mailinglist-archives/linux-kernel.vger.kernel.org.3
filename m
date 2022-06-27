Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3555B4EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 03:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiF0BTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 21:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiF0BTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 21:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF5021E9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656292748;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTICuoSGIjybXO+ji3eTtntVQ/cRXGaW1F4yfpiuCKg=;
        b=MHlSvSSaAam5FeYGOnU7vnDqrASfaO/BiC5Jienxq88JFdK8IvOvw+VNUAI/VsKjiTA276
        cNYc/kuvl3az//M9dZnXo0NvMHMaFDO7DLmYIZJLRukKzSAEHTP7Vv4dSq9/r9D8q/Vbfi
        aZkIlRvO4JsAYuj8q/uXh9DtmoqfZ9I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-SCE3jjzzM0i4gnRuEkX8aw-1; Sun, 26 Jun 2022 21:19:04 -0400
X-MC-Unique: SCE3jjzzM0i4gnRuEkX8aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E47AB29AB408;
        Mon, 27 Jun 2022 01:19:03 +0000 (UTC)
Received: from [10.64.54.155] (vpn2-54-155.bne.redhat.com [10.64.54.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D28118EAB;
        Mon, 27 Jun 2022 01:18:57 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v7 00/22] Support SDEI Virtualization
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, shijie@amperemail.onmicrosoft.com,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        oliver.upton@linux.dev, Oliver Upton <oupton@google.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
 <6bdb9280-3530-dc1f-d33e-5bc1c5ac927b@redhat.com>
 <87iloq2oke.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <af9029b7-5f83-fa3e-5fee-1d4cafd92ac6@redhat.com>
Date:   Mon, 27 Jun 2022 13:18:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87iloq2oke.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 6/24/22 11:12 PM, Marc Zyngier wrote:
> On Thu, 23 Jun 2022 07:11:08 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>> On 5/27/22 6:02 PM, Gavin Shan wrote:
>>> This series intends to virtualize Software Delegated Exception Interface
>>> (SDEI), which is defined by DEN0054C (v1.1). It allows the hypervisor to
>>> deliver NMI-alike SDEI event to guest and it's needed by Async PF to
>>> deliver page-not-present notification from hypervisor to guest. The code
>>> and the required qemu changes can be found from:
>>>
>>>      https://developer.arm.com/documentation/den0054/c
>>>      https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>>>      https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>>>
>>> The design is quite strightforward by following the specification. The
>>> (SDEI) events are classified into the shared and private ones according
>>> to their scope. The shared event is system or VM scoped, but the private
>>> event is vcpu scoped. This implementation doesn't support the shared
>>> event because all the needed events are private. Besides, the critial
>>> events aren't supported by the implementation either. It means all events
>>> are normal in terms of priority.
>>>
>>> There are several objects (data structures) introduced to help on the
>>> event registration, enablement, disablement, unregistration, reset,
>>> delivery and handling.
>>>
>>>     * kvm_sdei_event_handler
>>>       SDEI event handler, which is provided through EVENT_REGISTER
>>>       hypercall, is called when the SDEI event is delivered from
>>>       host to guest.
>>>          * kvm_sdei_event_context
>>>       The saved (preempted) context when SDEI event is delivered
>>>       for handling.
>>>          * kvm_sdei_vcpu
>>>       SDEI events and their states.
>>>
>>> The patches are organized as below:
>>>
>>>     PATCH[01-02] Preparatory work to extend smccc_get_argx() and refactor
>>>                  hypercall routing mechanism
>>>     PATCH[03]    Adds SDEI virtualization infrastructure
>>>     PATCH[04-16] Supports various SDEI hypercalls and event handling
>>>     PATCH[17]    Exposes SDEI capability
>>>     PATCH[18-19] Support SDEI migration
>>>     PATCH[20]    Adds document about SDEI
>>>     PATCH[21-22] SDEI related selftest cases
>>>
>>> The previous revisions can be found:
>>>
>>>     v6: https://lore.kernel.org/lkml/20220403153911.12332-4-gshan@redhat.com/T/
>>>     v5: https://lore.kernel.org/kvmarm/20220322080710.51727-1-gshan@redhat.com/
>>>     v4: https://lore.kernel.org/kvmarm/20210815001352.81927-1-gshan@redhat.com/
>>>     v3: https://lore.kernel.org/kvmarm/20210507083124.43347-1-gshan@redhat.com/
>>>     v2: https://lore.kernel.org/kvmarm/20210209032733.99996-1-gshan@redhat.com/
>>>     v1: https://lore.kernel.org/kvmarm/20200817100531.83045-1-gshan@redhat.com/
>>>
>>
>> Copying Oliver's new email address (oliver.upton@linux.dev).
>>
>> Please let me know if I need to rebase and repost the series.
> 
> My main issue with this series is that it is a solution in search of a
> problem. It is only an enabler for Asynchronous Page Fault support,
> and:
> 
> - as far as I know, the core Linux/arm64 maintainers have no plan to
>    support APF. Without it, this is a pointless exercise. And even with
>    it, this introduces a Linux specific behaviour in an otherwise
>    architectural hypervisor (something I'm quite keen on avoiding)
> 
> - It gives an incentive to other hypervisor vendors to add random crap
>    to the Linux mm subsystem, which is even worse. At this stage, we
>    might as well go back to the Xen PV days altogether.
> 
> - I haven't seen any of the KVM/arm64 users actually asking for the
>    APF horror, and the cloud vendors I directly asked had no plan to
>    use it, and not using it on their x86 systems either
> 
> - no performance data nor workloads that could help making an informed
>    decision have been disclosed, and the only argument in its favour
>    seems to be "but x86 has it" (hardly a compelling one)
> 
> Given the above, I don't see how to justify this series, as it has no
> purpose on its own, no matter how well written it is.
> 

Thank you for your time to review the series and provide comments. Long
time ago, I compare the features supported on x86 and arm64, to sort out
the gaps. Async page fault is one of the missed features. From that on,
I started to investigate x86's implementation and work on arm64's
implementation. It's the history why I continue to work on Async page
fault for arm64. It means there is no customer request, asking to support
Async page fault on arm64, on my side.

In order to support Async PF on arm64, there are two parts of changes,
which are related to kvm/arm64 and guest kernel. The service of Async
page fault won't be enabled if either kvm/arm64 or guest kernel doesn't
support it. The service is negotiated between host and guest. So I don't
think it would be a problem. It's true that Async page fault is only
beneficial to Linux host and Linux guest, until it gets supported on
other guest kernels.

SDEI implementation is following the specification. It's true that
Async PF isn't specified by arm64 architecture. However, it's also not
a architectural feature to x86 either. I guess the benefits count here.
The reason we need Async PF (and SDEI virtualization) is the benefit.

If I'm correct, Async PF has been used broadly on x86 because of
'post-copy live migration', which relies on userfaultfd. 'Async page fault'
is explicitly mentioned in its document (linux/Documentation/admin-guide/mm/userfaultfd.rst)
like below. It's the most important motivation to support Async PF.

Yeah, performance data is definitely helpful to measure the benefit,
especially for Async page fault on arm64. I used to revise both
serieses (SDEI virtualization and Async page fault) together, meaning
'Async page fault' series is revised if there are any code changes to
the series of 'SDEI virtualization', until I found it would be practical
to finialize 'SDEI virtualization' before working on 'Async page fault'.
It's why I don't post revised series of 'Async page fault' recently.
However, I think the performance data released in last year's KVM
forum is still relative. I certainly need to regain the performance
data when I continue to work on 'Async page fault' series after
'SDEI virutalization' is finalized.

https://static.sched.com/hosted_files/kvmforum2021/cb/sdei_apf_for_arm64_gavin.pdf
(In page 14 and 15, 41% to 68% improvement in live post-copy migration)


Extracted from linux/documentation/admin-guide/mm/userfaultfd.rst
------------------------------------------------------------------

QEMU/KVM
========

QEMU/KVM is using the ``userfaultfd`` syscall to implement postcopy live
migration. Postcopy live migration is one form of memory
externalization consisting of a virtual machine running with part or
all of its memory residing on a different node in the cloud. The
``userfaultfd`` abstraction is generic enough that not a single line of
KVM kernel code had to be modified in order to add postcopy live
migration to QEMU.

Guest async page faults, ``FOLL_NOWAIT`` and all other ``GUP*`` features work
just fine in combination with userfaults. Userfaults trigger async
page faults in the guest scheduler so those guest processes that
aren't waiting for userfaults (i.e. network bound) can keep running in
the guest vcpus.

Thanks,
Gavin


