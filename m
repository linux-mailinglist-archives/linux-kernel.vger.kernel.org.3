Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CF51B57D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiEECCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiEECCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:02:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1A496BA
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:58:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dv4so2091409qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=WAYJaqn/4jsrC63FS7JpHVRiU6idieihWGSlrSqaS3I=;
        b=DNYx53tiR8bWN5Rudy6owO9Ixme774X8e+nmpe1SjW6ecwZuJrX0anJmb04TuTcfmQ
         nsSVY0A+55xQD2tpm/vsN+9TbUAOP2wtMTLgtpttkndvotrfdYp4fRHxXyg+A+zQrr2m
         z/6YEWlANwPGY4sbtEiPShesHnduEBl8BhbLe0N63la8Gn6OlU/rMtN3houdKlafTPvi
         Ii42F0y8Q24OTXymaz+YBOZnVLEw3SlEJ5N+siB3aYdhJ0U9KcqSLYznoJhsdTaEZ+40
         ASqpVaj5WPJSw0uGJiprOojIH+M/vyvayNlmbMmIXqu3/LCAsGcrR2eAxsLlG+JcWiBG
         2PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WAYJaqn/4jsrC63FS7JpHVRiU6idieihWGSlrSqaS3I=;
        b=unjFFsJGsy4+SOtfj8xw6zeyV8MoUswf8DcS4hMb8Jmz/sR+VjAC0jcdx0YZYHvp27
         73/MEhuvQ7rkH37d678OCfXXyVvoyuUsDFkJUh1RXSZ3v81urFEo10St8dKhODBD/w4O
         DoXzyLhnTJWVFttUJIZ/87hRQ1pDOVm6i02C0j1tGvvl22fCVxzUyLSP29OOBZqmqMP2
         tQ3TMo1+ks4Fg+hako3pu8nw+kXnNcezbbeQ1AaZICQ2hOqaaaHUyGgIJIAAdElGtxv1
         lpaA+dz6qjpVxnUlnA/fMdW6IYKKoxVBpotAPF9ol7lzwvdQh9S2kOJxU/ih8HnYOWhZ
         yK5w==
X-Gm-Message-State: AOAM533+hw42BYK2/DbFo5kCNCaqh3QIT4vh8d8gYhJ7VMJTsKDP3o1A
        WpV+atLCg5guT13B/qSjVDaq2xRjgBNXHJmEF6g=
X-Google-Smtp-Source: ABdhPJygEgQUQsQir+UNYmEBJVBMaLnGmxatpdvIu/omvFTQoSJH6L8AJi7LsW4mQK/r3ukr9BrT2i/tUdGLebxQfuY=
X-Received: by 2002:a0c:f092:0:b0:458:1192:7781 with SMTP id
 g18-20020a0cf092000000b0045811927781mr20662982qvk.29.1651715902682; Wed, 04
 May 2022 18:58:22 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 5 May 2022 06:58:11 +0500
Message-ID: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
Subject: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
To:     linux@leemhuis.info,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Today, for the first time, I encountered the fact that my new nvme disk is down.
In the kernel logs, I found the following sequence of messages:

[ 3005.869069] [drm] free PSP TMR buffer
[ 4626.562712] nvme nvme0: controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0x10
[ 4626.584716] nvme 0000:06:00.0: enabling device (0000 -> 0002)
[ 4626.585006] nvme nvme0: Removing after probe failure status: -19
[ 4626.590776] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590784] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590797] nvme0n1: detected capacity change from 7814037168 to 0
[ 4626.590814] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590816] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590816] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590832] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590835] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590838] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590847] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
[ 4626.590847] BTRFS error (device nvme0n1p3): bdev /dev/nvme0n1p3
errs: wr 11, rd 0, flush 0, corrupt 0, gen 0
[ 4626.593059] BTRFS: error (device nvme0n1p3) in
btrfs_commit_transaction:2418: errno=-5 IO failure (Error while
writing out transaction)
[ 4626.593075] BTRFS info (device nvme0n1p3: state E): forced readonly
[ 4626.593099] BTRFS warning (device nvme0n1p3: state E): Skipping
commit of aborted transaction.
[ 4626.593107] BTRFS: error (device nvme0n1p3: state EA) in
cleanup_transaction:1982: errno=-5 IO failure
[ 4626.593137] BTRFS: error (device nvme0n1p3: state EA) in
btrfs_sync_log:3331: errno=-5 IO failure

Googling turned up a lot of links to various old reports (4.xx kernel)
and APST issue reports.
In a bug report on kernel.org [6], the unfortunate users talking with
each other with no hope of a solution being found.
The most clarifying article turned out to be [1].

After analyzing the answer of the commands "nvme id-ctrl /dev/nvme0"
and "cat /sys/module/nvme_core/parameters/default_ps_max_latency_us".

# nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x1bb1
ssvid     : 0x1bb1
sn        : 7VS00CLE
mn        : Seagate FireCuda 530 ZP4000GM30013
fr        : SU6SM001
[...]
ps    0 : mp:8.80W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:7.10W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:5.20W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0620W non-operational enlat:2500 exlat:7500 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0440W non-operational enlat:10500 exlat:65000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

# cat /sys/module/nvme_core/parameters/default_ps_max_latency_us
100000

I concluded that my problem is not related to APST because 2500 + 7500
+ 10500 + 65000 = 85500 < 100000
100000 is greater than the total latency of any state (enlat + xlat).

Or am I misinterpreting the results?

Therefore, I would like to ask if there are any other ideas why nvme
can stop working with the message "controller is down; will reset:
CSTS=0xffffffff, PCI_STATUS=0x10", which generally does not say
anything about the reason why this happened.

My kernel is 5.18rc5.

Thanks in advance for any answer that will clear things up. And where
to dig in search of a solution to the problem.

[1] https://wiki.archlinux.org/title/Solid_state_drive/NVMe
[2] [# smartctl -a /dev/nvme0] - https://pastebin.com/JwSXwu6c
[3] [# nvme get-feature /dev/nvme0 -f 0x0c -H] - https://pastebin.com/KZ6FjhGt
[4] [# nvme id-ctrl /dev/nvme0] - https://pastebin.com/seEkPfF7
[5] [full dmesg] - https://pastebin.com/aNEaqtCV
[6] [bug report about Samsung PM951 NVMe] -
https://bugzilla.kernel.org/show_bug.cgi?id=195039

-- 
Best Regards,
Mike Gavrilov.
