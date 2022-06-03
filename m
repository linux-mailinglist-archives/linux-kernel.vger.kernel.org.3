Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3753C7CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbiFCJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbiFCJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6445F3A712
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654249508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rsKQEbWsef0bo2M/j5MGFrCZlYTFc+y8nkNtaE/+Xtw=;
        b=HSYW+fgPgMzWaF33CWzRvGuRkPmgz5hSX+VK2/j8vhkYsn6lX6T9bbgrwlPgdEDmHfoI6y
        1tLcVTe76D0s9/62yzIDuqAP0ThivYI2gG5JAeVEPm8ViNSXDxkvvyHYPMjPE/6J8LMM8F
        BufYrXV0etb3YzQe5lDNXSg+nPUM4zE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516--f3xx-1YM3CGRoBgkhSAtA-1; Fri, 03 Jun 2022 05:45:07 -0400
X-MC-Unique: -f3xx-1YM3CGRoBgkhSAtA-1
Received: by mail-lf1-f71.google.com with SMTP id j4-20020a056512398400b0047866b0b823so3889419lfu.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rsKQEbWsef0bo2M/j5MGFrCZlYTFc+y8nkNtaE/+Xtw=;
        b=od66xCxT8B5qv8CbAb/+5LyG3Wo+8K/mlncS1WvQ049bNHt4LlXOklpo2v0JGJXuuF
         zRBuLfpVvLVvT5tdPjJCG5z5A3NBiZS+HO/5lEtpG1xam6qwtybUQ1tHS8r8AKNGSARj
         EmhkR91nUmUuY0CmgDyRQNfJw+FTQsCQFp1uCH87EYr7XrWMXcnLuD0YAahG7QpuJPYA
         UfL7FD8dzx8cxi0ZO3YbsYwuBMtjSPHa6YyVyitgIJvbCdknL9Dog8QkMFc/A+gpkNDk
         sUgRzB7AO7HDico1EnJGirF1UyhB1pq+8XRl97WaL7V/J9uj8UgiSZcm8LUCbqRm6mhp
         LGPw==
X-Gm-Message-State: AOAM531M94ZJyyak5BrrAn7knlCnEb3CtOT2LDzFV46EILlSdrPYFjFL
        fCDsVw0D8uJb1ciNtsbfCce+KAK6WZHmRkAvStLXD+mG/0lcisrv8GmRIjI8TMrEqHXi+cQ5QmE
        KQkQbgyaKKWPrTWYDfpWmRQZKN376Iii9kkyte2ch
X-Received: by 2002:a05:651c:c3:b0:255:6e3b:dfc3 with SMTP id 3-20020a05651c00c300b002556e3bdfc3mr6617830ljr.333.1654249505598;
        Fri, 03 Jun 2022 02:45:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKHEYE2FklYSXrnxjp3FmSc9id9tOu7q4s62Zi6TKTtY2fdB8POffhxX+2Se3QQpOBgHf2vFFWsI/N3nZnIpM=
X-Received: by 2002:a05:651c:c3:b0:255:6e3b:dfc3 with SMTP id
 3-20020a05651c00c300b002556e3bdfc3mr6617820ljr.333.1654249505402; Fri, 03 Jun
 2022 02:45:05 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 3 Jun 2022 11:44:54 +0200
Message-ID: <CA+QYu4qTWaDzep2GGxm-63r-xJOFf2rFCCNhWupAgZdKE7HV6w@mail.gmail.com>
Subject: [aarch64] INFO: rcu_sched detected expedited stalls on CPUs/tasks
To:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We recently started to hit this problem on some of our aarch64
machines. The stalls can happen even during boot.

[ 1086.949484] rcu: INFO: rcu_sched detected expedited stalls on
CPUs/tasks: { 23-... } 3 jiffies s: 3441 root: 0x2/.
[ 1086.949510] rcu: blocking rcu_node structures (internal RCU debug):
l=1:16-31:0x80/.
[ 1086.949524] Task dump for CPU 23:
[ 1086.949528] task:sugov:23        state:R  running task     stack:
 0 pid: 2914 ppid:     2 flags:0x0000000a
[ 1086.949543] Call trace:
[ 1086.949546]  __switch_to+0x104/0x19c
[ 1086.949568]  __schedule+0x410/0x67c
[ 1086.949576]  schedule+0x70/0xa8
[ 1086.949583]  schedule_hrtimeout_range_clock+0x144/0x1d8
[ 1086.949592]  schedule_hrtimeout_range+0x20/0x2c
[ 1086.949598]  usleep_range_state+0x5c/0x80
[ 1086.949603]  check_pcc_chan+0x7c/0xf4
[ 1086.949615]  send_pcc_cmd+0x130/0x2a8
[ 1086.949619]  cppc_set_perf+0x12c/0x22c
[ 1086.949624]  cppc_cpufreq_set_target+0xf8/0x15c [cppc_cpufreq]
[ 1086.949645]  __cpufreq_driver_target+0x94/0xfc
[ 1086.949658]  sugov_work+0x98/0xe0
[ 1086.949675]  kthread_worker_fn+0x124/0x2b8
[ 1086.949683]  kthread+0xd4/0x558
[ 1086.949689]  ret_from_fork+0x10/0x20

More logs:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Storage_block_filesystem_fio_test/12073991_aarch64_1_dmesg.log

https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Boot_test/12073991_aarch64_1_test_console.log

CKI issue tracker: https://datawarehouse.cki-project.org/issue/1259

Thanks,
Bruno Goncalves

