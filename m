Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F326C53CC55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiFCPcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiFCPcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DF37340DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654270340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvY94IZDVudeoGpp5T1ZFrfscSwRdc7raF/u1KiDh0U=;
        b=GKGr6MeAofjzJgk43uwIB4sLNW776+GUxrpgbWZwhbIrRODBPK+qWhHfQNAFyGJO0r4uD1
        DACSmBJzXmplTxt13QLxhm5jXOnVLLYx/GZOn8QKpT6lQ5eCofbEJUMSmgJkHZb9WbLYwv
        Ni4Lsd+9kflOLFpW6NMLLCmhJh3oV9A=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-6zi4aiSkNkim0bmztOvvNQ-1; Fri, 03 Jun 2022 11:32:18 -0400
X-MC-Unique: 6zi4aiSkNkim0bmztOvvNQ-1
Received: by mail-lj1-f200.google.com with SMTP id e3-20020a2e9303000000b00249765c005cso1350874ljh.17
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvY94IZDVudeoGpp5T1ZFrfscSwRdc7raF/u1KiDh0U=;
        b=dDdadNQ+VMSksvHzetLDhNXgvM2LFayMV8K9jn+YtsNkOmcvg/uG4Z2Cfxax3KY9XD
         XVP7XkFsWw4IYvqkno51zXQejpMU1B5eAbnu9jKmOr4XCgf/W+Z1AmYl4V6j2uWDJRYg
         zMT97aA6qcQUbij8FrkZ3Yd32SbKp8gJcJQmY0ySx55lFjF+gJKfv/2lwZl8mubMckDp
         cwdwqZ4/5bdrFNkeMxAMbO6bU6XBpbRPYjjBpjSvAZ9WN3yDxJWO8Cl5izLiu2rKxcuL
         P0cbSptJT3TWXnwOw6fH/AhJ6i78nMnzj59jWpUli2qGylYxIkcGbsfmN7mfdNptDllj
         om2g==
X-Gm-Message-State: AOAM531vvaX3zBgLgeq8PLQvcqd6Y7SSx5j5pQAJFWBnoWBk7CxhDl2A
        oBs4+rvh3MQpWCy+aMTtRDTXnYGdV7brBrLEK24UaYFxigZdcydjeDgG+XmxtBxA4TIEALhUCUd
        perTzzem0ONCUD37CbgG3EeBeeHnwn87zzopafy+U
X-Received: by 2002:a05:6512:1682:b0:479:97f:ebb with SMTP id bu2-20020a056512168200b00479097f0ebbmr7290347lfb.52.1654270337254;
        Fri, 03 Jun 2022 08:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8DumMnd5bqx5dt6/wtJs5zZ0ptZvzErtKnh7epqq31xlY9mI5W+Mzf6vcoRR57lX9B/LUMUSLZoz9BGHoKaM=
X-Received: by 2002:a05:6512:1682:b0:479:97f:ebb with SMTP id
 bu2-20020a056512168200b00479097f0ebbmr7290336lfb.52.1654270337012; Fri, 03
 Jun 2022 08:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qTWaDzep2GGxm-63r-xJOFf2rFCCNhWupAgZdKE7HV6w@mail.gmail.com>
 <99a207dc-93cd-1bea-2ffc-404a9f6587bf@arm.com>
In-Reply-To: <99a207dc-93cd-1bea-2ffc-404a9f6587bf@arm.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 3 Jun 2022 17:32:06 +0200
Message-ID: <CA+QYu4o0OqdwZYFCgCzm2CMHA7pM3nQ+j0_VbHtpFcdJmkMbhw@mail.gmail.com>
Subject: Re: [aarch64] INFO: rcu_sched detected expedited stalls on CPUs/tasks
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>, rric@kernel.org,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
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

On Fri, 3 Jun 2022 at 17:24, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Bruno,
> This looks like something we noticed on the PCC channel of the Tx2. Here was
> the original message:
> '''
> It seems there is synchronization issue on the PCC channels of the ThunderX2.
>
> Some abbreviations first. References are always to ACPI 6.4:
> Command Complete bit (CCb):
> 1 means the OS owns the PCC channel, 0 means the firmware owns the channel,
> cf s14.2.2 "Generic Communications Channel Status Field"
>
> Doorbell Write bits (DWb):
> Write a mask (just one bit in our case) to the doorbell register to notify the
> firmware of a message waiting in the channel,
> cf s14.1.4 "HW-Reduced Communications Subspace Structure (type 1)"
>
> Minimum Request Turnaround Time (MRTT):
> PCC channels have a 'Minimum Request Turnaround Time', being 'The minimum
> amount of time that OSPM must wait after the completion of a command before
> issuing the next command'.
> cf s14.1.4 "HW-Reduced Communications Subspace Structure (type 1)"
>
> The scenario that seems to cause trouble is:
> 1. The OS places a payload and clears the CCb bit
> 2. The OS rings at the doorbell (sets the DWb)
> 3. The firmware processes the message and then sets the CCb (the DWb seems to
>     be still set)
> 4. The OS continues (the DWb seems to be still set)
> 5. The OS wants to send another command. The MRTT has elapsed. So the OS does
>      1. again. (the DWb seems to be still set)
> 6. The OS does 2. again, but the DWb are still set so the OS overwrites the DWb
> 7. The firmware finally clears the DWb.
>
>   From 7.:
> - The OS indefinitely waits for an answer, thinking the firmware needs
>    to answer. The timeout of this request elapses, but the channel is still
>    assumed to belong to the firmware, so the OS never rings the doorbell again.
> - The firmware waits for the doorbell to ring (the DWb to be set), but the
>    OS never rings again.
>
> This can be reproduced by running a big load (e.g. 60 tasks running at 5%
> of the maximum CPU capacity). PCCT tables must have been published by
> selecting the right option in UEFI.
>
> Doubling the MRTT (going from 5ms to 10ms) makes the synchronization issue
> disappears, but it means decreasing the speed of all PCC channels.
> '''
>
> If you get messages such as:
> "PCC check channel failed for ss: XX. ret=X"
> then this should be the same issue.

Thanks for your reply, on console.log we don't see the message above.

Bruno

>
> What might be happening for you is that a stall is detected while the
> sugov_work thread is trying to set a frequency. check_pcc_chan() waits for
> 500 * 3000 us (the PCC channel nominal latency for the Tx2) = 1.5s, which
> is quite long.
>
> Cf. the end of the original message, could you try increasing the mrtt value ?
> (here it is doubled)
> pcc_data[pcc_ss_idx]->pcc_mrtt = 2 * pcc_chan->min_turnaround_time;
> https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/drivers/acpi/cppc_acpi.c#L547
> (for info, where the cppc dirvers waits for the mrtt to elapse)
> https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/drivers/acpi/cppc_acpi.c#L263
>
> On 6/3/22 11:44, Bruno Goncalves wrote:
> > Hello,
> >
> > We recently started to hit this problem on some of our aarch64
> > machines. The stalls can happen even during boot.
> >
> > [ 1086.949484] rcu: INFO: rcu_sched detected expedited stalls on
> > CPUs/tasks: { 23-... } 3 jiffies s: 3441 root: 0x2/.
> > [ 1086.949510] rcu: blocking rcu_node structures (internal RCU debug):
> > l=1:16-31:0x80/.
> > [ 1086.949524] Task dump for CPU 23:
> > [ 1086.949528] task:sugov:23        state:R  running task     stack:
> >   0 pid: 2914 ppid:     2 flags:0x0000000a
> > [ 1086.949543] Call trace:
> > [ 1086.949546]  __switch_to+0x104/0x19c
> > [ 1086.949568]  __schedule+0x410/0x67c
> > [ 1086.949576]  schedule+0x70/0xa8
> > [ 1086.949583]  schedule_hrtimeout_range_clock+0x144/0x1d8
> > [ 1086.949592]  schedule_hrtimeout_range+0x20/0x2c
> > [ 1086.949598]  usleep_range_state+0x5c/0x80
> > [ 1086.949603]  check_pcc_chan+0x7c/0xf4
> > [ 1086.949615]  send_pcc_cmd+0x130/0x2a8
> > [ 1086.949619]  cppc_set_perf+0x12c/0x22c
> > [ 1086.949624]  cppc_cpufreq_set_target+0xf8/0x15c [cppc_cpufreq]
> > [ 1086.949645]  __cpufreq_driver_target+0x94/0xfc
> > [ 1086.949658]  sugov_work+0x98/0xe0
> > [ 1086.949675]  kthread_worker_fn+0x124/0x2b8
> > [ 1086.949683]  kthread+0xd4/0x558
> > [ 1086.949689]  ret_from_fork+0x10/0x20
> >
> > More logs:
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Storage_block_filesystem_fio_test/12073991_aarch64_1_dmesg.log
> >
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Boot_test/12073991_aarch64_1_test_console.log
> >
> > CKI issue tracker: https://datawarehouse.cki-project.org/issue/1259
> >
> > Thanks,
> > Bruno Goncalves
> >
>

