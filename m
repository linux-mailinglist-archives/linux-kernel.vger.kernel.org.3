Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A169548D5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiAMKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:33:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33854 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231573AbiAMKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:33:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DANOWA023330;
        Thu, 13 Jan 2022 10:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=4xSW0gCrU9bMTll7GuKDOutTEMPptslUQFT0+BZpIs4=;
 b=Ccaq9OusI86zQq7ZYr1/AuJLcvYkzs5f3fEsz0wRQJOX133VNOODNU+eZDIsadBWxWjx
 hjV4Et/fE/+/hglP3W0Os+PlONhWAXoRGfCaZONyFSEHqck75dxlnqOF2OQC4b58uO4i
 b28o3zNNYJ+YIUcseaJtxody4MdFDa6FlKYQGEepKZDLQ6S7KHYhXzdcRzWhregJB6Yz
 /9S9FRvV+nRpOQr3FWf051YfBrgYsam5TkQJqGtac2SK26ZZ8q0Gi9GY+/Z+iJRaLgri
 tNtp1aTtWCYbTnsW95Q1QxPW/iqob0J1gS1gER4q/2DIcQeCQN1VLeVtgMh/W8LR2NGi rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djj9hr4nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 10:31:45 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DAOitS025755;
        Thu, 13 Jan 2022 10:31:44 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3djj9hr4n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 10:31:44 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DADKUD007606;
        Thu, 13 Jan 2022 10:31:43 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3df28bpp48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 10:31:43 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DAVgHZ17105366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 10:31:43 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E43AE092;
        Thu, 13 Jan 2022 10:31:42 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DD1EAE09A;
        Thu, 13 Jan 2022 10:31:34 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.58.83])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 10:31:33 +0000 (GMT)
X-Mailer: emacs 28.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
In-Reply-To: <20220104202227.2903605-9-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
Date:   Thu, 13 Jan 2022 16:01:31 +0530
Message-ID: <87a6g0nczg.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xn333cI9jijsBtKXgHkk3J-4QOwx4kgU
X-Proofpoint-ORIG-GUID: juiVo5qJBmGMnkvjSvFxmRAW3QQXJwAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_02,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.


Got the below lockdep warning while using the above kill/enable switch


[   84.252952] ======================================================
[   84.253012] WARNING: possible circular locking dependency detected
[   84.253074] 5.16.0-rc8-16204-g1cdcf1120b31 #511 Not tainted
[   84.253135] ------------------------------------------------------
[   84.253194] bash/2862 is trying to acquire lock:
[   84.253243] c0000000021ff740 (cgroup_mutex){+.+.}-{3:3}, at: store_enable+0x80/0x1510
[   84.253340]
               but task is already holding lock:
[   84.253410] c000000002221348 (mem_hotplug_lock){++++}-{0:0}, at: mem_hotplug_begin+0x30/0x50
[   84.253503]
               which lock already depends on the new lock.

[   84.253608]
               the existing dependency chain (in reverse order) is:
[   84.253693]
               -> #2 (mem_hotplug_lock){++++}-{0:0}:
[   84.253768]        lock_acquire+0x134/0x4a0
[   84.253821]        percpu_down_write+0x80/0x1c0
[   84.253872]        try_online_node+0x40/0x90
[   84.253924]        cpu_up+0x7c/0x160
[   84.253976]        bringup_nonboot_cpus+0xc4/0x120
[   84.254027]        smp_init+0x48/0xd4
[   84.254079]        kernel_init_freeable+0x274/0x45c
[   84.254134]        kernel_init+0x44/0x194
[   84.254188]        ret_from_kernel_thread+0x5c/0x64
[   84.254241]
               -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[   84.254321]        lock_acquire+0x134/0x4a0
[   84.254373]        cpus_read_lock+0x6c/0x180
[   84.254426]        static_key_disable+0x24/0x50
[   84.254477]        rebind_subsystems+0x3b0/0x5a0
[   84.254528]        cgroup_setup_root+0x24c/0x530
[   84.254581]        cgroup1_get_tree+0x7d8/0xb80
[   84.254638]        vfs_get_tree+0x48/0x150
[   84.254695]        path_mount+0x8b8/0xd20
[   84.254752]        do_mount+0xb8/0xe0
[   84.254808]        sys_mount+0x250/0x390
[   84.254863]        system_call_exception+0x15c/0x2b0
[   84.254932]        system_call_common+0xec/0x250
[   84.254989]
               -> #0 (cgroup_mutex){+.+.}-{3:3}:
[   84.255072]        check_prev_add+0x180/0x1050
[   84.255129]        __lock_acquire+0x17b8/0x25c0
[   84.255186]        lock_acquire+0x134/0x4a0
[   84.255243]        __mutex_lock+0xdc/0xa90
[   84.255300]        store_enable+0x80/0x1510
[   84.255356]        kobj_attr_store+0x2c/0x50
[   84.255413]        sysfs_kf_write+0x6c/0xb0
[   84.255471]        kernfs_fop_write_iter+0x1bc/0x2b0
[   84.255539]        new_sync_write+0x130/0x1d0
[   84.255594]        vfs_write+0x2cc/0x4c0
[   84.255645]        ksys_write+0x84/0x140
[   84.255699]        system_call_exception+0x15c/0x2b0
[   84.255771]        system_call_common+0xec/0x250
[   84.255829]
               other info that might help us debug this:

[   84.255933] Chain exists of:
                 cgroup_mutex --> cpu_hotplug_lock --> mem_hotplug_lock

[   84.256070]  Possible unsafe locking scenario:

[   84.256149]        CPU0                    CPU1
[   84.256201]        ----                    ----
[   84.256255]   lock(mem_hotplug_lock);
[   84.256311]                                lock(cpu_hotplug_lock);
[   84.256380]                                lock(mem_hotplug_lock);
[   84.256448]   lock(cgroup_mutex);
[   84.256491]
                *** DEADLOCK ***

[   84.256571] 5 locks held by bash/2862:
[   84.256626]  #0: c00000002043d460 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x84/0x140
[   84.256728]  #1: c00000004bafc888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x178/0x2b0
[   84.256830]  #2: c000000020b993b8 (kn->active#207){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x184/0x2b0
[   84.256942]  #3: c0000000020e5cd0 (cpu_hotplug_lock){++++}-{0:0}, at: mem_hotplug_begin+0x20/0x50
[   84.257045]  #4: c000000002221348 (mem_hotplug_lock){++++}-{0:0}, at: mem_hotplug_begin+0x30/0x50
[   84.257152]
               stack backtrace:
[   84.257220] CPU: 107 PID: 2862 Comm: bash Not tainted 5.16.0-rc8-16204-g1cdcf1120b31 #511
[   84.257309] Call Trace:
[   84.257346] [c000000040d5b4a0] [c000000000a89f94] dump_stack_lvl+0x98/0xe0 (unreliable)
[   84.257438] [c000000040d5b4e0] [c000000000267244] print_circular_bug.isra.0+0x3b4/0x3e0
[   84.257528] [c000000040d5b580] [c0000000002673e0] check_noncircular+0x170/0x1a0
[   84.257605] [c000000040d5b650] [c000000000268be0] check_prev_add+0x180/0x1050
[   84.257683] [c000000040d5b710] [c00000000026ca48] __lock_acquire+0x17b8/0x25c0
[   84.257760] [c000000040d5b840] [c00000000026e4c4] lock_acquire+0x134/0x4a0
[   84.257837] [c000000040d5b940] [c00000000148a53c] __mutex_lock+0xdc/0xa90
[   84.257914] [c000000040d5ba60] [c0000000004d5080] store_enable+0x80/0x1510
[   84.257989] [c000000040d5bbc0] [c000000000a9286c] kobj_attr_store+0x2c/0x50
[   84.258066] [c000000040d5bbe0] [c000000000752c4c] sysfs_kf_write+0x6c/0xb0
[   84.258143] [c000000040d5bc20] [c000000000750fcc] kernfs_fop_write_iter+0x1bc/0x2b0
[   84.258219] [c000000040d5bc70] [c000000000615df0] new_sync_write+0x130/0x1d0
[   84.258295] [c000000040d5bd10] [c00000000061997c] vfs_write+0x2cc/0x4c0
[   84.258373] [c000000040d5bd60] [c000000000619d54] ksys_write+0x84/0x140
[   84.258450] [c000000040d5bdb0] [c00000000002c91c] system_call_exception+0x15c/0x2b0
[   84.258528] [c000000040d5be10] [c00000000000c64c] system_call_common+0xec/0x250
[   84.258604] --- interrupt: c00 at 0x79c551e76554
[   84.258658] NIP:  000079c551e76554 LR: 000079c551de2674 CTR: 0000000000000000
[   84.258732] REGS: c000000040d5be80 TRAP: 0c00   Not tainted  (5.16.0-rc8-16204-g1cdcf1120b31)
[   84.258817] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28422428  XER: 00000000
[   84.258931] IRQMASK: 0
               GPR00: 0000000000000004 00007fffc8e9a320 000079c551f77100 0000000000000001
               GPR04: 0000017190973cc0 0000000000000002 0000000000000010 0000017190973cc0
               GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR12: 0000000000000000 000079c5520ab1d0 0000017190943590 000001718749b738
               GPR16: 00000171873b0ae0 0000000000000000 0000000020000000 0000017190973a60
               GPR20: 0000000000000000 0000000000000001 0000017187443ca0 00007fffc8e9a514
               GPR24: 00007fffc8e9a510 000001718749b0d0 000079c551f719d8 000079c551f72308
               GPR28: 0000000000000002 000079c551f717e8 0000017190973cc0 0000000000000002
[   84.259600] NIP [000079c551e76554] 0x79c551e76554
[   84.259651] LR [000079c551de2674] 0x79c551de2674
[   84.259701] --- interrupt: c00
