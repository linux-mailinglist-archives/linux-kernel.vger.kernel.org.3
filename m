Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ACC4C2CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiBXN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiBXN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:28:53 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7DB0E89
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:28:22 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j2so3898153ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PWoHM5P/pAPHOuW7BhTY/a4Hu1y7CT5eN63sjuNRDM0=;
        b=T6kRQLU5OYXCLAAhR3IDKqlM5/MBIPB0MlSNrYg1ST0xzKd67NFMMi1h1rfacr2EEK
         JmvSBDZQeHGT0VuDaEecgoXv1jcHtywHilkZdgncE5r8pY3dnIzpzeP2clkuaf75SBac
         AC4pPjWSD//SJh4bI8800iyNd/Lbq5HMFH9W5Fl42JvBa12dHgMhsIz47fIX/unGZhTb
         1nZtiuEpXCTa8SvJcvayYbSUjZl6zV7V2lYxe4lpRzHEFVMQM9hCAygqY4yuNtuf/i10
         9RwgEgYTkVh4srczR+kAQlRLepmfi17b6Fh0croahgB+qkdqFZZjhcGEc5EYuzj315VH
         f7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PWoHM5P/pAPHOuW7BhTY/a4Hu1y7CT5eN63sjuNRDM0=;
        b=otsUJQybnsdjAAw4rZcVKmvTD4d43e+kfmfNDHOqCcGLEYyP/v0v8acnOzv4PyAEOg
         ojIFAlNs/9A2TMUmalXnrxXJMimzwr9gqQcEhxZG24b9k4WQCCiamPgiOFsMCl0Kv0SS
         KXHMk/x3Crdobt5+V3iQNblQPe+9cGMDpplRT9SGiBeKRXprdB9B3tIKkNEDo5MaZBEz
         0DxaCYYqs7LHSWzHgTYkTO8l+Ktn5qHsYn74a25/f8gy7jqmM45zthBlfyUw1dgUKNf2
         okazVpkg6l9OnOkqyGwJ8JFHFj4iiolKEi+XCcHLuy7HwVNkA1crPBERFEvj/Ps3pHWu
         SD/A==
X-Gm-Message-State: AOAM533MOkUeTuG8N1nSIbBZNuLaCRAUsxjpttDTtDn3fLHN5cLF9xPw
        QDQ1jOTB6jKkqTnRfTfnzRgPuzUZ5KWzh6V9KQyoWg==
X-Google-Smtp-Source: ABdhPJxnnQg82+iGZ9tQJY/owmawEKGz4l4bYRutG1NcymM1wcsYLniNeRuWFOrxo49epnA8AM9EVI4jsl0UEGopAjU=
X-Received: by 2002:a25:6993:0:b0:624:55af:336c with SMTP id
 e141-20020a256993000000b0062455af336cmr2381922ybc.412.1645709301901; Thu, 24
 Feb 2022 05:28:21 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Feb 2022 18:58:10 +0530
Message-ID: <CA+G9fYtzLr+9T9Z1N8QLznW6DqTOU8iSHvgMftdhe2XkEf8F8g@mail.gmail.com>
Subject: [next] next-20220223 kernel crash
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20220223 boot failed due to the kernel crash on all devices.

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: d4a0ae62a277377de396850ed4b709b6bd9b7326
  git_describe: next-20220223
  kernel-config: https://builds.tuxbuild.com/25XO3ffPO3RLpbE3aNxffMu4nEf/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

crash log on x86_64 machine [1]:
[    5.326681] Please do not flush events WQ.
[    5.327480] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.17.0-rc5-next-20220223 #1
[    5.327480] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[    5.327480] Call Trace:
[    5.327480]  <TASK>
[    5.327480]  dump_stack_lvl+0x49/0x5e
[    5.327480]  dump_stack+0x10/0x12
[    5.327480]  check_flush_dependency.cold+0x19/0x2e
[    5.327480]  __flush_work.isra.0+0x186/0x400
[    5.327480]  ? alloc_unbound_pwq+0x600/0x600
[    5.327480]  ? preempt_count_sub+0xd2/0x120
[    5.327480]  ? __rcu_read_unlock+0x53/0x70
[    5.327480]  ? __queue_work+0x33e/0x680
[    5.327480]  ? queue_work_on+0x4e/0x80
[    5.327480]  ? work_on_cpu+0xb5/0xf0
[    5.327480]  ? trace_hardirqs_on+0x38/0x120
[    5.327480]  work_on_cpu+0xc1/0xf0
[    5.327480]  ? queue_work_on+0x80/0x80
[    5.327480]  ? __traceiter_workqueue_execute_end+0x70/0x70
[    5.327480]  ? acpi_processor_power_init_bm_check+0x1a0/0x1a0
[    5.327480]  ? acpi_os_allocate_zeroed+0x2a/0x2a
[    5.327480]  acpi_processor_ffh_cstate_probe+0x105/0x1f0
[    5.327480]  acpi_processor_evaluate_cst+0x553/0x670
[    5.327480]  ? acpi_processor_claim_cst_control+0x80/0x80
[    5.327480]  ? __kasan_check_write+0x14/0x20
[    5.327480]  ? up_write+0x3f/0x70
[    5.327480]  acpi_processor_get_power_info+0x87/0x850
[    5.327480]  acpi_processor_power_init+0x113/0x260
[    5.327480]  __acpi_processor_start+0x205/0x270
[    5.327480]  acpi_processor_start+0x41/0x60
[    5.327480]  really_probe+0x138/0x5d0
[    5.327480]  ? __kasan_check_write+0x14/0x20
[    5.327480]  __driver_probe_device+0x19e/0x230
[    5.327480]  driver_probe_device+0x4e/0xf0
[    5.327480]  __driver_attach+0xfc/0x260
[    5.327480]  ? __device_attach_driver+0x130/0x130
[    5.327480]  bus_for_each_dev+0xfb/0x150
[    5.327480]  ? subsys_dev_iter_exit+0x10/0x10
[    5.327480]  ? preempt_count_sub+0xd2/0x120
[    5.327480]  ? _raw_spin_unlock+0x1f/0x40
[    5.327480]  driver_attach+0x2d/0x40
[    5.327480]  bus_add_driver+0x23f/0x300
[    5.327480]  driver_register+0x119/0x1a0
[    5.327480]  ? acpi_video_init+0x142/0x142
[    5.327480]  acpi_processor_driver_init+0x33/0xc8
[    5.327480]  do_one_initcall+0x99/0x2c0
[    5.327480]  ? trace_event_raw_event_initcall_finish+0x160/0x160
[    5.327480]  ? parameqn+0x40/0xa0
[    5.327480]  ? __kmalloc+0x1cf/0x390
[    5.327480]  kernel_init_freeable+0x2d2/0x330
[    5.327480]  ? rest_init+0xf0/0xf0
[    5.327480]  kernel_init+0x1e/0x140
[    5.327480]  ret_from_fork+0x22/0x30
[    5.327480]  </TASK>

crash log on qemu [2]:

[    9.766144] Please do not flush events_unbound WQ.
[    9.766938] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
5.17.0-rc5-next-20220223 #1
[    9.766938] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[    9.766938] Call Trace:
[    9.766938]  <TASK>
[    9.766938]  dump_stack_lvl+0x49/0x5e
[    9.766938]  dump_stack+0x10/0x12
[    9.766938]  check_flush_dependency.cold+0x19/0x2e
[    9.766938]  __flush_work.isra.0+0x186/0x400
[    9.766938]  ? __queue_work+0x339/0x680
[    9.766938]  ? alloc_unbound_pwq+0x600/0x600
[    9.766938]  ? __queue_work+0x33e/0x680
[    9.766938]  ? queue_work_on+0x4e/0x80
[    9.766938]  ? driver_deferred_probe_trigger.part.0+0xcb/0xe0
[    9.766938]  ? trace_hardirqs_on+0x38/0x120
[    9.766938]  ? queue_work_on+0x4e/0x80
[    9.766938]  ? driver_deferred_probe_add.part.0+0xe0/0xe0
[    9.766938]  flush_work+0xe/0x10
[    9.766938]  deferred_probe_initcall+0x3e/0xa0
[    9.766938]  do_one_initcall+0x99/0x2c0
[    9.766938]  ? trace_event_raw_event_initcall_finish+0x160/0x160
[    9.766938]  ? parameqn+0x40/0xa0
[    9.766938]  ? __kmalloc+0x1cf/0x390
[    9.766938]  kernel_init_freeable+0x2d2/0x330
[    9.766938]  ? rest_init+0xf0/0xf0
[    9.766938]  kernel_init+0x1e/0x140
[    9.766938]  ret_from_fork+0x22/0x30
[    9.766938]  </TASK>
[    9.786217] PM:   Magic number: 10:124:564


--
Linaro LKFT
https://lkft.linaro.org


[1] https://lkft.validation.linaro.org/scheduler/job/4617047#L840
[2] https://lkft.validation.linaro.org/scheduler/job/4617053#L661
