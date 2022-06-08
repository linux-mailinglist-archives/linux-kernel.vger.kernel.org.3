Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720554314C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbiFHN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiFHN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161F478EF1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654694821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gkr+JeEJIEYqHKLWPUZGJMl2lpBqDfd+gD8G4AKG/jA=;
        b=hpiQnX9VD9SO7w5ZQNAF9f3c8dSm4jGRAZYBJ3R2YeMKdSzNziIFn4lRIA14Q/Zh/O6VUB
        Kx8rxt5R/DDJ1GtaTJEgRBLwjB4i890QNsWY83l0ARBfk6aL6c9gGsddXMDFqs+bREoyaJ
        gbs+mApQ/3Bewm5b6r4XxoV8x3qSnQI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-LQHtzlGhNaG1gL5iR8x5Aw-1; Wed, 08 Jun 2022 09:26:59 -0400
X-MC-Unique: LQHtzlGhNaG1gL5iR8x5Aw-1
Received: by mail-lj1-f198.google.com with SMTP id b26-20020a2e989a000000b002556f92fa13so3629106ljj.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gkr+JeEJIEYqHKLWPUZGJMl2lpBqDfd+gD8G4AKG/jA=;
        b=cxU5hrRlQwnPaUQsrm66dAY5Q5PymrSMgcV2EVlXs07vkE0u61rRvVWaabFQWT0Jcr
         tN0VwdijeHk62mWWXV+B8Tl9B2krxBpgMVkPUUOM9/Iht/x+EcDAphLR2TA/PSKcrBmN
         Agj944q8ye8I3N8lAB/UmnCSKJceeBKA6WuE4/AIylW6IHdPcn18JwxLBe1nYSmCuE1C
         1Q7UxlyzTqlwwXYGB0nguB7aaIW3Z/oakyzwi8zkv9op5lKrxMrea0NKny0ffVXv0MdH
         payfKI++jW7FI7vOkTXqzGtU6tD5L8z4RsA4b/CSMGB5UmXwEo+QxmYmLjbu0TsUsOu3
         KACg==
X-Gm-Message-State: AOAM530Xe1zDsxWz+KoQiesIr5wum1GPjI+WEyqAnxDnqV92zMi4v5i8
        0YyHoPLL8sxcp14Ym6i9QQCaKHyDEIwNb/AgI1hHLwYoFLbiaRiliwpNY1f9rbk/UVlsH9W/n4e
        2ftMY9Z4zdv0m3t/mixEsqF7hmZLM3D7Jf1BrcSp5
X-Received: by 2002:a05:6512:4004:b0:479:1d77:4e43 with SMTP id br4-20020a056512400400b004791d774e43mr16050336lfb.537.1654694816828;
        Wed, 08 Jun 2022 06:26:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGeeFakJ6/JJN2R0+wlVh3OXHs8NkXqtxcnFAYEuNpH0xt0xU/phTUIYH8+ZOESAuw9M8emLvEEzudcmaIKlw=
X-Received: by 2002:a05:6512:4004:b0:479:1d77:4e43 with SMTP id
 br4-20020a056512400400b004791d774e43mr16050326lfb.537.1654694816468; Wed, 08
 Jun 2022 06:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4qTWaDzep2GGxm-63r-xJOFf2rFCCNhWupAgZdKE7HV6w@mail.gmail.com>
 <99a207dc-93cd-1bea-2ffc-404a9f6587bf@arm.com> <CA+QYu4o0OqdwZYFCgCzm2CMHA7pM3nQ+j0_VbHtpFcdJmkMbhw@mail.gmail.com>
 <fe20591a-96bf-2ac5-c97f-442c2b36c455@arm.com>
In-Reply-To: <fe20591a-96bf-2ac5-c97f-442c2b36c455@arm.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 8 Jun 2022 15:26:45 +0200
Message-ID: <CA+QYu4rFB0-no98R0jfzDi2z1Q-aXsEyj1+j-G7RNBi1=3SLkQ@mail.gmail.com>
Subject: Re: [aarch64] INFO: rcu_sched detected expedited stalls on CPUs/tasks
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 10:55, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>
> On 6/3/22 17:32, Bruno Goncalves wrote:
> > On Fri, 3 Jun 2022 at 17:24, Pierre Gondois <pierre.gondois@arm.com> wrote:
> >>
> >> Hello Bruno,
> >> This looks like something we noticed on the PCC channel of the Tx2. Here was
> >> the original message:
> >> '''
> >> It seems there is synchronization issue on the PCC channels of the ThunderX2.
> >>
> >> Some abbreviations first. References are always to ACPI 6.4:
> >> Command Complete bit (CCb):
> >> 1 means the OS owns the PCC channel, 0 means the firmware owns the channel,
> >> cf s14.2.2 "Generic Communications Channel Status Field"
> >>
> >> Doorbell Write bits (DWb):
> >> Write a mask (just one bit in our case) to the doorbell register to notify the
> >> firmware of a message waiting in the channel,
> >> cf s14.1.4 "HW-Reduced Communications Subspace Structure (type 1)"
> >>
> >> Minimum Request Turnaround Time (MRTT):
> >> PCC channels have a 'Minimum Request Turnaround Time', being 'The minimum
> >> amount of time that OSPM must wait after the completion of a command before
> >> issuing the next command'.
> >> cf s14.1.4 "HW-Reduced Communications Subspace Structure (type 1)"
> >>
> >> The scenario that seems to cause trouble is:
> >> 1. The OS places a payload and clears the CCb bit
> >> 2. The OS rings at the doorbell (sets the DWb)
> >> 3. The firmware processes the message and then sets the CCb (the DWb seems to
> >>      be still set)
> >> 4. The OS continues (the DWb seems to be still set)
> >> 5. The OS wants to send another command. The MRTT has elapsed. So the OS does
> >>       1. again. (the DWb seems to be still set)
> >> 6. The OS does 2. again, but the DWb are still set so the OS overwrites the DWb
> >> 7. The firmware finally clears the DWb.
> >>
> >>    From 7.:
> >> - The OS indefinitely waits for an answer, thinking the firmware needs
> >>     to answer. The timeout of this request elapses, but the channel is still
> >>     assumed to belong to the firmware, so the OS never rings the doorbell again.
> >> - The firmware waits for the doorbell to ring (the DWb to be set), but the
> >>     OS never rings again.
> >>
> >> This can be reproduced by running a big load (e.g. 60 tasks running at 5%
> >> of the maximum CPU capacity). PCCT tables must have been published by
> >> selecting the right option in UEFI.
> >>
> >> Doubling the MRTT (going from 5ms to 10ms) makes the synchronization issue
> >> disappears, but it means decreasing the speed of all PCC channels.
> >> '''
> >>
> >> If you get messages such as:
> >> "PCC check channel failed for ss: XX. ret=X"
> >> then this should be the same issue.
> >
> > Thanks for your reply, on console.log we don't see the message above.
> >
> > Bruno
> >
> >>
> >> What might be happening for you is that a stall is detected while the
> >> sugov_work thread is trying to set a frequency. check_pcc_chan() waits for
> >> 500 * 3000 us (the PCC channel nominal latency for the Tx2) = 1.5s, which
> >> is quite long.
> >>
> >> Cf. the end of the original message, could you try increasing the mrtt value ?
> >> (here it is doubled)
> >> pcc_data[pcc_ss_idx]->pcc_mrtt = 2 * pcc_chan->min_turnaround_time;
> >> https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/drivers/acpi/cppc_acpi.c#L547
> >> (for info, where the cppc dirvers waits for the mrtt to elapse)
> >> https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/drivers/acpi/cppc_acpi.c#L263
> >>
> >> On 6/3/22 11:44, Bruno Goncalves wrote:
> >>> Hello,
> >>>
> >>> We recently started to hit this problem on some of our aarch64
> >>> machines. The stalls can happen even during boot.
> >>>
> >>> [ 1086.949484] rcu: INFO: rcu_sched detected expedited stalls on
> >>> CPUs/tasks: { 23-... } 3 jiffies s: 3441 root: 0x2/.
> >>> [ 1086.949510] rcu: blocking rcu_node structures (internal RCU debug):
> >>> l=1:16-31:0x80/.
> >>> [ 1086.949524] Task dump for CPU 23:
> >>> [ 1086.949528] task:sugov:23        state:R  running task     stack:
> >>>    0 pid: 2914 ppid:     2 flags:0x0000000a
> >>> [ 1086.949543] Call trace:
> >>> [ 1086.949546]  __switch_to+0x104/0x19c
> >>> [ 1086.949568]  __schedule+0x410/0x67c
> >>> [ 1086.949576]  schedule+0x70/0xa8
> >>> [ 1086.949583]  schedule_hrtimeout_range_clock+0x144/0x1d8
> >>> [ 1086.949592]  schedule_hrtimeout_range+0x20/0x2c
> >>> [ 1086.949598]  usleep_range_state+0x5c/0x80
> >>> [ 1086.949603]  check_pcc_chan+0x7c/0xf4
> >>> [ 1086.949615]  send_pcc_cmd+0x130/0x2a8
> >>> [ 1086.949619]  cppc_set_perf+0x12c/0x22c
> >>> [ 1086.949624]  cppc_cpufreq_set_target+0xf8/0x15c [cppc_cpufreq]
> >>> [ 1086.949645]  __cpufreq_driver_target+0x94/0xfc
> >>> [ 1086.949658]  sugov_work+0x98/0xe0
> >>> [ 1086.949675]  kthread_worker_fn+0x124/0x2b8
> >>> [ 1086.949683]  kthread+0xd4/0x558
> >>> [ 1086.949689]  ret_from_fork+0x10/0x20
> >>>
> >>> More logs:
> >>> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Storage_block_filesystem_fio_test/12073991_aarch64_1_dmesg.log
> >>>
> >>> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Boot_test/12073991_aarch64_1_test_console.log
> >>>
> >>> CKI issue tracker: https://datawarehouse.cki-project.org/issue/1259
> >>>
> >>> Thanks,
> >>> Bruno Goncalves
> >>>
> >>
> >
>
> Hello Bruno,
>
> Some pointers first:
> Build: https://datawarehouse.cki-project.org/kcidb/tests/3717528
> Job: https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-pipelines/cki-trusted-contributors/-/jobs/2536244504
> Config file: https://gitlab.com/api/v4/projects/18194050/jobs/2536244462/artifacts/artifacts/kernel-mainline.kernel.org-clang-aarch64-d1dc87763f406d4e67caf16dbe438a5647692395.config
>
> The config file has:
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
> Meaning that after 20ms (2 ticks at HZ=100), an expedited RCU stall will be
> declared. I think for !ANDROID, this config value should be let unset/set to 0.
> https://github.com/torvalds/linux/blob/1e57930e9f4083ad5854ab6eadffe790a8167fb4/kernel/rcu/Kconfig.debug#L85
>
> If unset, the value (in ms) of
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> will be used before declaring an expedited RCU stall, so 60ms (6 jiffies at
> 100HZ). In your log, all the expedited RCU stalls were declared at 3 or 4
> jiffies. So removing the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT entry should make
> the messages disappear.

Hello Pierre,

Tthank you very much for finding out the root cause.
We've contacted the Fedora kernel maintainer to fix the config as we
are using the config from there.

Regards,
Bruno

> Both timeout values can also be read/modified at runtime at:
> /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
> /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
>
> Regards,
> Pierre
>

