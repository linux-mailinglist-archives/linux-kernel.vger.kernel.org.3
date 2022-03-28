Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9E24E8D12
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 06:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiC1EXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 00:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiC1EXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 00:23:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F564F9E4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648441312;
        bh=kZA54Q7FV/KJhQtfXNqZqyzdrgKBtrmFkYh1WGJsfJ4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=IteuFnV2uO4jU7hhKoVdFNaCgHVRdraa4sk4l4cd+yC4GBnltLwk+YD6L+PoY+lGZ
         mxF9jwDt6h4u0nnWHBm4YM1i2HCAuCKMb+a/qtIZOOTa8OoHXgrEfvFqNOjaY1gGPu
         nUXAeLxYzGgjtfM/nk+DIfrgPCMievWgjIFBw8UA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.233]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1ngvPl4B0I-008IEC; Mon, 28
 Mar 2022 06:21:52 +0200
Message-ID: <00f2171be8b25fdeb5c64c1f880dea32763a2722.camel@gmx.de>
Subject: LTP zram tests triggers might_sleep splat - bisects to 0a9a25ca7843
 ("block: let blkcg_gq grab request queue's refcnt")
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Date:   Mon, 28 Mar 2022 06:21:51 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qcoUBTg5VFc9scOGOvfHxQVbbqQ/4a/1IJ8Aj65fyM/t/wNxC58
 AUJoVnS/JoucnwPdPEPhyxPt1lvNzq/PexA3LumkumMhbDYg4xHlDBK4xepXnZL7SAI+6a6
 47FWn8MkL29aBD3LL4qyCl+6MOgg5wo/b8Fh933MQzAZizBqX8e9fApF+QnMWGuqNo06HJU
 EcfCxOcFAPrR+BHYCD5FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YLL9KF88ovA=:E2QpQxRzdOtW8PM4BYBJbv
 J3qRRmdutlLiLTiNir5lwnZqcukNqvwk8Q35f2bn3kdUtw2NB2YG/AE8/EMP1QhrLlZVlCLng
 +VkQSFRapVyhfk/AP8ytARAUW/giUnSRrLUIIWLSFUNY3OWPbLJcrBCm2zXuTOsWJJ0Nv8wMk
 IcklYIPjrLdnwIAmH0eOytFtnhhiwvuM7iIrWEqK7Yf/DzTU+BZE5ikMBFcb2NuCvolyFSh4H
 DtqiCMoppHP0Mmhq4+xCberOLJERr1omszSJJDFb97jndHTS7Af4ixhtV49pWlNrhWZ3Tjc/r
 HtRIizP+hP+Im1xycEUz+Wtkade4rPZ5Tk6HLROx2EVsLcPfcTVbmOc7fObGepf3TkuNchHHj
 LAyQtjwvY6ikqIEoHYtfx9u6egSlBI6hovTeRUIp430mzeV2GvOGuVLqITdTjtCso1oyxUnKV
 r/+hOU+v0cd7Vl6O6b96+JBbn+g8Zh0XVvUwhhIQqrRH388MMgMU37/qN5/OE9OwMcc8e6a6j
 ncumbNZLSgxCoEahHeVID4049PjWo0kagOB5y/NiC0quVZcIR3gNyi28tF8ezVp/xrZGNfEoX
 uENEh0p+GFkttXd4m0USgpGhx1z9kEHRWGkgQ2mKUQ6Ml06UDKk81jc4qbzCOZUZXcSqXzNNM
 hOAM8MODC6hxeP6ZUty9sKr69EY7YX/RvWnacIDaofz3MGT+ZWUc+C6WiHUwiWVQe+usve70X
 uXqm4TITIYenpYI61pXf4VOIGco5xy1gQz8OBgKpY2k0DvGb6HgrjzpB4qfA8B/OkI3OmIbG+
 4yOOiPgTCSnTMXBUYZTDrFONebjk2oTTK3eF0XjxZMp2qjRWi5UGRTXyZi4I3+WIRLCGjlzmT
 n/Uk5R9ZB9xHA7faB3W9k3T6J2FYpobBbNDyJ8hC18P2lHlyt/KfRpQokzR4VjwMZTPH43elZ
 nBFY/wEQzJy2LxvSkitlZKfPAxIG3gzQeSuyiHV6ar3usCDWMyG+H62KsYGZPtWPBAHaQNrIp
 BmJnZRlvmk2rMeXGXW7qYDA5QrCTt3Uc/BbKit5PK01du9OrxqGH2zvUw419mgfV6DxBJlPxa
 bPj7Bireuoh4iM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splat bisected cleanly, verified with a revert afterward.

(note: "Preemption disabled at:" address tracking looked to be pretty
broken during bisection, so...)

[   50.659919] zram: Added device: zram0
[   50.670989] zram0: detected capacity change from 0 to 51200
[   50.684383] EXT4-fs (zram0): mounted filesystem with ordered data mode. Quota mode: none.
[   50.684393] ext4 filesystem being mounted at /tmp/LTP_zram01.4SaesNmV2L/zram0 supports timestamps until 2038 (0x7fffffff)
[   63.090651] zram0: detected capacity change from 51200 to 0
[   63.092612] zram: Removed device: zram0
[   63.164735] BUG: sleeping function called from invalid context at block/blk-sysfs.c:766
[   63.164742] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[   63.164744] preempt_count: 101, expected: 0
[   63.164745] RCU nest depth: 0, expected: 0
[   63.164747] Preemption disabled at:
[   63.164747] [<ffffffff8181757e>] schedule_preempt_disabled+0x1e/0x20
[   63.164754] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G        W   E     5.17.0.gf0228146-master #73 f6f3a9d86c34a7a5254509d9115123082e5393e5
[   63.164758] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[   63.164760] Call Trace:
[   63.164763]  <IRQ>
[   63.164765]  dump_stack_lvl+0x33/0x42
[   63.164769]  ? schedule_preempt_disabled+0x1e/0x20
[   63.164771]  __might_resched+0x15e/0x1b0
[   63.164776]  blk_release_queue+0x22/0xf0
[   63.164779]  kobject_put+0xa4/0x210
[   63.164783]  blkg_free.part.25+0x41/0x60
[   63.164787]  rcu_do_batch+0x167/0x470
[   63.164791]  rcu_core+0x1f8/0x3a0
[   63.164793]  __do_softirq+0xef/0x2df
[   63.164797]  irq_exit_rcu+0xcf/0xe0
[   63.164802]  sysvec_apic_timer_interrupt+0x9e/0xc0
[   63.164806]  </IRQ>
[   63.164807]  <TASK>
[   63.164808]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   63.164811] RIP: 0010:cpuidle_enter_state+0xd6/0x380
[   63.164815] Code: 49 89 c4 0f 1f 44 00 00 31 ff e8 65 20 aa ff 45 84 ff 74 12 9c 58 f6 c4 02 0f 85 95 02 00 00 31 ff e8 0e 0a af ff fb 45 85 f6 <0f> 88 69 01 00 00 49 63 d6 4c 2b 24 24 48 8d 04 52 48 8d 04 82 49
[   63.164818] RSP: 0018:ffffffff82403e58 EFLAGS: 00000206
[   63.164821] RAX: ffff88840ec00000 RBX: 0000000000000005 RCX: 000000000000001f
[   63.164823] RDX: 0000000eb4e90091 RSI: ffffffff8217eea1 RDI: ffffffff82162998
[   63.164827] RBP: ffff88840ec37500 R08: 0000000000000002 R09: 000000000002da80
[   63.164829] R10: ffffffff82403e38 R11: 0000000000000edb R12: 0000000eb4e90091
[   63.164831] R13: ffffffff825a1360 R14: 0000000000000005 R15: 0000000000000000
[   63.164835]  ? cpuidle_enter_state+0xbb/0x380
[   63.164839]  cpuidle_enter+0x29/0x40
[   63.164842]  do_idle+0x1c6/0x210
[   63.164847]  cpu_startup_entry+0x19/0x20
[   63.164851]  start_kernel+0x884/0x896
[   63.164856]  ? apply_microcode_early+0xcb/0xf0
[   63.164859]  ? load_ucode_intel_bsp+0x28/0x2d
[   63.164863]  secondary_startup_64_no_verify+0xc3/0xcb
[   63.164868]  </TASK>

