Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FDD51B859
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbiEEHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiEEHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:04:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567423916C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:00:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l203so3511426oif.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GYb2qyeDXFpfHBcs3u1MbmVCzXSjcUG0qu6nWI0aQBY=;
        b=ltzuFON4sacssZlcAtwXMz5GbnKSvVZaUwUQKVyMl+XFQ9LA6DmMRAMBetiiLTdxz1
         8mHAXwJg/IdvB+T5t4DPfLLq89MFeMOCiy2yYPxfGy+IoLE2hFmvEofMokeOjIseKA3V
         aLxHUzAKFr3t23SVRCMonUC9Jj3F+eXaKSmvTQVgx1d4MIOq27kFQahb8KMVyCHFKcH0
         iSypWWzIy1qRNf2kxYFPoR80Bjzwmy6X9pAuIuT6SRJKSBMZSXB61Zb1oohk8u8OZiXB
         nUVRX3M7Bqyq9+KQgxAOQJVumzaPpMeoNWopa6p8UhSoNIA0AckGfkc8+zyVSeN3J6mN
         VXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GYb2qyeDXFpfHBcs3u1MbmVCzXSjcUG0qu6nWI0aQBY=;
        b=1ji+lJyJEtDCaJS9R7GRwAFDfQZGLcqMEgWyzISYyAlVid3JzBOzzadeUPSnoSypI8
         EPvzPUfrCdlnakVnvMD+NWyCabyvyeSNTBo+bCWfXazrnv2rihLjKrYAAnaDVbU3pJq5
         bTwHlFObrZEDJGGpxXrB8W4JCNtj9pTt3QSE+cZuhlgQWwx3+zP2kE5rNTebZvtVGacS
         h3lBydORFUjFx4NV3fdwijQR8LyeYl0t9iuHskGmOYjJNHvlD3HGZN+CJSGhbZKNCXIc
         /dz3UL0alC34LcaVGeC/A8eutZzSSRUVCx698IgMb+wGZxhdUG/NNUwuUFlxgVZBDTbV
         SSow==
X-Gm-Message-State: AOAM5312vwM5K6mlIrt9vDf8+MMpwdiX6Fa8JxRWGICtI+S1112QuffI
        3U0ocCJov7RPJngDmme9SAgUFFMQX8+baRWdTq2/HQ==
X-Google-Smtp-Source: ABdhPJzIbrVzcDCPJMBPLSECStk77anISWTIvF2PH1N8TpB4sURyaOKd5cyPadiOr9DrZ+b3WQewur735l/o2y4cm30=
X-Received: by 2002:a05:6808:180a:b0:322:bcd3:ddaf with SMTP id
 bh10-20020a056808180a00b00322bcd3ddafmr1623748oib.35.1651734041647; Thu, 05
 May 2022 00:00:41 -0700 (PDT)
MIME-Version: 1.0
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Thu, 5 May 2022 14:59:35 +0800
Message-ID: <CAPpJ_edpzKpLzrwT-+gB2c-6qhVPs_iNHL6=uDOyc9Xr2wGCiQ@mail.gmail.com>
Subject: [BUG] The UI hangs when system changes CPU frequency on Raspberry Pi 4B
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
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

Hi,

We found the UI hangs totally when system changes CPU frequency on
Raspberry Pi 4B.  The test kernel is mainline kernel 5.18-rc3.

According to the oops messages and the stack:

[ 1330.166158] INFO: task kworker/0:0:6 blocked for more than 120 seconds.
[ 1330.172963]       Tainted: G        W   E     5.18.0-rc3 #61
[ 1330.178767] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1330.186742] task:kworker/0:0     state:D stack:    0 pid:    6
ppid:     2 flags:0x00000008
[ 1330.186762] Workqueue: events dbs_work_handler
[ 1330.186779] Call trace:
[ 1330.186782]  __switch_to+0xf8/0x150
[ 1330.186793]  __schedule+0x37c/0x141c
[ 1330.186800]  schedule+0x54/0xc4
[ 1330.186807]  schedule_timeout+0xa4/0x190
[ 1330.186813]  __wait_for_common+0xc4/0x224
[ 1330.186818]  wait_for_completion_timeout+0x2c/0x40
[ 1330.186822]  mbox_send_message+0xf0/0x1f4
[ 1330.186828]  rpi_firmware_property_list+0xf8/0x280
[ 1330.186834]  rpi_firmware_property+0x7c/0xc0
[ 1330.186839]  raspberrypi_fw_set_rate+0x64/0xe4 [clk_raspberrypi]
[ 1330.186851]  clk_change_rate+0xe4/0x470
[ 1330.186859]  clk_core_set_rate_nolock+0x1d0/0x2ec
[ 1330.186864]  clk_set_rate+0x44/0x190
[ 1330.186870]  _set_opp+0x3b4/0x70c
[ 1330.186876]  dev_pm_opp_set_rate+0x11c/0x2d0
[ 1330.186881]  set_target+0x3c/0x4c
[ 1330.186887]  __cpufreq_driver_target+0x400/0x7ac
[ 1330.186893]  od_dbs_update+0xc8/0x1c0
[ 1330.186898]  dbs_work_handler+0x4c/0x8c
[ 1330.186903]  process_one_work+0x210/0x480
[ 1330.186910]  worker_thread+0x180/0x520
[ 1330.186915]  kthread+0xe4/0xf0
[ 1330.186920]  ret_from_fork+0x10/0x20
[ 1330.186928] INFO: task kworker/u8:0:8 blocked for more than 120 seconds.
[ 1330.193744]       Tainted: G        W   E     5.18.0-rc3 #61
[ 1330.199509] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 1330.207467] task:kworker/u8:0    state:D stack:    0 pid:    8
ppid:     2 flags:0x00000008
[ 1330.207485] Workqueue: events_unbound commit_work [drm_kms_helper]
[ 1330.207555] Call trace:
[ 1330.207558]  __switch_to+0xf8/0x150
[ 1330.207572]  __schedule+0x37c/0x141c
[ 1330.207579]  schedule+0x54/0xc4
[ 1330.207586]  schedule_preempt_disabled+0x1c/0x2c
[ 1330.207593]  __mutex_lock.constprop.0+0x160/0x59c
[ 1330.207598]  __mutex_lock_slowpath+0x40/0x8c
[ 1330.207602]  mutex_lock+0x68/0x80
[ 1330.207607]  clk_prepare_lock+0x4c/0xac
[ 1330.207616]  clk_set_rate_range.part.0+0x3c/0x250
[ 1330.207622]  clk_set_min_rate+0x3c/0xdc
[ 1330.207627]  vc4_atomic_commit_tail+0x68c/0x77c [vc4]
[ 1330.207664]  commit_tail+0xd8/0x210 [drm_kms_helper]
[ 1330.207707]  commit_work+0x20/0x30 [drm_kms_helper]
[ 1330.207748]  process_one_work+0x210/0x480
[ 1330.207755]  worker_thread+0x180/0x520
[ 1330.207760]  kthread+0xe4/0xf0
[ 1330.207765]  ret_from_fork+0x10/0x20

Looks like clk_raspberrypi tries to set/change rate by invoking
raspberrypi_fw_set_rate(), but the transaction with firmware is
timeout. There might be a lock shared with others, but held by it. For
example, the second oops message from drm_kms_helper -> vc4 shows
clk_prepare_lock() is waiting to be scheduled.

The UI hangs until raspberrypi-firmware gets the failed returned error
from mbox_send_message().

[ 4887.601985] raspberrypi-firmware soc:firmware: mbox_send_message returned -62
[ 4887.609269] raspberrypi-clk soc:firmware:clocks: Failed to change
fw-clk-arm frequency: -62

The serial console is alive when the UI hangs.

I put all of the findings on https://bugzilla.kernel.org/show_bug.cgi?id=215875

Jian-Hong Pan
