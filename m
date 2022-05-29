Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADD8537302
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 01:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiE2XxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 19:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiE2XxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 19:53:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09A5EBFB
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:53:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso5584569wmp.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ludios.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BMcXcZRDgsVhF2JW/OguxESCZVj4ejMNNDUboWUbOrw=;
        b=DfxmqHXwSC1od3Sz/psUpzwHOgcXMBZ6DpgvvOTs0NYh8hjrJJJ0DQVAencfF5az0S
         BlSuag7TON87kspEIl5QkKK6/wfVyzITUeDmoRh3D3SE9kvJ0zM2V4VdFaqO14l3c9yG
         K42q4eu1CnbYnsMyzK/6PADOZS2kFDGXsMgqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BMcXcZRDgsVhF2JW/OguxESCZVj4ejMNNDUboWUbOrw=;
        b=VLN8MSDLVfuu8rlI185AD/ZvrX+24E1Bsp7qMwec96Us3fsLWXGDpAMZlixAFf2F7O
         P8/2sWcoQ53tKW+0VnpNJXqXOHh8C0N4n9GcOHh+LC8c1ra/ONJBJd7hT+UMBWFcNQH/
         xZ8Qn7AGXa3VHAxrlALLQ/YReLWVasdHrgjkdqdsb6p/KUC5YigP15vupf/b1FyGSGrK
         anyWlgxDHJceR+8ndiowzTQgqsQL8s6+TA/RE4vFpNGigq65U4MRv48HC1BHrxJOYW9K
         xCpkF0SQlTvwEQOQYYQ8ErPNmTQo94a08RTxTw0JDeDFwifKKnmfjj0F4vggbvnvAJek
         5vag==
X-Gm-Message-State: AOAM531LDD8RrMn36r8iaN7hRBwAWkcreFAVzpKDQErrfjV9TOw+h1Wt
        Ig1v2dXhRoNQVVvPwPkTNT1coLr2ULDcYA//n0lWRFnLasiX8A==
X-Google-Smtp-Source: ABdhPJy2Upe3A/vaaPwwNR5p3eWyjlyxF95uCVQy7yQTAGPYGr/KAY2mq+IsM5Yuvkkenr/L2X8FQslN7krrOG962zg=
X-Received: by 2002:a05:600c:2182:b0:397:58f5:c6cf with SMTP id
 e2-20020a05600c218200b0039758f5c6cfmr16291136wme.86.1653868388725; Sun, 29
 May 2022 16:53:08 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Kozik <ivan@ludios.org>
Date:   Sun, 29 May 2022 23:52:42 +0000
Message-ID: <CAKynti+AtijnHPG-hR-zDM9eCX9HawLgB+p2C9VzS8GN-4+UsQ@mail.gmail.com>
Subject: 5.18 missing /proc/sys/kernel/sched_autogroup_enabled?
To:     linux-kernel@vger.kernel.org
Cc:     nizhen@uniontech.com, peterz@infradead.org, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed that /proc/sys/kernel/sched_autogroup_enabled seems to have
gone missing in 5.18. Am I doing something wrong, or is this a
regression?

I also noticed that booting 5.18 with "noautogroup" results in a
"kernel: failed when register_sysctl sched_autogroup_sysctls to
kernel" message.  Because of the error and the missing
/proc/sys/kernel/sched_autogroup_enabled, it is unclear whether
autogroup is enabled or not.

Please see below for my testing. These kernels came from
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.18/ but I saw the
same thing with a 5.18.0 on NixOS.

Best regards,

Ivan



5.17, default:

at@ubuntu2204:~$ uname -a
Linux ubuntu2204 5.17.11-051711-generic #202205251331 SMP PREEMPT Wed
May 25 13:57:33 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

at@ubuntu2204:~$ journalctl -b | grep -i autogroup

at@ubuntu2204:~$ cat /proc/sys/kernel/sched_autogroup_enabled
1



5.17, noautogroup:

at@ubuntu2204:~$ uname -a
Linux ubuntu2204 5.17.11-051711-generic #202205251331 SMP PREEMPT Wed
May 25 13:57:33 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

at@ubuntu2204:~$ journalctl -b | grep -i autogroup
May 29 15:58:17 ubuntu2204 kernel: Command line:
BOOT_IMAGE=/boot/vmlinuz-5.17.11-051711-generic
root=UUID=20672a55-02fc-49b3-8c04-bd040f068096 ro
find_preseed=/preseed.cfg auto noprompt priority=critical locale=en_US
quiet splash noautogroup
May 29 15:58:17 ubuntu2204 kernel: Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-5.17.11-051711-generic
root=UUID=20672a55-02fc-49b3-8c04-bd040f068096 ro
find_preseed=/preseed.cfg auto noprompt priority=critical locale=en_US
quiet splash noautogroup

at@ubuntu2204:~$ cat /proc/sys/kernel/sched_autogroup_enabled
0



5.18, default:

at@ubuntu2204:~$ uname -a
Linux ubuntu2204 5.18.0-051800-generic #202205222030 SMP
PREEMPT_DYNAMIC Sun May 22 20:33:46 UTC 2022 x86_64 x86_64 x86_64
GNU/Linux

at@ubuntu2204:~$ journalctl -b | grep -i autogroup

at@ubuntu2204:~$ cat /proc/sys/kernel/sched_autogroup_enabled
cat: /proc/sys/kernel/sched_autogroup_enabled: No such file or directory

root@ubuntu2204:~# sysctl -a | grep -i autogroup



5.18, noautogroup:

at@ubuntu2204:~$ uname -a
Linux ubuntu2204 5.18.0-051800-generic #202205222030 SMP
PREEMPT_DYNAMIC Sun May 22 20:33:46 UTC 2022 x86_64 x86_64 x86_64
GNU/Linux

at@ubuntu2204:~$ journalctl -b | grep -i autogroup
May 29 15:53:17 ubuntu2204 kernel: Command line:
BOOT_IMAGE=/boot/vmlinuz-5.18.0-051800-generic
root=UUID=20672a55-02fc-49b3-8c04-bd040f068096 ro
find_preseed=/preseed.cfg auto noprompt priority=critical locale=en_US
quiet splash noautogroup
May 29 15:53:17 ubuntu2204 kernel: Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-5.18.0-051800-generic
root=UUID=20672a55-02fc-49b3-8c04-bd040f068096 ro
find_preseed=/preseed.cfg auto noprompt priority=critical locale=en_US
quiet splash noautogroup
May 29 15:53:17 ubuntu2204 kernel: failed when register_sysctl
sched_autogroup_sysctls to kernel

at@ubuntu2204:~$ cat /proc/sys/kernel/sched_autogroup_enabled
cat: /proc/sys/kernel/sched_autogroup_enabled: No such file or directory



root@ubuntu2204:~# cat /boot/config-5.1[78]* | grep -i config_sysctl=
CONFIG_SYSCTL=y
CONFIG_SYSCTL=y

root@ubuntu2204:~# cat /boot/config-5.1[78]* | grep -i autogroup
CONFIG_SCHED_AUTOGROUP=y
CONFIG_SCHED_AUTOGROUP=y
