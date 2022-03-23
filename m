Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D809C4E529D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiCWM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCWM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D0637C7A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648040239;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCSRESyL1rMniRRxHy5gX0fOKOEtNaDrhuCyYAnyEjY=;
        b=dXHAnBbAYEpJCNJICVAVsHYH4ZVnlhDe5iq0yqiLtJB1o1DpHgK/aP0jOgaEjHiJuTtziE
        Bh6g36VSxambsQtctlQvT+p9rB4nFoKXxQX0eoWA7EjFQvpBNP0SG1zoJ+vm8KHVoGJW27
        P5IfmAw+ajc9dmkkHUsu/z8t5Z5rsWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-TCOh3L9OPpeVrk5iFmknFQ-1; Wed, 23 Mar 2022 08:57:16 -0400
X-MC-Unique: TCOh3L9OPpeVrk5iFmknFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FAE5185A794;
        Wed, 23 Mar 2022 12:57:15 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BCFB1400C2F;
        Wed, 23 Mar 2022 12:57:09 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v5 00/22] Support SDEI Virtualization
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <YjoRteSXpPkDGqgp@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f3cbe494-dae8-3fc7-60dd-c47ed914d904@redhat.com>
Date:   Wed, 23 Mar 2022 20:57:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YjoRteSXpPkDGqgp@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 3/23/22 2:13 AM, Oliver Upton wrote:
> On Tue, Mar 22, 2022 at 04:06:48PM +0800, Gavin Shan wrote:
>> This series intends to virtualize Software Delegated Exception Interface
>> (SDEI), which is defined by DEN0054C (v1.1). It allows the hypervisor to
>> deliver NMI-alike SDEI event to guest and it's needed by Async PF to
>> deliver page-not-present notification from hypervisor to guest. The code
>> and the required qemu changes can be found from:
>>
>>     https://developer.arm.com/documentation/den0054/c
>>     https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>>     https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>>
>> For the design and migration needs, please refer to the document in
>> PATCH[21/22] in this series. The series is organized as below:
>>
>>    PATCH[01]    Introduces template for smccc_get_argx()
>>    PATCH[02]    Adds SDEI virtualization infrastructure
>>    PATCH[03-17] Supports various SDEI hypercalls and event handling
>>    PATCH[18-20] Adds ioctl commands to support migration and configuration
>>                 and exports SDEI capability
>>    PATCH[21]    Adds SDEI document
>>    PATCH[22]    Adds SDEI selftest case
>>
>> Testing
>> =======
>>
>> [1] The selftest case included in this series works fine. The default SDEI
>>      event, whose number is zero, can be registered, enabled, raised. The
>>      SDEI event handler can be invoked.
>>
>>      [host]# pwd
>>      /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>>      [root@virtlab-arm01 kvm]# ./aarch64/sdei
>>
>>          NR_VCPUS: 2    SDEI Event: 0x00000000
>>
>>      --- VERSION
>>          Version:              1.1 (vendor: 0x4b564d)
>>      --- FEATURES
>>          Shared event slots:   0
>>          Private event slots:  0
>>          Relative mode:        No
>>      --- PRIVATE_RESET
>>      --- SHARED_RESET
>>      --- PE_UNMASK
>>      --- EVENT_GET_INFO
>>          Type:                 Private
>>          Priority:             Normal
>>          Signaled:             Yes
>>      --- EVENT_REGISTER
>>      --- EVENT_ENABLE
>>      --- EVENT_SIGNAL
>>          Handled:              Yes
>>          IRQ:                  No
>>          Status:               Registered-Enabled-Running
>>          PC/PSTATE:            000000000040232c 00000000600003c5
>>          Regs:                 0000000000000000 0000000000000000
>>                                0000000000000000 0000000000000000
>>      --- PE_MASK
>>      --- EVENT_DISABLE
>>      --- EVENT_UNREGISTER
>>
>>          Result: OK
>>
>> [2] There are additional patches in the following repositories to create
>>      procfs entries, allowing to inject SDEI event from host side. The
>>      SDEI client in the guest side registers the SDEI default event, whose
>>      number is zero. Also, the QEMU exports SDEI ACPI table and supports
>>      migration for SDEI.
>>
>>      https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>>      https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
>>
>>      [2.1] Start the guests and migrate the source VM to the destination
>>            VM.
>>
>>      [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>>              -accel kvm -machine virt,gic-version=host                     \
>>              -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
>>              -m 1024M,slots=16,maxmem=64G                                  \
>>                 :                                                          \
>>              -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>>              -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
>>              -append earlycon=pl011,mmio,0x9000000                         \
>>                 :
>>
>>      [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>>              -accel kvm -machine virt,gic-version=host                     \
>>              -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
>>              -m 1024M,slots=16,maxmem=64G                                  \
>>                 :                                                          \
>>              -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>>              -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
>>              -append earlycon=pl011,mmio,0x9000000                         \
>>              -incoming tcp:0:4444                                          \
>>                 :
>>
>>      [2.2] Check kernel log on the source VM. The SDEI service is enabled
>>            and the default SDEI event (0x0) is enabled.
>>
>>       [guest-src]# dmesg | grep -i sdei
>>       ACPI: SDEI 0x000000005BC80000 000024 \
>>                  (v00 BOCHS  BXPC     00000001 BXPC 00000001)
>>       sdei: SDEIv1.1 (0x4b564d) detected in firmware.
>>       SDEI TEST: Version 1.1, Vendor 0x4b564d
>>       sdei_init: SDEI event (0x0) registered
>>       sdei_init: SDEI event (0x0) enabled
>>
>>   
>>       (qemu) migrate -d tcp:localhost:4444
>>
>>      [2.3] Migrate the source VM to the destination VM. Inject SDEI event
>>            to the destination VM. The event is raised and handled.
>>
>>      (qemu) migrate -d tcp:localhost:4444
>>
>>      [host]# echo 0 > /proc/kvm/kvm-5360/vcpu-1
>>
>>      [guest-dst]#
>>      =========== SDEI Event (CPU#1) ===========
>>      Event: 0000000000000000  Parameter: 00000000dabfdabf
>>      PC: ffff800008cbb554  PSTATE: 00000000604000c5  SP: ffff800009c7bde0
>>      Regs:    00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001
>>               ffff800016c28000 0000000000000000 0000000000000000 0000000000000000
>>               0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>               0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>               0000000000000000 0000000000000000 0000000000000000 ffff800009399008
>>               ffff8000097d9af0 ffff8000097d99f8 ffff8000093a8db8 ffff8000097d9b18
>>               0000000000000000 0000000000000000 ffff000000339d00 0000000000000000
>>               0000000000000000 ffff800009c7bde0 ffff800008cbb5c4
>>      Context: 00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001
>>               ffff800016c28000 03ffffffffffffff 000000024325db59 ffff8000097de190
>>               ffff00000033a790 ffff800008cbb814 0000000000000a30 0000000000000000
>>
>> Changelog
>> =========
>> v5:
> 
> Next time can you include a link to the cover letter of the previous
> patch set? It is extremely helpful for understanding the progress to
> date and allows reviewers to see prior feedback.
> 

Yep, I will provide the link to the cover letter of the previous version.
I'm amending it this time:

     https://lore.kernel.org/all/20210815001352.81927-3-gshan@redhat.com/

Besides, I don't know what happened to my "git send-email". Some of the
recipients are skipped even I have put them into the cc list. Lets amend
it again to avoid resending the series.

Thanks,
Gavin


