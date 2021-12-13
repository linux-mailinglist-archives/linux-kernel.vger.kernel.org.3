Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C95471FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhLMEZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhLMEZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:25:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17008C06173F;
        Sun, 12 Dec 2021 20:25:00 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so13723093pjc.4;
        Sun, 12 Dec 2021 20:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nPlyh9/dpW3O3t8/blbu6BlewNhMrFJiJO38ayFPy+g=;
        b=BFcqocfsaJ8zJzKq5wOOO+rCG7IVIqszM9ONHKMfRwJsVl78GVPrXllJ55kXofe+ZS
         bh25S0HH7biij/XoEvFRR57ZwVsa4rlfia/6UOci7qr7dnWnH0ShV0lG+/3xFQsJ9wVk
         kvwL7lurLsgRHkrJJMvnr5yPVNynm1R45KwmcVJUQRdTkiUW3V6/W7ZJiLSNgkJJFG6/
         NoMWFMnWwJrhgR0W1KDA+yurJZApyAsISVHnyjyI5iAZouQCON0V2v381ATiTOK8ZcFx
         EqY+pZokz5D5wgPxW0jzNPi2bY2GClAA+GVnAYetq70MpRLXoQX1Rruxl40v6UhOHURi
         lJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nPlyh9/dpW3O3t8/blbu6BlewNhMrFJiJO38ayFPy+g=;
        b=n1l51tnQMaer0kQuBR6x8v3orhBwoV+tXZcp4ZPEa/WmIicxskBC1hiSlPvctdsdSy
         rKvnWhjUJU1Uik4gde4TbWZUrunNWoazQCbY28WTbkFdbdicylKug1f/7DPpGTnZHd/+
         HW0WLhFkGdj2G2CoIpR1LnGTTKRzNBukDLwVxja0BowVl0gh0vvGA6A0QLnZjc6g9WQ1
         9x9+PQzRodiDNAn8/See2fRYueKs3cy7/0hD0F0P/qEQMWPV369XIiLRjCaP9LNg4Kyt
         NHKMnrxuveXSw+dtiJwAqW5quKm/cFJ3vZnq7yYH9bS5eajhb/R+wtbV/tOREJ2PkbPs
         OLMg==
X-Gm-Message-State: AOAM5315DQBv9z/UPM4TFq6tnPqOE91kT447PSbvwQBcneyfwQYTVYy/
        0/swfDBAJW2eklO3UPkyNdMubPlQDMDExAa9
X-Google-Smtp-Source: ABdhPJzsL8+3eYnmECCiXuMFK2nXrD0sb+OTIahPuzg4bwVTPNH6eyaEidZzhdGaOacru/+uAhWcKA==
X-Received: by 2002:a17:902:d2c7:b0:142:f06:e5fa with SMTP id n7-20020a170902d2c700b001420f06e5famr92749499plc.87.1639369499401;
        Sun, 12 Dec 2021 20:24:59 -0800 (PST)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id mq14sm5311123pjb.54.2021.12.12.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 20:24:58 -0800 (PST)
Date:   Mon, 13 Dec 2021 13:22:23 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     efremov@linux.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yjkwon@kaist.ac.kr
Subject: WARNING in schedule_bh
Message-ID: <YbbKf6fU7y3GGZum@archdragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

During fuzzing, I observed a few warnings in the floppy driver, which
seems similar with the one found by Syzkaller.
(https://syzkaller.appspot.com/bug?id=7c17d936536dc3864e5df2d79ea11cdd946f81bf).

One of the warning reports is as follow:
------------[ cut here ]------------
WARNING: CPU: 2 PID: 11682 at drivers/block/floppy.c:1000 schedule_bh drivers/block/floppy.c:1000 [inline]
WARNING: CPU: 2 PID: 11682 at drivers/block/floppy.c:1000 process_fd_request drivers/block/floppy.c:2851 [inline]
WARNING: CPU: 2 PID: 11682 at drivers/block/floppy.c:1000 fd_locked_ioctl drivers/block/floppy.c:3506 [inline]
WARNING: CPU: 2 PID: 11682 at drivers/block/floppy.c:1000 fd_ioctl+0x4825/0x4e90 drivers/block/floppy.c:3555
Modules linked in:
...
(skipped)
...
Call Trace:
 <TASK>
 blkdev_ioctl+0x45f/0xb20 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0x12c/0x1e0 fs/ioctl.c:860
 __x64_sys_ioctl+0x9e/0xe0 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x6f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x478b29
...
(skipped)
...
 </TASK>
------------------------------------

A similar warning seems to occur in places where schedule_bh() is
called (e.g., floppy_queue_rq, floppy_interrupt, ...).

I am trying to understand why this happens. The below execution
scenario is my best guess (but different with the above call
trace). Since I don't fully understand the semantic of the floppy
driver, please execuse me if this is wrong.


fd_locked_ioctl(FDRESET)      kworkerd                                  floppy_interrupt
  user_reset_fdc()
    cont = &reset_cont;
    wait_til_done(reset_fdc)
      schedule_bh(reset_fdc)
	  wait_event(command_done)
                              reset_fdc()
                                do_floppy = reset_interrupt
                                /* triggering an interrupt
                                   as stated in the comment */
                                                                        handler = do_floppy // reset_interrupt
                                                                        schedule_bh(handler)
                              reset_interrupt()
                                success_and_wakeup // reset_cont.redo
								  genric_success()
                                    generic_done(1)  // reset_cont.done
                                      cont = &wakeup_cont
                                  do_wakeup()      // wakeup_cont.redo
                                    reschedule_timeout()
                                    cont = NULL
                                    wake_up(command_done) // fd_locked_ioctl() can now resume

                              floppy_shutdown() // invoked by the above reschedule_timeout()
                                process_fd_request() // cont is NULL by reset_interrupt()
                                  schedule_bh(redo_fd_request)
    process_fd_request()
      schedule_bh(redo_fd_request) <- WARNING


So, for me, concurrent execution of floppy_shutdown() and
fd_locked_ioctl() is suspicious. Could you please check the above
scenario is reasonable?


Best regards,
Dae R. Jeong.
