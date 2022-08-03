Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141E5888EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiHCI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiHCI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:57:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B871FCE4;
        Wed,  3 Aug 2022 01:57:05 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LyQgN3vr8zTgTg;
        Wed,  3 Aug 2022 16:55:44 +0800 (CST)
Received: from [10.174.179.2] (10.174.179.2) by canpemm500008.china.huawei.com
 (7.192.105.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 16:57:01 +0800
Subject: Re: [PATCH] scsi: iscsi: iscsi_tcp: Fix null-ptr-deref while calling
 getpeername()
To:     Mike Christie <michael.christie@oracle.com>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "cleech@redhat.com" <cleech@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mark.mielke@gmail.com" <mark.mielke@gmail.com>
CC:     "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>
References: <20220802101939.3972556-1-lijinlin3@huawei.com>
 <d8afc88468ab481eb325e842ad384e0e@huawei.com>
 <f52cc786-be48-d670-6212-5ae6117d314d@oracle.com>
From:   Li Jinlin <lijinlin3@huawei.com>
Message-ID: <edd3f6af-98eb-2f17-2144-99daf6455be8@huawei.com>
Date:   Wed, 3 Aug 2022 16:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f52cc786-be48-d670-6212-5ae6117d314d@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500008.china.huawei.com (7.192.105.151)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2022 12:25 AM, Mike Christie wrote:
> On 8/2/22 6:23 AM, lijinlin (A) wrote:
>> So sorry, this patch has problem, please ignore.
>>
> 
> Was the issue the fget use?
>> I know I gave the suggestion to do the get, but seeing it now makes
> me think I was wrong and it's getting too messy.
> 
I use get_file() in local, and test the patch can fix this null-ptr-deref.
But I got an INFO report as below, it only appears once in multiple
tests. I'm not sure if this info report represents a possible problem
with the patch. So I ask for ignore it.

    INFO: trying to register non-static key.
    The code is fine but needs lockdep annotation, or maybe
    you didn't initialize this object before use?
    turning off the locking correctness validator.
    CPU: 21 PID: 1074 Comm: cat Not tainted 5.19.0 #44
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
    Call Trace:
    <TASK>
    dump_stack_lvl+0x49/0x63
    dump_stack+0x10/0x16
    register_lock_class+0x483/0x490
    ? reacquire_held_locks+0xcb/0x1e0
    ? release_sock+0x1e/0xb0
    __lock_acquire.constprop.0+0x4e/0x530
    ? lock_release+0x142/0x2d0
    lock_acquire+0xc3/0x1b0
    ? iscsi_sw_tcp_host_get_param+0xa4/0x120
    _raw_spin_lock_bh+0x34/0x50
    ? iscsi_sw_tcp_host_get_param+0xa4/0x120
    iscsi_sw_tcp_host_get_param+0xa4/0x120
    show_host_param_ISCSI_HOST_PARAM_IPADDRESS+0x56/0x70
    dev_attr_show+0x1d/0x50
    sysfs_kf_seq_show+0xad/0x120
    kernfs_seq_show+0x2c/0x40
    seq_read_iter+0x12e/0x4d0
    ? aa_file_perm+0x177/0x5a0
    kernfs_fop_read_iter+0x183/0x210
    new_sync_read+0xfe/0x180
    ? 0xffffffff81000000
    vfs_read+0x14d/0x1a0
    ksys_read+0x6d/0xf0
    __x64_sys_read+0x1a/0x20
    do_syscall_64+0x3b/0x90
    entry_SYSCALL_64_after_hwframe+0x63/0xcd


> Let's just add a mutex for getting/setting the tcp_sw_conn->sock in
> the non-io paths (io paths are flushed/locked already). Something like
> this (patch is only compile tested):
> 

This patch is clean, I have tested it and it is effective.
Please push this patch to the mainline, Thanks.

Jinlin

> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 9fee70d6434a..c1696472965e 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c

