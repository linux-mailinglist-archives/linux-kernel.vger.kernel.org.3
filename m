Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B45498F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355683AbiFMPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351297AbiFMPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:12:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4F113A0B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:26:37 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LM9l02wydzjXZw;
        Mon, 13 Jun 2022 20:25:32 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 20:26:35 +0800
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: [Bug] Take more 150s to boot qemu on ARM64
To:     <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <linuxarm@huawei.com>
Message-ID: <36a0c658-ee5d-3a1c-416c-c041dc344bff@hisilicon.com>
Date:   Mon, 13 Jun 2022 20:26:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I encounter a issue with kernel 5.19-rc1 on a ARM64 board:  it takes 
about 150s between beginning to run qemu command and beginng to boot 
Linux kernel ("EFI stub: Booting Linux Kernel...").

But in kernel 5.18-rc4, it only takes about 5s. I git bisect the kernel 
code and it finds c2445d387850 ("srcu: Add contention check to 
call_srcu() srcu_data ->lock acquisition").

The qemu (qemu version is 6.2.92) command i run is :

./qemu-system-aarch64 -m 4G,slots=4,maxmem=8g \
--trace "kvm*" \
-cpu host \
-machine virt,accel=kvm,gic-version=3  \
-machine smp.cpus=2,smp.sockets=2 \
-no-reboot \
-nographic \
-monitor unix:/home/cx/qmp-test,server,nowait \
-bios /home/cx/boot/QEMU_EFI.fd \
-kernel /home/cx/boot/Image  \
-device 
pcie-root-port,port=0x8,chassis=1,id=net1,bus=pcie.0,multifunction=on,addr=0x1 
\
-device vfio-pci,host=7d:01.3,id=net0 \
-device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4  \
-drive file=/home/cx/boot/boot_ubuntu.img,if=none,id=drive0 \
-append "rdinit=init console=ttyAMA0 root=/dev/vda rootfstype=ext4 rw " \
-net none \
-D /home/cx/qemu_log.txt

I am not familiar with rcu code, and don't know how it causes the issue. 
Do you have any idea about this issue?


Best Regard,

Xiang Chen


