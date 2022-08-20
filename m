Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE60059AD9D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbiHTLsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbiHTLsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:48:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C93C9C50C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:48:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c24so5615986pgg.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=pqa1Gq7h3v2DwS5gTjROvbrNkKxCSUCGRWODSzQFQlY=;
        b=H2KqB9HFxh0DLW+IAZDpk7GdLg7ZcFOHUeMun3xra2V1GuhuHMdvsjOG5hXbWCdf9D
         F2BJzGPaJFd0KJ67Qrsle+Web9TwP7c0M6mpG8V+vR0c7TdNA0OyfI0LTi7vsV5KwUaE
         0JhMmq8ULhxtsFAF2iiyo6lrj07TDqidIf45NHNXx2FgAnUxCtHF4sLZ9nO8chYHjAlG
         bzIhD6T8ZCYzKU3ZwirReuJJUzRB647Ni7Q7KBmW7Y0hRWR2stohU0tEKPKpBWoX1Zjf
         gFahuTCyMP3onI1aF/pbnlnTp94meFJZ4AUkZ3X7ChIei7yazE9NRVW+7nMSFlnEct5b
         K/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=pqa1Gq7h3v2DwS5gTjROvbrNkKxCSUCGRWODSzQFQlY=;
        b=1cFPiij8pUFMYp6Fpnuhlb5JOYQw+ju0mk+1Al/EH3w+4PfQU57luhw/DoY7EzyYSA
         pYPqYq23Ui7KeTqFOsE2p+/eqWN6fpvpPgQJc2VBfNK09gExjzj90NJZ88xCw5a1+m31
         mlZv2wpzj19Hkywo08J/mcW8A7B+KfIy1ipbrAqA1nzS+g3YzO0YXBpipGwMxNSdeFcB
         MV4DJK1gLTTTrldUte6woKdDI6foVV/88dsJqGNgcG5JfyUoQ/kMmCLjalPAwfxfuV/P
         ihvq3ZzZ5Wr2OML9a0VBjPJY2EyPPJpG1c81QD/ENXeN/LFw/KtX1z7DGUHocEteU1Ac
         J7JA==
X-Gm-Message-State: ACgBeo24udqzMlqita54i2S9yBdzxxroVqqXO1FHvILjasjvxIdi65su
        BSsQiSVxCXvKE12F+sgmCLM=
X-Google-Smtp-Source: AA6agR7blKmtMST2597dF+AKeWC9qpO27kXN80dDlQaT0zqz1lDOmXy2ibvzPFbcNZzXMeIkeIWiIw==
X-Received: by 2002:a63:5a10:0:b0:429:d91c:e146 with SMTP id o16-20020a635a10000000b00429d91ce146mr9903425pgb.19.1660996089014;
        Sat, 20 Aug 2022 04:48:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902ef4400b001708c4ebbaesm4636429plx.309.2022.08.20.04.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 04:48:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 20 Aug 2022 04:48:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Isaac Manjarres <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220820114801.GA3958319@roeck-us.net>
References: <YvvQOBk9T3J1uX8k@google.com>
 <20220817010559.GA1880847@roeck-us.net>
 <YvxAfiSOrzy7/c1J@google.com>
 <20220818225932.GA3433999@roeck-us.net>
 <Yv7bd6Yl8+thp2CY@google.com>
 <20220819112832.GA3106213@roeck-us.net>
 <Yv/MKymRC9O04Nqu@google.com>
 <baa1f65a-d983-0518-3979-7099679995f2@acm.org>
 <20220819220841.GA3230067@roeck-us.net>
 <12b231ea-dc7d-bb09-3986-32a07a63acd4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b231ea-dc7d-bb09-3986-32a07a63acd4@acm.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:07:09PM -0700, Bart Van Assche wrote:
> On 8/19/22 15:08, Guenter Roeck wrote:
> > On Fri, Aug 19, 2022 at 01:01:29PM -0700, Bart Van Assche wrote:
> > > Since the issue has been observed in qemu, how about sharing the sysrq-t
> > > output? I recommend to collect that output as follows:
> > > * Send the serial console output to a file. This involves adding
> > > console=ttyS0,115200n8 to the kernel command line and using the proper qemu
> > > options to save the serial console output into a file.
> > > * Reproduce the hang and send the sysrq-t key sequence to qemu, e.g. as
> > > follows: virsh send-key ${vm_name} KEY_LEFTALT KEY_SYSRQ KEY_T
> > > 
> > Unless I am missing something, this requires a virtio keyboard.
> > So far I have been unable to get this to work with qemu arm emulations.
> 
> That's unfortunate. Is there another way to collect call traces after
> the lockup has happened? Is it sufficient to enable the serial console
> and to monitor the serial console output? Is CONFIG_SOFTLOCKUP_DETECTOR=y
> sufficient? If not, how about converting the new wait calls in the SCSI
> code, e.g. as shown in the (totally untested) patch below?
> 

Enabling the lockup detector did the trick. Backtrace below.

Guenter

---
INFO: task init:283 blocked for more than 122 seconds.
      Tainted: G                 N 6.0.0-rc1-00303-g963a70bee588 #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:init            state:D stack:    0 pid:  283 ppid:     1 flags:0x00000000
 __schedule from schedule+0x70/0x118
 schedule from scsi_remove_host+0x178/0x1c4
 scsi_remove_host from usb_stor_disconnect+0x40/0xe8
 usb_stor_disconnect from usb_unbind_interface+0x78/0x274
 usb_unbind_interface from device_release_driver_internal+0x1a4/0x230
 device_release_driver_internal from bus_remove_device+0xd0/0x100
 bus_remove_device from device_del+0x174/0x3ec
 device_del from usb_disable_device+0xcc/0x178
 usb_disable_device from usb_disconnect+0xcc/0x274
 usb_disconnect from usb_disconnect+0x98/0x274
 usb_disconnect from usb_remove_hcd+0xd0/0x16c
 usb_remove_hcd from host_stop+0x38/0xa8
 host_stop from ci_hdrc_remove+0x40/0x134
 ci_hdrc_remove from platform_remove+0x24/0x54
 platform_remove from device_release_driver_internal+0x1a4/0x230
 device_release_driver_internal from bus_remove_device+0xd0/0x100
 bus_remove_device from device_del+0x174/0x3ec
 device_del from platform_device_del.part.0+0x10/0x78
 platform_device_del.part.0 from platform_device_unregister+0x18/0x28
 platform_device_unregister from ci_hdrc_remove_device+0xc/0x24
 ci_hdrc_remove_device from ci_hdrc_imx_remove+0x28/0xfc
 ci_hdrc_imx_remove from device_shutdown+0x178/0x230
 device_shutdown from __do_sys_reboot+0x168/0x258
 __do_sys_reboot from ret_fast_syscall+0x0/0x1c
Exception stack(0xc8cb9fa8 to 0xc8cb9ff0)
9fa0:                   01234567 0000000f fee1dead 28121969 01234567 00000000
9fc0: 01234567 0000000f 00000001 00000058 000e05c0 00000000 00000000 00000000
9fe0: 000e0298 beacede4 000994bc b6efc2c0

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/10:
 #0: c0de0d6c (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x24/0x48c
1 lock held by khungtaskd/16:
 #0: c0de0c98 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x24/0x1a8
8 locks held by init/283:
 #0: c0dc87e4 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x258
 #1: c1985888 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xd8/0x230
 #2: c1998488 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xe8/0x230
 #3: c2596088 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x34/0x230
 #4: c0e5a5ac (usb_bus_idr_lock){+.+.}-{3:3}, at: usb_remove_hcd+0xc4/0x16c
 #5: c277c8f8 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x60/0x274
 #6: c27880f8 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x60/0x274
 #7: c27a9498 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x34/0x230

=============================================

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 16 Comm: khungtaskd Tainted: G                 N 6.0.0-rc1-00303-g963a70bee588 #3
Hardware name: Freescale i.MX25 (Device Tree Support)
 unwind_backtrace from show_stack+0x10/0x18
 show_stack from dump_stack_lvl+0x34/0x54
 dump_stack_lvl from panic+0x114/0x32c
 panic from watchdog+0x3f4/0x7b4
 watchdog from kthread+0xec/0x128
 kthread from ret_from_fork+0x14/0x3c
Exception stack(0xc88b5fb0 to 0xc88b5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
