Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E14E45C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiCVSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiCVSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:14:43 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E3FD13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:13:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q11so21155928iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rtlpiHKGuBI50mYkezQOMw981of4REeJs1p1T1jGRPs=;
        b=b1k7K7ub7mzBu3/wLuv94d84NYAlaajtfz6AOuR0CeT9C9qpU91QBP1wQJB/2RAXLe
         GN5zOQaagJhe27FM8MOPvm08HNFOa5bSpOxyEy0ci74fos4f/fJuFx3DEt0HzRCcfZnW
         npFZwNfX5aB1iXWx6m/OWMBxdVuUt8zGqB1hI+8vlEa+1k9wBWo+qM5zex7uBxaF+Vcu
         uXVcjMjKcNtHim7npKFNLvwvVpT1pxRZODArBqMETzMc+ICCDZIbFg+U/go3dxvN41WP
         SP2Fya60PunclCXP/JP4lFIf8EYh77i4MxWLTEctWVK5vyKHswcNcPtaLN0Z2ebnWbRE
         dM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtlpiHKGuBI50mYkezQOMw981of4REeJs1p1T1jGRPs=;
        b=yGmkVOz7SKlIaT+f0UqgiN5CxtGAJbIq20WeuZuReChEcmto0hZ7fq9BRP0aW6QkLO
         u2jo38UrJkWZTaWGTw7ABugeTac01w31l9pYI+dA72t5y31EGAlpKhyh59PaQ4ky9Kg7
         EN4IySdFkcF2RT2KHw40+/mCMvPr4rUp/0G+MTRFKEnFxCf2gtgTJtqoJqUSXJLqMtVP
         CWXauXvol8RMa0hl5aKQ/TX6s0jH2Q2z2QTt6n3O3huIvFMHvCZeCasSyQSLk1TZJ3zT
         SlemanewpH/Yn3YtzXBp4gcIUZV31ZOuvHOMjoZbIv0Zz0BRUXErEu4tNzyK6qEJ6V/P
         5hBw==
X-Gm-Message-State: AOAM532uhRXMLE/oFJ1erd4yP9HJUGqSo44cKgPpAEEBsTLTqimXSXBR
        o6HKSh6naIMpioismT2ozOAyKOa342DkXQ==
X-Google-Smtp-Source: ABdhPJxq27BzAmXq4Aget5l4uWNoLAIXNiKfQwk5X/rVxCtuv8st/BJUxLXdZyLFZ4x7jhTu9xZtcw==
X-Received: by 2002:a05:6638:3e13:b0:321:446d:2977 with SMTP id co19-20020a0566383e1300b00321446d2977mr5417041jab.178.1647972793943;
        Tue, 22 Mar 2022 11:13:13 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id w13-20020a92d2cd000000b002c8533c4b27sm341551ilg.78.2022.03.22.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:13:13 -0700 (PDT)
Date:   Tue, 22 Mar 2022 18:13:09 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 00/22] Support SDEI Virtualization
Message-ID: <YjoRteSXpPkDGqgp@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:06:48PM +0800, Gavin Shan wrote:
> This series intends to virtualize Software Delegated Exception Interface
> (SDEI), which is defined by DEN0054C (v1.1). It allows the hypervisor to
> deliver NMI-alike SDEI event to guest and it's needed by Async PF to
> deliver page-not-present notification from hypervisor to guest. The code
> and the required qemu changes can be found from:
> 
>    https://developer.arm.com/documentation/den0054/c
>    https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>    https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
> 
> For the design and migration needs, please refer to the document in
> PATCH[21/22] in this series. The series is organized as below:
> 
>   PATCH[01]    Introduces template for smccc_get_argx()
>   PATCH[02]    Adds SDEI virtualization infrastructure
>   PATCH[03-17] Supports various SDEI hypercalls and event handling
>   PATCH[18-20] Adds ioctl commands to support migration and configuration
>                and exports SDEI capability
>   PATCH[21]    Adds SDEI document 
>   PATCH[22]    Adds SDEI selftest case
> 
> Testing
> =======
> 
> [1] The selftest case included in this series works fine. The default SDEI
>     event, whose number is zero, can be registered, enabled, raised. The
>     SDEI event handler can be invoked.
> 
>     [host]# pwd
>     /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>     [root@virtlab-arm01 kvm]# ./aarch64/sdei 
> 
>         NR_VCPUS: 2    SDEI Event: 0x00000000
> 
>     --- VERSION
>         Version:              1.1 (vendor: 0x4b564d)
>     --- FEATURES
>         Shared event slots:   0
>         Private event slots:  0
>         Relative mode:        No
>     --- PRIVATE_RESET
>     --- SHARED_RESET
>     --- PE_UNMASK
>     --- EVENT_GET_INFO
>         Type:                 Private
>         Priority:             Normal
>         Signaled:             Yes
>     --- EVENT_REGISTER
>     --- EVENT_ENABLE
>     --- EVENT_SIGNAL
>         Handled:              Yes
>         IRQ:                  No
>         Status:               Registered-Enabled-Running
>         PC/PSTATE:            000000000040232c 00000000600003c5
>         Regs:                 0000000000000000 0000000000000000
>                               0000000000000000 0000000000000000
>     --- PE_MASK
>     --- EVENT_DISABLE
>     --- EVENT_UNREGISTER
> 
>         Result: OK
> 
> [2] There are additional patches in the following repositories to create
>     procfs entries, allowing to inject SDEI event from host side. The
>     SDEI client in the guest side registers the SDEI default event, whose
>     number is zero. Also, the QEMU exports SDEI ACPI table and supports
>     migration for SDEI.
> 
>     https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>     https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
> 
>     [2.1] Start the guests and migrate the source VM to the destination
>           VM.
> 
>     [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>             -accel kvm -machine virt,gic-version=host                     \
>             -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
>             -m 1024M,slots=16,maxmem=64G                                  \
>                :                                                          \
>             -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>             -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
>             -append earlycon=pl011,mmio,0x9000000                         \
>                :
> 
>     [host]# /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64       \
>             -accel kvm -machine virt,gic-version=host                     \
>             -cpu host -smp 6,sockets=2,cores=3,threads=1                  \
>             -m 1024M,slots=16,maxmem=64G                                  \
>                :                                                          \
>             -kernel /home/gavin/sandbox/linux.guest/arch/arm64/boot/Image \
>             -initrd /home/gavin/sandbox/images/rootfs.cpio.xz             \
>             -append earlycon=pl011,mmio,0x9000000                         \
>             -incoming tcp:0:4444                                          \
>                :
> 
>     [2.2] Check kernel log on the source VM. The SDEI service is enabled
>           and the default SDEI event (0x0) is enabled.
> 
>      [guest-src]# dmesg | grep -i sdei
>      ACPI: SDEI 0x000000005BC80000 000024 \
>                 (v00 BOCHS  BXPC     00000001 BXPC 00000001)
>      sdei: SDEIv1.1 (0x4b564d) detected in firmware.
>      SDEI TEST: Version 1.1, Vendor 0x4b564d
>      sdei_init: SDEI event (0x0) registered
>      sdei_init: SDEI event (0x0) enabled
> 
>  
>      (qemu) migrate -d tcp:localhost:4444
> 
>     [2.3] Migrate the source VM to the destination VM. Inject SDEI event
>           to the destination VM. The event is raised and handled.
> 
>     (qemu) migrate -d tcp:localhost:4444
> 
>     [host]# echo 0 > /proc/kvm/kvm-5360/vcpu-1
> 
>     [guest-dst]#
>     =========== SDEI Event (CPU#1) ===========
>     Event: 0000000000000000  Parameter: 00000000dabfdabf
>     PC: ffff800008cbb554  PSTATE: 00000000604000c5  SP: ffff800009c7bde0
>     Regs:    00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001 
>              ffff800016c28000 0000000000000000 0000000000000000 0000000000000000 
>              0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>              0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>              0000000000000000 0000000000000000 0000000000000000 ffff800009399008 
>              ffff8000097d9af0 ffff8000097d99f8 ffff8000093a8db8 ffff8000097d9b18 
>              0000000000000000 0000000000000000 ffff000000339d00 0000000000000000 
>              0000000000000000 ffff800009c7bde0 ffff800008cbb5c4 
>     Context: 00000000000016ee ffff00001ffd2e28 00000000000016ed 0000000000000001 
>              ffff800016c28000 03ffffffffffffff 000000024325db59 ffff8000097de190 
>              ffff00000033a790 ffff800008cbb814 0000000000000a30 0000000000000000 
> 
> Changelog
> ========= 
> v5:

Next time can you include a link to the cover letter of the previous
patch set? It is extremely helpful for understanding the progress to
date and allows reviewers to see prior feedback.

--
Thanks,
Oliver
