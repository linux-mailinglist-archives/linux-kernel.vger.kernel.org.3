Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5F5A1820
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbiHYRsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiHYRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:48:23 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE23B99FE;
        Thu, 25 Aug 2022 10:48:22 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso5717346pjk.0;
        Thu, 25 Aug 2022 10:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qBvhEEGuLxX+PJv+tbfEQq/bCO94kZfgiA0ElB3g654=;
        b=L/rzbB8T7WniDhIYY5Wag62yhe6NJ1CyS7am8/wbxiyoH6/Kfv3LwTjWnxsnKaosa8
         FjF1IFokoe+y2NVuGdJyUNm/uDRJLcrV5XET9x6SgQ1HOt14BJWfWIPBrKLTDTMicmtV
         5tp1Jdv9QjfByZ0yrf6pRYIBP+qNwEIXmIHeX7zQWGZB+JSxwFxgOOw/msOOb9qyBDzS
         BEpfm9DjDmCveLiedCZFPQREjf+huoHZ3Tkq/4Yxd/wmtq0F5sK0AuF05yaPBElgC6IO
         GLIIUcGCKahk3+FU7EvLF5YvW6Y861RbomIPzgBbUERcdjvPChsxfFH8Gjo62yMkI73P
         cvdQ==
X-Gm-Message-State: ACgBeo2t0dkP+nh+knD4lKvmraLUVforVj+pVNG2evdMQrzHbS1Bfzv+
        RPpb88BIaZ4bUjakYg4cbsI=
X-Google-Smtp-Source: AA6agR5cGI2rlUxjZutlHyCVw4YwR2efDBuTB1Rgl/S09JMuKrd2JkNWWXHv0YFZNevkCJqE/aaSRQ==
X-Received: by 2002:a17:90b:4ad2:b0:1fa:f9d3:df64 with SMTP id mh18-20020a17090b4ad200b001faf9d3df64mr238704pjb.19.1661449701882;
        Thu, 25 Aug 2022 10:48:21 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b001f3e643ebbfsm15247pjd.0.2022.08.25.10.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 10:48:21 -0700 (PDT)
Message-ID: <f70b1cf7-0291-6ebc-68f8-db9c68963255@acm.org>
Date:   Thu, 25 Aug 2022 10:48:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in blk_mq_map_swqueue
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>
References: <0000000000004c3b1405e6b7de26@google.com>
Cc:     syzbot <syzbot+ea55456e1ff28ef7f9ff@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0000000000004c3b1405e6b7de26@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 20:24, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3cc40a443a04 Merge tag 'nios2_fixes_v6.0' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cf3c7b080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f267ed4fb258122a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ea55456e1ff28ef7f9ff
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ea55456e1ff28ef7f9ff@syzkaller.appspotmail.com
> 
> scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
> BUG: unable to handle page fault for address: ffffdc0000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 12026067
> P4D 12026067 PUD 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.0.0-rc1-syzkaller-00017-g3cc40a443a04 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Workqueue: events_unbound async_run_entry_fn
> RIP: 0010:blk_mq_map_swqueue+0xa86/0x1630 block/blk-mq.c:3722
> Code: 00 00 fc ff df 43 0f b6 04 37 84 c0 0f 85 49 02 00 00 41 0f b7 45 00 8d 48 01 66 41 89 4d 00 48 8d 1c c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 4c 8b 7c 24 68 74 08 48 89 df e8 36 7b c1 fd 48 8b
> RSP: 0000:ffffc90000b77380 EFLAGS: 00010a06
> RAX: 1fffe00000000000 RBX: ffff000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: ffffc90000b774f0 R08: ffffffff841bbbaa R09: ffffed1004143326
> R10: ffffed1004143326 R11: 1ffff11004143325 R12: dffffc0000000000
> R13: ffff888020a1998e R14: dffffc0000000000 R15: 1ffff11004143331
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffdc0000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   blk_mq_init_allocated_queue+0x1a31/0x1c20 block/blk-mq.c:4119
>   blk_mq_init_queue_data block/blk-mq.c:3908 [inline]
>   blk_mq_init_queue+0x9f/0x120 block/blk-mq.c:3918
>   scsi_alloc_sdev+0x697/0x9d0 drivers/scsi/scsi_scan.c:335
>   scsi_probe_and_add_lun+0x1d1/0x4ab0 drivers/scsi/scsi_scan.c:1191
>   __scsi_scan_target+0x1fb/0x10e0 drivers/scsi/scsi_scan.c:1673
>   scsi_scan_channel drivers/scsi/scsi_scan.c:1761 [inline]
>   scsi_scan_host_selected+0x394/0x6c0 drivers/scsi/scsi_scan.c:1790
>   do_scsi_scan_host drivers/scsi/scsi_scan.c:1929 [inline]
>   do_scan_async+0x12e/0x7b0 drivers/scsi/scsi_scan.c:1939
>   async_run_entry_fn+0xa6/0x400 kernel/async.c:127
>   process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
>   worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>   kthread+0x266/0x300 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30
>   </TASK>
> Modules linked in:
> CR2: ffffdc0000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:blk_mq_map_swqueue+0xa86/0x1630 block/blk-mq.c:3722
> Code: 00 00 fc ff df 43 0f b6 04 37 84 c0 0f 85 49 02 00 00 41 0f b7 45 00 8d 48 01 66 41 89 4d 00 48 8d 1c c3 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 4c 8b 7c 24 68 74 08 48 89 df e8 36 7b c1 fd 48 8b
> RSP: 0000:ffffc90000b77380 EFLAGS: 00010a06
> RAX: 1fffe00000000000 RBX: ffff000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: ffffc90000b774f0 R08: ffffffff841bbbaa R09: ffffed1004143326
> R10: ffffed1004143326 R11: 1ffff11004143325 R12: dffffc0000000000
> R13: ffff888020a1998e R14: dffffc0000000000 R15: 1ffff11004143331
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffdc0000000000 CR3: 000000000ca8e000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 5 bytes skipped:
>     0:	43 0f b6 04 37       	movzbl (%r15,%r14,1),%eax
>     5:	84 c0                	test   %al,%al
>     7:	0f 85 49 02 00 00    	jne    0x256
>     d:	41 0f b7 45 00       	movzwl 0x0(%r13),%eax
>    12:	8d 48 01             	lea    0x1(%rax),%ecx
>    15:	66 41 89 4d 00       	mov    %cx,0x0(%r13)
>    1a:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
>    1e:	48 89 d8             	mov    %rbx,%rax
>    21:	48 c1 e8 03          	shr    $0x3,%rax
> * 25:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
>    2a:	4c 8b 7c 24 68       	mov    0x68(%rsp),%r15
>    2f:	74 08                	je     0x39
>    31:	48 89 df             	mov    %rbx,%rdi
>    34:	e8 36 7b c1 fd       	callq  0xfdc17b6f
>    39:	48                   	rex.W
>    3a:	8b                   	.byte 0x8b

Hi Dmitry,

This issue and also another report that has been shared recently on the
linux-scsi mailing list look like USB issues to me. Who is the right person
to make sure that the USB mailing list is included for USB related issues?

Thanks,

Bart.
