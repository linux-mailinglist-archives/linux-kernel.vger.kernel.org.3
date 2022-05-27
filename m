Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB8535B07
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiE0IEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348560AbiE0IDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15111102753
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CT8ZCTvZFdAX+p3wnFweEaCytomahmIYJ7xKHAPoTSA=;
        b=EoRfwJji5d4Vn+8kLECtmStENfXJijsr1odl+xrUT/bFE4eiY99ZDePk/JPLGrfxVnwRzI
        1kRyVmel38OQeFqTiusUwDRO0IP9mu8+bTQIHsZjRJQbq3NnlJDdZeu9MequfeTjHjSSeL
        pdaYVdAXyMXPd2QtFbm2cCY+d0k2qME=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-c6P6qpKrMbKAr03NZkc4uA-1; Fri, 27 May 2022 04:03:43 -0400
X-MC-Unique: c6P6qpKrMbKAr03NZkc4uA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F541C161A3;
        Fri, 27 May 2022 08:03:42 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 686A82026D07;
        Fri, 27 May 2022 08:03:33 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 00/22] Support SDEI Virtualization
Date:   Fri, 27 May 2022 16:02:31 +0800
Message-Id: <20220527080253.1562538-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intends to virtualize Software Delegated Exception Interface
(SDEI), which is defined by DEN0054C (v1.1). It allows the hypervisor to
deliver NMI-alike SDEI event to guest and it's needed by Async PF to
deliver page-not-present notification from hypervisor to guest. The code
and the required qemu changes can be found from:

   https://developer.arm.com/documentation/den0054/c
   https://github.com/gwshan/linux    ("kvm/arm64_sdei")
   https://github.com/gwshan/qemu     ("kvm/arm64_sdei")

The design is quite strightforward by following the specification. The
(SDEI) events are classified into the shared and private ones according
to their scope. The shared event is system or VM scoped, but the private
event is vcpu scoped. This implementation doesn't support the shared
event because all the needed events are private. Besides, the critial
events aren't supported by the implementation either. It means all events
are normal in terms of priority.

There are several objects (data structures) introduced to help on the
event registration, enablement, disablement, unregistration, reset,
delivery and handling.

  * kvm_sdei_event_handler
    SDEI event handler, which is provided through EVENT_REGISTER
    hypercall, is called when the SDEI event is delivered from
    host to guest.
    
  * kvm_sdei_event_context
    The saved (preempted) context when SDEI event is delivered
    for handling.
    
  * kvm_sdei_vcpu
    SDEI events and their states.

The patches are organized as below:

  PATCH[01-02] Preparatory work to extend smccc_get_argx() and refactor
               hypercall routing mechanism
  PATCH[03]    Adds SDEI virtualization infrastructure
  PATCH[04-16] Supports various SDEI hypercalls and event handling
  PATCH[17]    Exposes SDEI capability
  PATCH[18-19] Support SDEI migration
  PATCH[20]    Adds document about SDEI
  PATCH[21-22] SDEI related selftest cases

The previous revisions can be found:

  v6: https://lore.kernel.org/lkml/20220403153911.12332-4-gshan@redhat.com/T/
  v5: https://lore.kernel.org/kvmarm/20220322080710.51727-1-gshan@redhat.com/
  v4: https://lore.kernel.org/kvmarm/20210815001352.81927-1-gshan@redhat.com/
  v3: https://lore.kernel.org/kvmarm/20210507083124.43347-1-gshan@redhat.com/
  v2: https://lore.kernel.org/kvmarm/20210209032733.99996-1-gshan@redhat.com/
  v1: https://lore.kernel.org/kvmarm/20200817100531.83045-1-gshan@redhat.com/

Testing
=======
[1] The selftest case included in this series works fine. The default SDEI
    event, whose number is zero, can be registered, enabled, raised. The
    SDEI event handler can be invoked.

    [host]# pwd
    /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
    [root@virtlab-arm01 kvm]# ./aarch64/sdei 

        NR_VCPUS: 2    SDEI Event: 0x00000000

    --- VERSION
        Version:              1.1 (vendor: 0x4b564d)
    --- FEATURES
        Shared event slots:   0
        Private event slots:  0
        Relative mode:        No
    --- PRIVATE_RESET
    --- SHARED_RESET
    --- PE_UNMASK
    --- EVENT_GET_INFO
        Type:                 Private
        Priority:             Normal
        Signaled:             Yes
    --- EVENT_REGISTER
    --- EVENT_ENABLE
    --- EVENT_SIGNAL
        Handled:              Yes
        IRQ:                  No
        Status:               Registered-Enabled-Running
        PC/PSTATE:            000000000040232c 00000000600003c5
        Regs:                 0000000000000000 0000000000000000
                              0000000000000000 0000000000000000
    --- PE_MASK
    --- EVENT_DISABLE
    --- EVENT_UNREGISTER

        Result: OK

[2] There are additional patches in the following repositories to create
    procfs entries, allowing to inject SDEI event from host side. The
    SDEI client in the guest side registers the SDEI default event, whose
    number is zero. Also, the QEMU exports SDEI ACPI table and supports
    migration for SDEI.

    https://github.com/gwshan/linux    ("kvm/arm64_sdei")
    https://github.com/gwshan/qemu     ("kvm/arm64_sdei")

    [2.1] Start the guests and migrate the source VM to the destination
          VM.

    [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
            -accel kvm -machine virt,gic-version=host                     \
            -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
            -m 1024M,slots=16,maxmem=64G                                  \
               :                                                          \
            -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
            -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
            -append earlycon=pl011,mmio,0x9000000                         \
               :

    [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
            -accel kvm -machine virt,gic-version=host                     \
            -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
            -m 1024M,slots=16,maxmem=64G                                  \
               :                                                          \
            -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
            -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
            -append earlycon=pl011,mmio,0x9000000                         \
            -incoming tcp:0:4444                                          \
               :

    [2.2] Check kernel log on the source VM. The SDEI service is enabled
          and the default SDEI event (0x0) is enabled.

     [guest-src]# dmesg | grep -i sdei
     ACPI: SDEI 0x000000005BC80000 000024 \
                (v00 BOCHS  BXPC     00000001 BXPC 00000001)
     sdei: SDEIv1.1 (0x4b564d) detected in firmware.
     SDEI TEST: Version 1.1, Vendor 0x4b564d
     sdei_init: SDEI event (0x0) registered
     sdei_init: SDEI event (0x0) enabled

 
     (qemu) migrate -d tcp:localhost:4444

    [2.3] Migrate the source VM to the destination VM. Inject SDEI event
          to the destination VM. The event is raised and handled.

    (qemu) migrate -d tcp:localhost:4444

    [host]# echo 0 > /proc/kvm/kvm-5360/vcpu-1

    [guest-dst]#
    =========== SDEI Event (CPU#1) ===========
    Event: 0000000000000000  Parameter: 00000000dabfdabf
    PC:    ffff800008cbb554  PSTATE: 00000000604000c5  SP: ffff800009c7bde0
    Regs:    00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001 
             ffff800016c28000 0000000000000000 0000000000000000 0000000000000000 
             0000000000000000 0000000000000000 0000000000000000 0000000000000000 
             0000000000000000 0000000000000000 0000000000000000 0000000000000000 
             0000000000000000 0000000000000000 0000000000000000 ffff800009399008 
             ffff8000097d9af0 ffff8000097d99f8 ffff8000093a8db8 ffff8000097d9b18 
             0000000000000000 0000000000000000 ffff000000339d00 0000000000000000 
             0000000000000000 ffff800009c7bde0 ffff800008cbb5c4 
    Context: 00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001 
             ffff800016c28000 03ffffffffffffff 000000024325db59 ffff8000097de190 
             ffff00000033a790 ffff800008cbb814 0000000000000a30 0000000000000000 

Changelog
========= 
v7:
   * Rebased to v5.19.rc1                                     (Gavin)
   * Add hypercall ranges for routing                         (Oliver)
   * Remove support to the critical event and redesigned
     data structures. Function names are also modified
     as Oliver suggested                                      (Oliver)
   * Deliver event when it's enabled or the specific PE
     is unmasked                                              (Oliver)
   * Improve EVENT_COMPLETE_AND_RESUME hypercall to resume
     from the specified address                               (Oliver) 
   * Add patches for SDEI migration and documentation         (Gavin)
   * Misc comments from Oliver Upon                           (Oliver)
v6:
   * Rebased to v5.18.rc1                                     (Gavin)
   * Pass additional argument to smccc_get_arg()              (Oliver) 
   * Add preparatory patch to route hypercalls based on their
     owners                                                   (Oliver)
   * Remove the support for shared event.                     (Oliver/Gavin)
   * Remove the support for migration and add-on patches to
     support it in future                                     (Oliver)
   * The events are exposed by KVM instead of VMM             (Oliver)
   * kvm_sdei_state.h is dropped and all the structures are
     folded into the corresponding ones in kvm_sdei.h         (Oliver)
   * Rename 'struct kvm_sdei_registered_event' to
     'struct kvm_sdei_event'                                  (Oliver)
   * Misc comments from Oliver Upon                           (Oliver)  
v5/v4/v3/v2/v1:
   * Skipped here and please visit the history by
     https://lore.kernel.org/lkml/20220403153911.12332-4-gshan@redhat.com/T/

Gavin Shan (22):
  KVM: arm64: Extend smccc_get_argx()
  KVM: arm64: Route hypercalls based on their owner
  KVM: arm64: Add SDEI virtualization infrastructure
  KVM: arm64: Support EVENT_REGISTER hypercall
  KVM: arm64: Support EVENT_{ENABLE, DISABLE} hypercall
  KVM: arm64: Support EVENT_CONTEXT hypercall
  KVM: arm64: Support EVENT_UNREGISTER hypercall
  KVM: arm64: Support EVENT_STATUS hypercall
  KVM: arm64: Support EVENT_GET_INFO hypercall
  KVM: arm64: Support PE_{MASK, UNMASK} hypercall
  KVM: arm64: Support {PRIVATE, SHARED}_RESET hypercall
  KVM: arm64: Support event injection and delivery
  KVM: arm64: Support EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall
  KVM: arm64: Support EVENT_SIGNAL hypercall
  KVM: arm64: Support SDEI_FEATURES hypercall
  KVM: arm64: Support SDEI_VERSION hypercall
  KVM: arm64: Expose SDEI capbility and service
  KVM: arm64: Allow large sized pseudo firmware registers
  KVM: arm64: Support SDEI event migration
  KVM: arm64: Add SDEI document
  selftests: KVM: aarch64: Add SDEI case in hypercall tests
  selftests: KVM: aarch64: Add SDEI test case

 Documentation/virt/kvm/api.rst                |  11 +
 Documentation/virt/kvm/arm/hypercalls.rst     |   4 +
 Documentation/virt/kvm/arm/sdei.rst           |  64 ++
 arch/arm64/include/asm/kvm_host.h             |   3 +
 arch/arm64/include/asm/kvm_sdei.h             |  81 +++
 arch/arm64/include/uapi/asm/kvm.h             |  18 +
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/arm.c                          |   8 +
 arch/arm64/kvm/hypercalls.c                   | 182 +++--
 arch/arm64/kvm/psci.c                         |  14 +-
 arch/arm64/kvm/pvtime.c                       |   2 +-
 arch/arm64/kvm/sdei.c                         | 676 ++++++++++++++++++
 arch/arm64/kvm/trng.c                         |   4 +-
 include/kvm/arm_hypercalls.h                  |  19 +-
 include/linux/arm-smccc.h                     |   7 +
 include/uapi/linux/arm_sdei.h                 |   8 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/aarch64/hypercalls.c        |  11 +-
 tools/testing/selftests/kvm/aarch64/sdei.c    | 450 ++++++++++++
 20 files changed, 1499 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/virt/kvm/arm/sdei.rst
 create mode 100644 arch/arm64/include/asm/kvm_sdei.h
 create mode 100644 arch/arm64/kvm/sdei.c
 create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c

-- 
2.23.0

