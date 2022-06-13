Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831C549E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiFMT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346463AbiFMT7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:59:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116ED12D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:31:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so12789067ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3ixBtslEj5PPEAdoE6Ws96hGe2iDO+ulqmxYhXpP1DQ=;
        b=NmdmBvOZjTajqysa2xUNAcl3cXBwsTqcKKDTYdLGaUSsXA9omvXVxxqsFIxHEYFj9T
         F2zYonkTigB4hdL8dXo+6MKnHoUKoB6Xf3SeuudSSTH9S7nZI3uAz0BT9pRgPbE9SU/s
         dol7ygxkQSWomTammHH0Vc9F1fMVA3cAdI/Tv00E/OYv/AmGvEYuZpIe+vCFE3OZkX4s
         t96fu9F8aU4vs1PkVuQ8ZvcnLXYd/Xv3QEaWfy5ZMH91UMkbv6x/c4UJ6mQwUZJm5ezO
         yFAT6E/0bfAyAGljiJ5rjfMBDgcaAOF3yMeahGbL4MjN4xL7yaeTxL9n6sQDEFZT+rUN
         tb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3ixBtslEj5PPEAdoE6Ws96hGe2iDO+ulqmxYhXpP1DQ=;
        b=L0qQhxup2fGAVFBRXJouZvC6e+qbiHA/aanRlNZYeVlP4N/SAT7O7L2nFsxUsB1i5J
         8BfxD/Ch406iTeAwmUsv/D0EFZEGmIlXIF1lTFDE/1s9khHpAFTUycilFcRbwLnb2xej
         d8ScSvLVVg+MjW+psI/BTlDB6O33RVEdQ4kGICw2eWCZbN3yVb87GJ7lqxwFUa0r0t1q
         7htXHpgGNhoN3qkqxDcC/Ya0YpEu7RdCFIxhtKTzbXSya4u+rJKfsyun2Z2k7Y+exk3i
         qLCFwY4oIR7z+2mHgK7cUqk/shAJ22dPPb/THtNxrHQGHK7bOQIUo8e97vrCZyrlNAAD
         mQtA==
X-Gm-Message-State: AOAM531qigG/f5F77NKR0wsK5PhWxSRprtFljTsFl40X84D/TdENv6q4
        Zm5IY2nvE5fyHQ7JSYdbhSFHIu7z/AY=
X-Google-Smtp-Source: AGRyM1uVVzcVyZ9D/6isvvbEn9cBJX4KTYW61Ag8HZgUTI42c0DtWH+6tQinPk8222SrPHq7bZjKRA==
X-Received: by 2002:a17:907:3c09:b0:70b:442e:7e80 with SMTP id gh9-20020a1709073c0900b0070b442e7e80mr1003387ejc.593.1655145063005;
        Mon, 13 Jun 2022 11:31:03 -0700 (PDT)
Received: from tuco.localdomain (net-93-66-118-196.cust.vodafonedsl.it. [93.66.118.196])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906319800b00712134a676asm4168868ejy.93.2022.06.13.11.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:31:02 -0700 (PDT)
Date:   Mon, 13 Jun 2022 20:31:00 +0200
From:   Ivan Grimaldi <grimaldi.ivan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Grimaldi <grimaldi.ivan@gmail.com>
Subject: RCU stall in SyS_futex kernel v4.4.240
Message-ID: <CAO1575X8_=xFh_wuMP1utyUXiPYh_iNBAz=ehaVA2TGbT38beQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TUID: ZimEydHRBzUp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I occasionally have kernel rcu stall (randomly some hours after boot) and after that the output just goes on until I reboot the machine. There doesn't appear to be any pattern when it occurs and I cannot reproduce it.
The similar rcu stall info happened on different machines, which all have the same Backtrace output.

Can someone help me how to process this type of issue further?

The Linux version is v4.4.240 and the machine is imx6dl based, 32 bits.

Below is the rcu stall info:

[ ... ]

INFO: rcu_sched self-detected stall on CPU
1-...: (52300 ticks this GP) idle=439/140000000000001/0 softirq=806264/806264 fqs=52291
INFO: rcu_sched detected stalls on CPUs/tasks:
1-...: (52300 ticks this GP) idle=439/140000000000001/0 softirq=806264/806264 fqs=52291
(detected by 0, t=52542 jiffies, g=463552, c=463551, q=391502)
Task dump for CPU 1:
WQ#1(System) R running 4640 28173 28140 0x00000002
Backtrace:
[<beb5bd7c>] (0xbeb5bd7c) from [<beb5bdac>] (0xbeb5bdac)
Backtrace aborted due to bad frame pointer <8007759c>
(t=52545 jiffies g=463552 c=463551 q=391595)
Task dump for CPU 1:
WQ#1(System) R running 4640 28173 28140 0x00000002
Backtrace:
[<80014a38>] (dump_backtrace) from [<80014c80>] (show_stack+0x20/0x24)
r7:807b26c0 r6:60010193 r5:807b26c0 r4:bcfbae00
[<80014c60>] (show_stack) from [<80057204>] (sched_show_task+0xbc/0x118)
[<80057148>] (sched_show_task) from [<80059354>] (dump_cpu_task+0x3c/0x4c)
r5:807b26c0 r4:00000001
[<80059318>] (dump_cpu_task) from [<80082344>] (rcu_dump_cpu_stacks+0x94/0xd8)
r5:807b26c0 r4:00000001
[<800822b0>] (rcu_dump_cpu_stacks) from [<80086698>] (rcu_check_callbacks+0x548/0x860)
r9:bf7d3100 r8:807b26c0 r7:807a460c r6:3f033000 r5:807a4584 r4:807a0100
[<80086150>] (rcu_check_callbacks) from [<8008aca4>] (update_process_times+0x48/0xa8)
r10:8009d204 r9:bf7cfc98 r8:805989c4 r7:00002fd9 r6:bcfbae00 r5:ffffe000
r4:00000000
[<8008ac5c>] (update_process_times) from [<8009d200>] (tick_sched_handle+0x58/0x5c)
r7:00002fd9 r6:23800e91 r5:beb5bde8 r4:bf7cfdb8
[<8009d1a8>] (tick_sched_handle) from [<8009d258>] (tick_sched_timer+0x54/0x9c)
[<8009d204>] (tick_sched_timer) from [<8008b9fc>] (__hrtimer_run_queues+0x160/0x324)
r7:bf7cfc00 r6:beb5a000 r5:00000000 r4:bf7cfdb8
[<8008b89c>] (__hrtimer_run_queues) from [<8008c2e8>] (hrtimer_interrupt+0xc8/0x22c)
r10:bf7cfc78 r9:bf7cfc98 r8:bf7cfc14 r7:00000000 r6:8079cc00 r5:00000003
r4:bf7cfc00
[<8008c220>] (hrtimer_interrupt) from [<80018728>] (twd_handler+0x3c/0x50)
r10:807eea3c r9:f4000100 r8:bf022d80 r7:00000010 r6:bf7d5700 r5:bf08a400
r4:00000001
[<800186ec>] (twd_handler) from [<8007c1e8>] (handle_percpu_devid_irq+0x88/0x1a0)
r5:bf08a400 r4:8079e38c
[<8007c160>] (handle_percpu_devid_irq) from [<8007759c>] (generic_handle_irq+0x30/0x44)
r10:807a4cc0 r9:f4000100 r8:bf034000 r7:00000001 r6:00000000 r5:00000010
r4:8079e38c r3:8007c160
[<8007756c>] (generic_handle_irq) from [<800778a0>] (__handle_domain_irq+0x60/0xc8)
[<80077840>] (__handle_domain_irq) from [<800094c0>] (gic_handle_irq+0x60/0xc4)
r9:f4000100 r8:807eea38 r7:beb5bde8 r6:000003ff r5:000003eb r4:f400010c
[<80009460>] (gic_handle_irq) from [<80593534>] (__irq_svc+0x54/0x70)
Exception stack(0xbeb5bde8 to 0xbeb5be30)
bde0: bf1a1e44 00000000 0000b2cc 0000a7b4 00000000 00000000
be00: ffffffff 01bc9294 bf1a1e40 bf1a1e40 00000001 beb5be44 80592d34 beb5be38
be20: 8009ef44 80592d60 80010013 ffffffff
r10:00000001 r9:bf1a1e40 r8:bf1a1e40 r7:beb5be1c r6:ffffffff r5:80010013
r4:80592d60
[<80592d20>] (_raw_spin_lock) from [<8009ef44>] (futex_wake+0xa4/0x194)
[<8009eea0>] (futex_wake) from [<800a0ec4>] (do_futex+0x128/0xd80)
r10:000000f0 r9:01bc9294 r8:00000001 r7:01bc9294 r6:00000081 r5:00000000
r4:00000000
[<800a0d9c>] (do_futex) from [<800a1ba4>] (SyS_futex+0x88/0x188)
r10:000000f0 r9:beb5a000 r8:80010844 r7:01bc9294 r6:00000081 r5:00000000
r4:00000001
[<800a1b1c>] (SyS_futex) from [<80010660>] (ret_fast_syscall+0x0/0x48)
r10:000000f0 r9:beb5a000 r8:80010844 r7:000000f0 r6:7ee2e842 r5:01bc92b0
r4:00000000

[ ... ]

Thanks and Regards,
Ivan
