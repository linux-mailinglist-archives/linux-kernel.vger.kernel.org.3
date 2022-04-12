Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321014FE15A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350053AbiDLM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355260AbiDLMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:55 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0C107
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:26:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x200so9060251ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rjYB9r5mrGcVBAjgGt1bInhhzLQlNG53OqDzfAn6lZc=;
        b=yDaqkME5ggqBLzU7hAyc/Ba7A36G1dN5NULnQTKZ5CmgwqC3QshL1/HpjtFUMmgw7b
         VkAkSMEdy3gwTFT52YAVA5YeGjmywmYuETKUpBTDluOKHoUe/ztHZemb2xNwbMMXJqGI
         t7xZ2tvOGpt9N27O+lEfBvDfjHV6JzChrad0QpIfH4SsAXwB0jqPe82ugvY/gFjh5/Uq
         Ogy2YsV1DPf9dky2fOfOKQCHk/YX7df0vWHo+aC6I7ux+40DwqTFHYteQ5qbQxqvuQK/
         Ws5zzPTuVsW5+ceTyKUA8sy77WjGrOMb7Cp4IWwvt/b8KkRcE6jh22d6S4U2fFOn5tlt
         ZfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rjYB9r5mrGcVBAjgGt1bInhhzLQlNG53OqDzfAn6lZc=;
        b=pM1//E9rDhyPARx8CcXVhTyPGGXVW1gop3Z/Jsk5pRAqoGv6+4dluho6UFxAxiBdIn
         TVttQR17JM86XyJ0gNl+N+NaAfgni4Bbst9jwEzKFpiR0uGjxdhvghY1kyYyWTLZVldl
         /eR1v5kFXzP/irWIYlcs4o2TbIj/lR9wyArhMylhjRhMl1a/9Bt5GbpRphOZti0DQxuM
         YVKayXOps0b4i1RT0dn0oz0eUdZnALjFf3tSHafmHTuxDJpor/OfJ4V1vE3eDYVzVvZD
         S1XkzFyxVjs54fa9q6eKDiqVhisxAwezuRA1W2TJ3QGTZP5knOY1GZxdUgEyBdDmVLFS
         3PZA==
X-Gm-Message-State: AOAM530yYg7itTI6PsQdB0NHMFmHocX12sqPw3SejQEg0deVXRnV4jk5
        VrIPRK2oCtMdjskfOZfTdFbULCdN7wNmLvtZThxGSg==
X-Google-Smtp-Source: ABdhPJx7kbd1SSavyL9M8frEDZRWy33OZ3fJFq6CJGFFXe/GkTIkYLryUHtmLDP4nVEo3roRDGELsZOpFo0E841/0CU=
X-Received: by 2002:a25:9001:0:b0:641:67c5:23ba with SMTP id
 s1-20020a259001000000b0064167c523bamr5887888ybl.128.1649766413136; Tue, 12
 Apr 2022 05:26:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Apr 2022 17:56:42 +0530
Message-ID: <CA+G9fYusMPEsFXhDd4BEMa0jy-qZxgRTCpxZ8E4gjdrpHdQGOQ@mail.gmail.com>
Subject: [next] next-20220412: BUG: Bad page map in process oom_reaper pte
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
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

Linux next-20220412 i386 LTP mm test case caused following kernel crash
however, test runs to complete successfully.

tst_test.c:1422: TINFO: Timeout per run is disabled
mem.c:708: TINFO: set overcommit_memory to 2
mem.c:708: TINFO: set min_free_kbytes to 41716
memfree is 2916072 kB before eatup mem
memfree is 1585764 kB after eatup mem
mem.c:708: TINFO: set min_free_kbytes to 83432
memfree is 2915168 kB before eatup mem
memfree is 1583424 kB after eatup mem
mem.c:708: TINFO: set min_free_kbytes to 61704
memfree is 2909960 kB before eatup mem
memfree is 1583480 kB after eatup mem
mem.c:708: TINFO: set overcommit_memory to 0
mem.c:708: TINFO: set min_free_kbytes to 41716
[  951.727784] systemd invoked oom-killer:
gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0,
oom_score_adj=0
[  951.730905] CPU: 1 PID: 1 Comm: systemd Tainted: G        W
5.18.0-rc2-next-20220412 #1
[  951.732870] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  951.734537] Call Trace:
[  951.735061]  dump_stack_lvl+0x44/0x57
[  951.735904]  dump_stack+0xd/0x10
[  951.736572]  dump_header+0x45/0x1d4
[  951.737417]  ? ___ratelimit+0x73/0x110
[  951.738641]  ? preempt_count_sub+0xc1/0x110
[  951.739338]  ? oom_badness+0x125/0x1b0
[  951.739963]  oom_kill_process.cold+0x9/0xe
[  951.740675]  out_of_memory+0xe1/0x2c0
[  951.741447]  __alloc_pages+0xd02/0xdf0
[  951.742104]  ? finish_task_switch+0xa4/0x2c0
[  951.742806]  __folio_alloc+0x22/0x50
[  951.743360]  __filemap_get_folio+0x1a3/0x340
[  951.744050]  filemap_fault+0x176/0x880
[  951.744609]  ? next_uptodate_page+0x240/0x240
[  951.745412]  __do_fault+0x32/0xa0
[  951.745920]  handle_mm_fault+0x974/0xe80
[  951.746676]  do_user_addr_fault+0x17b/0x530
[  951.747531]  ? irqentry_enter+0x45/0x50
[  951.748368]  exc_page_fault+0x4d/0x160
[  951.749170]  ? do_fast_syscall_32+0x32/0x70
[  951.750063]  ? paravirt_BUG+0x10/0x10
[  951.750725]  handle_exception+0x133/0x133
[  951.751397] EIP: 0xb7e2091f
[  951.751875] Code: Unable to access opcode bytes at RIP 0xb7e208f5.
[  951.752877] EAX: 00000000 EBX: b7f8c2e4 ECX: bfcf2464 EDX: 00000000
[  951.754163] ESI: bfcf2464 EDI: 0000002c EBP: bfcf2798 ESP: bfcf2450
[  951.755463] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010207
[  951.756880]  ? paravirt_BUG+0x10/0x10
[  951.757927] Mem-Info:
[  951.758557] active_anon:61 inactive_anon:732341 isolated_anon:0
[  951.758557]  active_file:71 inactive_file:14 isolated_file:0
[  951.758557]  unevictable:0 dirty:25 writeback:10
[  951.758557]  slab_reclaimable:2308 slab_unreclaimable:3155
[  951.758557]  mapped:344 shmem:2200 pagetables:898 bounce:0
[  951.758557]  kernel_misc_reclaimable:0
[  951.758557]  free:31053 free_pcp:333 free_cma:0
[  951.787248] Node 0 active_anon:244kB inactive_anon:2929364kB
active_file:16kB inactive_file:116kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB mapped:1376kB dirty:100kB
writeback:40kB shmem:8800kB shmem_thp: 0kB shmem_pmdmapped: 0kB
anon_thp: 0kB writeback_tmp:0kB kernel_stack:1016kB pagetables:3592kB
all_unreclaimable? no
[  951.791525] DMA free:12732kB boost:0kB min:760kB low:948kB
high:1136kB reserved_highatomic:0KB active_anon:0kB
inactive_anon:2628kB active_file:0kB inactive_file:0kB unevictable:0kB
writepending:0kB present:15992kB managed:15360kB mlocked:0kB
bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  951.795238] lowmem_reserve[]: 0 805 2997 2997
[  951.795896] Normal free:111020kB boost:0kB min:40952kB low:51188kB
high:61424kB reserved_highatomic:0KB active_anon:0kB
inactive_anon:684420kB active_file:0kB inactive_file:372kB
unevictable:0kB writepending:0kB present:884728kB managed:825372kB
mlocked:0kB bounce:0kB free_pcp:560kB local_pcp:8kB free_cma:0kB
[  951.799843] lowmem_reserve[]: 0 0 17535 17535
[  951.800479] HighMem free:460kB boost:0kB min:512kB low:28352kB
high:56192kB reserved_highatomic:0KB active_anon:244kB
inactive_anon:2242168kB active_file:16kB inactive_file:288kB
unevictable:0kB writepending:140kB present:2244480kB managed:2244480kB
mlocked:0kB bounce:0kB free_pcp:912kB local_pcp:560kB free_cma:0kB
[  951.804447] lowmem_reserve[]: 0 0 0 0
[  951.805010] DMA: 1*4kB (M) 1*8kB (M) 1*16kB (M) 1*32kB (M) 0*64kB
1*128kB (M) 1*256kB (M) 0*512kB 2*1024kB (UM) 1*2048kB (U) 2*4096kB
(M) = 12732kB
[  951.807652] Normal: 925*4kB (UE) 807*8kB (UE) 586*16kB (UME)
391*32kB (UE) 227*64kB (UME) 129*128kB (UME) 30*256kB (UE) 14*512kB
(UE) 6*1024kB (UME) 1*2048kB (E) 6*4096kB (M) = 110700kB
[  951.810641] HighMem: 37*4kB (M) 13*8kB (M) 9*16kB (M) 0*32kB 1*64kB
(M) 1*128kB (M) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 588kB
[  951.812794] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=4096kB
[  951.814031] 2313 total pagecache pages
[  951.814588] 0 pages in swap cache
[  951.815098] Swap cache stats: add 0, delete 0, find 0/0
[  951.815867] Free swap  = 0kB
[  951.816298] Total swap = 0kB
[  951.816729] 786300 pages RAM
[  951.817228] 561120 pages HighMem/MovableOnly
[  951.817873] 14997 pages reserved
[  951.818348] Tasks state (memory values in pages):
[  951.819043] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[  951.820291] [    204]     0   204     3450      354    28672
0             0 systemd-journal
[  951.821628] [    241]     0   241     3283      124    20480
0         -1000 systemd-udevd
[  951.822922] [    256]   993   256     1569       59    20480
0             0 systemd-network
[  951.824232] [    265]   992   265     1729       77    20480
0             0 systemd-resolve
[  951.825591] [    269]     0   269      811       63    16384
0             0 crond
[  951.826788] [    272]     0   272      594       16    16384
0             0 acpid
[  951.827972] [    273]     0   273     1468       84    20480
0             0 systemd-logind
[  951.829278] [    274]   995   274     1246      115    24576
0             0 avahi-daemon
[  951.830565] [    276]     0   276      921       17    16384
0             0 syslogd
[  951.831775] [    277]   996   277     1173      109    20480
0          -900 dbus-daemon
[  951.833062] [    280]   995   280     1182       58    20480
0             0 avahi-daemon
[  951.834812] [    288]     0   288    14090      365    53248
0             0 NetworkManager
[  951.836476] [    289]     0   289      922       14    16384
0             0 klogd
[  951.837686] [    293]     0   293     2069      790    24576
0             0 haveged
[  951.838904] [    326]     0   326      947       94    16384
0             0 login
[  951.840095] [    327]     0   327      666       26    16384
0             0 agetty
[  951.841315] [    332] 65534   332      729       32    16384
0             0 dnsmasq
[  951.842524] [    337]   998   337    19521      745    69632
0             0 polkitd
[  951.843735] [    338]     0   338     8698      317    36864
0             0 dhclient
[  951.844960] [    353]     0   353     1892      100    20480
0             0 systemd
[  951.846197] [    354]     0   354     2317      295    20480
0             0 (sd-pam)
[  951.847417] [    358]     0   358      971       72    16384
0             0 sh
[  951.848580] [    373]     0   373      903       39    16384
0             0 lava-test-runne
[  951.849911] [   1087]     0  1087      903       25    16384
0             0 lava-test-shell
[  951.851232] [   1088]     0  1088      903       25    16384
0             0 sh
[  951.852382] [   1090]     0  1090      969      113    16384
0             0 ltp.sh
[  951.853821] [   1109]     0  1109      969      116    16384
0             0 ltp.sh
[  951.855456] [   1110]     0  1110      969      115    16384
0             0 ltp.sh
[  951.856922] [   1111]     0  1111      969      115    16384
0             0 ltp.sh
[  951.858149] [   1112]     0  1112     1002      148    16384
0             0 runltp
[  951.859347] [   1113]     0  1113      592       11    16384
0             0 tee
[  951.860505] [   1180]     0  1180      590       25    16384
0             0 ltp-pan
[  951.861999] [  20965]     0 20965      673       22    16384
0         -1000 min_free_kbytes
[  951.863792] [  20966]     0 20966      673       27    16384
0             0 min_free_kbytes
[  951.865275] [  20972]     0 20972   726433   725743  2912256
0             0 min_free_kbytes
[  951.866586] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/,task=min_free_kbytes,pid=20972,uid=0
[  951.868579] Out of memory: Killed process 20972 (min_free_kbytes)
total-vm:2905732kB, anon-rss:2902972kB, file-rss:0kB, shmem-rss:0kB,
UID:0 pgtables:2844kB oom_score_adj:0
[  951.985382] __swap_info_get: Bad swap file entry 6c0373b6
[  951.986163] BUG: Bad page map in process oom_reaper  pte:06e76c3e
pmd:0583f067
[  951.987098] addr:77da7000 vm_flags:00100073 anon_vma:c4e22c40
mapping:00000000 index:77da7
[  951.988163] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[  951.988850] CPU: 2 PID: 36 Comm: oom_reaper Tainted: G        W
    5.18.0-rc2-next-20220412 #1
[  951.990034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  951.991101] Call Trace:
[  951.991457]  dump_stack_lvl+0x44/0x57
[  951.991942]  dump_stack+0xd/0x10
[  951.992371]  print_bad_pte.cold+0x82/0xd9
[  951.992901]  ? free_swap_and_cache+0x2e/0xe0
[  951.993475]  unmap_page_range+0x6b5/0x790
[  951.994005]  __oom_reap_task_mm+0xc0/0x140
[  951.994539]  ? _raw_spin_lock_irqsave+0x28/0x70
[  951.995128]  ? trace_preempt_on+0x8/0xe0
[  951.995645]  oom_reaper+0x28c/0x3d0
[  951.996103]  ? __kthread_parkme+0x37/0x80
[  951.996626]  ? trace_preempt_on+0x29/0xe0
[  951.997205]  ? __kthread_parkme+0x37/0x80
[  951.997723]  ? nsec_high+0xa0/0xa0
[  951.998174]  kthread+0xe0/0x110
[  951.998588]  ? __oom_reap_task_mm+0x140/0x140
[  951.999154]  ? kthread_complete_and_exit+0x20/0x20
[  951.999771]  ret_from_fork+0x1c/0x28
[  952.000258] Disabling lock debugging due to kernel taint
[  952.000951] __swap_info_get: Bad swap file entry 6c0373b7
[  952.001779] BUG: Bad page map in process oom_reaper  pte:06e76e3e
pmd:0583f067
[  952.002827] addr:77da8000 vm_flags:00100073 anon_vma:c4e22c40
mapping:00000000 index:77da8
[  952.004010] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[  952.004764] CPU: 2 PID: 36 Comm: oom_reaper Tainted: G    B   W
    5.18.0-rc2-next-20220412 #1
[  952.006060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  952.007248] Call Trace:
[  952.007611]  dump_stack_lvl+0x44/0x57
[  952.008142]  dump_stack+0xd/0x10
[  952.008614]  print_bad_pte.cold+0x82/0xd9
[  952.009225]  ? free_swap_and_cache+0x2e/0xe0
[  952.009848]  unmap_page_range+0x6b5/0x790
[  952.010432]  __oom_reap_task_mm+0xc0/0x140
[  952.011219]  ? _raw_spin_lock_irqsave+0x28/0x70
[  952.011863]  ? trace_preempt_on+0x8/0xe0
[  952.012470]  oom_reaper+0x28c/0x3d0
[  952.013048]  ? __kthread_parkme+0x37/0x80
[  952.013628]  ? trace_preempt_on+0x29/0xe0
[  952.014202]  ? __kthread_parkme+0x37/0x80
[  952.014774]  ? nsec_high+0xa0/0xa0
[  952.015265]  kthread+0xe0/0x110
[  952.015716]  ? __oom_reap_task_mm+0x140/0x140
[  952.016336]  ? kthread_complete_and_exit+0x20/0x20
[  952.017035]  ret_from_fork+0x1c/0x28
[  952.017547] __swap_info_get: Bad swap file entry 6c0373b8
[  952.018368] BUG: Bad page map in process oom_reaper  pte:06e7703e
pmd:0583f067


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
