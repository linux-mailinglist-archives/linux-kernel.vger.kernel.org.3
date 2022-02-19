Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE74BC576
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 06:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiBSFC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 00:02:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiBSFC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 00:02:58 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827DC12769;
        Fri, 18 Feb 2022 21:02:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q8so10010037iod.2;
        Fri, 18 Feb 2022 21:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BIKVZrckfhtAF9SK+XfuUymxSxixxysTWLjC886EzDM=;
        b=NrnimEpHx/blgiX41w56YiM0mq9EPeIdHIT+N0Yjnlbb8mep0WIlTFA87ysHCyd2oh
         rCoceSY73Cpvjxyep40R6h//OyakKm1qLRw2bXm1epGg3Ink2LX2Gp9ndSdAHLk35VKl
         wszvVuobQY4rw83YS771kkYWqZ/NST3cMt8qJ2+juSkROG7H3eSsySRmPEW+FtYqfaF1
         QqPiAErMgdOHk4U5yke6yQ45xZWlKLCde66KNeKVPQqwsnf7a3GQzFBUO2FGK8UA9Emt
         IcduBpo+pEYmvOdeAYPTluluWRIbqq6BPY0q8dri39rM0ZJtdhyEZ+vpAuoctDcXPKxd
         KaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BIKVZrckfhtAF9SK+XfuUymxSxixxysTWLjC886EzDM=;
        b=wcGu0S6SJCbbzYs4IlzwQzinQCVTtb1K840ceNT8rwB7z4EMwFTMtksnEJAtCuMTfi
         gYsOAUCd+BfUFEcy5Pp49pRRs46V9eUJv+AAL4InankBOyylhW716fjC939LYUINRKiN
         AyJBYRHu5M9ZEDCDdoGXCcMeLpZgntKKYNP5mx/J4qGDpPjWboLZOTUXVUFGAkl8tn9Y
         5tkjs+2IHoLQcwwCQymZRPv9tWKHL3EWgu//meG6Kdsf3Z1x8O8XvVtFnmBRJDstkcMc
         pOf3UtV1/IMkjzDPGemvm7ngd+JO+YKWRnol7QUYo5cy/HN2AwzEKSp28NdTGybj1eez
         zaYg==
X-Gm-Message-State: AOAM533N3VfMFQtx9gKPnHv6yCOn0zIod811rvq25KpoBynvDBqX06my
        M/q7qbi4bHNcw4YBac+R3QIpv6vnxISxt56VaqVLTKAEfua8sg==
X-Google-Smtp-Source: ABdhPJx2/yo/I6eRLYSt0JE+Iaox+MAfJpAuIR8xhZvEIgekFpGtm90LJaK/LqqCoEsSiYHqMiMpn9Fdhd7nb7KM/Y8=
X-Received: by 2002:a02:5b0a:0:b0:30f:60e4:b9ab with SMTP id
 g10-20020a025b0a000000b0030f60e4b9abmr7320808jab.189.1645246958795; Fri, 18
 Feb 2022 21:02:38 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Fri, 18 Feb 2022 21:02:28 -0800
Message-ID: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
Subject: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
To:     qat-linux@intel.com, giovanni.cabiddu@intel.com
Cc:     Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
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

A2SDi-8C-HLN4F has IQAT enabled by default, when this device is
attempted to be used by xfs (through dm-crypt) the entire kernel
thread stalls forever. Multiple users have hit this over the years
(through sporadic reporting) - I ended up trying ZFS and encryption
wasn't an issue there at all because I guess they don't use this
device. Returning to sanity (xfs), I was able to provision a dm-crypt
volume no problem on the disk, however when running mkfs.xfs on the
volume is what triggers the cascading failure (each request kills a
kthread). Disabling IQAT on the south bridge results in a working
system, however this is not the default configuration for the
distribution of choice (Ubuntu 20.04.3 LTS), nor the motherboard. I'm
convinced this never worked properly based on the lack of popularity
for kernel encryption (crypto), and the embedded nature that
SuperMicro has integrated this device in collaboration with intel as
it looks like the primary usage is through external accelerator cards.

Kernels tried were from RHEL8 over a year ago, and this impacts the
entirety of the 5.4 series on Ubuntu.
Please CC me on replies as I'm not subscribed to all lists. CPU is C3758.

  363.495058] INFO: task kworker/u16:0:8 blocked for more than 120 seconds.
[  363.495114]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.495155] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.495201] kworker/u16:0   D    0     8      2 0x80004000
[  363.495213] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.495214] Call Trace:
[  363.495223]  __schedule+0x2e3/0x740
[  363.495226]  schedule+0x42/0xb0
[  363.495228]  schedule_timeout+0x10e/0x160
[  363.495232]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.495233]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.495236]  wait_for_completion+0xb1/0x120
[  363.495239]  ? wake_up_q+0x70/0x70
[  363.495242]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.495245]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.495249]  process_one_work+0x1eb/0x3b0
[  363.495251]  worker_thread+0x4d/0x400
[  363.495254]  kthread+0x104/0x140
[  363.495256]  ? process_one_work+0x3b0/0x3b0
[  363.495257]  ? kthread_park+0x90/0x90
[  363.495260]  ret_from_fork+0x1f/0x40
[  363.495274] INFO: task kworker/u16:1:123 blocked for more than 120 seconds.
[  363.495317]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.495364] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.495410] kworker/u16:1   D    0   123      2 0x80004000
[  363.495415] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.495416] Call Trace:
[  363.495419]  __schedule+0x2e3/0x740
[  363.495422]  schedule+0x42/0xb0
[  363.495424]  schedule_timeout+0x10e/0x160
[  363.495426]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.495427]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.495430]  wait_for_completion+0xb1/0x120
[  363.495431]  ? wake_up_q+0x70/0x70
[  363.495434]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.495437]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.495441]  process_one_work+0x1eb/0x3b0
[  363.495443]  worker_thread+0x4d/0x400
[  363.495445]  kthread+0x104/0x140
[  363.495447]  ? process_one_work+0x3b0/0x3b0
[  363.495449]  ? kthread_park+0x90/0x90
[  363.495451]  ret_from_fork+0x1f/0x40
[  363.495457] INFO: task kworker/u16:2:153 blocked for more than 120 seconds.
[  363.495499]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.495539] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.495584] kworker/u16:2   D    0   153      2 0x80004000
[  363.495589] Workqueue: kcryptd/253:5 kcryptd_crypt [dm_crypt]
[  363.495590] Call Trace:
[  363.495593]  __schedule+0x2e3/0x740
[  363.495595]  schedule+0x42/0xb0
[  363.495597]  schedule_timeout+0x10e/0x160
[  363.495599]  ? skcipher_decrypt_ablkcipher+0x61/0x70
[  363.495601]  ? crypto_skcipher_decrypt+0x48/0x60
[  363.495603]  wait_for_completion+0xb1/0x120
[  363.495605]  ? wake_up_q+0x70/0x70
[  363.495608]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.495611]  kcryptd_crypt+0xc6/0x3b0 [dm_crypt]
[  363.495613]  ? __switch_to+0x7f/0x480
[  363.495615]  ? switch_mm_irqs_off+0x19b/0x500
[  363.495618]  process_one_work+0x1eb/0x3b0
[  363.495621]  worker_thread+0x4d/0x400
[  363.495623]  kthread+0x104/0x140
[  363.495625]  ? process_one_work+0x3b0/0x3b0
[  363.495627]  ? kthread_park+0x90/0x90
[  363.495629]  ret_from_fork+0x1f/0x40
[  363.495636] INFO: task kworker/u16:5:279 blocked for more than 120 seconds.
[  363.495677]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.495717] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.495762] kworker/u16:5   D    0   279      2 0x80004000
[  363.495766] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.495767] Call Trace:
[  363.495771]  __schedule+0x2e3/0x740
[  363.495773]  schedule+0x42/0xb0
[  363.495775]  schedule_timeout+0x10e/0x160
[  363.495777]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.495778]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.495781]  wait_for_completion+0xb1/0x120
[  363.495782]  ? wake_up_q+0x70/0x70
[  363.495785]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.495788]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.495791]  process_one_work+0x1eb/0x3b0
[  363.495794]  worker_thread+0x4d/0x400
[  363.495796]  kthread+0x104/0x140
[  363.495798]  ? process_one_work+0x3b0/0x3b0
[  363.495800]  ? kthread_park+0x90/0x90
[  363.495802]  ret_from_fork+0x1f/0x40
[  363.495808] INFO: task kworker/u16:11:299 blocked for more than 120 seconds.
[  363.495849]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.495890] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.495935] kworker/u16:11  D    0   299      2 0x80004000
[  363.495939] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.495940] Call Trace:
[  363.495943]  __schedule+0x2e3/0x740
[  363.495946]  schedule+0x42/0xb0
[  363.495947]  schedule_timeout+0x10e/0x160
[  363.495949]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.495951]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.495953]  wait_for_completion+0xb1/0x120
[  363.495955]  ? wake_up_q+0x70/0x70
[  363.495958]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.495961]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.495964]  process_one_work+0x1eb/0x3b0
[  363.495966]  worker_thread+0x4d/0x400
[  363.495969]  kthread+0x104/0x140
[  363.495971]  ? process_one_work+0x3b0/0x3b0
[  363.495972]  ? kthread_park+0x90/0x90
[  363.495974]  ret_from_fork+0x1f/0x40
[  363.495977] INFO: task kworker/u16:12:300 blocked for more than 120 seconds.
[  363.496018]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.496058] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.496108] kworker/u16:12  D    0   300      2 0x80004000
[  363.496113] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.496114] Call Trace:
[  363.496117]  __schedule+0x2e3/0x740
[  363.496120]  schedule+0x42/0xb0
[  363.496121]  schedule_timeout+0x10e/0x160
[  363.496123]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.496125]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.496127]  wait_for_completion+0xb1/0x120
[  363.496129]  ? wake_up_q+0x70/0x70
[  363.496132]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.496134]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.496138]  process_one_work+0x1eb/0x3b0
[  363.496140]  worker_thread+0x4d/0x400
[  363.496142]  kthread+0x104/0x140
[  363.496144]  ? process_one_work+0x3b0/0x3b0
[  363.496146]  ? kthread_park+0x90/0x90
[  363.496148]  ret_from_fork+0x1f/0x40
[  363.496151] INFO: task kworker/u16:13:301 blocked for more than 120 seconds.
[  363.496193]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.496233] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.496278] kworker/u16:13  D    0   301      2 0x80004000
[  363.496282] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.496283] Call Trace:
[  363.496286]  __schedule+0x2e3/0x740
[  363.496289]  schedule+0x42/0xb0
[  363.496290]  schedule_timeout+0x10e/0x160
[  363.496292]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.496294]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.496296]  wait_for_completion+0xb1/0x120
[  363.496298]  ? wake_up_q+0x70/0x70
[  363.496301]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.496304]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.496307]  process_one_work+0x1eb/0x3b0
[  363.496310]  worker_thread+0x4d/0x400
[  363.496312]  kthread+0x104/0x140
[  363.496314]  ? process_one_work+0x3b0/0x3b0
[  363.496316]  ? kthread_park+0x90/0x90
[  363.496317]  ret_from_fork+0x1f/0x40
[  363.496320] INFO: task kworker/u16:14:302 blocked for more than 120 seconds.
[  363.496362]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.496402] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.496447] kworker/u16:14  D    0   302      2 0x80004000
[  363.496451] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.496452] Call Trace:
[  363.496455]  __schedule+0x2e3/0x740
[  363.496458]  schedule+0x42/0xb0
[  363.496459]  schedule_timeout+0x10e/0x160
[  363.496461]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.496463]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.496465]  wait_for_completion+0xb1/0x120
[  363.496467]  ? wake_up_q+0x70/0x70
[  363.496470]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.496473]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.496476]  process_one_work+0x1eb/0x3b0
[  363.496478]  worker_thread+0x4d/0x400
[  363.496481]  kthread+0x104/0x140
[  363.496483]  ? process_one_work+0x3b0/0x3b0
[  363.496484]  ? kthread_park+0x90/0x90
[  363.496486]  ret_from_fork+0x1f/0x40
[  363.496489] INFO: task kworker/u16:15:303 blocked for more than 120 seconds.
[  363.496531]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.496571] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.496616] kworker/u16:15  D    0   303      2 0x80004000
[  363.496620] Workqueue: kcryptd/253:0 kcryptd_crypt [dm_crypt]
[  363.496621] Call Trace:
[  363.496624]  __schedule+0x2e3/0x740
[  363.496627]  schedule+0x42/0xb0
[  363.496629]  schedule_timeout+0x10e/0x160
[  363.496630]  ? skcipher_encrypt_ablkcipher+0x61/0x70
[  363.496632]  ? crypto_skcipher_encrypt+0x48/0x60
[  363.496634]  wait_for_completion+0xb1/0x120
[  363.496636]  ? wake_up_q+0x70/0x70
[  363.496639]  crypt_convert+0x144/0x1f0 [dm_crypt]
[  363.496642]  kcryptd_crypt+0x2b9/0x3b0 [dm_crypt]
[  363.496645]  process_one_work+0x1eb/0x3b0
[  363.496647]  worker_thread+0x4d/0x400
[  363.496650]  kthread+0x104/0x140
[  363.496652]  ? process_one_work+0x3b0/0x3b0
[  363.496654]  ? kthread_park+0x90/0x90
[  363.496655]  ret_from_fork+0x1f/0x40
[  363.496713] INFO: task mergerfs:9760 blocked for more than 120 seconds.
[  363.496752]       Tainted: P           O      5.4.0-100-generic #113-Ubuntu
[  363.496793] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  363.496838] mergerfs        D    0  9760      1 0x00000000
[  363.496840] Call Trace:
[  363.496843]  __schedule+0x2e3/0x740
[  363.496846]  schedule+0x42/0xb0
[  363.496848]  schedule_timeout+0x10e/0x160
[  363.496851]  ? blk_finish_plug+0x26/0x40
[  363.496853]  wait_for_completion+0xb1/0x120
[  363.496855]  ? wake_up_q+0x70/0x70
[  363.496910]  ? __xfs_buf_submit+0x138/0x260 [xfs]
[  363.496950]  xfs_buf_iowait+0x26/0xe0 [xfs]
[  363.496990]  __xfs_buf_submit+0x138/0x260 [xfs]
[  363.497030]  _xfs_buf_read+0x27/0x30 [xfs]
[  363.497070]  xfs_buf_read_map+0x132/0x1d0 [xfs]
[  363.497073]  ? new_slab+0x4a/0x70
[  363.497117]  xfs_trans_read_buf_map+0xca/0x350 [xfs]
[  363.497155]  xfs_imap_to_bp+0x66/0xd0 [xfs]
[  363.497193]  xfs_iread+0x83/0x200 [xfs]
[  363.497234]  xfs_iget+0x214/0x9e0 [xfs]
[  363.497270]  ? xfs_da_compname+0x1d/0x30 [xfs]
[  363.497306]  ? xfs_dir2_sf_lookup+0xd0/0x200 [xfs]
[  363.497348]  xfs_lookup+0xe2/0x120 [xfs]
[  363.497390]  xfs_vn_lookup+0x72/0xb0 [xfs]
[  363.497393]  __lookup_slow+0x92/0x160
[  363.497395]  lookup_slow+0x3b/0x60
[  363.497397]  walk_component+0x1da/0x360
[  363.497399]  ? link_path_walk.part.0+0x2a2/0x550
[  363.497401]  path_lookupat.isra.0+0x80/0x230
[  363.497404]  filename_lookup+0xae/0x170
[  363.497407]  ? __check_object_size+0x13f/0x150
[  363.497409]  ? strncpy_from_user+0x4c/0x150
[  363.497412]  user_path_at_empty+0x3a/0x50
[  363.497414]  vfs_statx+0x7d/0xe0
[  363.497417]  __do_sys_newlstat+0x3e/0x80
[  363.497419]  ? vfs_read+0x12e/0x160
[  363.497420]  ? fput+0x13/0x20
[  363.497422]  ? ksys_read+0xce/0xe0
[  363.497424]  __x64_sys_newlstat+0x16/0x20
[  363.497427]  do_syscall_64+0x57/0x190
[  363.497429]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  363.497432] RIP: 0033:0x7f7f32c656ea
[  363.497438] Code: Bad RIP value.
[  363.497439] RSP: 002b:00007f7f31fea0c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000006
[  363.497441] RAX: ffffffffffffffda RBX: 0000560953796248 RCX: 00007f7f32c656ea
[  363.497442] RDX: 00007f7f31fea110 RSI: 00007f7f31fea110 RDI: 00007f7f31fea100
[  363.497443] RBP: 00007f7f31fea120 R08: 0000000000000001 R09: 000000000000000a
[  363.497445] R10: 00007f7f14000b90 R11: 0000000000000246 R12: 00007f7f31fea220
[  363.497446] R13: 00007f7f14000b90 R14: 00007f7f31fea100 R15: 00007f7f31fea110
