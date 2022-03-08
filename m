Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92FA4D1167
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbiCHH7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbiCHH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:59:11 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A141720F49;
        Mon,  7 Mar 2022 23:58:15 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id q5so9179772ljb.11;
        Mon, 07 Mar 2022 23:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8H62A7bY/REvpOM9FEUHdRBpq6Rax/WotG9i5gVPJuQ=;
        b=NiOyj27MscCFQKpr/GhdbrKroO+EeEppQkSO1sWZi8xyDoi6kqdThqd3k+0cCeqADb
         lkCOBq/pVSQ0Tw7Fu2loF3wAuAY21POJeJcjr9BtI0LO6/AO+UUhEaqIqMhvb6ijjUo7
         tL/5Ruhxs9R9CvnfzMBUEJ2rm2cIAMwbQhudlYFW2l8VKFrhollgxU1hgNcNPpwKpGBY
         g/xlxEtN15AB26RRm8fVHkZVc1o+gpki7A/0ppNNcyZ3CQjoiELp0AvirjWplqmufj++
         zhTnjGiqZjbSN5XG/bKKcEewJKo9IVbyIEHXH8g/yzq/y7PxyNAeJ6O4UffhIgwjAtxJ
         i9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8H62A7bY/REvpOM9FEUHdRBpq6Rax/WotG9i5gVPJuQ=;
        b=v55XZ1lCrvKGCTNkhQIM6t547T2By+P4UGcV4MthhtjR7KoOYPrDOw2VNcWZs08k6m
         uzcwD29CmuGALbOmF8GTHKNzVS53pHtTHvfWXoHmbBbpFS6+/0qhGg6dfOnPWjoYTrJ8
         BlSyps+ES590TCCJqPNYtEkfADZ0aPk678NDhbMOmZLFE/vzgTvZDv3fPDhnwsZKqhYj
         yJury8lGJvGScqhfsKUf0Z5d8neVMS9hCNd4Yy+5iuFyK/3p/d4Gxrfrrobs2X2t689q
         3fnTkLj/vSELOWpBC10F1Ewl23pTg4NpU8oMGwiImq3t09m/sHJCjm7QogRyhqITI8Xs
         nVzA==
X-Gm-Message-State: AOAM533m+eXwM4nirSJqbUJIMgDPBSGHTZXsy3HM4g+cxNVV2NODRoad
        vjXxdzKRbWWwzBb08paddkY=
X-Google-Smtp-Source: ABdhPJwPqZ6s5Y6fLF7aB/cMEvLw4XpNDKghdyzowW9/cWHWZ9P4U+WDezZU4dqSz+OK6Lbsn+e5Ew==
X-Received: by 2002:a05:651c:2103:b0:244:de1e:bbf7 with SMTP id a3-20020a05651c210300b00244de1ebbf7mr10120311ljq.115.1646726293667;
        Mon, 07 Mar 2022 23:58:13 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id f6-20020a2eb386000000b0024624f70b13sm3710577lje.136.2022.03.07.23.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 23:58:13 -0800 (PST)
Message-ID: <3d52c633-befc-b128-d063-ef8a9908be26@gmail.com>
Date:   Tue, 8 Mar 2022 10:58:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Fw:Re: [PATCH] fs: nilfs2: fix memory leak in nilfs sysfs create
 device group
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        =?UTF-8?B?5oWV5Yas5Lqu?= <dzm91@hust.edu.cn>
References: <3192BC90-D082-472B-B310-6E09A14A77C6@hust.edu.cn>
 <CAD-N9QUqfq+0UeMjQALUmGpX5xgjS6=BXvsqcXQpJRzhB6hHLw@mail.gmail.com>
 <CAKFNMokdB+Zph-1OyC1-Xnyi93r+yKSusgaEaa=CkuUBttwRZA@mail.gmail.com>
 <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAD-N9QU8-Od3G+-=RHM5K7vR2-4Af+4t=XutJJVdmkKhH7OarA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongliang,

On 3/8/22 05:22, Dongliang Mu wrote:
> Hi Ryusuke,
> 
> My local syzkaller instance always complains about the following crash
> report no matter how many times I clean up the generated crash
> reports.
> 
> BUG: memory leak
> unreferenced object 0xffff88812e902be0 (size 32):
>    comm "syz-executor.2", pid 25972, jiffies 4295025942 (age 12.490s)
>    hex dump (first 32 bytes):
>      6c 6f 6f 70 32 00 00 00 00 00 00 00 00 00 00 00  loop2...........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff8148a466>] kstrdup+0x36/0x70 mm/util.c:60
>      [<ffffffff8148a4f3>] kstrdup_const+0x53/0x80 mm/util.c:83
>      [<ffffffff8228dcd2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
>      [<ffffffff8238ca5b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
>      [<ffffffff8238d3bd>] kobject_add_varg lib/kobject.c:384 [inline]
>      [<ffffffff8238d3bd>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:473
>      [<ffffffff81d39d3a>] nilfs_sysfs_create_device_group+0x9a/0x3d0
> fs/nilfs2/sysfs.c:991
>      [<ffffffff81d22ee0>] init_nilfs+0x420/0x580 fs/nilfs2/the_nilfs.c:637
>      [<ffffffff81d108e2>] nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
>      [<ffffffff81d108e2>] nilfs_mount+0x532/0x8c0 fs/nilfs2/super.c:1316
>      [<ffffffff815de0db>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>      [<ffffffff81579ba8>] vfs_get_tree+0x28/0x100 fs/super.c:1497
>      [<ffffffff815bb582>] do_new_mount fs/namespace.c:3024 [inline]
>      [<ffffffff815bb582>] path_mount+0xb92/0xfe0 fs/namespace.c:3354
>      [<ffffffff815bba71>] do_mount+0xa1/0xc0 fs/namespace.c:3367
>      [<ffffffff815bc084>] __do_sys_mount fs/namespace.c:3575 [inline]
>      [<ffffffff815bc084>] __se_sys_mount fs/namespace.c:3552 [inline]
>      [<ffffffff815bc084>] __x64_sys_mount+0xf4/0x160 fs/namespace.c:3552
>      [<ffffffff843dd8e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>      [<ffffffff843dd8e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>      [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Unfortunately, there is no reproducer attached to the crash report.
> But I still think there should be another issue in the code.
> 

Can you, please, attach the log or try to find any fault injections? 
Them may point exactly to the root case.




With regards,
Pavel Skripkin
