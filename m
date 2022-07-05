Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099E567005
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiGENzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGENzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:55:15 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A51A060
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:34:19 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E5F471E39;
        Tue,  5 Jul 2022 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657027997;
        bh=MFERf1XEK+8Zqa9iJXsrH9Wb2AmYnu6f21K7ML0QXkM=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=MKbn2bcjz1aZEmrfxN69RywlpL+7dqR1AjMgkktDq98dxZjvFNDCbDHMbHHOTxeDJ
         pHt86ntpn/tmzBbCYnFqRmRnH/gNfd5ownnhNzOc0S3CfGJQRpN5RQju+HlQ+xGbB8
         Ympx1PZ0LScat8NMeUxGnPo90ljDs59Kwxj/sQkI=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 5 Jul 2022 16:34:17 +0300
Message-ID: <b006448b-811f-a188-5bae-a7f9279a326b@paragon-software.com>
Date:   Tue, 5 Jul 2022 16:34:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ntfs3: fix NULL deref in ntfs_update_mftmirr
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Pavel Skripkin <paskripkin@gmail.com>, <ntfs3@lists.linux.dev>
CC:     <syzbot+c95173762127ad76a824@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>
References: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>
 <89d2979c-7e8a-f63f-327e-1969a4c03c11@gmail.com>
 <7bfc9b09-e7ee-d781-5ea3-ac31d42c34e1@paragon-software.com>
In-Reply-To: <7bfc9b09-e7ee-d781-5ea3-ac31d42c34e1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 19:42, Konstantin Komarov wrote:
> 
> 
> On 6/4/22 14:42, Pavel Skripkin wrote:
>> On 4/21/22 23:53, Pavel Skripkin wrote:
>>> If ntfs_fill_super() wasn't called then sbi->sb will be equal to NULL.
>>> Code should check this ptr before dereferencing. Syzbot hit this issue
>>> via passing wrong mount param as can be seen from log below
>>>
>>> Fail log:
>>> ntfs3: Unknown parameter 'iochvrset'
>>> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
>>> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>>> CPU: 1 PID: 3589 Comm: syz-executor210 Not tainted 5.18.0-rc3-syzkaller-00016-gb253435746d9 #0
>>> ...
>>> Call Trace:
>>>   <TASK>
>>>   put_ntfs+0x1ed/0x2a0 fs/ntfs3/super.c:463
>>>   ntfs_fs_free+0x6a/0xe0 fs/ntfs3/super.c:1363
>>>   put_fs_context+0x119/0x7a0 fs/fs_context.c:469
>>>   do_new_mount+0x2b4/0xad0 fs/namespace.c:3044
>>>   do_mount fs/namespace.c:3383 [inline]
>>>   __do_sys_mount fs/namespace.c:3591 [inline]
>>>
>>> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
>>> Reported-and-tested-by: syzbot+c95173762127ad76a824@syzkaller.appspotmail.com
>>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
>>
>> gentle ping
>>
>>
>>
>>
>> With regards,
>> Pavel Skripkin
> 
> 1st patch is correct.
> 2nd patch is a good catch, but I'm not sure if simply ignoring is good.
> If mftmirr is broken / missing, then theoretically we can continue working.
> But still it's a major fs error.
> I'm thinking about exiting mount with error, and if "force" is present,
> then continue with mount.
> I'll reply again when I'll be sure what is correct behavior.
> Thank you for your work!

I've accepted both patches.
I don't want to invent convoluted logic for mftmirr.
Thanks again for your work!
