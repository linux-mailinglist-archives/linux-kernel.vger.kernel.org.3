Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A694D5977E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiHQUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiHQUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9176DAD6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660767883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7eJHQmPYyM/mf6v3+m1b1jTyRSOZ/jT/4Wpy2jMbUBc=;
        b=NbHrLkSAFIJIlQUKR1XGJm4FMct9ys4mxrWsMAcjAA6wAp5lcmaGtqUAFhC9YPDTvhBcSP
        WMwJKDiEVQIVOB+hRMs77VzP9ZOMaLVrlFpa/5hzQm1NLK+/0nAibfOR4qkh8Ww4XkKAIY
        cQC83ibHlTEytac+79ZYmZdFrZUFFKo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-4aVp582iMkCUuoV6LOTFpQ-1; Wed, 17 Aug 2022 16:24:40 -0400
X-MC-Unique: 4aVp582iMkCUuoV6LOTFpQ-1
Received: by mail-ej1-f69.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso3299968ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7eJHQmPYyM/mf6v3+m1b1jTyRSOZ/jT/4Wpy2jMbUBc=;
        b=XyteHOFIMTHjBdz9RXBcYWUpxiGfCe6TwQLwdfsx70V09nNLRED8bNd+IJse+AH2vm
         HT4zABTnB5quS/GqZ4pra3Te2pZEsnbxE1iYYtYCFtrmfSb5MlDwxtf41LtU00HpEhiz
         OSJPYpRO8AEATqtsTPOoE+2WLb0wj8i/Q0gMVD6IYo7D0A+Xuc1Q0SjOJddp/WoSLgrP
         5ZScZ/LvWRJgq9ryJpHfeGxx/DgZ+RvbXV8FAU9gqEswcL9LqkMBIFUgehlSxL4YV8t0
         7VljP5PDE3czx4nhPr2D+vnG6n2w92kQ6xLluUGe8ARxgF5verJBWtzTz4iyNh9m0sBs
         aTrA==
X-Gm-Message-State: ACgBeo1AXTS8wdLcse9YMWKqfNmpg9St1jEL/pVZW36dnabuSA6ZoVtK
        JLSUq9hWSztq36AuQQe3txPuWMlSZhwBaxOzuog5Wxs5Wp+4MHpaLbaytcvih+LHYFiRZS7CyES
        ZZFT++KBMxRiz8NcfERgUeJo/
X-Received: by 2002:a17:907:d0f:b0:731:5c2:a9a5 with SMTP id gn15-20020a1709070d0f00b0073105c2a9a5mr16816354ejc.413.1660767878621;
        Wed, 17 Aug 2022 13:24:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78oDZzXo73CpETaAmOMXs0JQqieon8sgm30ydgGIxhZFwEjnS3FEh7hXbucMf7gsNkC7cZpQ==
X-Received: by 2002:a17:907:d0f:b0:731:5c2:a9a5 with SMTP id gn15-20020a1709070d0f00b0073105c2a9a5mr16816349ejc.413.1660767878403;
        Wed, 17 Aug 2022 13:24:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id gf15-20020a170906e20f00b0072b1cb2818csm7237170ejb.158.2022.08.17.13.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 13:24:37 -0700 (PDT)
Message-ID: <bb50f7ae-0670-fe7d-c7d7-10036aba13f4@redhat.com>
Date:   Wed, 17 Aug 2022 22:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in kvm_dev_ioctl
Content-Language: en-US
To:     syzbot <syzbot+8d24abd02cd4eb911bbd@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000c6e06605e670b459@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <000000000000c6e06605e670b459@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 16:30, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b66b6b080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c15de4ee7650fb42
> dashboard link: https://syzkaller.appspot.com/bug?extid=8d24abd02cd4eb911bbd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8d24abd02cd4eb911bbd@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: vmalloc-out-of-bounds in __list_add_valid+0x93/0xb0 lib/list_debug.c:27
> Read of size 8 at addr ffffc90006b7a348 by task syz-executor.4/20901
> 
> CPU: 1 PID: 20901 Comm: syz-executor.4 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:317 [inline]
>   print_report.cold+0x59/0x6e9 mm/kasan/report.c:433
>   kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>   __list_add_valid+0x93/0xb0 lib/list_debug.c:27
>   __list_add include/linux/list.h:69 [inline]
>   list_add include/linux/list.h:88 [inline]
>   kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1219 [inline]
>   kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4910 [inline]
>   kvm_dev_ioctl+0xf44/0x1ce0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4957
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb1fba89279
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb1fcc1e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fb1fbb9bf80 RCX: 00007fb1fba89279
> RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000004
> RBP: 00007fb1fbae3189 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffea48aadbf R14: 00007fb1fcc1e300 R15: 0000000000022000
>   </TASK>
> 
> Memory state around the buggy address:
>   ffffc90006b7a200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>   ffffc90006b7a280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>> ffffc90006b7a300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                                                ^
>   ffffc90006b7a380: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>   ffffc90006b7a400: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 

#syz dup: BUG: unable to handle kernel paging request in 
kvm_arch_hardware_enable

