Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40458545232
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiFIQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFIQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:42:10 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF81DA52
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:42:10 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 6292F244E;
        Thu,  9 Jun 2022 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654792889;
        bh=y32IiNUxl6m5I0VISQueAwvEd4gOfccyXSQVopjX+0I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=keGcOE0GqLju67sIkEbWxg1NvfrbRoda8cQNe+eMr0c18+gLwOLQChAOZRCeRZhRU
         fXaKZUiH8y6E3WRpZ6K5PHXXJRdPfdxjsrZt27ze5WFIZ4MeD5jK/IIpWb4pjoRuuA
         2V1uxdvBTAH13wBAlF/tKwpDyhx2adJpAtYG2NyE=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 9 Jun 2022 19:42:07 +0300
Message-ID: <7bfc9b09-e7ee-d781-5ea3-ac31d42c34e1@paragon-software.com>
Date:   Thu, 9 Jun 2022 19:42:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] ntfs3: fix NULL deref in ntfs_update_mftmirr
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, <ntfs3@lists.linux.dev>
CC:     <syzbot+c95173762127ad76a824@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>
References: <85293dd018cae78e4d48d74ca77710b11eed59ba.1650574393.git.paskripkin@gmail.com>
 <89d2979c-7e8a-f63f-327e-1969a4c03c11@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <89d2979c-7e8a-f63f-327e-1969a4c03c11@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/22 14:42, Pavel Skripkin wrote:
> On 4/21/22 23:53, Pavel Skripkin wrote:
>> If ntfs_fill_super() wasn't called then sbi->sb will be equal to NULL.
>> Code should check this ptr before dereferencing. Syzbot hit this issue
>> via passing wrong mount param as can be seen from log below
>>
>> Fail log:
>> ntfs3: Unknown parameter 'iochvrset'
>> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
>> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>> CPU: 1 PID: 3589 Comm: syz-executor210 Not tainted 5.18.0-rc3-syzkaller-00016-gb253435746d9 #0
>> ...
>> Call Trace:
>>   <TASK>
>>   put_ntfs+0x1ed/0x2a0 fs/ntfs3/super.c:463
>>   ntfs_fs_free+0x6a/0xe0 fs/ntfs3/super.c:1363
>>   put_fs_context+0x119/0x7a0 fs/fs_context.c:469
>>   do_new_mount+0x2b4/0xad0 fs/namespace.c:3044
>>   do_mount fs/namespace.c:3383 [inline]
>>   __do_sys_mount fs/namespace.c:3591 [inline]
>>
>> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
>> Reported-and-tested-by: syzbot+c95173762127ad76a824@syzkaller.appspotmail.com
>> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> gentle ping
> 
> 
> 
> 
> With regards,
> Pavel Skripkin

1st patch is correct.
2nd patch is a good catch, but I'm not sure if simply ignoring is good.
If mftmirr is broken / missing, then theoretically we can continue working.
But still it's a major fs error.
I'm thinking about exiting mount with error, and if "force" is present,
then continue with mount.
I'll reply again when I'll be sure what is correct behavior.
Thank you for your work!
