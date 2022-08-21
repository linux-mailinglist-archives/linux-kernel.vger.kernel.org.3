Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2537559B66B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiHUVVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHUVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 17:21:16 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDB17041;
        Sun, 21 Aug 2022 14:21:15 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id jl18so8324103plb.1;
        Sun, 21 Aug 2022 14:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7hWEQ4EyGrRlJd2RpmmrF42tsj+N1vQRBA8ec0fDmQE=;
        b=2p+AKm/KqEATA+2e3U89K2iCFPV9Teefa4rUkgaqoB/J5sOC3OCd7435BJJgg5oxo2
         RSZWaOf/V3c9lHKhTI7uFHnjPf5Fj6gKxIVohL6WSovCnv91Z46Ot5sauUOhpg0nhx+F
         3JL5EL7ylbzFC8GHiM6dK1w2QUwSRlNCZY+4OG8imvovAeSYQB/QMYq9augAM2L0/N82
         8yyxIkjUDPXoEN8ZzervGPjGs0PY5dC7x+fHTQ14eqLePv0hfg+TfJLLUFkiZR0Ivb4W
         tgY0ZPdvaHlAiIZUV7ZaWO3Le3IAhaIIlHpzPkWzAYSSNOoN0jgYq66pT7CsBlCG6htE
         95ag==
X-Gm-Message-State: ACgBeo36BXycVy9hvJaXAA/p/0zcus3AWiEAyQnS1gCziEzNuzufYMCT
        sIUvkRIYvsw9K996u2K3UGQ=
X-Google-Smtp-Source: AA6agR4uHOqkTf6kXuwBojmUlIiwF4wVtPSsNuZgfMB7eWC5G9MgAQXxJkifsxYxjVOfyVEUbxSdug==
X-Received: by 2002:a17:902:7242:b0:171:398d:9e66 with SMTP id c2-20020a170902724200b00171398d9e66mr17673380pll.19.1661116874959;
        Sun, 21 Aug 2022 14:21:14 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b00172ea8ff334sm901640plh.7.2022.08.21.14.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 14:21:13 -0700 (PDT)
Message-ID: <400efea9-1635-25e9-8924-1813bb8e9d4f@acm.org>
Date:   Sun, 21 Aug 2022 14:21:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] INFO: task hung in scsi_remove_host
Content-Language: en-US
To:     syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com, Ming Lei <ming.lei@redhat.com>
References: <000000000000b5187d05e6c08086@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <000000000000b5187d05e6c08086@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 06:42, syzbot wrote:
> INFO: task kworker/1:3:3625 blocked for more than 143 seconds.
>        Not tainted 6.0.0-rc1-syzkaller-00399-g15b3f48a4339 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:3     state:D stack:24520 pid: 3625 ppid:     2 flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:5182 [inline]
>   __schedule+0xadf/0x52b0 kernel/sched/core.c:6494
>   schedule+0xda/0x1b0 kernel/sched/core.c:6570
>   scsi_remove_host+0x348/0x440 drivers/scsi/hosts.c:199
>   quiesce_and_remove_host drivers/usb/storage/usb.c:867 [inline]
>   usb_stor_disconnect+0x115/0x260 drivers/usb/storage/usb.c:1087
>   usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
>   device_remove drivers/base/dd.c:520 [inline]
>   device_remove+0x11f/0x170 drivers/base/dd.c:512
>   __device_release_driver drivers/base/dd.c:1209 [inline]
>   device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1235
>   bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
>   device_del+0x4f3/0xc80 drivers/base/core.c:3704
>   usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1419
>   usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
>   hub_port_connect drivers/usb/core/hub.c:5197 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
>   port_event drivers/usb/core/hub.c:5653 [inline]
>   hub_event+0x1f86/0x4610 drivers/usb/core/hub.c:5735
>   process_one_work+0x991/0x1610 kernel/workqueue.c:2289
>   worker_thread+0x665/0x1080 kernel/workqueue.c:2436
>   kthread+0x2e4/0x3a0 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>   </TASK>
Hi Ming,

Do you agree that the issue reported above should be fixed by reverting the
patch series "scsi: core: Call blk_mq_free_tag_set() earlier"?

Thanks,

Bart.
