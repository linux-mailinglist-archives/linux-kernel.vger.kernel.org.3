Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280F4562F8D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiGAJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiGAJIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:08:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1161EC62
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:08:37 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LZ8Sn2d6Mz1L8Vl;
        Fri,  1 Jul 2022 17:06:17 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 17:08:36 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 17:08:35 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
Subject: [BUG] I found a syzkaller softlockup "BUG: soft lockup in
 __mmap_region"
To:     <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>
CC:     <yangjihong1@huawei.com>
Message-ID: <7c67bae9-be74-e3cc-9189-e42bbb39a0a0@huawei.com>
Date:   Fri, 1 Jul 2022 17:08:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello，

In my environment, a perf_mmap softlockup syzkaller problem occurs. The 
call stack is as follows:
[ 3666.984385][    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! 
[syz-executor.2:32404]
[ 3666.986137][    C2] Modules linked in:
[ 3666.989581][    C2] CPU: 2 PID: 32404 Comm: syz-executor.2 Not 
tainted 5.10.0+ #4
[ 3666.990697][    C2] Hardware name: linux,dummy-virt (DT)
[ 3666.992270][    C2] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[ 3666.993787][    C2] pc : __kasan_check_write+0x0/0x40
[ 3666.994841][    C2] lr : perf_mmap+0x3c8/0xf80
[ 3666.995661][    C2] sp : ffff00001011f8f0
[ 3666.996598][    C2] x29: ffff00001011f8f0 x28: ffff0000cf644868
[ 3666.998488][    C2] x27: ffff000012cad2c0 x26: 0000000000000000
[ 3666.999888][    C2] x25: 0000000000000001 x24: ffff000012cad298
[ 3667.003511][    C2] x23: 0000000000000000 x22: ffff000012cad000
[ 3667.005504][    C2] x21: ffff0000cf644818 x20: ffff0000cf6d2400
[ 3667.006891][    C2] x19: ffff0000cf6d24c0 x18: 0000000000000000
[ 3667.008295][    C2] x17: 0000000000000000 x16: 0000000000000000
[ 3667.009528][    C2] x15: 0000000000000000 x14: 0000000000000000
[ 3667.010658][    C2] x13: 0000000000000000 x12: ffff800002023f17
[ 3667.012169][    C2] x11: 1fffe00002023f16 x10: ffff800002023f16
[ 3667.013780][    C2] x9 : dfffa00000000000 x8 : ffff00001011f8b7
[ 3667.015265][    C2] x7 : 0000000000000001 x6 : ffff800002023f16
[ 3667.016683][    C2] x5 : ffff0000c0f36400 x4 : 0000000000000000
[ 3667.018078][    C2] x3 : ffffa00010000000 x2 : ffffa000119a0000
[ 3667.019343][    C2] x1 : 0000000000000004 x0 : ffff0000cf6d24c0
[ 3667.021276][    C2] Call trace:
[ 3667.022598][    C2]  __kasan_check_write+0x0/0x40
[ 3667.023666][    C2]  __mmap_region+0x7a4/0xc90
[ 3667.024679][    C2]  __do_mmap_mm+0x600/0xa20
[ 3667.025700][    C2]  do_mmap+0x114/0x384
[ 3667.026583][    C2]  vm_mmap_pgoff+0x138/0x230
[ 3667.027532][    C2]  ksys_mmap_pgoff+0x1d8/0x570
[ 3667.028537][    C2]  __arm64_sys_mmap+0xa4/0xd0
[ 3667.029597][    C2]  el0_svc_common.constprop.0+0xf4/0x414
[ 3667.030682][    C2]  do_el0_svc+0x50/0x11c
[ 3667.031545][    C2]  el0_svc+0x20/0x30
[ 3667.032368][    C2]  el0_sync_handler+0xe4/0x1e0
[ 3667.033305][    C2]  el0_sync+0x148/0x180

I checked the perf_mmap code locally. When the problem occurred, the 
kernel kept running the goto again command:

again:
         mutex_lock(&event->mmap_mutex);
         if (event->rb) {
                 if (data_page_nr(event->rb) != nr_pages) {
                         ret = -EINVAL;
                         goto unlock;
                 }

                 if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
                         /*
                          * Raced against perf_mmap_close() through
                          * perf_event_set_output(). Try again, hope for 
bette
                          * luck.
                          */
                         mutex_unlock(&event->mmap_mutex);
                         goto again;             ===> kept goto again
                 }

                 goto unlock;
         } else {
                 printk("[%d]test_mmap: perf_mmap lock, NULL\n", get_cpu());
                 put_cpu();
         }


Under what conditions would this cause?

Best Regards,
Yang
